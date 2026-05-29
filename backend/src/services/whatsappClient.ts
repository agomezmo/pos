import { Client, LocalAuth } from 'whatsapp-web.js';

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

function getChromePath(): string | undefined {
  const possible = [
    '/usr/bin/chromium-browser',
    '/usr/bin/chromium',
    '/usr/bin/google-chrome',
    '/usr/bin/google-chrome-stable',
    '/snap/bin/chromium',
  ];
  try {
    const fs = require('fs');
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

    // waNumberId already has the correct format (e.g., 525632139541@c.us)
    console.log(`📤 Sending WhatsApp message to ${waNumberId}...`);
    await c.sendMessage(waNumberId, message);
    console.log(`✅ WhatsApp message sent to ${waNumberId}`);
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

export async function reconnect() {
  await disconnect();
  return getClient();
}
