import { useState, useEffect, FormEvent } from 'react';
import { productsApi, categoriesApi, suppliersApi } from '../services/api';
import CsvImportModal from '../components/CsvImportModal';

interface Product {
  id: number; code: string; barcode: string; name: string; description: string;
  categoryid: number; category_name: string; supplierid: number; supplier_name: string;
  purchaseprice: number; saleprice: number; stock: number; minstock: number;
  unit: string; isactive: boolean; requiresprescription: boolean;
  wholesale_price: number; expiry_date: string; requires_tax: boolean;
}
interface Category { id: number; name: string; }
interface Supplier { id: number; name: string; }

export default function Products() {
  const [products, setProducts] = useState<Product[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [form, setForm] = useState<any>({});
  const [error, setError] = useState('');
  const [showImport, setShowImport] = useState(false);

  const handleCsvImport = async (rows: Record<string, string>[]) => {
    const products = rows.map(r => ({
      code: r.code, barcode: r.barcode || '', name: r.name,
      description: r.description || '', categoryid: r.category_id || r.categoryid || null,
      supplierid: r.supplier_id || r.supplierid || null,
      purchaseprice: parseFloat(r.purchase_price || r.purchaseprice) || 0,
      saleprice: parseFloat(r.sale_price || r.saleprice) || 0,
      stock: parseInt(r.stock) || 0, minstock: parseInt(r.min_stock || r.minstock) || 0,
      unit: r.unit || 'pza', wholesale_price: parseFloat(r.wholesale_price || '0') || 0,
      expiry_date: r.expiry_date || r.expirydate || '',
      requiresprescription: (r.requires_prescription || '').toUpperCase() === 'TRUE',
      requires_tax: (r.requires_tax || '').toUpperCase() !== 'FALSE',
    }));
    try {
      const res = await productsApi.importBulk(products);
      const data = res.data;
      return { success: data.created, errors: data.errors || [] };
    } catch (err: any) {
      const message = err.response?.data?.error?.message || err.message || 'Error al importar';
      return { success: 0, errors: [{ row: 0, message }] };
    }
  };

  const fetchProducts = async () => {
    try {
      const res = await productsApi.getAll({ search, limit: 200 });
      setProducts(res.data.products || []);
    } catch (err) { console.error(err); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    fetchProducts();
    categoriesApi.getAll().then(r => setCategories(r.data)).catch(() => {});
    suppliersApi.getAll().then(r => setSuppliers(r.data)).catch(() => {});
  }, []);

  useEffect(() => { fetchProducts(); }, [search]);

  const openCreate = () => {
    setEditId(null);
    setForm({ name: '', code: '', barcode: '', description: '', categoryid: '', supplierid: '', purchaseprice: 0, saleprice: 0, stock: 0, minstock: 0, unit: 'pza', requiresprescription: false, wholesale_price: 0, expiry_date: '', requires_tax: true });
    setShowModal(true);
  };

  const openEdit = (p: Product) => {
    setEditId(p.id);
    setForm({ ...p, categoryid: p.categoryid || '', supplierid: p.supplierid || '' });
    setShowModal(true);
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      const payload = { ...form };
      if (payload.supplierid === '') payload.supplierid = null;
      if (payload.categoryid === '') payload.categoryid = null;
      if (editId) {
        await productsApi.update(editId, payload);
      } else {
        await productsApi.create(payload);
      }
      setShowModal(false);
      fetchProducts();
    } catch (err: any) {
      setError(err.response?.data?.error?.message || 'Error al guardar');
    }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('¿Desactivar este producto?')) return;
    try {
      await productsApi.delete(id);
      fetchProducts();
    } catch (err) { console.error(err); }
  };

  if (loading) return <div className="page-loading">Cargando...</div>;

  return (
    <div className="page">
      <div className="page-header">
        <h1>Productos</h1>
        <div style={{ display: 'flex', gap: '0.5rem' }}>
          <button className="btn-secondary" onClick={() => setShowImport(true)}>📥 Importar CSV</button>
          <button className="btn-primary" onClick={openCreate}>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Nuevo Producto
          </button>
        </div>
      </div>
      <div className="search-bar">
        <input type="text" placeholder="Buscar por nombre, código o código de barras..." value={search} onChange={e => setSearch(e.target.value)} />
      </div>
      <div className="table-container">
        <table className="table">
          <thead>
            <tr>
              <th>Código</th><th>Nombre</th><th>Categoría</th><th>Precio Venta</th><th>Stock</th><th>Stock Mín</th><th>Unidad</th><th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {products.map(p => (
              <tr key={p.id} className={p.stock <= p.minstock ? 'row-warning' : ''}>
                <td>{p.code}</td>
                <td>{p.name}</td>
                <td>{p.category_name}</td>
                <td>${Number(p.saleprice).toFixed(2)}</td>
                <td>{p.stock}</td>
                <td>{p.minstock}</td>
                <td>{p.unit}</td>
                <td className="actions">
                  <button className="btn-sm" onClick={() => openEdit(p)}>Editar</button>
                  <button className="btn-sm btn-danger" onClick={() => handleDelete(p.id)}>Desactivar</button>
                </td>
              </tr>
            ))}
            {products.length === 0 && <tr><td colSpan={8} className="empty">No hay productos</td></tr>}
          </tbody>
        </table>
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <h2>{editId ? 'Editar Producto' : 'Nuevo Producto'}</h2>
            {error && <div className="error-message">{error}</div>}
            <form onSubmit={handleSubmit}>
              <div className="form-row">
                <div className="form-group">
                  <label>Código *</label>
                  <input value={form.code || ''} onChange={e => setForm({...form, code: e.target.value})} required />
                </div>
                <div className="form-group">
                  <label>Código de Barras</label>
                  <input value={form.barcode || ''} onChange={e => setForm({...form, barcode: e.target.value})} />
                </div>
              </div>
              <div className="form-group">
                <label>Nombre *</label>
                <input value={form.name || ''} onChange={e => setForm({...form, name: e.target.value})} required />
              </div>
              <div className="form-group">
                <label>Descripción</label>
                <textarea value={form.description || ''} onChange={e => setForm({...form, description: e.target.value})} />
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Categoría *</label>
                  <select value={form.categoryid || ''} onChange={e => setForm({...form, categoryid: e.target.value})} required>
                    <option value="">Seleccionar...</option>
                    {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
                  </select>
                </div>
                <div className="form-group">
                  <label>Proveedor</label>
                  <select value={form.supplierid || ''} onChange={e => setForm({...form, supplierid: e.target.value})}>
                    <option value="">Seleccionar...</option>
                    {suppliers.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                  </select>
                </div>
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Precio Compra</label>
                  <input type="number" step="0.01" value={form.purchaseprice || 0} onChange={e => setForm({...form, purchaseprice: parseFloat(e.target.value) || 0})} />
                </div>
                <div className="form-group">
                  <label>Precio Venta *</label>
                  <input type="number" step="0.01" value={form.saleprice || 0} onChange={e => setForm({...form, saleprice: parseFloat(e.target.value) || 0})} required />
                </div>
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Stock</label>
                  <input type="number" value={form.stock || 0} onChange={e => setForm({...form, stock: parseInt(e.target.value) || 0})} />
                </div>
                <div className="form-group">
                  <label>Stock Mínimo</label>
                  <input type="number" value={form.minstock || 0} onChange={e => setForm({...form, minstock: parseInt(e.target.value) || 0})} />
                </div>
                <div className="form-group">
                  <label>Unidad</label>
                  <input value={form.unit || 'pza'} onChange={e => setForm({...form, unit: e.target.value})} />
                </div>
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Precio Mayoreo</label>
                  <input type="number" step="0.01" value={form.wholesale_price || 0} onChange={e => setForm({...form, wholesale_price: parseFloat(e.target.value) || 0})} />
                </div>
                <div className="form-group">
                  <label>Fecha Caducidad</label>
                  <input type="date" value={form.expiry_date || ''} onChange={e => setForm({...form, expiry_date: e.target.value})} />
                </div>
              </div>
              <div className="form-row checkbox-row">
                <label>
                  <input type="checkbox" checked={form.requiresprescription || false} onChange={e => setForm({...form, requiresprescription: e.target.checked})} />
                  Requiere Receta
                </label>
                <label>
                  <input type="checkbox" checked={form.requires_tax ?? true} onChange={e => setForm({...form, requires_tax: e.target.checked})} />
                  Aplica IVA
                </label>
              </div>
              <div className="modal-actions">
                <button type="button" className="btn-secondary" onClick={() => setShowModal(false)}>Cancelar</button>
                <button type="submit" className="btn-primary">{editId ? 'Guardar Cambios' : 'Crear Producto'}</button>
              </div>
            </form>
          </div>
        </div>
      )}
      <CsvImportModal
        show={showImport}
        onClose={() => { setShowImport(false); fetchProducts(); }}
        title="Productos"
        sampleCsv="code,name,description,category_id,supplier_id,purchase_price,sale_price,stock,min_stock,unit,wholesale_price,expiry_date,requires_prescription,requires_tax
MED-001,Paracetamol 500mg,Analgesico y antipiretico,1,1,2.50,8.00,200,50,tbl,6.50,2027-06-30,FALSE,TRUE
MED-002,Amoxicilina 500mg,Antibiotico de amplio espectro,2,1,15.00,35.00,100,20,caps,28.00,2026-12-31,TRUE,TRUE
MED-003,Ibuprofeno 400mg,Antiinflamatorio no esteroideo,3,2,3.00,10.00,150,30,tbl,8.00,2027-03-15,FALSE,TRUE
MED-004,Omeprazol 20mg,Inhibidor de bomba de protones,1,1,1.50,6.00,300,50,caps,4.50,2027-09-01,FALSE,TRUE
MED-005,Losartan 50mg,Antihipertensivo,4,3,8.00,22.00,80,15,tbl,18.00,2026-08-20,TRUE,TRUE"
        onImport={handleCsvImport}
      />
    </div>
  );
}
