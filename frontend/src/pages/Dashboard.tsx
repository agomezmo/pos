import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { reportsApi, alertsApi } from '../services/api';
import api from '../services/api';

/* ── Componentes de gráficas reutilizables ── */

function BarChart({ data, labelKey, valueKey, color, title, format }: {
  data: any[]; labelKey: string; valueKey: string; color: string; title: string; format?: (v: number) => string;
}) {
  if (!data.length) return <div className="card"><h2>{title}</h2><p style={{ color: 'var(--gray-400)', padding: '1rem 0' }}>Sin datos</p></div>;
  const max = Math.max(...data.map(d => Number(d[valueKey])), 1);
  const pad = data.length < 6 ? 30 : 10;
  const w = data.length * (40 + pad) + 40;
  return (
    <div className="card"><h2>{title}</h2>
      <svg width="100%" height="180" viewBox={`0 0 ${w} 160`} style={{ overflow: 'visible' }}>
        {data.map((d, i) => {
          const v = Number(d[valueKey]); const h = (v / max) * 120;
          const x = i * (40 + pad) + 20; const y = 140 - h;
          const label = d[labelKey]?.toString().length > 5 ? d[labelKey]?.toString().slice(0, 5) : (d[labelKey] || '');
          return (<g key={i}>
            <rect x={x} y={y} width={30} height={h} rx={4} fill={color} opacity={0.85}>
              <title>{`${d[labelKey]}: ${format ? format(v) : v}`}</title>
            </rect>
            <text x={x + 15} y={154} textAnchor="middle" fontSize={10} fill="var(--gray-500)">{label}</text>
            <text x={x + 15} y={y - 4} textAnchor="middle" fontSize={9} fill="var(--gray-600)">{format ? format(v) : v}</text>
          </g>);
        })}
      </svg>
    </div>
  );
}

function HBarChart({ data, labelKey, valueKey, valueLabel, title, color, format }: {
  data: any[]; labelKey: string; valueKey: string; valueLabel?: string; title: string; color: string; format?: (v: number) => string;
}) {
  if (!data.length) return <div className="card"><h2>{title}</h2><p style={{ color: 'var(--gray-400)', padding: '1rem 0' }}>Sin datos</p></div>;
  const max = Math.max(...data.map(d => Number(d[valueKey])), 1);
  const bh = 32; const gap = 8; const h = data.length * (bh + gap) + 20;
  const lw = 200; const cw = 600;
  return (
    <div className="card"><h2>{title}</h2>
      <div style={{ overflowX: 'auto' }}>
        <svg width="100%" height={h} viewBox={`0 0 ${lw + cw + 80} ${h}`} style={{ overflow: 'visible', minWidth: '500px' }}>
          {data.map((d, i) => {
            const v = Number(d[valueKey]); const bw = (v / max) * cw; const y = i * (bh + gap) + 10;
            const name = (d[labelKey] || '').toString(); const short = name.length > 28 ? name.slice(0, 26) + '…' : name;
            return (<g key={i}>
              <text x={0} y={y + bh / 2 + 5} fontSize={13} fill="var(--gray-700)" textAnchor="end" fontWeight="500">{short}</text>
              <rect x={lw + 4} y={y} width={Math.max(bw, 6)} height={bh} rx={4} fill={color} opacity={0.85}>
                <title>{`${name}\n${valueLabel || valueKey}: ${format ? format(v) : v}`}</title>
              </rect>
              <text x={lw + 10} y={y + bh / 2 + 5} fontSize={12} fill="#fff" fontWeight="bold">{format ? format(v) : v}</text>
            </g>);
          })}
        </svg>
      </div>
    </div>
  );
}

