import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const customersRouter = Router();

customersRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { search } = req.query;
    let query = 'SELECT c.*, rf.descripcion as regimen_fiscal_desc, ucf.descripcion as uso_cfdi_desc FROM customers c LEFT JOIN cat_regimen_fiscal rf ON c.regimenfiscalid = rf.id LEFT JOIN cat_uso_cfdi ucf ON c.usocfdiid = ucf.id WHERE 1=1';
    const params: any[] = [];
    let idx = 1;

    if (search) {
      query += ` AND (c.fullname ILIKE $${idx} OR c.documentnumber ILIKE $${idx} OR c.rfc ILIKE $${idx})`;
      params.push(`%${search}%`);
      idx++;
    }
    query += ' ORDER BY c.fullname';

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

customersRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      `SELECT c.*, rf.descripcion as regimen_fiscal_desc, ucf.descripcion as uso_cfdi_desc
       FROM customers c LEFT JOIN cat_regimen_fiscal rf ON c.regimenfiscalid = rf.id
       LEFT JOIN cat_uso_cfdi ucf ON c.usocfdiid = ucf.id WHERE c.id = $1`, [id]
    );
    if (result.rows.length === 0) throw new AppError('Customer not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

customersRouter.post('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { documenttype, documentnumber, fullname, phone, email, address, rfc, razonsocial, codigopostal, regimenfiscalid, usocfdiid } = req.body;
    if (!documenttype || !documentnumber || !fullname) throw new AppError('Document type, number, and full name are required', 400, 'VALIDATION_ERROR');

    const result = await pool.query(
      `INSERT INTO customers (documenttype, documentnumber, fullname, phone, email, address, rfc, razonsocial, codigopostal, regimenfiscalid, usocfdiid)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING *`,
      [documenttype, documentnumber, fullname, phone, email, address, rfc, razonsocial, codigopostal, regimenfiscalid, usocfdiid]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

customersRouter.put('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const fields = ['documenttype', 'documentnumber', 'fullname', 'phone', 'email', 'address', 'rfc', 'razonsocial', 'codigopostal', 'regimenfiscalid', 'usocfdiid'];
    const setClauses: string[] = [];
    const values: any[] = [];
    let idx = 1;

    for (const field of fields) {
      if (req.body[field] !== undefined) {
        setClauses.push(`${field} = $${idx++}`);
        values.push(req.body[field]);
      }
    }
    if (setClauses.length === 0) throw new AppError('No fields to update', 400, 'VALIDATION_ERROR');
    setClauses.push('updatedat = NOW()');
    values.push(id);

    const result = await pool.query(`UPDATE customers SET ${setClauses.join(', ')} WHERE id = $${idx} RETURNING *`, values);
    if (result.rows.length === 0) throw new AppError('Customer not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

customersRouter.delete('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM customers WHERE id = $1 RETURNING id', [id]);
    if (result.rows.length === 0) throw new AppError('Customer not found', 404, 'NOT_FOUND');
    res.json({ message: 'Customer deleted', id: Number(id) });
  } catch (err) {
    next(err);
  }
});
