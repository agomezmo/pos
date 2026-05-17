import { Router, Request, Response, NextFunction } from 'express';
import bcrypt from 'bcryptjs';
import pool from '../config/database';
import { authenticate, authorize } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const usersRouter = Router();

usersRouter.get('/', authenticate, authorize('Admin'), async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      `SELECT u.id, u.username, u.email, u.fullname, u.isactive, u.lastlogin, u.createdat, r.name as role
       FROM users u JOIN roles r ON u.roleid = r.id ORDER BY u.fullname`
    );
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

usersRouter.post('/', authenticate, authorize('Admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { username, password, email, fullname, roleid } = req.body;
    if (!username || !password || !fullname || !roleid) throw new AppError('Username, password, full name, and role are required', 400, 'VALIDATION_ERROR');

    const existing = await pool.query('SELECT id FROM users WHERE username = $1', [username]);
    if (existing.rows.length > 0) throw new AppError('Username already exists', 409, 'DUPLICATE');

    const passwordhash = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (username, passwordhash, email, fullname, roleid) VALUES ($1, $2, $3, $4, $5) RETURNING id, username, email, fullname, roleid, isactive',
      [username, passwordhash, email, fullname, roleid]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

usersRouter.put('/:id', authenticate, authorize('Admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { email, fullname, roleid, isactive } = req.body;
    const result = await pool.query(
      `UPDATE users SET email = COALESCE($1, email), fullname = COALESCE($2, fullname),
       roleid = COALESCE($3, roleid), isactive = COALESCE($4, isactive), updatedat = NOW()
       WHERE id = $5 RETURNING id, username, email, fullname, roleid, isactive`,
      [email, fullname, roleid, isactive, id]
    );
    if (result.rows.length === 0) throw new AppError('User not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

usersRouter.put('/:id/password', authenticate, authorize('Admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const { password } = req.body;
    if (!password) throw new AppError('Password is required', 400, 'VALIDATION_ERROR');

    const passwordhash = await bcrypt.hash(password, 10);
    const result = await pool.query('UPDATE users SET passwordhash = $1, updatedat = NOW() WHERE id = $2', [passwordhash, id]);
    if (result.rowCount === 0) throw new AppError('User not found', 404, 'NOT_FOUND');
    res.json({ message: 'Password updated' });
  } catch (err) {
    next(err);
  }
});
