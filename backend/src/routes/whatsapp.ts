import { Router, Request, Response } from 'express';
import { authenticate, authorize } from '../middleware/auth';
import { getStatus, getQr, reconnect } from '../services/whatsappClient';

export const whatsappRouter = Router();

// GET /api/whatsapp/status
whatsappRouter.get('/status', authenticate, async (_req: Request, res: Response) => {
  const status = getStatus();
  res.json(status);
});

// GET /api/whatsapp/qr (returns QR as base64 PNG for inline display)
whatsappRouter.get('/qr', authenticate, authorize('admin'), async (_req: Request, res: Response) => {
  const qr = getQr();
  if (!qr) {
    res.status(404).json({ error: 'No QR code available. Check if WhatsApp is connecting...' });
    return;
  }

  try {
    const qrcode = require('qrcode');
    const dataUrl = await qrcode.toDataURL(qr, { width: 400, margin: 2 });
    res.json({ qr: dataUrl, code: qr });
  } catch {
    // Fallback: return the raw qr string
    res.json({ qr: null, code: qr });
  }
});

// POST /api/whatsapp/reconnect
whatsappRouter.post('/reconnect', authenticate, authorize('admin'), async (_req: Request, res: Response) => {
  try {
    await reconnect();
    res.json({ message: 'Reconectando WhatsApp...' });
  } catch (err: any) {
    res.status(500).json({ error: err.message });
  }
});
