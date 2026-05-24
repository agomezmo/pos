import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const prescriptionsRouter = Router();

prescriptionsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { patientid, limit = '50', page = '1' } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);
    let query = `SELECT rx.*, c.fullname as patient_name
                 FROM prescriptions rx
                 JOIN patients p ON rx.patientid = p.id
                 JOIN customers c ON p.customerid = c.id WHERE 1=1`;
    const params: any[] = [];
    let idx = 1;
    if (patientid) { query += ` AND rx.patientid = $${idx++}`; params.push(patientid); }
    query += ` ORDER BY rx.issueddate DESC LIMIT $${idx} OFFSET $${idx + 1}`;
    params.push(parseInt(limit as string), offset);
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { next(err); }
});

prescriptionsRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const rx = await pool.query(
      `SELECT rx.*, c.fullname as patient_name
       FROM prescriptions rx JOIN patients p ON rx.patientid = p.id
       JOIN customers c ON p.customerid = c.id WHERE rx.id = $1`,
      [req.params.id]
    );
    if (rx.rows.length === 0) throw new AppError('Prescription not found', 404);
    const items = await pool.query(
      `SELECT ri.*, pr.name as product_name, pr.code as product_code
       FROM prescriptionitems ri JOIN products pr ON ri.productid = pr.id
       WHERE ri.prescriptionid = $1`,
      [req.params.id]
    );
    res.json({ ...rx.rows[0], items: items.rows });
  } catch (err) { next(err); }
});

prescriptionsRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  const client = await pool.connect();
  try {
    const { patientid, doctorname, doctorlicense, diagnosis, notes, issueddate, expirydate, items } = req.body;
    if (!patientid || !doctorname) throw new AppError('patientid and doctorname are required', 400);

    await client.query('BEGIN');
    const rx = await client.query(
      `INSERT INTO prescriptions (patientid, doctorname, doctorlicense, diagnosis, notes, issueddate, expirydate)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [patientid, doctorname, doctorlicense || null, diagnosis || null, notes || null,
       issueddate || new Date().toISOString(), expirydate || null]
    );
    const rxId = rx.rows[0].id;

    if (items && Array.isArray(items)) {
      for (const item of items) {
        await client.query(
          `INSERT INTO prescriptionitems (prescriptionid, productid, dosage, frequency, duration, notes)
           VALUES ($1, $2, $3, $4, $5, $6)`,
          [rxId, item.productid, item.dosage || null, item.frequency || null, item.duration || null, item.notes || null]
        );
      }
    }
    await client.query('COMMIT');
    res.status(201).json({ ...rx.rows[0], items: items || [] });
  } catch (err) {
    await client.query('ROLLBACK');
    next(err);
  } finally {
    client.release();
  }
});
