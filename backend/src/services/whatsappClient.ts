import { Client, LocalAuth } from 'whatsapp-web.js';
import * as fs from 'fs';
import * as path from 'path';

let client: Client | null = null;
let isReady = false;
let lastQr: string | null = null;
let initializing = false;

const STATUS = {
  UNINITIALIZED: 'uninitialized',
  INITIALIZING: 'initializing',
  QR_READY: 'qr_ready',
  CONNECTED: 'connected',
  DISCONNECTED: 'disconnected',
  ERROR: 'error',
};

let status = STATUS.UNINITIALIZED;
let errorMessage: string | null = null;

function cleanupStaleLocks(): void {
  const sessionDir = '/app/whatsapp-auth/session';
  try {
    if (!fs.existsSync(sessionDir)) return;
    const files = fs.readdirSync(sessionDir);
    for (const file of files) {
      if (file.startsWith('Singleton') || file.startsWith('LOCK')) {
        try {
          fs.unlinkSync(path.join(sessionDir, file));
          console.log(`🧹 Removed stale Chromium lock: ${file}`);
        } catch { /* file may already be gone */ }
      }
    }
  } catch { /* session dir may not exist yet */ }
}

function getChromePath(): string | undefined {
  const possible = [
    '/usr/bin/chromium-browser',
    '/usr/bin/chromium',
    '/usr/bin/google-chrome',
    '/usr/bin/google-chrome-stable',
    '/snap/bin/chromium',
  ];
  try {
    for (const p of possible) {
      if (fs.existsSync(p)) return p;
    }
  } catch { }
  return undefined;
}

export async function getClient(): Promise<Client | null> {
  if (client && isReady) return client;
  if (client) return null; // already initialized but not ready (e.g. waiting for QR scan)
  if (initializing) return null;

  initializing = true;
  status = STATUS.INITIALIZING;
  errorMessage = null;

  // Remove stale Chromium locks so the profile is never "in use"
  cleanupStaleLocks();

  try {
    const chromePath = getChromePath();
    const puppeteerOpts: any = {
      headless: true,
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-gpu',
        '--single-process',
      ],
    };

    if (chromePath) {
      puppeteerOpts.executablePath = chromePath;
    }

    client = new Client({
      authStrategy: new LocalAuth({
        dataPath: '/app/whatsapp-auth',
      }),
      puppeteer: puppeteerOpts,
      qrMaxRetries: 3,
      takeoverOnConflict: true,
    });

    client.on('qr', (qr: string) => {
      lastQr = qr;
      status = STATUS.QR_READY;
      console.log('📱 WhatsApp QR code generated. Scan with your phone.');

      try {
        const qrcode = require('qrcode-terminal');
        qrcode.generate(qr, { small: true });
      } catch {
        console.log('QR (base64):', qr.substring(0, 60) + '...');
        console.log('Install qrcode-terminal for pretty QR display.');
      }
    });

    client.on('ready', () => {
      isReady = true;
      status = STATUS.CONNECTED;
      lastQr = null;
      errorMessage = null;
      initializing = false;
      console.log('✅ WhatsApp client ready!');
    });

    client.on('disconnected', (reason: string) => {
      isReady = false;
      status = STATUS.DISCONNECTED;
      lastQr = null;
      errorMessage = `Desconectado: ${reason}`;
      console.log('⚠️ WhatsApp disconnected:', reason);
      client = null;
      initializing = false;

      // Auto-reconnect after a few seconds
      setTimeout(() => {
        if (!client && !initializing) {
          console.log('🔄 Auto-reconnecting WhatsApp...');
          getClient().catch(() => {});
        }
      }, 5000);
    });

    client.on('auth_failure', (msg: string) => {
      isReady = false;
      status = STATUS.ERROR;
      errorMessage = msg;
      initializing = false;
      console.error('❌ WhatsApp auth failure:', msg);
    });

    client.on('loading_screen', (percent: string) => {
      if (Number(percent) % 25 === 0) {
        console.log(`⏳ WhatsApp loading: ${percent}%`);
      }
    });

    client.on('authenticated', () => {
      console.log('🔐 WhatsApp authenticated');
    });

    await client.initialize();

    // If no QR event fired and not ready after timeout, it might be recovering
    // Wait for ready or error
    const timeout = setTimeout(() => {
      if (!isReady && status === STATUS.INITIALIZING) {
        console.log('⏳ WhatsApp still initializing... check logs for QR code');
      }
    }, 15000);

    // Wait up to 20s for ready
    for (let i = 0; i < 20 && !isReady && status !== STATUS.QR_READY && status !== STATUS.ERROR; i++) {
      await new Promise(r => setTimeout(r, 1000));
    }
    clearTimeout(timeout);

    initializing = false;
    return client;
  } catch (err: any) {
    console.error('❌ WhatsApp client initialization error:', err.message);

    // If it's a lock error, clean up and retry once
    if (err.message && err.message.includes('profile appears to be in use')) {
      console.log('🔄 Cleaning Chromium locks and retrying initialization...');
      cleanupStaleLocks();
      initializing = false; // allow retry
      client = null;

      // Wait a moment then retry
      await new Promise(r => setTimeout(r, 2000));
      return getClient();
    }

    status = STATUS.ERROR;
    errorMessage = err.message;
    initializing = false;
    return null;
  }
}

