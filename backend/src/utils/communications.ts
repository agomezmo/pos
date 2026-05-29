import nodemailer from 'nodemailer';
import pool from '../config/database';

// ─── SMTP Transport ────────────────────────────────────────────────────────────
let transporter: nodemailer.Transporter | null = null;

function getSmtpConfig() {
  return {
    host: process.env.SMTP_HOST || '',
    port: parseInt(process.env.SMTP_PORT || '587'),
    user: process.env.SMTP_USER || '',
    pass: process.env.SMTP_PASS || '',
    from: process.env.SMTP_FROM || process.env.SMTP_USER || 'noreply@farmacia.com',
  };
}

function getTransporter() {
  if (transporter) return transporter;
  const cfg = getSmtpConfig();
  if (!cfg.host || !cfg.user || !cfg.pass) {
    console.warn('⚠️  SMTP no configurado. Los correos se registrarán como pendientes.');
    return null;
  }
  transporter = nodemailer.createTransport({
    host: cfg.host,
    port: cfg.port,
    secure: cfg.port === 465,
    auth: { user: cfg.user, pass: cfg.pass },
  });
  return transporter;
}

// ─── Send Email ────────────────────────────────────────────────────────────────
export async function sendEmail(to: string, subject: string, html: string): Promise<{ success: boolean; error?: string }> {
  try {
    const t = getTransporter();
    if (!t) {
      return { success: false, error: 'SMTP no configurado' };
    }
    const cfg = getSmtpConfig();
    await t.sendMail({
      from: `"${process.env.SMTP_FROM_NAME || 'Farmacia'}" <${cfg.from}>`,
      to,
      subject,
      html,
    });
    return { success: true };
  } catch (err: any) {
    console.error('Error enviando correo:', err);
    return { success: false, error: err.message };
  }
}

// ─── Build HTML Campaign Email ─────────────────────────────────────────────────
export function buildCampaignEmailHtml(campaignName: string, customerName: string, products: Array<{
  name: string;
  original_price: number;
  offer_price: number;
  expiry_date: string;
}>, companyName: string, notes?: string): string {
  const productRows = products.map(p => `
    <tr>
      <td style="padding:10px;border-bottom:1px solid #eee;font-size:14px;">${p.name}</td>
      <td style="padding:10px;border-bottom:1px solid #eee;text-align:center;font-size:14px;color:#999;text-decoration:line-through;">$${Number(p.original_price).toFixed(2)}</td>
      <td style="padding:10px;border-bottom:1px solid #eee;text-align:center;font-size:16px;color:#22c55e;font-weight:700;">$${Number(p.offer_price).toFixed(2)}</td>
    </tr>
  `).join('');

  return `
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"></head>
<body style="margin:0;padding:0;font-family:Arial,Helvetica,sans-serif;background:#f4f4f5;">
  <table width="100%" cellpadding="0" cellspacing="0"><tr><td align="center" style="padding:20px;">
    <table width="600" cellpadding="0" cellspacing="0" style="background:#fff;border-radius:12px;overflow:hidden;">
      <tr><td style="background:#22c55e;padding:24px;text-align:center;">
        <h1 style="color:#fff;margin:0;font-size:24px;">¡Ofertas Especiales!</h1>
      </td></tr>
      <tr><td style="padding:24px;">
        <p style="font-size:16px;color:#333;">Hola <strong>${customerName}</strong>,</p>
        <p style="font-size:14px;color:#555;line-height:1.6;">
          ${campaignName ? `Tenemos una promoción especial: <strong>${campaignName}</strong>. ` : ''}
          Aprovecha estos precios exclusivos en los siguientes productos:
        </p>
        ${notes ? `<p style="font-size:13px;color:#888;font-style:italic;">${notes}</p>` : ''}
        <table width="100%" cellpadding="0" cellspacing="0" style="margin-top:16px;">
          <tr style="background:#f8fafc;">
            <th style="padding:10px;text-align:left;font-size:13px;color:#666;">Producto</th>
            <th style="padding:10px;text-align:center;font-size:13px;color:#666;">Precio Regular</th>
            <th style="padding:10px;text-align:center;font-size:13px;color:#666;">Precio Oferta</th>
          </tr>
          ${productRows}
        </table>
        <p style="font-size:13px;color:#888;margin-top:16px;line-height:1.5;">
          * Oferta válida hasta agotar existencias. Aplica únicamente en nuestra farmacia.
        </p>
      </td></tr>
      <tr><td style="background:#f8fafc;padding:16px;text-align:center;font-size:12px;color:#999;">
        ${companyName ? `${companyName} — ` : ''}Gracias por su preferencia.
      </td></tr>
    </table>
  </td></tr></table>
</body>
</html>`;
}

// ─── WhatsApp integration ──────────────────────────────────────────────────────
export async function sendWhatsApp(phone: string, message: string): Promise<{ success: boolean; error?: string }> {
  // If WHATSAPP_API_URL is configured (Meta Cloud API / Twilio), use that
  const apiUrl = process.env.WHATSAPP_API_URL;
  const apiToken = process.env.WHATSAPP_API_TOKEN;
  if (apiUrl && apiToken) {
    try {
      const response = await fetch(apiUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${apiToken}`,
        },
        body: JSON.stringify({ to: phone, message }),
      });
      if (!response.ok) {
        const text = await response.text();
        return { success: false, error: `WhatsApp API error: ${text}` };
      }
      return { success: true };
    } catch (err: any) {
      console.error('Error enviando WhatsApp por API:', err);
      return { success: false, error: err.message };
    }
  }

  // Fallback: use whatsapp-web.js (QR-based, free)
  try {
    const { sendWaMessage } = await import('../services/whatsappClient');
    const result = await sendWaMessage(phone, message);
    return result;
  } catch (err: any) {
    console.error('Error enviando WhatsApp por QR client:', err);
    return { success: false, error: err.message };
  }
}

export function buildWhatsAppMessage(customerName: string, products: Array<{ name: string; offer_price: number }>, notes?: string): string {
  const items = products.map(p => `• ${p.name} — $${Number(p.offer_price).toFixed(2)}`).join('\n');
  let msg = `Hola ${customerName}, tenemos ofertas especiales para ti:\n\n${items}`;
  if (notes) msg += `\n\n${notes}`;
  msg += '\n\n¡Te esperamos!';
  return msg;
}
