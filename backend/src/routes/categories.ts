import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const categoriesRouter = Router();

categoriesRouter.get('/', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      'SELECT * FROM categories WHERE isactive = true ORDER BY name'
    );
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

categoriesRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM categories WHERE id = $1', [id]);
    if (result.rows.length === 0) {
      throw new AppError('Category not found', 404, 'NOT_FOUND');
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

categoriesRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { name, description } = req.body;
    if (!name) throw new AppError('Name is required', 400, 'VALIDATION_ERROR');

    const result = await pool.query(
      'INSERT INTO categories (name, description) VALUES ($1, $2) RETURNING *',
      [name, description]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

categoriesRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { name, description, isactive } = req.body;

    const result = await pool.query(
      `UPDATE categories SET name = COALESCE($1, name), description = COALESCE($2, description),
       isactive = COALESCE($3, isactive) WHERE id = $4 RETURNING *`,
      [name, description, isactive, id]
    );

    if (result.rows.length === 0) {
      throw new AppError('Category not found', 404, 'NOT_FOUND');
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

categoriesRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'UPDATE categories SET isactive = false WHERE id = $1 RETURNING *',
      [id]
    );
    if (result.rows.length === 0) {
      throw new AppError('Category not found', 404, 'NOT_FOUND');
    }
    res.json({ message: 'Category deactivated' });
  } catch (err) {
    next(err);
  }
});
