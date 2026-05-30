import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate, authorize } from '../middleware/auth';

export const alertsRouter = Router();

alertsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    // Stored alerts from DB
    const storedResult = await pool.query(
      'SELECT * FROM alerts ORDER BY createdat DESC LIMIT 100'
    );

    // Compute real-time counts from products table
    const lowStockResult = await pool.query(
      `SELECT COUNT(*) as count FROM products WHERE isactive = true AND stock <= minstock`
    );
    const lowStockCount = parseInt(lowStockResult.rows[0].count, 10);

    const expiryResult = await pool.query(
      `SELECT COUNT(*) as count FROM products
       WHERE isactive = true AND expiry_date IS NOT NULL
         AND expiry_date <= CURRENT_DATE + INTERVAL '30 days'
         AND expiry_date >= CURRENT_DATE`
    );
    const expiryCount = parseInt(expiryResult.rows[0].count, 10);

    res.json({
      alerts: storedResult.rows,
      counts: {
        low_stock: lowStockCount,
        expiry: expiryCount,
      },
    });
  } catch (err) {
    next(err);
  }
});

alertsRouter.patch('/:id/read', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'UPDATE alerts SET isread = true WHERE id = $1 RETURNING *',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: { message: 'Alert not found' } });
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

alertsRouter.patch('/read-all', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      'UPDATE alerts SET isread = true WHERE isread = false RETURNING *'
    );
    res.json({ updated: result.rowCount, alerts: result.rows });
  } catch (err) {
    next(err);
  }
});