function PieChart({ data, labelKey, valueKey, title, format }: {
  data: any[]; labelKey: string; valueKey: string; title: string; format?: (v: number) => string;
}) {
  if (!data.length) return <div className="card"><h2>{title}</h2><p style={{ color: 'var(--gray-400)', padding: '1rem 0' }}>Sin datos</p></div>;
  const total = data.reduce((s, d) => s + Number(d[valueKey]), 0) || 1;
  const colors = ['#4f46e5', '#06b6d4', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899', '#14b8a6'];
  let acc = 0;
  const r = 55; const cx = 70; const cy = 60;
  const slices = data.map((d, i) => {
    const pct = Number(d[valueKey]) / total; const ang = pct * 360;
    const start = (acc / 360) * 2 * Math.PI; const end = ((acc + ang) / 360) * 2 * Math.PI;
    const x1 = cx + r * Math.sin(start); const y1 = cy - r * Math.cos(start);
    const x2 = cx + r * Math.sin(end); const y2 = cy - r * Math.cos(end);
    const large = ang > 180 ? 1 : 0;
    acc += ang;
    return { d: `M${cx},${cy} L${x1},${y1} A${r},${r} 0 ${large},1 ${x2},${y2} Z`, color: colors[i % colors.length], pct, label: d[labelKey], val: d[valueKey] };
  });
  return (
    <div className="card"><h2>{title}</h2>
      <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', padding: '0.5rem 0' }}>
        <svg width="140" height="130" viewBox="0 0 140 130">
          {slices.map((s, i) => <path key={i} d={s.d} fill={s.color}><title>{`${s.label}: ${format ? format(s.val) : s.val} (${(s.pct * 100).toFixed(1)}%)`}</title></path>)}
        </svg>
        <div style={{ fontSize: '11px', lineHeight: '1.6' }}>
          {slices.map((s, i) => <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
            <span style={{ width: 10, height: 10, borderRadius: 2, background: s.color, display: 'inline-block' }}></span>
            <span>{s.label}: <strong>{format ? format(s.val) : s.val}</strong> ({(s.pct * 100).toFixed(1)}%)</span>
          </div>)}
        </div>
      </div>
    </div>
  );
}

/* ── Dashboard ── */

export default function Dashboard() {
  const { user } = useAuth();
  const navigate = useNavigate();
  const [summary, setSummary] = useState<any>(null);
  const [invStatus, setInvStatus] = useState<any>(null);
  const [alerts, setAlerts] = useState<any[]>([]);
  const [recentSales, setRecentSales] = useState<any[]>([]);
  const [monthlySales, setMonthlySales] = useState<any[]>([]);
  const [monthlyExpenses, setMonthlyExpenses] = useState<any[]>([]);
  const [lowStock, setLowStock] = useState<any[]>([]);
  const [expiringProducts, setExpiringProducts] = useState<any[]>([]);
  const [topProducts, setTopProducts] = useState<any[]>([]);

  /* Nuevos estados */
  const [salesByCategory, setSalesByCategory] = useState<any[]>([]);
  const [hourlySales, setHourlySales] = useState<any[]>([]);
  const [paymentMethods, setPaymentMethods] = useState<any[]>([]);
  const [topCustomers, setTopCustomers] = useState<any[]>([]);
  const [profitMargin, setProfitMargin] = useState<any[]>([]);
  const [returnRate, setReturnRate] = useState<any[]>([]);
  const [dayOfWeek, setDayOfWeek] = useState<any[]>([]);
  const [monthlyComparison, setMonthlyComparison] = useState<any[]>([]);

  useEffect(() => {
    const today = new Date().toISOString().split('T')[0];
    reportsApi.getDailySummary(today).then(r => setSummary(r.data)).catch(() => {});
    reportsApi.getInventoryStatus().then(r => setInvStatus(r.data)).catch(() => {});

    alertsApi.getAll().then(r => {
      const d = Array.isArray(r.data) ? r.data : [];
      setAlerts(d.filter((a: any) => !a.isread).slice(0, 5));
    }).catch(() => {});

    api.get('/sales', { params: { limit: 5 } })
      .then(r => setRecentSales(r.data?.sales || [])).catch(() => {});

    reportsApi.getMonthlySales(6).then(r => {
      const d = Array.isArray(r.data) ? r.data.reverse() : [];
      setMonthlySales(d.map((m: any) => ({ label: `${String(m.month).padStart(2, '0')}/${m.year}`, ...m })));
    }).catch(() => {});

    reportsApi.getMonthlyExpenses(6).then(r => {
      const d = Array.isArray(r.data) ? r.data.reverse() : [];
      setMonthlyExpenses(d.map((m: any) => ({ label: `${String(m.month).padStart(2, '0')}/${m.year}`, ...m })));
    }).catch(() => {});

    api.get('/products', { params: { limit: 200 } }).then(r => {
      const prods: any[] = r.data?.products || r.data || [];
      setLowStock(prods.filter((p: any) => p.stock <= p.minstock).slice(0, 5));
      const thirtyDays = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000);
      setExpiringProducts(prods.filter((p: any) => p.expiry_date && new Date(p.expiry_date) <= thirtyDays).slice(0, 5));
    }).catch(() => {});

    reportsApi.getTopProducts({ limit: 10 })
      .then(r => setTopProducts(Array.isArray(r.data) ? r.data : [])).catch(() => {});

    /* Carga de nuevas estadísticas */
    reportsApi.getSalesByCategory({})
      .then(r => setSalesByCategory(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getHourlySales({})
      .then(r => setHourlySales(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getPaymentMethods({})
      .then(r => setPaymentMethods(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getTopCustomers({ limit: 5 })
      .then(r => setTopCustomers(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getProfitMargin({ limit: 8 })
      .then(r => setProfitMargin(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getReturnRate(6)
      .then(r => setReturnRate(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getDayOfWeek({})
      .then(r => setDayOfWeek(Array.isArray(r.data) ? r.data : [])).catch(() => {});
    reportsApi.getMonthlyComparison({ months: 12 })
      .then(r => {
        const d = Array.isArray(r.data) ? r.data : [];
        setMonthlyComparison(d.map((m: any) => ({ label: `${String(m.month).padStart(2, '0')}/${m.year}`, ...m })));
      }).catch(() => {});
  }, []);

  const modules = [
    { title: '🛒 Nueva Venta', desc: 'Registrar una venta', path: '/sales/new', color: 'var(--success)' },
    { title: '💰 Caja', desc: 'Abrir/cerrar caja', path: '/cash-register', color: 'var(--warning)' },
    { title: '💊 Productos', desc: 'Inventario de productos', path: '/products', color: 'var(--primary)' },
    { title: '👥 Clientes', desc: 'Administrar clientes', path: '/customers', color: 'var(--info)' },
    { title: '📄 Facturación', desc: 'CFDI y facturas', path: '/facturas', color: '#8b5cf6' },
    { title: '📦 Reportes', desc: 'Reportes y estadísticas', path: '/reports', color: '#ec4899' },
  ];

  return (
    <div className="dashboard">
      <div className="welcome-card">
        <h1>Bienvenido, {user?.fullname || user?.username}</h1>
        <p>{user?.role} · {new Date().toLocaleDateString('es-MX', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}</p>
      </div>

      {/* KPIs */}
      <div className="dashboard-grid">
        {summary && <>
          <div className="dashboard-card">
            <h3>💰 Ventas Hoy</h3>
            <p className="stat-number">${Number(summary.total_revenue || 0).toFixed(2)}</p>
            <p>{summary.total_sales || 0} transacciones</p>
          </div>
          <div className="dashboard-card">
            <h3>🧾 IVA del Día</h3>
            <p className="stat-number">${Number(summary.total_tax || 0).toFixed(2)}</p>
            <p>{summary.total_discounts > 0 ? `Descuentos: $${Number(summary.total_discounts).toFixed(2)}` : 'Sin descuentos'}</p>
          </div>
        </>}
        {invStatus && <>
          <div className="dashboard-card">
            <h3>📦 Productos</h3>
            <p className="stat-number">{invStatus.total_products}</p>
            <p>{invStatus.low_stock_count > 0 ? `${invStatus.low_stock_count} con stock bajo` : 'Stock saludable'}</p>
          </div>
          <div className="dashboard-card">
            <h3>💰 Valor Inventario</h3>
            <p className="stat-number">${Number(invStatus.inventory_value || 0).toFixed(2)}</p>
            <p>{invStatus.out_of_stock_count > 0 ? `${invStatus.out_of_stock_count} agotados` : 'Todo en stock'}</p>
          </div>
        </>}
      </div>

      {/* Fila 1: Ventas y Gastos mensuales */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '1.5rem' }}>
        <BarChart data={monthlySales} labelKey="label" valueKey="revenue" color="var(--success)" title="📈 Ventas Mensuales" format={v => `$${Number(v).toFixed(0)}`} />
        <BarChart data={monthlyExpenses} labelKey="label" valueKey="total" color="var(--danger)" title="📉 Gastos Mensuales" format={v => `$${Number(v).toFixed(0)}`} />
      </div>

      {/* Fila 2: Comparativa mensual 12 meses */}
      {monthlyComparison.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <BarChart data={monthlyComparison} labelKey="label" valueKey="revenue" color="var(--info)" title="📊 Comparativa Mensual (12 meses)" format={v => `$${Number(v).toFixed(0)}`} />
        </div>
      )}

      {/* Fila 3: Productos más vendidos */}
      {topProducts.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <HBarChart data={topProducts} labelKey="name" valueKey="total_quantity" title="🏆 Productos Más Vendidos" color="var(--primary)" format={v => String(v)} />
        </div>
      )}

      {/* Fila 4: Categorías (full width) */}
      {salesByCategory.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <HBarChart data={salesByCategory} labelKey="name" valueKey="revenue" title="📂 Ventas por Categoría" color="#8b5cf6" format={v => `$${Number(v).toFixed(0)}`} />
        </div>
      )}

      {/* Fila 5: Horas y Días / Métodos */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '1.5rem' }}>
        <BarChart data={hourlySales} labelKey="hour" valueKey="sale_count" title="⏰ Ventas por Hora" color="#06b6d4" format={v => String(v)} />
        <BarChart data={dayOfWeek} labelKey="day_name" valueKey="revenue" title="📅 Ventas por Día" color="#f59e0b" format={v => `$${Number(v).toFixed(0)}`} />
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '1.5rem' }}>
        <PieChart data={paymentMethods} labelKey="paymentmethod" valueKey="total" title="💳 Métodos de Pago" format={v => `$${Number(v).toFixed(0)}`} />
      </div>

      {/* Fila 6: Margen de ganancia (full width) */}
      {profitMargin.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <HBarChart data={profitMargin} labelKey="name" valueKey="margin_pct" valueLabel="Margen %" title="💰 Margen de Ganancia" color="#10b981" format={v => `${v}%`} />
        </div>
      )}

      {/* Fila 7: Clientes frecuentes (full width) */}
      {topCustomers.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <HBarChart data={topCustomers} labelKey="fullname" valueKey="total_spent" title="👥 Clientes Frecuentes" color="#ec4899" format={v => `$${Number(v).toFixed(0)}`} />
        </div>
      )}

      {/* Fila 8: Tasa de devolución */}

      {/* Fila 6: Tasa de devolución */}
      {returnRate.length > 0 && (
        <div style={{ marginBottom: '1.5rem' }}>
          <BarChart
            data={returnRate.map((r: any) => ({ label: `${String(r.month).padStart(2, '0')}/${r.year}`, ...r }))}
            labelKey="label" valueKey="return_rate_pct" color="#ef4444" title="🔄 Tasa de Devolución (%)"
            format={v => `${v}%`}
          />
        </div>
      )}

      {/* Stock bajo y próximos a caducar */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '1.5rem' }}>
        {lowStock.length > 0 && (
          <div className="card card-danger">
            <h2>⚠️ Stock Bajo</h2>
            {lowStock.map((p: any) => (
              <div key={p.id} style={{ display: 'flex', justifyContent: 'space-between', padding: '0.35rem 0', borderBottom: '1px solid var(--gray-100)' }}>
                <span><strong>{p.name}</strong></span>
                <span style={{ color: 'var(--danger)' }}>{p.stock} / {p.minstock} {p.unit}</span>
              </div>
            ))}
            <button className="btn-sm" style={{ marginTop: '0.5rem' }} onClick={() => navigate('/products?filter=low_stock')}>Ver todos</button>
          </div>
        )}
        {expiringProducts.length > 0 && (
          <div className="card card-warning">
            <h2>⏰ Próximos a Caducar</h2>
            {expiringProducts.map((p: any) => (
              <div key={p.id} style={{ display: 'flex', justifyContent: 'space-between', padding: '0.35rem 0', borderBottom: '1px solid var(--gray-100)' }}>
                <span><strong>{p.name}</strong></span>
                <span style={{ color: 'var(--warning)' }}>{p.expiry_date ? new Date(p.expiry_date).toLocaleDateString() : ''}</span>
              </div>
            ))}
            <button className="btn-sm" style={{ marginTop: '0.5rem' }} onClick={() => navigate('/products?filter=expiring')}>Ver todos</button>
          </div>
        )}
      </div>

      {/* Acceso rápido */}
      <h2 style={{ marginBottom: '0.75rem', fontSize: '1.1rem' }}>Acceso Rápido</h2>
      <div className="dashboard-grid">
        {modules.map(m => (
          <div key={m.path} className="dashboard-card" onClick={() => navigate(m.path)} style={{ borderLeft: `3px solid ${m.color}` }}>
            <h3>{m.title}</h3><p>{m.desc}</p>
          </div>
        ))}
      </div>

      {/* Últimas ventas y alertas */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginTop: '1rem' }}>
        {recentSales.length > 0 && (
          <div className="card">
            <h2>Últimas Ventas</h2>
            <table className="table">
              <thead><tr><th>Folio</th><th>Total</th><th>Hora</th></tr></thead>
              <tbody>
                {recentSales.map((s: any) => (
                  <tr key={s.id} style={{ cursor: 'pointer' }} onClick={() => navigate('/sales')}>
                    <td>{s.receiptnumber}</td>
                    <td><strong>${Number(s.total).toFixed(2)}</strong></td>
                    <td>{new Date(s.createdat).toLocaleTimeString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
        {alerts.length > 0 && (
          <div className="card">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <h2>Alertas Pendientes</h2>
              <button className="btn-sm" onClick={() => navigate('/alerts')}>Ver todas</button>
            </div>
            {alerts.map((a: any) => (
              <div key={a.id} className="alert-item unread" style={{ marginBottom: '0.35rem', padding: '0.5rem' }}>
                <strong>{a.title}</strong>
                <p style={{ fontSize: '0.82rem' }}>{a.message}</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
