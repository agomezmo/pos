import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const appointmentsRouter = Router();

appointmentsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { status, startdate, enddate, limit = '50', page = '1' } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);

    let query = `SELECT a.*,
                  c.fullname as patient_name,
                  c.phone as patient_phone,
                  u.fullname as doctor_name
                 FROM appointments a
                 JOIN patients p ON a.patientid = p.id
                 JOIN customers c ON p.customerid = c.id
                 LEFT JOIN users u ON a.userid = u.id
                 WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;

    if (status) {
      query += ` AND a.status = $${idx++}`;
      params.push(status);
    }
    if (startdate) {
      query += ` AND a.appointmentdate >= $${idx++}`;
      params.push(startdate);
    }
    if (enddate) {
      query += ` AND a.appointmentdate <= $${idx++}`;
      params.push(enddate);
    }

    query += ` ORDER BY a.appointmentdate DESC LIMIT $${idx++} OFFSET $${idx++}`;
    params.push(parseInt(limit as string), offset);

    const result = await pool.query(query, params);
    res.json({ appointments: result.rows, page: parseInt(page as string), limit: parseInt(limit as string) });
  } catch (err) {
    next(err);
  }
});

appointmentsRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      `SELECT a.*,
        c.fullname as patient_name,
        c.phone as patient_phone,
        u.fullname as doctor_name
       FROM appointments a
       JOIN patients p ON a.patientid = p.id
       JOIN customers c ON p.customerid = c.id
       LEFT JOIN users u ON a.userid = u.id
       WHERE a.id = $1`,
      [id]
    );
    if (result.rows.length === 0) throw new AppError('Appointment not found', 404);
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

appointmentsRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { patientid, userid, appointmentdate, status, notes } = req.body;
    if (!patientid || !appointmentdate) {
      throw new AppError('patientid and appointmentdate are required', 400);
    }

    const result = await pool.query(
      `INSERT INTO appointments (patientid, userid, appointmentdate, status, notes)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [patientid, userid || null, appointmentdate, status || 'Scheduled', notes || null]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

appointmentsRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const fields = ['patientid', 'userid', 'appointmentdate', 'status', 'notes'];
    const setClauses: string[] = [];
    const values: any[] = [];
    let idx = 1;

    for (const field of fields) {
      if (req.body[field] !== undefined) {
        setClauses.push(`${field} = $${idx++}`);
        values.push(req.body[field]);
      }
    }

    if (setClauses.length === 0) throw new AppError('No fields to update', 400);

    values.push(id);
    const result = await pool.query(
      `UPDATE appointments SET ${setClauses.join(', ')} WHERE id = $${idx} RETURNING *`,
      values
    );
    if (result.rows.length === 0) throw new AppError('Appointment not found', 404);
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

appointmentsRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM appointments WHERE id = $1 RETURNING *', [id]);
    if (result.rows.length === 0) throw new AppError('Appointment not found', 404);
    res.json({ message: 'Appointment deleted', id });
  } catch (err) {
    next(err);
  }
});
