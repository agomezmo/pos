import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const salesRouter = Router();

salesRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { page = '1', limit = '20', startdate, enddate } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);
    let query = `SELECT s.*, u.fullname as user_name, c.fullname as customer_name
                 FROM sales s LEFT JOIN users u ON s.userid = u.id
                 LEFT JOIN customers c ON s.customerid = c.id WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;

    if (startdate) { query += ` AND s.createdat >= $${idx++}::date`; params.push(startdate); }
    if (enddate) { query += ` AND s.createdat < ($${idx++}::date + '1 day'::interval)`; params.push(enddate); }

    query += ` ORDER BY s.createdat DESC LIMIT $${idx++} OFFSET $${idx++}`;
    params.push(parseInt(limit as string), offset);

    const result = await pool.query(query, params);
    res.json({ sales: result.rows, page: parseInt(page as string), limit: parseInt(limit as string) });
  } catch (err) {
    next(err);
  }
});

salesRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const sale = await pool.query(
      `SELECT s.*, u.fullname as user_name, c.fullname as customer_name
       FROM sales s LEFT JOIN users u ON s.userid = u.id
       LEFT JOIN customers c ON s.customerid = c.id WHERE s.id = $1`, [id]
    );
    if (sale.rows.length === 0) throw new AppError('Sale not found', 404, 'NOT_FOUND');

    const items = await pool.query(
      `SELECT si.*, p.name as product_name, p.code as product_code
       FROM saleitems si JOIN products p ON si.productid = p.id WHERE si.saleid = $1`, [id]
    );

    const payments = await pool.query(
      'SELECT * FROM payments WHERE saleid = $1', [id]
    );

    res.json({ ...sale.rows[0], items: items.rows, payments: payments.rows });
  } catch (err) {
    next(err);
  }
});

salesRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { customerid, items, paymentmethod, amountreceived, discount = 0, notes, cashregistersessionid } = req.body;
    if (!items?.length) throw new AppError('Items are required', 400, 'VALIDATION_ERROR');

    await client.query('BEGIN');

    const receiptResult = await client.query(
      `SELECT COALESCE(MAX(CAST(SUBSTRING(receiptnumber FROM 'FAC-[0-9]+-([0-9]+)$') AS INTEGER)), 0) + 1 as next
       FROM sales WHERE receiptnumber LIKE 'FAC-%' AND receiptnumber ~ 'FAC-[0-9]+-[0-9]+$'`
    );
    const nextNum = String(receiptResult.rows[0].next).padStart(4, '0');
    const receiptNumber = `FAC-${new Date().toISOString().slice(0, 10).replace(/-/g, '')}-${nextNum}`;

    let subtotal = 0;
    let tax = 0;

    for (const item of items) {
      const prod = await client.query('SELECT saleprice, requires_tax FROM products WHERE id = $1 AND isactive = true', [item.productid]);
      if (prod.rows.length === 0) throw new AppError(`Product ${item.productid} not found`, 404, 'NOT_FOUND');
      const unitPrice = item.unitprice || prod.rows[0].saleprice;
      const lineSubtotal = unitPrice * item.quantity;
      subtotal += lineSubtotal;
      if (prod.rows[0].requires_tax) {
        tax += lineSubtotal * 0.16;
      }
    }

    const total = subtotal + tax - discount;

    const saleResult = await client.query(
      `INSERT INTO sales (receiptnumber, userid, customerid, subtotal, tax, discount, total, paymentmethod, paymentstatus, notes, amountreceived, change, cashregistersessionid)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, 'Completed', $9, $10, $11, $12) RETURNING *`,
      [receiptNumber, req.user!.userId, customerid || null, subtotal, tax, discount, total, paymentmethod || 'Efectivo', notes, amountreceived || 0, (amountreceived || 0) - total, cashregistersessionid || null]
    );
    const saleId = saleResult.rows[0].id;

    for (const item of items) {
      const prod = await client.query('SELECT saleprice, requires_tax FROM products WHERE id = $1', [item.productid]);
      const unitPrice = item.unitprice || prod.rows[0].saleprice;
      const lineSubtotal = unitPrice * item.quantity;

      await client.query(
        'INSERT INTO saleitems (saleid, productid, quantity, unitprice, discount, subtotal) VALUES ($1, $2, $3, $4, $5, $6)',
        [saleId, item.productid, item.quantity, unitPrice, item.discount || 0, lineSubtotal]
      );

      await client.query(
        'INSERT INTO inventorymovements (productid, type, quantity, referencetype, referenceid, notes, userid) VALUES ($1, $2, $3, $4, $5, $6, $7)',
        [item.productid, 'OUT', item.quantity, 'Sale', saleId, `Sale ${receiptNumber}`, req.user!.userId]
      );

      await client.query('UPDATE products SET stock = stock - $1 WHERE id = $2', [item.quantity, item.productid]);
    }

    await client.query(
      'INSERT INTO payments (saleid, amount, paymentmethod) VALUES ($1, $2, $3)',
      [saleId, total, paymentmethod || 'Efectivo']
    );

    await client.query('COMMIT');

    const fullSale = await pool.query(
      `SELECT s.*, u.fullname as user_name FROM sales s JOIN users u ON s.userid = u.id WHERE s.id = $1`, [saleId]
    );
    const saleItemsRes = await pool.query(
      `SELECT si.*, p.name as product_name, p.code as product_code
       FROM saleitems si JOIN products p ON si.productid = p.id WHERE si.saleid = $1`, [saleId]
    );
    const paymentsRes = await pool.query(
      'SELECT * FROM payments WHERE saleid = $1', [saleId]
    );
    res.status(201).json({ ...fullSale.rows[0], items: saleItemsRes.rows, payments: paymentsRes.rows });
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});

salesRouter.post('/:id/cancel', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { id } = req.params;
    const sale = await client.query('SELECT * FROM sales WHERE id = $1 AND paymentstatus = $2', [id, 'Completed']);
    if (sale.rows.length === 0) throw new AppError('Sale not found or already cancelled', 404, 'NOT_FOUND');

    await client.query('BEGIN');

    await client.query('UPDATE sales SET paymentstatus = $1 WHERE id = $2', ['Cancelled', id]);

    const items = await client.query('SELECT * FROM saleitems WHERE saleid = $1', [id]);
    for (const item of items.rows) {
      await client.query(
        'INSERT INTO inventorymovements (productid, type, quantity, referencetype, referenceid, notes, userid) VALUES ($1, $2, $3, $4, $5, $6, $7)',
        [item.productid, 'IN', item.quantity, 'Cancellation', id, `Cancelled sale ${sale.rows[0].receiptnumber}`, req.user!.userId]
      );
      await client.query('UPDATE products SET stock = stock + $1 WHERE id = $2', [item.quantity, item.productid]);
    }

    await client.query('COMMIT');
    res.json({ message: 'Sale cancelled successfully' });
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});
