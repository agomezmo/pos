import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate, authorize } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';
import { sendEmail, sendWhatsApp, buildCampaignEmailHtml, buildWhatsAppMessage } from '../utils/communications';

export const campaignsRouter = Router();

// ─── List campaigns ────────────────────────────────────────────────────────────
campaignsRouter.get('/', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { status } = req.query;
    let sql = `
      SELECT c.*, u.username as created_by_name,
        (SELECT COUNT(*) FROM promo_campaign_products WHERE campaign_id = c.id) as product_count,
        (SELECT COUNT(*) FROM promo_campaign_customers WHERE campaign_id = c.id) as customer_count,
        (SELECT COUNT(*) FROM promo_campaign_log WHERE campaign_id = c.id AND status = 'sent') as sent_count
      FROM promo_campaigns c
      LEFT JOIN users u ON u.id = c.created_by
      WHERE 1=1
    `;
    const params: any[] = [];
    if (status) {
      params.push(status);
      sql += ` AND c.status = $${params.length}`;
    }
    sql += ' ORDER BY c.created_at DESC';

    const result = await pool.query(sql, params);
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

// ─── Get single campaign ───────────────────────────────────────────────────────
campaignsRouter.get('/:id', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const campaign = await pool.query(`
      SELECT c.*, u.username as created_by_name
      FROM promo_campaigns c
      LEFT JOIN users u ON u.id = c.created_by
      WHERE c.id = $1
    `, [id]);
    if (campaign.rows.length === 0) throw new AppError('Campaña no encontrada', 404, 'NOT_FOUND');

    const products = await pool.query(`
      SELECT pcp.*, p.name as product_name, p.code as product_code, p.barcode,
        c.name as category_name
      FROM promo_campaign_products pcp
      JOIN products p ON p.id = pcp.product_id
      LEFT JOIN categories c ON c.id = p.categoryid
      WHERE pcp.campaign_id = $1
      ORDER BY p.name
    `, [id]);

    const customers = await pool.query(`
      SELECT pcc.*, c.fullname as customer_name, c.phone, c.email,
        c.documentnumber
      FROM promo_campaign_customers pcc
      JOIN customers c ON c.id = pcc.customer_id
      WHERE pcc.campaign_id = $1
      ORDER BY c.fullname
    `, [id]);

    const logs = await pool.query(`
      SELECT pcl.*, c.fullname as customer_name
      FROM promo_campaign_log pcl
      LEFT JOIN customers c ON c.id = pcl.customer_id
      WHERE pcl.campaign_id = $1
      ORDER BY pcl.created_at DESC
    `, [id]);

    res.json({
      ...campaign.rows[0],
      products: products.rows,
      customers: customers.rows,
      logs: logs.rows,
    });
  } catch (err) {
    next(err);
  }
});

