import { useState, useEffect, useMemo } from 'react';
import api from '../services/api';

interface Campaign {
  id: number; name: string; description: string; status: string;
  offer_type: string; offer_value: number; min_expiry_days: number; max_expiry_days: number;
  notes: string; created_by_name: string; created_at: string; sent_at: string;
  product_count: number; customer_count: number; sent_count: number;
}

interface Product {
  id: number; name: string; code: string; barcode: string;
  category_name: string; saleprice: number; purchaseprice: number; expiry_date: string;
}

interface Customer {
  id: number; fullname: string; email: string; phone: string; documentnumber: string;
}

const OFFER_TYPES = [
  { value: 'cost_price', label: 'Precio de costo' },
  { value: 'percentage', label: 'Descuento %' },
  { value: 'fixed', label: 'Precio fijo' },
] as const;

const CATEGORY_COLORS: Record<string, string> = {
  'Analgésicos': '#ef4444', 'Antibióticos': '#f97316', 'Cardiovasculares': '#e11d48',
  'Cuidado Personal': '#a855f7', 'Dermatológicos': '#ec4899', 'Gastrointestinales': '#f59e0b',
  'Respiratorios': '#3b82f6', 'Sistema Nervioso': '#8b5cf6', 'Vitaminas': '#22c55e',
};

