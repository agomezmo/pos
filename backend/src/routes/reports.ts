import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';

export const reportsRouter = Router();

reportsRouter.get('/daily-summary', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { date, startDate, endDate } = req.query;
    if (startDate && endDate) {
      const result = await pool.query(`
        SELECT COUNT(*)::int as total_sales, COALESCE(SUM(total), 0) as total_revenue,
               COALESCE(SUM(tax), 0) as total_tax, COALESCE(SUM(discount), 0) as total_discounts,
               COUNT(DISTINCT customerid) as unique_customers
        FROM sales WHERE DATE(createdat) >= $1 AND DATE(createdat) <= $2 AND paymentstatus = 'Completed'
      `, [startDate, endDate]);
      return res.json(result.rows[0]);
    }
    const targetDate = date || new Date().toISOString().split('T')[0];
    const result = await pool.query(`
      SELECT COUNT(*)::int as total_sales, COALESCE(SUM(total), 0) as total_revenue,
             COALESCE(SUM(tax), 0) as total_tax, COALESCE(SUM(discount), 0) as total_discounts,
             COUNT(DISTINCT customerid) as unique_customers
      FROM sales WHERE DATE(createdat) = $1 AND paymentstatus = 'Completed'
    `, [targetDate]);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

reportsRouter.get('/top-products', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate, limit = '10' } = req.query;
    const result = await pool.query(`
      SELECT p.id, p.name, p.code, SUM(si.quantity)::int as total_quantity,
             SUM(si.subtotal) as total_revenue, p.purchaseprice
      FROM saleitems si JOIN products p ON si.productid = p.id
      JOIN sales s ON si.saleid = s.id
      WHERE s.paymentstatus = 'Completed'
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY p.id, p.name, p.code, p.purchaseprice
      ORDER BY total_quantity DESC LIMIT $3
    `, [startDate || null, endDate || null, parseInt(limit as string)]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/monthly-sales', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const months = parseInt(req.query.months as string) || 6;
    const result = await pool.query(`
      SELECT EXTRACT(YEAR FROM createdat)::int as year, EXTRACT(MONTH FROM createdat)::int as month,
             COUNT(*)::int as count, COALESCE(SUM(total), 0) as revenue,
             COALESCE(SUM(tax), 0) as tax, COALESCE(SUM(discount), 0) as discounts
      FROM sales WHERE paymentstatus = 'Completed'
        AND createdat >= date_trunc('month', CURRENT_DATE) - ($1 || ' months')::interval
      GROUP BY year, month ORDER BY year DESC, month DESC
    `, [months]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/monthly-expenses', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const months = parseInt(req.query.months as string) || 6;
    const result = await pool.query(`
      SELECT EXTRACT(YEAR FROM createdat)::int as year, EXTRACT(MONTH FROM createdat)::int as month,
             COUNT(*)::int as count, COALESCE(SUM(amount), 0) as total
      FROM expenses
      WHERE createdat >= date_trunc('month', CURRENT_DATE) - ($1 || ' months')::interval
      GROUP BY year, month ORDER BY year DESC, month DESC
    `, [months]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/inventory-status', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(`
      SELECT COUNT(*)::int as total_products,
             SUM(CASE WHEN stock <= minstock THEN 1 ELSE 0 END)::int as low_stock_count,
             SUM(CASE WHEN stock = 0 THEN 1 ELSE 0 END)::int as out_of_stock_count,
             COALESCE(SUM(stock * purchaseprice), 0) as inventory_value
      FROM products WHERE isactive = true
    `);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

/* ── Nuevos endpoints de estadísticas ── */

reportsRouter.get('/sales-by-category', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate } = req.query;
    const result = await pool.query(`
      SELECT cat.id, cat.name, COUNT(DISTINCT s.id)::int as sale_count,
             SUM(si.quantity)::int as total_quantity,
             COALESCE(SUM(si.subtotal), 0) as revenue
      FROM saleitems si
      JOIN products p ON si.productid = p.id
      JOIN categories cat ON p.categoryid = cat.id
      JOIN sales s ON si.saleid = s.id
      WHERE s.paymentstatus = 'Completed'
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY cat.id, cat.name
      ORDER BY revenue DESC
    `, [startDate || null, endDate || null]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/hourly-sales', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate } = req.query;
    const result = await pool.query(`
      SELECT EXTRACT(HOUR FROM createdat)::int as hour,
             COUNT(*)::int as sale_count,
             COALESCE(SUM(total), 0) as revenue
      FROM sales
      WHERE paymentstatus = 'Completed'
        AND ($1::date IS NULL OR createdat >= $1::date)
        AND ($2::date IS NULL OR createdat <= $2::date)
      GROUP BY hour ORDER BY hour
    `, [startDate || null, endDate || null]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/monthly-comparison', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const months = parseInt(req.query.months as string) || 12;
    const result = await pool.query(`
      SELECT EXTRACT(YEAR FROM createdat)::int as year, EXTRACT(MONTH FROM createdat)::int as month,
             COALESCE(SUM(total), 0) as revenue, COALESCE(SUM(tax), 0) as tax,
             COALESCE(SUM(discount), 0) as discounts, COUNT(*)::int as sale_count
      FROM sales WHERE paymentstatus = 'Completed'
        AND createdat >= date_trunc('month', CURRENT_DATE) - ($1 || ' months')::interval
      GROUP BY year, month ORDER BY year, month
    `, [months]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/payment-methods', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate } = req.query;
    const result = await pool.query(`
      SELECT s.paymentmethod, COUNT(*)::int as sale_count,
             COALESCE(SUM(s.total), 0) as total
      FROM sales s
      WHERE s.paymentstatus = 'Completed'
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY s.paymentmethod ORDER BY total DESC
    `, [startDate || null, endDate || null]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/top-customers', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate, limit = '5' } = req.query;
    const result = await pool.query(`
      SELECT c.id, c.fullname, c.rfc, COUNT(s.id)::int as sale_count,
             COALESCE(SUM(s.total), 0) as total_spent
      FROM sales s JOIN customers c ON s.customerid = c.id
      WHERE s.paymentstatus = 'Completed'
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY c.id, c.fullname, c.rfc
      ORDER BY total_spent DESC LIMIT $3
    `, [startDate || null, endDate || null, parseInt(limit as string)]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/profit-margin', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate, limit = '10' } = req.query;
    const result = await pool.query(`
      SELECT p.id, p.name, p.code, p.purchaseprice, p.saleprice,
             SUM(si.quantity)::int as total_sold,
             COALESCE(SUM(si.subtotal), 0) as total_revenue,
             COALESCE(SUM(si.quantity * p.purchaseprice), 0) as total_cost,
             COALESCE(SUM(si.subtotal) - SUM(si.quantity * p.purchaseprice), 0) as gross_profit,
             CASE WHEN SUM(si.subtotal) > 0
               THEN ROUND(((SUM(si.subtotal) - SUM(si.quantity * p.purchaseprice)) / SUM(si.subtotal)) * 100, 1)
               ELSE 0 END as margin_pct
      FROM saleitems si JOIN products p ON si.productid = p.id
      JOIN sales s ON si.saleid = s.id
      WHERE s.paymentstatus = 'Completed'
        AND p.purchaseprice > 0
        AND ($1::date IS NULL OR s.createdat >= $1::date)
        AND ($2::date IS NULL OR s.createdat <= $2::date)
      GROUP BY p.id, p.name, p.code, p.purchaseprice, p.saleprice
      ORDER BY gross_profit DESC LIMIT $3
    `, [startDate || null, endDate || null, parseInt(limit as string)]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/return-rate', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const months = parseInt(req.query.months as string) || 6;
    const result = await pool.query(`
      SELECT EXTRACT(YEAR FROM s.createdat)::int as year,
             EXTRACT(MONTH FROM s.createdat)::int as month,
             COUNT(DISTINCT s.id)::int as total_sales,
             COUNT(DISTINCT r.id)::int as total_returns,
             CASE WHEN COUNT(DISTINCT s.id) > 0
               THEN ROUND((COUNT(DISTINCT r.id)::numeric / COUNT(DISTINCT s.id)::numeric) * 100, 2)
               ELSE 0 END as return_rate_pct
      FROM sales s
      LEFT JOIN returns r ON r.saleid = s.id
      WHERE s.paymentstatus = 'Completed'
        AND s.createdat >= date_trunc('month', CURRENT_DATE) - ($1 || ' months')::interval
      GROUP BY year, month ORDER BY year, month
    `, [months]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

reportsRouter.get('/day-of-week', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { startDate, endDate } = req.query;
    const days = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
    const result = await pool.query(`
      SELECT EXTRACT(DOW FROM createdat)::int as dow,
             COUNT(*)::int as sale_count,
             COALESCE(SUM(total), 0) as revenue
      FROM sales
      WHERE paymentstatus = 'Completed'
        AND ($1::date IS NULL OR createdat >= $1::date)
        AND ($2::date IS NULL OR createdat <= $2::date)
      GROUP BY dow ORDER BY dow
    `, [startDate || null, endDate || null]);
    const mapped = result.rows.map((r: any) => ({ ...r, day_name: days[r.dow] || '' }));
    res.json(mapped);
  } catch (err) { next(err); }
});
