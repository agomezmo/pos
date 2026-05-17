import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';

export const reportsRouter = Router();

reportsRouter.get('/daily-summary', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { date } = req.query;
    const targetDate = date || new Date().toISOString().split('T')[0];

    const result = await pool.query(`
      SELECT
        COUNT(*)::int as total_sales,
        COALESCE(SUM(total), 0) as total_revenue,
        COALESCE(SUM(tax), 0) as total_tax,
        COALESCE(SUM(discount), 0) as total_discounts,
        COUNT(DISTINCT customerid) as unique_customers
      FROM sales
      WHERE DATE(createdat) = $1 AND paymentstatus = 'Completed'
    `, [targetDate]);

    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

reportsRouter.get('/top-products', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate, limit = '10' } = req.query;

    const result = await pool.query(`
      SELECT p.id, p.name, p.code,
             SUM(si.quantity)::int as total_quantity,
             SUM(si.subtotal) as total_revenue
      FROM saleitems si
      JOIN products p ON si.productid = p.id
      JOIN sales s ON si.saleid = s.id
      WHERE s.paymentstatus = 'Completed'
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY p.id, p.name, p.code
      ORDER BY total_quantity DESC
      LIMIT $3
    `, [startDate || null, endDate || null, parseInt(limit as string)]);

    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

reportsRouter.get('/inventory-status', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(`
      SELECT
        COUNT(*)::int as total_products,
        SUM(CASE WHEN stock <= minstock THEN 1 ELSE 0 END)::int as low_stock_count,
        SUM(CASE WHEN stock = 0 THEN 1 ELSE 0 END)::int as out_of_stock_count,
        COALESCE(SUM(stock * purchaseprice), 0) as inventory_value
      FROM products WHERE isactive = true
    `);
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});
