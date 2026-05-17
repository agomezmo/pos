import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';

export const companyRouter = Router();

companyRouter.get('/', authenticate, async (_req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query('SELECT * FROM companyinfo LIMIT 1');
    if (result.rows.length === 0) {
      return res.json({
        name: 'Mi Empresa',
        rfc: '',
        address: '',
        phone: '',
        email: '',
        logo_url: null,
      });
    }
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

companyRouter.put('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { name, rfc, address, phone, email, logo_url } = req.body;
    const existing = await pool.query('SELECT id FROM companyinfo LIMIT 1');

    if (existing.rows.length > 0) {
      const result = await pool.query(
        `UPDATE companyinfo SET name = COALESCE($1, name), rfc = COALESCE($2, rfc),
         address = COALESCE($3, address), phone = COALESCE($4, phone),
         email = COALESCE($5, email), logo_url = COALESCE($6, logo_url)
         WHERE id = $7 RETURNING *`,
        [name, rfc, address, phone, email, logo_url, existing.rows[0].id]
      );
      res.json(result.rows[0]);
    } else {
      const result = await pool.query(
        `INSERT INTO companyinfo (name, rfc, address, phone, email, logo_url)
         VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
        [name, rfc, address, phone, email, logo_url]
      );
      res.status(201).json(result.rows[0]);
    }
  } catch (err) {
    next(err);
  }
});
