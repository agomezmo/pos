import { Router, Request, Response, NextFunction } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

const JWT_SECRET = process.env.JWT_SECRET || 'pos-system-secret-key-change-in-production';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '24h';

export const authRouter = Router();

authRouter.post('/login', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      throw new AppError('Username and password required', 400, 'VALIDATION_ERROR');
    }

    const result = await pool.query(
      `SELECT u.id, u.username, u.passwordhash, u.email, u.fullname, u.roleid, r.name as role
       FROM users u JOIN roles r ON u.roleid = r.id
       WHERE u.username = $1 AND u.isactive = true`,
      [username]
    );

    if (result.rows.length === 0) {
      throw new AppError('Invalid credentials', 401, 'INVALID_CREDENTIALS');
    }

    const user = result.rows[0];
    const valid = await bcrypt.compare(password, user.passwordhash);
    if (!valid) {
      throw new AppError('Invalid credentials', 401, 'INVALID_CREDENTIALS');
    }

    await pool.query('UPDATE users SET lastlogin = NOW() WHERE id = $1', [user.id]);

    const token = jwt.sign(
      { userId: user.id, username: user.username, roleId: user.roleid, role: user.role },
      JWT_SECRET,
      { expiresIn: 86400 }
    );

    res.json({
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        fullname: user.fullname,
        role: user.role,
      },
    });
  } catch (err) {
    next(err);
  }
});

authRouter.get('/me', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      `SELECT u.id, u.username, u.email, u.fullname, r.name as role
       FROM users u JOIN roles r ON u.roleid = r.id
       WHERE u.id = $1`,
      [req.user!.userId]
    );

    if (result.rows.length === 0) {
      throw new AppError('User not found', 404, 'USER_NOT_FOUND');
    }

    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});
