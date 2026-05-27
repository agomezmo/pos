import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const suppliersRouter = Router();

suppliersRouter.get('/', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query('SELECT * FROM suppliers ORDER BY name');
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

suppliersRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM suppliers WHERE id = $1', [id]);
    if (result.rows.length === 0) throw new AppError('Supplier not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

suppliersRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { name, contactname, phone, email, address } = req.body;
    if (!name) throw new AppError('Name is required', 400, 'VALIDATION_ERROR');

    const result = await pool.query(
      'INSERT INTO suppliers (name, contactname, phone, email, address) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [name, contactname, phone, email, address]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

suppliersRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { name, contactname, phone, email, address } = req.body;
    const result = await pool.query(
      `UPDATE suppliers SET name = COALESCE($1, name), contactname = COALESCE($2, contactname),
       phone = COALESCE($3, phone), email = COALESCE($4, email), address = COALESCE($5, address)
       WHERE id = $6 RETURNING *`,
      [name, contactname, phone, email, address, id]
    );
    if (result.rows.length === 0) throw new AppError('Supplier not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

suppliersRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM suppliers WHERE id = $1 RETURNING id', [id]);
    if (result.rows.length === 0) throw new AppError('Supplier not found', 404, 'NOT_FOUND');
    res.json({ message: 'Supplier deleted', id: Number(id) });
  } catch (err) {
    next(err);
  }
});
