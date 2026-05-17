import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const inventoryRouter = Router();

inventoryRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { productId, type, page = '1', limit = '50' } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);
    let query = `SELECT im.*, p.name as product_name, u.fullname as user_name
                 FROM inventorymovements im
                 JOIN products p ON im.productid = p.id
                 LEFT JOIN users u ON im.userid = u.id
                 WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;

    if (productId) {
      query += ` AND im.productid = $${idx++}`;
      params.push(productId);
    }
    if (type) {
      query += ` AND im.type = $${idx++}`;
      params.push(type);
    }

    query += ` ORDER BY im.createdat DESC LIMIT $${idx++} OFFSET $${idx++}`;
    params.push(parseInt(limit as string), offset);

    const result = await pool.query(query, params);
    res.json({ movements: result.rows, page: parseInt(page as string), limit: parseInt(limit as string) });
  } catch (err) {
    next(err);
  }
});

inventoryRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { productId, type, quantity, reason, reference } = req.body;
    if (!productId || !type || !quantity) {
      throw new AppError('Product ID, type, and quantity are required', 400, 'VALIDATION_ERROR');
    }

    const client = await pool.connect();
    try {
      await client.query('BEGIN');

      const result = await client.query(
        `INSERT INTO inventorymovements (productid, type, quantity, reason, reference, userid)
         VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
        [productId, type, quantity, reason, reference, req.user!.userId]
      );

      if (type === 'in') {
        await client.query('UPDATE products SET stock = stock + $1 WHERE id = $2', [quantity, productId]);
      } else if (type === 'out') {
        await client.query('UPDATE products SET stock = stock - $1 WHERE id = $2', [quantity, productId]);
      }

      await client.query('COMMIT');
      res.status(201).json(result.rows[0]);
    } catch (err) {
      await client.query('ROLLBACK');
      throw err;
    } finally {
      client.release();
    }
  } catch (err) {
    next(err);
  }
});
