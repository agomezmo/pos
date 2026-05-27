import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const returnsRouter = Router();

returnsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { saleid } = req.query;
    let query = `SELECT r.*, u.fullname as user_name FROM returns r LEFT JOIN users u ON r.userid = u.id WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;
    if (saleid) { query += ` AND r.saleid = $${idx++}`; params.push(saleid); }
    query += ` ORDER BY r.createdat DESC`;
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { next(err); }
});

returnsRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const ret = await pool.query(
      `SELECT r.*, u.fullname as user_name FROM returns r LEFT JOIN users u ON r.userid = u.id WHERE r.id = $1`,
      [id]
    );
    if (ret.rows.length === 0) throw new AppError('Return not found', 404);
    const items = await pool.query(
      `SELECT ri.*, p.name as product_name, p.code as product_code
       FROM returnitems ri JOIN products p ON ri.productid = p.id WHERE ri.returnid = $1`,
      [id]
    );
    res.json({ ...ret.rows[0], items: items.rows });
  } catch (err) { next(err); }
});

returnsRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { saleid, reason, items } = req.body;
    if (!saleid) throw new AppError('saleid is required', 400);
    if (!items?.length) throw new AppError('items are required', 400);

    await client.query('BEGIN');

    let total = 0;
    for (const item of items) {
      const prod = await client.query('SELECT saleprice FROM products WHERE id = $1', [item.productid]);
      const unitPrice = item.unitprice || prod.rows[0]?.saleprice || 0;
      total += unitPrice * item.quantity;
    }

    const ret = await client.query(
      `INSERT INTO returns (saleid, userid, reason, total) VALUES ($1, $2, $3, $4) RETURNING *`,
      [saleid, req.user!.userId, reason, total]
    );
    const returnId = ret.rows[0].id;

    for (const item of items) {
      const prod = await client.query('SELECT saleprice FROM products WHERE id = $1', [item.productid]);
      const unitPrice = item.unitprice || prod.rows[0]?.saleprice || 0;
      const subtotal = unitPrice * item.quantity;
      await client.query(
        `INSERT INTO returnitems (returnid, productid, quantity, unitprice, subtotal) VALUES ($1, $2, $3, $4, $5)`,
        [returnId, item.productid, item.quantity, unitPrice, subtotal]
      );
      await client.query('UPDATE products SET stock = stock + $1 WHERE id = $2', [item.quantity, item.productid]);
    }

    await client.query('COMMIT');

    const full = await pool.query(
      `SELECT r.*, u.fullname as user_name FROM returns r LEFT JOIN users u ON r.userid = u.id WHERE r.id = $1`,
      [returnId]
    );
    res.status(201).json(full.rows[0]);
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});

returnsRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { reason } = req.body;
    if (!reason?.trim()) throw new AppError('reason is required', 400);
    const result = await pool.query(
      `UPDATE returns SET reason = $1 WHERE id = $2 RETURNING *`,
      [reason.trim(), id]
    );
    if (result.rows.length === 0) throw new AppError('Return not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

returnsRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { id } = req.params;
    const ret = await client.query('SELECT id FROM returns WHERE id = $1', [id]);
    if (ret.rows.length === 0) throw new AppError('Return not found', 404);

    await client.query('BEGIN');

    const items = await client.query('SELECT productid, quantity FROM returnitems WHERE returnid = $1', [id]);
    for (const item of items.rows) {
      await client.query('UPDATE products SET stock = stock - $1 WHERE id = $2', [item.quantity, item.productid]);
    }

    await client.query('DELETE FROM returnitems WHERE returnid = $1', [id]);
    await client.query('DELETE FROM returns WHERE id = $1', [id]);

    await client.query('COMMIT');
    res.json({ message: 'Return deleted', id: Number(id) });
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});
