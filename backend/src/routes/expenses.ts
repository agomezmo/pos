import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const expensesRouter = Router();

expensesRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { limit = '50', startdate, enddate } = req.query;
    let query = `SELECT e.*, u.fullname as user_name FROM expenses e LEFT JOIN users u ON e.userid = u.id WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;
    if (startdate) { query += ` AND e.createdat >= $${idx++}`; params.push(startdate); }
    if (enddate) { query += ` AND e.createdat <= $${idx++}`; params.push(enddate); }
    query += ` ORDER BY e.createdat DESC LIMIT $${idx++}`;
    params.push(parseInt(limit as string));
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { next(err); }
});

expensesRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM expenses WHERE id = $1', [id]);
    if (result.rows.length === 0) throw new AppError('Expense not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

expensesRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { description, amount, category, paymentmethod, reference, notes } = req.body;
    if (!description || amount == null) throw new AppError('description and amount are required', 400);
    const result = await pool.query(
      `INSERT INTO expenses (description, amount, category, paymentmethod, reference, notes, userid)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [description, amount, category || 'Otros', paymentmethod || 'Efectivo', reference || null, notes || null, req.user!.userId]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) { next(err); }
});

expensesRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { description, amount, category, paymentmethod, reference, notes } = req.body;
    const result = await pool.query(
      `UPDATE expenses SET description = $1, amount = $2, category = $3, paymentmethod = $4, reference = $5, notes = $6
       WHERE id = $7 RETURNING *`,
      [description, amount, category, paymentmethod, reference, notes, id]
    );
    if (result.rows.length === 0) throw new AppError('Expense not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

expensesRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM expenses WHERE id = $1 RETURNING id', [id]);
    if (result.rows.length === 0) throw new AppError('Expense not found', 404);
    res.json({ message: 'Expense deleted' });
  } catch (err) { next(err); }
});
