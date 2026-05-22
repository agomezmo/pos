import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const cashRegisterRouter = Router();

/* GET /cashregister — list active registers */
cashRegisterRouter.get('/', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query('SELECT * FROM cashregisters WHERE isactive = true ORDER BY name');
    res.json(result.rows);
  } catch (err) { next(err); }
});

/* GET /cashregister/active — get the currently open session with aggregated totals */
cashRegisterRouter.get('/active', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const session = await pool.query(`
      SELECT cs.*, u.fullname as user_name
      FROM cashregistersessions cs
      JOIN users u ON cs.userid = u.id
      WHERE cs.status = 'Open'
      ORDER BY cs.openedat DESC LIMIT 1
    `);
    if (session.rows.length === 0) return res.status(404).json({ error: { message: 'No active session' } });

    const s = session.rows[0];
    const sales = await pool.query(`
      SELECT paymentmethod, COUNT(*)::int as count, COALESCE(SUM(total), 0) as total
      FROM sales WHERE cashregistersessionid = $1 AND paymentstatus = 'Completed' GROUP BY paymentmethod
    `, [s.id]);

    const totals = { total_sales: 0, total_cash: 0, total_card: 0, total_transfer: 0 };
    for (const row of sales.rows) {
      totals.total_sales += row.count;
      if (row.paymentmethod === 'Efectivo') totals.total_cash = Number(row.total);
      else if (row.paymentmethod === 'Tarjeta') totals.total_card = Number(row.total);
      else if (row.paymentmethod === 'Transferencia') totals.total_transfer = Number(row.total);
    }

    res.json({ ...s, ...totals });
  } catch (err) { next(err); }
});

/* GET /cashregister/sessions — list historical sessions */
cashRegisterRouter.get('/sessions', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { limit = '20' } = req.query;
    const result = await pool.query(`
      SELECT cs.*, u.fullname as user_name,
        (SELECT COUNT(*) FROM sales WHERE cashregistersessionid = cs.id AND paymentstatus = 'Completed') as total_sales
      FROM cashregistersessions cs
      JOIN users u ON cs.userid = u.id
      ORDER BY cs.openedat DESC LIMIT $1
    `, [parseInt(limit as string)]);
    res.json(result.rows);
  } catch (err) { next(err); }
});

/* POST /cashregister/open — open a new session */
cashRegisterRouter.post('/open', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { openingbalance, notes } = req.body;
    if (openingbalance == null || openingbalance < 0) throw new AppError('openingbalance is required', 400);

    const existing = await pool.query("SELECT id FROM cashregistersessions WHERE status = 'Open' LIMIT 1");
    if (existing.rows.length > 0) throw new AppError('There is already an open session', 400);

    /* Get or create default cash register */
    let reg = await pool.query('SELECT id FROM cashregisters WHERE isactive = true LIMIT 1');
    let regId: number;
    if (reg.rows.length === 0) {
      const newReg = await pool.query(
        "INSERT INTO cashregisters (name) VALUES ($1) RETURNING id",
        ['Caja Principal']
      );
      regId = newReg.rows[0].id;
    } else {
      regId = reg.rows[0].id;
    }

    const result = await pool.query(
      `INSERT INTO cashregistersessions (cashregisterid, userid, openingamount, openingnotes, status)
       VALUES ($1, $2, $3, $4, 'Open') RETURNING *`,
      [regId, req.user!.userId, openingbalance, notes || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) { next(err); }
});

/* POST /cashregister/close — close the active session */
cashRegisterRouter.post('/close', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { closingbalance, notes } = req.body;
    if (closingbalance == null || closingbalance < 0) throw new AppError('closingbalance is required', 400);

    const existing = await pool.query(
      "SELECT id FROM cashregistersessions WHERE status = 'Open' ORDER BY openedat DESC LIMIT 1"
    );
    if (existing.rows.length === 0) throw new AppError('No active session found', 404);

    const result = await pool.query(
      `UPDATE cashregistersessions SET status = 'Closed', closingamount = $1, closingnotes = $2, closedat = NOW()
       WHERE id = $3 RETURNING *`,
      [closingbalance, notes || null, existing.rows[0].id]
    );
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});