export async function sendWaMessage(to: string, message: string): Promise<{ success: boolean; error?: string }> {
  try {
    const c = await getClient();
    if (!c) {
      return { success: false, error: 'WhatsApp no conectado. Escanea el código QR primero.' };
    }
    if (!isReady) {
      return { success: false, error: 'WhatsApp cliente no está listo.' };
    }

    // Format phone: remove any non-digit chars, ensure country code
    let cleanPhone = to.replace(/\D/g, '');
    if (cleanPhone.length === 10) {
      cleanPhone = '52' + cleanPhone;
    }

    // First check if the number exists on WhatsApp
    let waNumberId: any;
    try {
      waNumberId = await c.getNumberId(cleanPhone);
    } catch (checkErr: any) {
      console.error(`Error checking number ${cleanPhone}:`, checkErr.message);
    }

    if (!waNumberId) {
      console.warn(`⚠️ Number ${cleanPhone} does not appear to be registered on WhatsApp`);
      return { success: false, error: `El número ${to} no está registrado en WhatsApp` };
    }

    // waNumberId is a ContactId object with _serialized (e.g., 525583024067@c.us)
    const chatId = typeof waNumberId === 'string' ? waNumberId : waNumberId._serialized;
    console.log(`📤 Sending WhatsApp message to ${chatId}...`);
    await c.sendMessage(chatId, message);
    console.log(`✅ WhatsApp message sent to ${chatId}`);
    return { success: true };
  } catch (err: any) {
    console.error('Error sending WhatsApp message:', err);
    return { success: false, error: err.message };
  }
}

export function getStatus() {
  // Auto-initialize if not started yet
  if (!initializing && client === null && status === STATUS.UNINITIALIZED) {
    getClient().catch(() => {});
  }
  return {
    status,
    ready: isReady,
    hasQr: lastQr !== null,
    error: errorMessage,
  };
}

export function getQr(): string | null {
  return lastQr;
}

export async function disconnect() {
  if (client) {
    try {
      await client.destroy();
    } catch { }
    client = null;
    isReady = false;
    status = STATUS.DISCONNECTED;
    lastQr = null;
    initializing = false;
  }
}

export async function clearAuth(): Promise<void> {
  await disconnect();
  // Eliminar todos los datos de sesión guardados
  const authDir = '/app/whatsapp-auth';
  try {
    if (fs.existsSync(authDir)) {
      const entries = fs.readdirSync(authDir);
      for (const entry of entries) {
        const fullPath = path.join(authDir, entry);
        fs.rmSync(fullPath, { recursive: true, force: true });
      }
      console.log('🗑️ WhatsApp session data cleared');
    }
  } catch (err: any) {
    console.error('Error clearing WhatsApp auth:', err.message);
  }
  // Reset status so getClient() will reinitialize fresh (new QR)
  status = STATUS.UNINITIALIZED;
}

export async function reconnect() {
  await disconnect();
  return getClient();
}
