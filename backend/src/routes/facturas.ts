import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const facturasRouter = Router();

facturasRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      `SELECT f.*, s.receiptnumber, c.fullname as customer_name
       FROM facturas f
       JOIN sales s ON f.saleid = s.id
       LEFT JOIN customers c ON s.customerid = c.id
       ORDER BY f.createdat DESC LIMIT 50`
    );
    res.json(result.rows);
  } catch (err) { next(err); }
});

facturasRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      `SELECT f.*, s.receiptnumber, c.fullname as customer_name, c.rfc as customer_rfc
       FROM facturas f
       JOIN sales s ON f.saleid = s.id
       LEFT JOIN customers c ON s.customerid = c.id
       WHERE f.id = $1`,
      [id]
    );
    if (result.rows.length === 0) throw new AppError('Factura not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

facturasRouter.post('/generate', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { saleId } = req.body;
    if (!saleId) throw new AppError('saleId is required', 400);

    await client.query('BEGIN');

    const sale = await client.query(
      `SELECT s.*, c.rfc as customer_rfc, c.fullname as customer_name,
              c.razonsocial, c.codigopostal as customer_cp, c.usocfdiid
       FROM sales s LEFT JOIN customers c ON s.customerid = c.id WHERE s.id = $1`,
      [saleId]
    );
    if (sale.rows.length === 0) throw new AppError('Sale not found', 404);
    const s = sale.rows[0];

    const company = await client.query('SELECT * FROM companyinfo LIMIT 1');
    if (company.rows.length === 0) throw new AppError('Configure company info first', 400);
    const c = company.rows[0];

    if (!c.rfc) throw new AppError('Company RFC is required for invoicing', 400);

    const nextFolio = c.folioactual + 1;
    const serie = c.seriefactura || 'F';
    const folio = `${serie}${String(nextFolio).padStart(6, '0')}`;

    const existing = await client.query('SELECT id FROM facturas WHERE saleid = $1', [saleId]);
    if (existing.rows.length > 0) {
      throw new AppError('This sale already has a factura', 400, 'DUPLICATE');
    }

    const result = await client.query(
      `INSERT INTO facturas (
        saleid, folio, serie,
        emisorrfc, emisornombre, emisorregimenfiscal, emisorcodigopostal,
        receptorrfc, receptornombre, receptorusocfdi, receptorcodigopostal,
        subtotal, descuento, iva, total, formapago, metodopago,
        lugarexpedicion, createdby
      ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19) RETURNING *`,
      [
        saleId, folio, serie,
        c.rfc, c.name, c.regimenfiscalcode || '601', c.codigopostal,
        s.customer_rfc || 'XAXX010101000', s.razonsocial || s.customer_name, s.usocfdiid || 'G01', s.customer_cp,
        s.subtotal, s.discount, s.tax, s.total,
        s.paymentmethod === 'Efectivo' ? '01' : '99',
        'PUE', c.codigopostal, req.user!.userId
      ]
    );

    await client.query('UPDATE companyinfo SET folioactual = $1 WHERE id = $2', [nextFolio, c.id]);

    await client.query('COMMIT');
    res.status(201).json(result.rows[0]);
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});

facturasRouter.post('/:id/cancel', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { motivo } = req.body;
    const result = await pool.query(
      `UPDATE facturas SET estado = 'Cancelled', motivocancelacion = $1 WHERE id = $2 AND estado != 'Cancelled' RETURNING *`,
      [motivo || 'Cancelación manual', id]
    );
    if (result.rows.length === 0) throw new AppError('Factura not found or already cancelled', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});
