import { useState, useEffect } from 'react';
import { facturasApi, salesApi } from '../services/api';

export default function Facturas() {
  const [facturas, setFacturas] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [detail, setDetail] = useState<any>(null);
  const [showGenerate, setShowGenerate] = useState(false);
  const [saleSearch, setSaleSearch] = useState('');
  const [saleResults, setSaleResults] = useState<any[]>([]);
  const [searching, setSearching] = useState(false);
  const [genError, setGenError] = useState('');
  const [generating, setGenerating] = useState(false);

  const fetchFacturas = async () => {
    try {
      const res = await facturasApi.getAll();
      setFacturas(Array.isArray(res.data) ? res.data : []);
    } catch (err) { console.error(err); }
    finally { setLoading(false); }
  };

  useEffect(() => { fetchFacturas(); }, []);

  const viewDetail = async (id: number) => {
    try {
      const res = await facturasApi.getById(id);
      setDetail(res.data);
    } catch (err) { console.error(err); }
  };

  const handleCancel = async (id: number) => {
    const motivo = prompt('Motivo de cancelación:');
    if (!motivo) return;
    try {
      await facturasApi.cancel(id, motivo);
      fetchFacturas();
    } catch (err: any) {
      alert(err.response?.data?.error?.message || 'Error al cancelar factura');
    }
  };

  const searchSales = async () => {
    if (!saleSearch.trim()) return;
    setSearching(true);
    try {
      const res = await salesApi.getAll({ search: saleSearch, limit: 10 });
      setSaleResults(res.data?.sales || res.data || []);
    } catch { setSaleResults([]); }
    finally { setSearching(false); }
  };

  const generateFactura = async (saleId: number) => {
    setGenerating(true);
    setGenError('');
    try {
      await facturasApi.generate(saleId);
      setShowGenerate(false);
      setSaleSearch('');
      setSaleResults([]);
      fetchFacturas();
    } catch (err: any) {
      setGenError(err.response?.data?.error?.message || err.response?.data?.error || 'Error al generar factura');
    } finally {
      setGenerating(false);
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'Active': return <span className="badge badge-success">Activa</span>;
      case 'Cancelled': return <span className="badge badge-danger">Cancelada</span>;
      default: return <span className="badge badge-secondary">{status}</span>;
    }
  };

  if (loading) return <div className="page-loading">Cargando...</div>;

  return (
    <div className="page">
      <div className="page-header">
        <h1>Facturación CFDI</h1>
        <button className="btn-primary" onClick={() => { setShowGenerate(true); setGenError(''); }}>
          + Nueva Factura
        </button>
      </div>
      <div className="table-container">
        <table className="table">
          <thead>
            <tr>
              <th>UUID</th><th>Serie</th><th>Folio</th><th>RFC</th><th>Razón Social</th><th>Total</th><th>Estado</th><th>Fecha</th><th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {facturas.map(f => (
              <tr key={f.id}>
                <td title={f.uuid}>{f.uuid?.substring(0, 12)}...</td>
                <td>{f.serie || '-'}</td>
                <td>{f.folio || '-'}</td>
                <td>{f.receptorrfc || f.emisorrfc || '-'}</td>
                <td>{f.receptornombre || f.emisornombre || '-'}</td>
                <td><strong>${Number(f.total).toFixed(2)}</strong></td>
                <td>{getStatusBadge(f.estado || f.status)}</td>
                <td>{new Date(f.createdat).toLocaleDateString()}</td>
                <td className="actions">
                  <button className="btn-sm" onClick={() => viewDetail(f.id)}>Ver</button>
                  {(f.estado || f.status) === 'Active' && (
                    <button className="btn-sm btn-danger" onClick={() => handleCancel(f.id)}>Cancelar</button>
                  )}
                </td>
              </tr>
            ))}
            {facturas.length === 0 && <tr><td colSpan={9} className="empty">No hay facturas generadas</td></tr>}
          </tbody>
        </table>
      </div>

      {/* Generate Invoice Modal */}
      {showGenerate && (
        <div className="modal-overlay" onClick={() => { setShowGenerate(false); setGenError(''); }}>
          <div className="modal modal-lg" onClick={e => e.stopPropagation()}>
            <h2>Nueva Factura CFDI</h2>
            <p className="subtitle">Busca la venta para generar su factura</p>
            {genError && <div className="error-message">{genError}</div>}

            <div className="form-group">
              <label>Buscar Venta (folio o ID)</label>
              <div style={{ display: 'flex', gap: '0.5rem' }}>
                <input value={saleSearch} onChange={e => setSaleSearch(e.target.value)}
                  onKeyDown={e => e.key === 'Enter' && searchSales()}
                  placeholder="Folio de venta..." />
                <button className="btn-primary" onClick={searchSales} disabled={searching}>
                  {searching ? 'Buscando...' : 'Buscar'}
                </button>
              </div>
            </div>

            {saleResults.length > 0 && (
              <div style={{ maxHeight: '300px', overflowY: 'auto', border: '1px solid var(--gray-200)', borderRadius: '6px' }}>
                {saleResults.map(s => (
                  <div key={s.id}
                    style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0.75rem', borderBottom: '1px solid var(--gray-100)' }}>
                    <div>
                      <strong>{s.receiptnumber || '#' + s.id}</strong>
                      <span style={{ marginLeft: '1rem', color: 'var(--gray-500)' }}>
                        {s.customer_name || 'Consumidor Final'}
                      </span>
                      <span style={{ marginLeft: '1rem' }}>${Number(s.total).toFixed(2)}</span>
                      <span style={{ marginLeft: '1rem', fontSize: '0.85rem', color: 'var(--gray-500)' }}>
                        {new Date(s.createdat).toLocaleDateString()}
                      </span>
                    </div>
                    <button className="btn-primary" disabled={generating}
                      onClick={() => generateFactura(s.id)}>
                      {generating ? 'Generando...' : 'Facturar'}
                    </button>
                  </div>
                ))}
              </div>
            )}
            {saleResults.length === 0 && saleSearch && !searching && (
              <p style={{ color: 'var(--gray-400)', marginTop: '0.5rem' }}>Sin resultados</p>
            )}

            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => { setShowGenerate(false); setGenError(''); }}>Cerrar</button>
            </div>
          </div>
        </div>
      )}

      {detail && (
        <div className="modal-overlay" onClick={() => setDetail(null)}>
          <div className="modal modal-lg" onClick={e => e.stopPropagation()}>
            <h2>Factura: {detail.uuid || detail.folio}</h2>
            <div className="detail-grid">
              <div><strong>Serie:</strong> {detail.serie} <strong>Folio:</strong> {detail.folio}</div>
              <div><strong>RFC:</strong> {detail.receptorrfc}</div>
              <div><strong>Razón Social:</strong> {detail.receptornombre}</div>
              <div><strong>Total:</strong> ${Number(detail.total).toFixed(2)}</div>
              <div><strong>Estado:</strong> {getStatusBadge(detail.estado || detail.status)}</div>
              <div><strong>Venta:</strong> #{detail.saleid}</div>
            </div>
            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => setDetail(null)}>Cerrar</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