export default function Campaigns() {
  const [campaigns, setCampaigns] = useState<Campaign[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [showDetail, setShowDetail] = useState<Campaign | null>(null);
  const [detailData, setDetailData] = useState<any>(null);
  const [products, setProducts] = useState<Product[]>([]);
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [sending, setSending] = useState(false);
  const [productSearch, setProductSearch] = useState('');
  const [customerSearch, setCustomerSearch] = useState('');
  const [activeCategory, setActiveCategory] = useState('');

  const [form, setForm] = useState({
    name: '', description: '', offer_type: 'cost_price', offer_value: 0,
    min_expiry_days: 30, max_expiry_days: 90, notes: '',
    product_ids: [] as number[], customer_ids: [] as number[],
  });

  useEffect(() => { loadCampaigns(); }, []);

  const loadCampaigns = async () => {
    try {
      const res = await api.get('/campaigns');
      setCampaigns(res.data);
    } catch (err) { console.error(err); } finally { setLoading(false); }
  };

  const categories = useMemo(() => Array.from(new Set(products.map(p => p.category_name || 'Sin categoría'))).sort(), [products]);
  const categoryCounts = useMemo(() => {
    const map: Record<string, number> = {};
    for (const p of products) { const cat = p.category_name || 'Sin categoría'; map[cat] = (map[cat] || 0) + 1; }
    return map;
  }, [products]);

  const filteredProducts = useMemo(() => {
    const s = productSearch.toLowerCase().trim();
    return products.filter(p => {
      if (activeCategory && (p.category_name || 'Sin categoría') !== activeCategory) return false;
      return !s || p.name.toLowerCase().includes(s) || p.code.toLowerCase().includes(s);
    });
  }, [products, productSearch, activeCategory]);

  const filteredCustomers = useMemo(() => {
    const s = customerSearch.toLowerCase().trim();
    if (!s) return customers;
    return customers.filter(c => c.fullname.toLowerCase().includes(s) || (c.email || '').toLowerCase().includes(s) || (c.phone || '').includes(s));
  }, [customers, customerSearch]);

  const openCreate = async () => {
    try {
      const [pr, cr] = await Promise.all([
        api.get('/campaigns/expiring-products/list', { params: { days: 90 } }),
        api.get('/campaigns/available-customers/list'),
      ]);
      setProducts(pr.data); setCustomers(cr.data);
    } catch (err) { console.error(err); }
    setForm({ name: '', description: '', offer_type: 'cost_price', offer_value: 0, min_expiry_days: 30, max_expiry_days: 90, notes: '', product_ids: [], customer_ids: [] });
    setProductSearch(''); setCustomerSearch(''); setActiveCategory('');
    setShowForm(true);
  };

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try { await api.post('/campaigns', form); setShowForm(false); loadCampaigns(); }
    catch (err: any) { alert(err.response?.data?.error?.message || err.response?.data?.error || 'Error al crear campaña'); }
  };

  const viewDetail = async (c: Campaign) => {
    try { const r = await api.get(`/campaigns/${c.id}`); setDetailData(r.data); setShowDetail(r.data); }
    catch (err) { console.error(err); }
  };

  const [sendChannels, setSendChannels] = useState({ email: false, whatsapp: false });
  const [showSendModal, setShowSendModal] = useState(false);
  const [sendCampaignId, setSendCampaignId] = useState<number | null>(null);

  const openSendModal = (id: number, hasEmail: boolean, hasPhone: boolean) => {
    setSendCampaignId(id);
    setSendChannels({ email: hasEmail, whatsapp: hasPhone });
    setShowSendModal(true);
  };

  const handleSend = async () => {
    const channels = [];
    if (sendChannels.email) channels.push('email');
    if (sendChannels.whatsapp) channels.push('whatsapp');
    if (channels.length === 0) { alert('Selecciona al menos un canal de envío'); return; }
    if (!confirm(`Enviar esta campaña por ${channels.map(c => c === 'email' ? 'Email' : 'WhatsApp').join(' y ')}?`)) return;
    setSending(true);
    setShowSendModal(false);
    try {
      const r = await api.post(`/campaigns/${sendCampaignId}/send`, { channels });
      alert(r.data.message); viewDetail(showDetail!); loadCampaigns();
    } catch (err: any) { alert(err.response?.data?.error?.message || err.response?.data?.error || 'Error al enviar'); }
    finally { setSending(false); setSendCampaignId(null); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('Eliminar campaña?')) return;
    try { await api.delete(`/campaigns/${id}`); setShowDetail(null); loadCampaigns(); }
    catch (err: any) { alert(err.response?.data?.error?.message || err.response?.data?.error || 'Error al eliminar'); }
  };

  const toggleProduct = (id: number) => setForm(p => ({ ...p, product_ids: p.product_ids.includes(id) ? p.product_ids.filter(x => x !== id) : [...p.product_ids, id] }));
  const toggleCustomer = (id: number) => setForm(p => ({ ...p, customer_ids: p.customer_ids.includes(id) ? p.customer_ids.filter(x => x !== id) : [...p.customer_ids, id] }));

  const selectAllProducts = () => setForm(p => ({ ...p, product_ids: products.map(x => x.id) }));
  const deselectAllProducts = () => setForm(p => ({ ...p, product_ids: [] }));
  const selectExpiringSoon = (n: number) => {
    const now = Date.now();
    setForm(p => ({ ...p, product_ids: products.filter(x => { if (!x.expiry_date) return false; const d = Math.ceil((new Date(x.expiry_date).getTime() - now) / 86400000); return d > 0 && d <= n; }).map(x => x.id) }));
  };
  const selectAllCustomers = () => setForm(p => ({ ...p, customer_ids: customers.map(x => x.id) }));
  const selectWithEmail = () => setForm(p => ({ ...p, customer_ids: customers.filter(x => x.email).map(x => x.id) }));
  const selectWithPhone = () => setForm(p => ({ ...p, customer_ids: customers.filter(x => x.phone).map(x => x.id) }));
  const deselectAllCustomers = () => setForm(p => ({ ...p, customer_ids: [] }));

  const fDate = (d: string) => d ? new Date(d).toLocaleDateString() : '-';
  const fCur = (n: number) => `$${Number(n).toFixed(2)}`;

  const badge = (s: string) => {
    const m: Record<string, string> = { draft: 'bg-gray-100 text-gray-600', active: 'bg-blue-100 text-blue-700', completed: 'bg-green-100 text-green-700', cancelled: 'bg-red-100 text-red-700' };
    const l: Record<string, string> = { draft: 'Borrador', active: 'Activa', completed: 'Enviada', cancelled: 'Cancelada' };
    return <span className={`px-2 py-0.5 rounded-full text-xs font-semibold ${m[s] || 'bg-gray-100 text-gray-600'}`}>{l[s] || s}</span>;
  };

  if (loading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-green-600" /></div>;

  return (
    <div className="space-y-6">
      {/* ── Header ─────────────────────────────────────────────────────────── */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Campañas</h1>
          <p className="text-sm text-gray-500 mt-0.5">Crea y envía ofertas a tus clientes</p>
        </div>
        <button onClick={openCreate}
          className="btn-primary">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          Nueva Campaña
        </button>
      </div>

      {/* ── List ───────────────────────────────────────────────────────────── */}
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        {campaigns.length === 0 ? (
          <p className="text-center py-12 text-gray-400 text-sm">No hay campañas. Crea la primera.</p>
        ) : (
          <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-50 border-b border-gray-200">
                  <th className="text-left py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Nombre</th>
                  <th className="text-left py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Estado</th>
                  <th className="text-center py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Prod.</th>
                  <th className="text-center py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Clientes</th>
                  <th className="text-center py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Env.</th>
                  <th className="text-left py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Creada</th>
                  <th className="text-center py-3 px-4 text-gray-500 font-semibold text-xs uppercase">Envío</th>
                </tr>
              </thead>
              <tbody>
                {campaigns.map(c => (
                  <tr key={c.id} onClick={() => viewDetail(c)}
                    className="border-b border-gray-100 hover:bg-gray-50 cursor-pointer last:border-0 transition-colors">
                    <td className="py-3 px-4 font-medium text-gray-800">{c.name}</td>
                    <td className="py-3 px-4">{badge(c.status)}</td>
                    <td className="py-3 px-4 text-center text-gray-700">{c.product_count}</td>
                    <td className="py-3 px-4 text-center text-gray-700">{c.customer_count}</td>
                    <td className="py-3 px-4 text-center text-gray-700">{c.sent_count}</td>
                    <td className="py-3 px-4 text-gray-500 text-sm">{fDate(c.created_at)}</td>
                    <td className="py-3 px-4 text-center">
                      {c.status === 'draft' && (
                        <button onClick={e => { e.stopPropagation(); openSendModal(c.id, true, true); }}
                          className="text-xs font-semibold text-emerald-600 bg-emerald-50 hover:bg-emerald-100 px-3 py-1.5 rounded-lg transition-colors border border-emerald-200">
                          Enviar
                        </button>
                      )}
                      {c.status === 'completed' && (
                        <span className="text-xs text-gray-400">✓ Enviada</span>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
          </table>
        )}
      </div>

      {/* ══════════════════════════════════════════════════════════════════════ */}
      {/* NUEVA CAMPAÑA — Elegant modal like User creation                    */}
      {/* ══════════════════════════════════════════════════════════════════════ */}
      {showForm && (
        <div className="modal-overlay" onClick={e => { if (e.target === e.currentTarget) setShowForm(false); }}>
          <div className="modal modal-xl" onClick={e => e.stopPropagation()}>

            <h2>Nueva campaña</h2>
            <p className="subtitle">Completa los datos para crear la promoción</p>

            <form onSubmit={handleCreate}>
              <div className="form-row">
                <div className="form-group" style={{ flex: 2 }}>
                  <label>Nombre de la campaña *</label>
                  <input required value={form.name}
                    onChange={e => setForm({ ...form, name: e.target.value })}
                    placeholder="Ej: Ofertas de temporada" />
                </div>
                <div className="form-group">
                  <label>Tipo de oferta</label>
                  <select value={form.offer_type}
                    onChange={e => setForm({ ...form, offer_type: e.target.value })}>
                    {OFFER_TYPES.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                  </select>
                </div>
              </div>

              <div className="form-row">
                {form.offer_type !== 'cost_price' && (
                  <div className="form-group">
                    <label>{form.offer_type === 'percentage' ? 'Descuento %' : 'Precio fijo ($)'}</label>
                    <input type="number" step="0.01" min="0" value={form.offer_value}
                      onChange={e => setForm({ ...form, offer_value: Number(e.target.value) })} />
                  </div>
                )}
                <div className="form-group" style={form.offer_type === 'cost_price' ? { flex: 2 } : {}}>
                  <label>Días para caducar</label>
                  <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                    <input type="number" min="1" value={form.min_expiry_days}
                      onChange={e => setForm({ ...form, min_expiry_days: Number(e.target.value) })} />
                    <span style={{ color: '#9ca3af', fontWeight: 500 }}>—</span>
                    <input type="number" min="1" value={form.max_expiry_days}
                      onChange={e => setForm({ ...form, max_expiry_days: Number(e.target.value) })} />
                  </div>
                </div>
                <div className="form-group">
                  <label>Notas</label>
                  <input value={form.notes}
                    onChange={e => setForm({ ...form, notes: e.target.value })}
                    placeholder="Opcional" />
                </div>
              </div>

              {/* Tabs for Products / Customers */}
              <div style={{ display: 'flex', gap: '0.5rem', margin: '1rem 0 0.5rem' }}>
                <span style={{ fontWeight: 700, color: '#374151', fontSize: '0.85rem' }}>Productos</span>
                <span style={{ color: '#9ca3af' }}>|</span>
                <span style={{ fontWeight: 700, color: '#374151', fontSize: '0.85rem' }}>Clientes</span>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                {/* ── PRODUCTOS ──────────────────────────────────────────── */}
                <div style={{ border: '1px solid #e5e7eb', borderRadius: '8px', padding: '0.75rem' }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                    <span style={{ fontSize: '0.8rem', fontWeight: 600, color: '#374151' }}>Selección</span>
                    <span style={{ fontSize: '0.75rem', color: '#9ca3af' }}>{form.product_ids.length}/{products.length}</span>
                  </div>
                  <input type="text" placeholder="Buscar producto..."
                    value={productSearch}
                    onChange={e => { setProductSearch(e.target.value); setActiveCategory(''); }}
                    style={{ width: '100%', padding: '0.4rem 0.6rem', border: '1px solid #d1d5db', borderRadius: '6px', fontSize: '0.8rem', marginBottom: '0.5rem', boxSizing: 'border-box' }} />
                  <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.25rem', marginBottom: '0.5rem' }}>
                    <button type="button" onClick={selectAllProducts} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem' }}>Todos</button>
                    <button type="button" onClick={() => selectExpiringSoon(7)} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem', background: '#fef2f2', color: '#dc2626' }}>7d</button>
                    <button type="button" onClick={() => selectExpiringSoon(15)} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem', background: '#fff7ed', color: '#ea580c' }}>15d</button>
                    <button type="button" onClick={() => selectExpiringSoon(30)} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem', background: '#fffbeb', color: '#d97706' }}>30d</button>
                    <button type="button" onClick={deselectAllProducts} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem' }}>Limpiar</button>
                  </div>
                  <div style={{ display: 'flex', gap: '0.25rem', flexWrap: 'wrap', marginBottom: '0.5rem' }}>
                    <button type="button" onClick={() => setActiveCategory('')}
                      className="btn-sm" style={{ fontSize: '0.65rem', padding: '0.15rem 0.5rem', background: !activeCategory ? '#1f2937' : '#f3f4f6', color: !activeCategory ? '#fff' : '#6b7280' }}>Todas</button>
                    {categories.map(cat => (
                      <button key={cat} type="button" onClick={() => { setActiveCategory(cat); setProductSearch(''); }}
                        className="btn-sm" style={{ fontSize: '0.65rem', padding: '0.15rem 0.5rem', background: activeCategory === cat ? (CATEGORY_COLORS[cat] || '#6b7280') : '#f3f4f6', color: activeCategory === cat ? '#fff' : '#6b7280' }}>
                        {cat} {categoryCounts[cat] || 0}
                      </button>
                    ))}
                  </div>
                  <div style={{ maxHeight: '200px', overflowY: 'auto', border: '1px solid #e5e7eb', borderRadius: '6px' }}>
                    {filteredProducts.length === 0 ? (
                      <p style={{ textAlign: 'center', padding: '2rem', color: '#d1d5db', fontSize: '0.8rem' }}>Sin resultados</p>
                    ) : (
                      filteredProducts.map(p => {
                        const days = p.expiry_date ? Math.ceil((new Date(p.expiry_date).getTime() - Date.now()) / 86400000) : 0;
                        const sel = form.product_ids.includes(p.id);
                        return (
                          <div key={p.id} onClick={() => toggleProduct(p.id)}
                            style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', padding: '0.4rem 0.6rem', cursor: 'pointer', borderBottom: '1px solid #f3f4f6', fontSize: '0.8rem', background: sel ? '#f0fdf4' : 'transparent' }}>
                            <input type="checkbox" checked={sel} readOnly style={{ accentColor: '#16a34a', width: '14px', height: '14px', pointerEvents: 'none' }} />
                            <div style={{ flex: 1, minWidth: 0 }}>
                              <span style={{ display: 'block', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', fontWeight: sel ? 600 : 400 }}>{p.name}</span>
                            </div>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', flexShrink: 0 }}>
                              {days > 0 && days <= 30 && (
                                <span style={{ fontSize: '0.65rem', fontWeight: 700, padding: '0.1rem 0.3rem', borderRadius: '4px',
                                  background: days <= 7 ? '#fef2f2' : days <= 15 ? '#fff7ed' : '#fffbeb',
                                  color: days <= 7 ? '#dc2626' : days <= 15 ? '#ea580c' : '#d97706' }}>{days}d</span>
                              )}
                              <span style={{ fontSize: '0.7rem', color: '#9ca3af', textDecoration: 'line-through' }}>${Number(p.saleprice).toFixed(2)}</span>
                              <span style={{ fontSize: '0.7rem', fontWeight: 700, color: '#16a34a' }}>${Number(p.purchaseprice).toFixed(2)}</span>
                            </div>
                          </div>
                        );
                      })
                    )}
                  </div>
                </div>

                {/* ── CLIENTES ───────────────────────────────────────────── */}
                <div style={{ border: '1px solid #e5e7eb', borderRadius: '8px', padding: '0.75rem' }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                    <span style={{ fontSize: '0.8rem', fontWeight: 600, color: '#374151' }}>Selección</span>
                    <span style={{ fontSize: '0.75rem', color: '#9ca3af' }}>{form.customer_ids.length}/{customers.length}</span>
                  </div>
                  <input type="text" placeholder="Buscar cliente..."
                    value={customerSearch}
                    onChange={e => setCustomerSearch(e.target.value)}
                    style={{ width: '100%', padding: '0.4rem 0.6rem', border: '1px solid #d1d5db', borderRadius: '6px', fontSize: '0.8rem', marginBottom: '0.5rem', boxSizing: 'border-box' }} />
                  <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.25rem', marginBottom: '0.5rem' }}>
                    <button type="button" onClick={selectAllCustomers} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem' }}>Todos</button>
                    <button type="button" onClick={selectWithEmail} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem', background: '#eff6ff', color: '#2563eb' }}>Email</button>
                    <button type="button" onClick={selectWithPhone} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem', background: '#ecfdf5', color: '#059669' }}>Tel</button>
                    <button type="button" onClick={deselectAllCustomers} className="btn-sm" style={{ fontSize: '0.7rem', padding: '0.2rem 0.6rem' }}>Limpiar</button>
                  </div>
                  <div style={{ maxHeight: '200px', overflowY: 'auto', border: '1px solid #e5e7eb', borderRadius: '6px' }}>
                    {filteredCustomers.length === 0 ? (
                      <p style={{ textAlign: 'center', padding: '2rem', color: '#d1d5db', fontSize: '0.8rem' }}>Sin resultados</p>
                    ) : (
                      filteredCustomers.map(c => {
                        const sel = form.customer_ids.includes(c.id);
                        return (
                          <div key={c.id} onClick={() => toggleCustomer(c.id)}
                            style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', padding: '0.4rem 0.6rem', cursor: 'pointer', borderBottom: '1px solid #f3f4f6', fontSize: '0.8rem', background: sel ? '#eff6ff' : 'transparent' }}>
                            <input type="checkbox" checked={sel} readOnly style={{ accentColor: '#2563eb', width: '14px', height: '14px', pointerEvents: 'none' }} />
                            <div style={{ flex: 1, minWidth: 0 }}>
                              <span style={{ display: 'block', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', fontWeight: sel ? 600 : 400 }}>{c.fullname}</span>
                            </div>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', flexShrink: 0 }}>
                              {c.email && <span style={{ fontSize: '0.65rem', background: '#eff6ff', color: '#2563eb', padding: '0.1rem 0.3rem', borderRadius: '4px' }}>@</span>}
                              {c.phone && <span style={{ fontSize: '0.65rem', background: '#ecfdf5', color: '#059669', padding: '0.1rem 0.3rem', borderRadius: '4px' }}>📞</span>}
                            </div>
                          </div>
                        );
                      })
                    )}
                  </div>
                </div>
              </div>

              <div className="modal-actions">
                <button type="button" className="btn-secondary" onClick={() => setShowForm(false)}>Cancelar</button>
                <button type="submit" className="btn-primary"
                  disabled={!form.name || form.product_ids.length === 0 || form.customer_ids.length === 0}>
                  Crear campaña
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ══════════════════════════════════════════════════════════════════════ */}
      {/* DETALLE DE CAMPAÑA                                                    */}
      {/* ══════════════════════════════════════════════════════════════════════ */}
      {showDetail && (
        <div className="fixed inset-0 bg-black/40 z-[1000] flex items-start justify-center overflow-y-auto py-6"
          onClick={e => { if (e.target === e.currentTarget) setShowDetail(null); }}>
          <div className="bg-white rounded-xl shadow-2xl w-full max-w-4xl mx-4"
            onClick={e => e.stopPropagation()}>

            {/* header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200">
              <div>
                <div className="flex items-center gap-3">
                  <h2 className="text-xl font-bold text-gray-800">{detailData.name}</h2>
                  {badge(detailData.status)}
                </div>
                <p className="text-sm text-gray-500 mt-0.5">{detailData.description || 'Sin descripción'}</p>
              </div>
              <button onClick={() => setShowDetail(null)}
                className="w-8 h-8 rounded-lg hover:bg-gray-100 flex items-center justify-center text-gray-400 hover:text-gray-600 text-xl leading-none">&times;</button>
            </div>

            <div className="px-6 py-5 space-y-6">

              {/* Info cards */}
              <div className="grid grid-cols-4 gap-4">
                <div className="bg-gray-50 rounded-lg px-4 py-3 border border-gray-100">
                  <p className="text-xs text-gray-500 font-semibold uppercase tracking-wider">Tipo</p>
                  <p className="text-sm font-semibold text-gray-800 mt-1">{OFFER_TYPES.find(t => t.value === detailData.offer_type)?.label || detailData.offer_type}</p>
                </div>
                {detailData.offer_value > 0 && (
                  <div className="bg-gray-50 rounded-lg px-4 py-3 border border-gray-100">
                    <p className="text-xs text-gray-500 font-semibold uppercase tracking-wider">Valor</p>
                    <p className="text-sm font-semibold text-gray-800 mt-1">{detailData.offer_type === 'percentage' ? `${detailData.offer_value}%` : `$${detailData.offer_value}`}</p>
                  </div>
                )}
                <div className="bg-gray-50 rounded-lg px-4 py-3 border border-gray-100">
                  <p className="text-xs text-gray-500 font-semibold uppercase tracking-wider">Vencimiento</p>
                  <p className="text-sm font-semibold text-gray-800 mt-1">{detailData.min_expiry_days}–{detailData.max_expiry_days} días</p>
                </div>
                <div className="bg-gray-50 rounded-lg px-4 py-3 border border-gray-100">
                  <p className="text-xs text-gray-500 font-semibold uppercase tracking-wider">Creada por</p>
                  <p className="text-sm font-semibold text-gray-800 mt-1">{detailData.created_by_name}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{fDate(detailData.created_at)}</p>
                </div>
              </div>

              {detailData.notes && (
                <div className="bg-gray-50 rounded-lg px-4 py-3 border border-gray-100">
                  <p className="text-xs text-gray-500 font-semibold uppercase tracking-wider mb-1">Notas</p>
                  <p className="text-sm text-gray-700">{detailData.notes}</p>
                </div>
              )}

              {/* Products */}
              <div>
                <h3 className="text-sm font-bold text-gray-700 mb-3">Productos ({detailData.products?.length || 0})</h3>
                <div className="border border-gray-200 rounded-lg overflow-hidden">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="bg-gray-50 border-b border-gray-200">
                        <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Producto</th>
                        <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Precio</th>
                        <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Oferta</th>
                        <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Caduca</th>
                      </tr>
                    </thead>
                    <tbody>
                      {detailData.products?.map((p: any) => (
                        <tr key={p.id} className="border-b border-gray-100 last:border-0">
                          <td className="py-2.5 px-4 text-gray-700 text-sm">{p.product_name}</td>
                          <td className="py-2.5 px-4 text-center text-gray-400 line-through text-sm">{fCur(p.original_price)}</td>
                          <td className="py-2.5 px-4 text-center text-green-600 font-bold text-sm">{fCur(p.offer_price)}</td>
                          <td className="py-2.5 px-4 text-center text-gray-500 text-sm">{p.expiry_date ? fDate(p.expiry_date) : '—'}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              {/* Customers */}
              <div>
                <h3 className="text-sm font-bold text-gray-700 mb-3">Clientes ({detailData.customers?.length || 0})</h3>
                <div className="border border-gray-200 rounded-lg overflow-hidden">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="bg-gray-50 border-b border-gray-200">
                        <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Nombre</th>
                        <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Email</th>
                        <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Teléfono</th>
                      </tr>
                    </thead>
                    <tbody>
                      {detailData.customers?.map((c: any) => (
                        <tr key={c.id} className="border-b border-gray-100 last:border-0">
                          <td className="py-2.5 px-4 text-gray-700 text-sm">{c.customer_name}</td>
                          <td className="py-2.5 px-4 text-blue-600 text-sm">{c.contact_email || '—'}</td>
                          <td className="py-2.5 px-4 text-emerald-600 text-sm">{c.contact_phone || '—'}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              {/* Logs */}
              {detailData.logs?.length > 0 && (
                <div>
                  <h3 className="text-sm font-bold text-gray-700 mb-3">Bitácora de envíos ({detailData.logs.length})</h3>
                  <div className="border border-gray-200 rounded-lg overflow-hidden">
                    <table className="w-full text-sm">
                      <thead>
                        <tr className="bg-gray-50 border-b border-gray-200">
                          <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Cliente</th>
                          <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Canal</th>
                          <th className="text-left py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Destino</th>
                          <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Estado</th>
                          <th className="text-center py-2.5 px-4 text-gray-500 font-semibold text-xs uppercase">Fecha</th>
                        </tr>
                      </thead>
                      <tbody>
                        {detailData.logs?.map((l: any) => (
                          <tr key={l.id} className="border-b border-gray-100 last:border-0 text-sm">
                            <td className="py-2.5 px-4 text-gray-700">{l.customer_name || '—'}</td>
                            <td className="py-2.5 px-4 text-center">
                              <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${
                                l.channel === 'email' ? 'bg-blue-50 text-blue-600' : 'bg-green-50 text-green-600'
                              }`}>{l.channel === 'email' ? 'Email' : 'WhatsApp'}</span>
                            </td>
                            <td className="py-2.5 px-4 text-gray-500 text-sm">{l.recipient}</td>
                            <td className="py-2.5 px-4 text-center">
                              {l.status === 'sent' ? <span className="text-green-600 font-semibold text-sm">✓ Enviado</span> :
                               l.status === 'failed' ? <span className="text-red-500 font-semibold text-sm" title={l.error_message || ''}>✗ Falló</span> :
                               <span className="text-gray-400 text-sm">— Pendiente</span>}
                            </td>
                            <td className="py-2.5 px-4 text-center text-gray-500 text-sm">{l.sent_at ? fDate(l.sent_at) : '—'}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}

              {/* Actions */}
              <div className="flex flex-wrap gap-3 pt-4 border-t border-gray-200">
                {detailData.status === 'draft' && (
                  <>
                    <button onClick={() => { setSendCampaignId(detailData.id); setShowSendModal(true); }} disabled={sending}
                      className="flex-1 min-w-[160px] px-5 py-2.5 text-sm font-bold text-white bg-emerald-600 hover:bg-emerald-700 rounded-xl transition-all disabled:opacity-40 shadow-sm hover:shadow-md">
                      {sending ? 'Enviando...' : '📨 Enviar Campaña'}
                    </button>
                    <button onClick={() => handleDelete(detailData.id)}
                      className="px-4 py-2.5 text-sm font-semibold text-red-500 hover:bg-red-50 rounded-xl transition-colors border border-transparent hover:border-red-200">
                      Eliminar
                    </button>
                  </>
                )}
                <button onClick={() => setShowDetail(null)}
                  className="px-5 py-2.5 text-sm font-semibold text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-xl transition-colors">
                  Cerrar
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* ══════════════════════════════════════════════════════════════════════ */}
      {/* SEND CAMPAIGN MODAL — Elegant modal like campaign creation           */}
      {/* ══════════════════════════════════════════════════════════════════════ */}
      {showSendModal && (
        <div className="modal-overlay" onClick={e => { if (e.target === e.currentTarget) setShowSendModal(false); }}>
          <div className="modal" onClick={e => e.stopPropagation()} style={{ maxWidth: '480px' }}>

            <h2 style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M22 2L11 13"/><path d="M22 2l-7 20-4-9-9-4 20-7z"/></svg>
              Enviar campaña
            </h2>
            <p className="subtitle">Selecciona los canales para enviar esta campaña</p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '1.5rem' }}>
              <label className={`btn ${sendChannels.email ? 'btn-primary' : 'btn-outline'}`}
                style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '0.85rem 1rem', cursor: 'pointer', borderRadius: '12px', justifyContent: 'flex-start', fontSize: '0.85rem' }}>
                <input type="checkbox" checked={sendChannels.email}
                  onChange={e => setSendChannels({ ...sendChannels, email: e.target.checked })}
                  style={{ accentColor: 'var(--primary)', width: '18px', height: '18px' }} />
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                <div style={{ flex: 1 }}>
                  <span style={{ fontWeight: 600 }}>Email</span>
                  <span style={{ display: 'block', fontSize: '0.75rem', opacity: 0.7 }}>Clientes con correo reciben plantilla HTML</span>
                </div>
              </label>

              <label className={`btn ${sendChannels.whatsapp ? 'btn-primary' : 'btn-outline'}`}
                style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '0.85rem 1rem', cursor: 'pointer', borderRadius: '12px', justifyContent: 'flex-start', fontSize: '0.85rem' }}>
                <input type="checkbox" checked={sendChannels.whatsapp}
                  onChange={e => setSendChannels({ ...sendChannels, whatsapp: e.target.checked })}
                  style={{ accentColor: 'var(--primary)', width: '18px', height: '18px' }} />
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                <div style={{ flex: 1 }}>
                  <span style={{ fontWeight: 600 }}>WhatsApp</span>
                  <span style={{ display: 'block', fontSize: '0.75rem', opacity: 0.7 }}>Clientes con teléfono reciben mensaje de texto</span>
                </div>
              </label>
            </div>

            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => setShowSendModal(false)}>Cancelar</button>
              <button className="btn-primary" onClick={handleSend}
                disabled={!sendChannels.email && !sendChannels.whatsapp}
                style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                Enviar ahora
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
