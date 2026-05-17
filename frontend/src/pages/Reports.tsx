import { useState, useEffect } from 'react';
import api from '../services/api';

export default function Reports() {
  const [summary, setSummary] = useState<any>(null);
  const [topProducts, setTopProducts] = useState<any[]>([]);
  const [invStatus, setInvStatus] = useState<any>(null);
  const [date, setDate] = useState(new Date().toISOString().split('T')[0]);

  useEffect(() => {
    api.get('/reports/daily-summary', { params: { date } }).then(r => setSummary(r.data)).catch(() => {});
    api.get('/reports/top-products', { params: { limit: 10 } }).then(r => setTopProducts(r.data)).catch(() => {});
    api.get('/reports/inventory-status').then(r => setInvStatus(r.data)).catch(() => {});
  }, [date]);

  return (
    <div className="page">
      <div className="page-header">
        <h1>Reportes</h1>
      </div>

      <div className="search-bar" style={{marginBottom:'1.5rem'}}>
        <label>Fecha:</label>
        <input type="date" value={date} onChange={e => setDate(e.target.value)} />
      </div>

      <div className="dashboard-grid">
        {summary && (
          <>
            <div className="dashboard-card">
              <h3>Ventas del día</h3>
              <p className="stat-number">{summary.total_sales}</p>
            </div>
            <div className="dashboard-card">
              <h3>Ingresos</h3>
              <p className="stat-number">${Number(summary.total_revenue).toFixed(2)}</p>
            </div>
            <div className="dashboard-card">
              <h3>IVA</h3>
              <p className="stat-number">${Number(summary.total_tax).toFixed(2)}</p>
            </div>
            <div className="dashboard-card">
              <h3>Clientes Únicos</h3>
              <p className="stat-number">{summary.unique_customers}</p>
            </div>
          </>
        )}
      </div>

      <div className="reports-grid">
        {invStatus && (
          <div className="card">
            <h2>Estado del Inventario</h2>
            <div className="inv-stats">
              <div><strong>Total Productos:</strong> {invStatus.total_products}</div>
              <div><strong>Stock Bajo:</strong> {invStatus.low_stock_count}</div>
              <div><strong>Sin Stock:</strong> {invStatus.out_of_stock_count}</div>
              <div><strong>Valor Inventario:</strong> ${Number(invStatus.inventory_value).toFixed(2)}</div>
            </div>
          </div>
        )}

        {topProducts.length > 0 && (
          <div className="card">
            <h2>Productos Más Vendidos</h2>
            <table className="table">
              <thead>
                <tr><th>#</th><th>Producto</th><th>Código</th><th>Cantidad</th><th>Ingresos</th></tr>
              </thead>
              <tbody>
                {topProducts.map((p: any, i: number) => (
                  <tr key={p.id}>
                    <td>{i + 1}</td>
                    <td>{p.name}</td>
                    <td>{p.code}</td>
                    <td>{p.total_quantity}</td>
                    <td>${Number(p.total_revenue).toFixed(2)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