// ─── Create campaign ───────────────────────────────────────────────────────────
campaignsRouter.post('/', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const {
      name, description, offer_type, offer_value,
      min_expiry_days, max_expiry_days, notes,
      product_ids, customer_ids,
    } = req.body;

    if (!name) throw new AppError('El nombre de la campaña es requerido', 400, 'VALIDATION_ERROR');
    if (!product_ids || !Array.isArray(product_ids) || product_ids.length === 0) {
      throw new AppError('Debe seleccionar al menos un producto', 400, 'VALIDATION_ERROR');
    }
    if (!customer_ids || !Array.isArray(customer_ids) || customer_ids.length === 0) {
      throw new AppError('Debe seleccionar al menos un cliente', 400, 'VALIDATION_ERROR');
    }

    const userId = req.user!.userId;

    // Get products with their prices and expiry dates
    const productsResult = await pool.query(
      `SELECT id, name, saleprice, purchaseprice, expiry_date
       FROM products WHERE id = ANY($1::int[])`,
      [product_ids]
    );

    if (productsResult.rows.length === 0) {
      throw new AppError('No se encontraron productos válidos', 400, 'VALIDATION_ERROR');
    }

    // Calculate offer prices
    const offerType = offer_type || 'cost_price';
    const products = productsResult.rows.map((p: any) => {
      let offerPrice: number;
      if (offerType === 'cost_price') {
        offerPrice = Number(p.purchaseprice);
      } else if (offerType === 'percentage') {
        const discount = Number(offer_value || 0);
        offerPrice = Number(p.saleprice) * (1 - discount / 100);
      } else {
        offerPrice = Number(offer_value || p.purchaseprice);
      }
      return {
        product_id: p.id,
        original_price: Number(p.saleprice),
        offer_price: Math.round(offerPrice * 100) / 100,
        expiry_date: p.expiry_date,
      };
    });

    // Get customer contact info
    const customersResult = await pool.query(
      `SELECT id, fullname, email, phone FROM customers WHERE id = ANY($1::int[])`,
      [customer_ids]
    );

    // Create campaign
    const result = await pool.query(
      `INSERT INTO promo_campaigns
        (name, description, status, offer_type, offer_value, min_expiry_days, max_expiry_days, notes, created_by)
       VALUES ($1, $2, 'draft', $3, $4, $5, $6, $7, $8) RETURNING *`,
      [name, description || null, offerType, offer_value || null,
       min_expiry_days || 30, max_expiry_days || 90, notes || null, userId]
    );
    const campaignId = result.rows[0].id;

    // Insert campaign products
    for (const p of products) {
      await pool.query(
        `INSERT INTO promo_campaign_products (campaign_id, product_id, offer_price, original_price, expiry_date)
         VALUES ($1, $2, $3, $4, $5)`,
        [campaignId, p.product_id, p.offer_price, p.original_price, p.expiry_date || null]
      );
    }

    // Insert campaign customers
    for (const c of customersResult.rows) {
      await pool.query(
        `INSERT INTO promo_campaign_customers (campaign_id, customer_id, contact_email, contact_phone)
         VALUES ($1, $2, $3, $4)`,
        [campaignId, c.id, c.email || null, c.phone || null]
      );
    }

    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// ─── Update campaign ───────────────────────────────────────────────────────────
campaignsRouter.put('/:id', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { name, description, status, offer_type, offer_value, notes } = req.body;

    const result = await pool.query(
      `UPDATE promo_campaigns SET
        name = COALESCE($1, name),
        description = COALESCE($2, description),
        status = COALESCE($3, status),
        offer_type = COALESCE($4, offer_type),
        offer_value = COALESCE($5, offer_value),
        notes = COALESCE($6, notes),
        updated_at = NOW()
       WHERE id = $7 RETURNING *`,
      [name, description, status, offer_type, offer_value, notes, id]
    );

    if (result.rows.length === 0) throw new AppError('Campaña no encontrada', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// ─── Delete campaign ───────────────────────────────────────────────────────────
campaignsRouter.delete('/:id', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM promo_campaigns WHERE id = $1 RETURNING id', [id]);
    if (result.rows.length === 0) throw new AppError('Campaña no encontrada', 404, 'NOT_FOUND');
    res.json({ message: 'Campaña eliminada', id: Number(id) });
  } catch (err) {
    next(err);
  }
});

// ─── Send campaign (emails + WhatsApp) ─────────────────────────────────────────
campaignsRouter.post('/:id/send', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { channels } = req.body; // ['email', 'whatsapp'] or both

    // Load campaign
    const campaign = await pool.query('SELECT * FROM promo_campaigns WHERE id = $1', [id]);
    if (campaign.rows.length === 0) throw new AppError('Campaña no encontrada', 404, 'NOT_FOUND');
    const camp = campaign.rows[0];

    if (camp.status === 'completed' || camp.status === 'cancelled') {
      throw new AppError('La campaña ya fue enviada o cancelada', 400, 'INVALID_STATUS');
    }

    // Load products
    const products = await pool.query(`
      SELECT pcp.*, p.name as product_name
      FROM promo_campaign_products pcp
      JOIN products p ON p.id = pcp.product_id
      WHERE pcp.campaign_id = $1
    `, [id]);

    // Load customers
    const customers = await pool.query(`
      SELECT pcc.*, c.fullname as customer_name, c.email, c.phone
      FROM promo_campaign_customers pcc
      JOIN customers c ON c.id = pcc.customer_id
      WHERE pcc.campaign_id = $1
    `, [id]);

    // Load company info for branding
    const companyResult = await pool.query('SELECT name FROM companyinfo LIMIT 1');
    const companyName = companyResult.rows[0]?.name || '';

    const selectedChannels = channels || ['email'];
    const results = { sent: 0, failed: 0, errors: [] as string[] };

    for (const cust of customers.rows) {
      // Send email
      if (selectedChannels.includes('email') && cust.email) {
        const html = buildCampaignEmailHtml(
          camp.name,
          cust.customer_name,
          products.rows.map((p: any) => ({
            name: p.product_name,
            original_price: p.original_price,
            offer_price: p.offer_price,
            expiry_date: p.expiry_date || '',
          })),
          companyName,
          camp.notes || undefined
        );
        const subject = camp.name || 'Ofertas especiales en nuestra farmacia';
        const emailResult = await sendEmail(cust.email, subject, html);

        await pool.query(
          `INSERT INTO promo_campaign_log (campaign_id, customer_id, channel, recipient, subject, message, status, error_message)
           VALUES ($1, $2, 'email', $3, $4, $5, $6, $7)`,
          [id, cust.customer_id, cust.email, subject, html,
           emailResult.success ? 'sent' : 'failed', emailResult.error || null]
        );

        if (emailResult.success) results.sent++;
        else { results.failed++; results.errors.push(`Email to ${cust.email}: ${emailResult.error}`); }
      }

      // Send WhatsApp
      if (selectedChannels.includes('whatsapp') && cust.phone) {
        const msg = buildWhatsAppMessage(
          cust.customer_name,
          products.rows.map((p: any) => ({ name: p.product_name, offer_price: p.offer_price })),
          camp.notes || undefined
        );
        const waResult = await sendWhatsApp(cust.phone, msg);

        await pool.query(
          `INSERT INTO promo_campaign_log (campaign_id, customer_id, channel, recipient, message, status, error_message)
           VALUES ($1, $2, 'whatsapp', $3, $4, $5, $6)`,
          [id, cust.customer_id, cust.phone, msg,
           waResult.success ? 'sent' : 'failed', waResult.error || null]
        );

        if (waResult.success) results.sent++;
        else { results.failed++; results.errors.push(`WhatsApp to ${cust.phone}: ${waResult.error}`); }
      }
    }

    // Update campaign status
    await pool.query(
      `UPDATE promo_campaigns SET status = 'completed', sent_at = NOW(), updated_at = NOW() WHERE id = $1`,
      [id]
    );

    res.json({
      message: `Campaña enviada: ${results.sent} enviados, ${results.failed} fallidos`,
      ...results,
    });
  } catch (err) {
    next(err);
  }
});

// ─── Get customers with email/phone (for selection UI) ─────────────────────────
campaignsRouter.get('/available-customers/list', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      `SELECT id, fullname, email, phone, documentnumber
       FROM customers
       WHERE (email IS NOT NULL AND email != '')
          OR (phone IS NOT NULL AND phone != '')
       ORDER BY fullname`
    );
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

// ─── Get expiring products (for selection UI) ──────────────────────────────────
campaignsRouter.get('/expiring-products/list', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { days } = req.query;
    const maxDays = parseInt(String(days || '90'));
    const result = await pool.query(
      `SELECT p.*, c.name as category_name
       FROM products p
       LEFT JOIN categories c ON c.id = p.categoryid
       WHERE p.expiry_date IS NOT NULL
         AND p.expiry_date BETWEEN NOW() AND NOW() + $1::interval
         AND p.isactive = true
       ORDER BY p.expiry_date ASC`,
      [`${maxDays} days`]
    );
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});
