import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const patientsRouter = Router();

patientsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { search, limit = '50', page = '1' } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);
    let query = `SELECT p.*, c.fullname as customer_name, c.phone as customer_phone
                 FROM patients p JOIN customers c ON p.customerid = c.id WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;
    if (search) {
      query += ` AND (c.fullname ILIKE $${idx} OR c.phone ILIKE $${idx})`;
      params.push(`%${search}%`);
      idx++;
    }
    query += ` ORDER BY c.fullname LIMIT $${idx} OFFSET $${idx + 1}`;
    params.push(parseInt(limit as string), offset);
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { next(err); }
});

patientsRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await pool.query(
      'SELECT p.*, c.fullname as customer_name, c.phone as customer_phone FROM patients p JOIN customers c ON p.customerid = c.id WHERE p.id = $1',
      [req.params.id]
    );
    if (result.rows.length === 0) throw new AppError('Patient not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

patientsRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { customerid, medicalhistory, allergies, bloodtype } = req.body;
    if (!customerid) throw new AppError('customerid is required', 400);
    const result = await pool.query(
      `INSERT INTO patients (customerid, medicalhistory, allergies, bloodtype)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [customerid, medicalhistory || null, allergies || null, bloodtype || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) { next(err); }
});

patientsRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { medicalhistory, allergies, bloodtype } = req.body;
    const result = await pool.query(
      `UPDATE patients SET medicalhistory = COALESCE($1, medicalhistory), allergies = COALESCE($2, allergies),
       bloodtype = COALESCE($3, bloodtype) WHERE id = $4 RETURNING *`,
      [medicalhistory, allergies, bloodtype, req.params.id]
    );
    if (result.rows.length === 0) throw new AppError('Patient not found', 404);
    res.json(result.rows[0]);
  } catch (err) { next(err); }
});

patientsRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM patients WHERE id = $1 RETURNING id', [id]);
    if (result.rows.length === 0) throw new AppError('Patient not found', 404);
    res.json({ message: 'Patient deleted', id: Number(id) });
  } catch (err) { next(err); }
});
