import { Router, Request, Response, NextFunction } from 'express';
import pool from '../config/database';
import { authenticate, authorize } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

export const productsRouter = Router();

productsRouter.get('/', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { categoryid, search, lowstock, page = '1', limit = '50' } = req.query;
    const offset = (parseInt(page as string) - 1) * parseInt(limit as string);

    let query = `SELECT p.*, c.name as category_name, s.name as supplier_name
                 FROM products p LEFT JOIN categories c ON p.categoryid = c.id
                 LEFT JOIN suppliers s ON p.supplierid = s.id WHERE p.isactive = true`;
    const params: any[] = [];
    let paramIndex = 1;

    if (categoryid) {
      query += ` AND p.categoryid = $${paramIndex++}`;
      params.push(categoryid);
    }
    if (search) {
      query += ` AND (p.name ILIKE $${paramIndex} OR p.code ILIKE $${paramIndex} OR p.barcode ILIKE $${paramIndex})`;
      params.push(`%${search}%`);
      paramIndex++;
    }
    if (lowstock === 'true') {
      query += ` AND p.stock <= p.minstock`;
    }

    query += ' ORDER BY p.name LIMIT $' + paramIndex++ + ' OFFSET $' + paramIndex++;
    params.push(parseInt(limit as string), offset);

    const result = await pool.query(query, params);
    res.json({ products: result.rows, page: parseInt(page as string), limit: parseInt(limit as string) });
  } catch (err) {
    next(err);
  }
});

productsRouter.get('/low-stock', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { threshold } = req.query;
    const result = await pool.query(
      `SELECT p.*, c.name as category_name, s.name as supplier_name
       FROM products p LEFT JOIN categories c ON p.categoryid = c.id
       LEFT JOIN suppliers s ON p.supplierid = s.id
       WHERE p.isactive = true AND p.stock <= p.minstock
       ORDER BY (p.stock::float / NULLIF(p.minstock, 0)) ASC`
    );
    res.json({ products: result.rows, count: result.rows.length });
  } catch (err) {
    next(err);
  }
});

productsRouter.get('/category/:categoryId', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { categoryId } = req.params;
    const result = await pool.query(
      `SELECT p.*, c.name as category_name, s.name as supplier_name
       FROM products p LEFT JOIN categories c ON p.categoryid = c.id
       LEFT JOIN suppliers s ON p.supplierid = s.id
       WHERE p.isactive = true AND p.categoryid = $1
       ORDER BY p.name`,
      [categoryId]
    );
    res.json({ products: result.rows, count: result.rows.length });
  } catch (err) {
    next(err);
  }
});

productsRouter.get('/expiring-soon', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { days = '30' } = req.query;
    const result = await pool.query(
      `SELECT p.*, c.name as category_name, s.name as supplier_name
       FROM products p LEFT JOIN categories c ON p.categoryid = c.id
       LEFT JOIN suppliers s ON p.supplierid = s.id
       WHERE p.isactive = true AND p.expiry_date IS NOT NULL
         AND p.expiry_date <= CURRENT_DATE + $1::integer
         AND p.expiry_date >= CURRENT_DATE
       ORDER BY p.expiry_date ASC`,
      [days]
    );
    res.json({ products: result.rows, count: result.rows.length });
  } catch (err) {
    next(err);
  }
});

productsRouter.get('/:id', authenticate, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      `SELECT p.*, c.name as category_name, s.name as supplier_name
       FROM products p LEFT JOIN categories c ON p.categoryid = c.id
       LEFT JOIN suppliers s ON p.supplierid = s.id WHERE p.id = $1`,
      [id]
    );
    if (result.rows.length === 0) throw new AppError('Product not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// Bulk import from CSV with duplicate handling (ON CONFLICT)
productsRouter.post('/import', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { products } = req.body;
    if (!Array.isArray(products) || products.length === 0) {
      throw new AppError('Se requiere un arreglo de productos', 400, 'VALIDATION_ERROR');
    }
    const results = { created: 0, skipped: 0, errors: [] as { row: number; message: string }[] };

    for (let i = 0; i < products.length; i++) {
      const p = products[i];
      try {
        if (!p.code || !p.name) {
          results.errors.push({ row: i + 1, message: 'Código y nombre son requeridos' });
          continue;
        }
        // Check if code already exists
        const existing = await pool.query('SELECT id FROM products WHERE code = $1', [p.code]);
        if (existing.rows.length > 0) {
          results.skipped++;
          continue;
        }
        await pool.query(
          `INSERT INTO products (code, barcode, name, description, categoryid, supplierid,
            purchaseprice, saleprice, stock, minstock, unit, requiresprescription,
            wholesale_price, expiry_date, requires_tax)
           VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)`,
          [p.code, p.barcode || '', p.name, p.description || '', p.categoryid || null,
           p.supplierid || null, p.purchaseprice || 0, p.saleprice || 0, p.stock || 0,
           p.minstock || 0, p.unit || 'pza', p.requiresprescription || false,
           p.wholesale_price || 0, p.expiry_date || null, p.requires_tax !== false]
        );
        results.created++;
      } catch (err: any) {
        results.errors.push({ row: i + 1, message: err.message || 'Error desconocido' });
      }
    }
    res.json(results);
  } catch (err) {
    next(err);
  }
});

productsRouter.post('/', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { code, barcode, name, description, categoryid, supplierid, purchaseprice, saleprice, stock, minstock, unit, requiresprescription, wholesale_price, expiry_date, requires_tax } = req.body;
    if (!code || !name || !categoryid) throw new AppError('Code, name, and category are required', 400, 'VALIDATION_ERROR');

    const result = await pool.query(
      `INSERT INTO products (code, barcode, name, description, categoryid, supplierid, purchaseprice, saleprice, stock, minstock, unit, requiresprescription, wholesale_price, expiry_date, requires_tax)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15) RETURNING *`,
      [code, barcode, name, description, categoryid, supplierid === '' ? null : supplierid, purchaseprice, saleprice, stock || 0, minstock || 0, unit, requiresprescription || false, wholesale_price, expiry_date, requires_tax]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

productsRouter.put('/:id', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const fields = ['code', 'barcode', 'name', 'description', 'categoryid', 'supplierid', 'purchaseprice', 'saleprice', 'stock', 'minstock', 'unit', 'isactive', 'requiresprescription', 'wholesale_price', 'expiry_date', 'requires_tax'];
    const setClauses: string[] = [];
    const values: any[] = [];
    let idx = 1;

    for (const field of fields) {
      if (req.body[field] !== undefined) {
        let val = req.body[field];
        if (val === '' && (field === 'supplierid' || field === 'categoryid')) val = null;
        setClauses.push(`${field} = $${idx++}`);
        values.push(val);
      }
    }

    if (setClauses.length === 0) throw new AppError('No fields to update', 400, 'VALIDATION_ERROR');

    setClauses.push(`updatedat = NOW()`);
    values.push(id);

    const result = await pool.query(
      `UPDATE products SET ${setClauses.join(', ')} WHERE id = $${idx} RETURNING *`,
      values
    );
    if (result.rows.length === 0) throw new AppError('Product not found', 404, 'NOT_FOUND');
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

productsRouter.delete('/:id', authenticate, authorize('admin'), async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const result = await pool.query('UPDATE products SET isactive = false WHERE id = $1 RETURNING *', [id]);
    if (result.rows.length === 0) throw new AppError('Product not found', 404, 'NOT_FOUND');
    res.json({ message: 'Product deactivated' });
  } catch (err) {
    next(err);
  }
});
