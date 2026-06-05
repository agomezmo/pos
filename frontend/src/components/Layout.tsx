import { useState } from 'react';
import { Outlet, NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const NAV_ITEMS = [
  { section: 'PUNTO DE VENTA' },
  { to: '/sales/new', icon: '🛒', label: 'Nueva Venta', roles: ['admin', 'cajero'] },
  { to: '/sales', icon: '📋', label: 'Historial Ventas', roles: ['admin', 'cajero'], exact: true },
  { to: '/cash-register', icon: '💰', label: 'Caja', roles: ['admin', 'cajero'] },
  { to: '/returns', icon: '↩️', label: 'Devoluciones', roles: ['admin', 'cajero'] },
  { to: '/facturas', icon: '📄', label: 'Facturación CFDI', roles: ['admin'] },
  { section: 'INVENTARIO' },
  { to: '/products', icon: '💊', label: 'Productos', roles: ['admin', 'cajero', 'almacenero'] },
  { to: '/categories', icon: '📂', label: 'Categorías', roles: ['admin', 'almacenero'] },
  { to: '/suppliers', icon: '🚚', label: 'Proveedores', roles: ['admin', 'almacenero'] },
  { to: '/inventory', icon: '📦', label: 'Movimientos', roles: ['admin', 'cajero', 'almacenero'] },
  { to: '/alerts', icon: '🔔', label: 'Alertas', roles: ['admin', 'cajero', 'almacenero'] },
  { section: 'CLIENTES' },
  { to: '/customers', icon: '👥', label: 'Clientes', roles: ['admin', 'cajero'] },
  { to: '/patients', icon: '🏥', label: 'Pacientes', roles: ['admin', 'cajero'] },
  { to: '/prescriptions', icon: '📝', label: 'Recetas', roles: ['admin', 'cajero'] },
  { section: 'CONSULTORIO' },
  { to: '/appointments', icon: '📅', label: 'Citas Médicas', roles: ['admin'] },
  { section: 'MARKETING' },
  { to: '/campaigns', icon: '📢', label: 'Campañas', roles: ['admin'] },
  { to: '/whatsapp', icon: '💬', label: 'WhatsApp', roles: ['admin'] },
  { section: 'ADMINISTRACIÓN' },
  { to: '/expenses', icon: '💸', label: 'Gastos', roles: ['admin'] },
  { to: '/reports', icon: '📈', label: 'Reportes', roles: ['admin'] },
  { to: '/users', icon: '👤', label: 'Usuarios', roles: ['admin'] },
  { to: '/company', icon: '⚙️', label: 'Empresa', roles: ['admin'] },
];

export default function Layout() {
  const { logout, user } = useAuth();
  const navigate = useNavigate();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const userInitial = user?.username?.charAt(0)?.toUpperCase() || 'U';
  const userRole = user?.role?.toLowerCase() || '';

  return (
    <div className="app-layout">
      <nav className={`sidebar ${sidebarOpen ? 'open' : ''}`}>
        <div className="sidebar-header">
          <div className="brand">
            <div className="brand-icon">⚕️</div>
            <div className="brand-text">
              <h2>POS Farmacia</h2>
              <span>Sistema de Venta</span>
            </div>
          </div>
          <button className="sidebar-close" onClick={() => setSidebarOpen(false)}>×</button>
        </div>

        <div className="sidebar-menu">
          <NavLink to="/" end className={({ isActive }) => isActive ? 'nav-item active' : 'nav-item'}
            onClick={() => setSidebarOpen(false)}>
            <span className="nav-icon">📊</span> Dashboard
          </NavLink>

          {NAV_ITEMS.map((item, i) => {
            if ('section' in item) {
              return <div key={i} className="nav-section">{item.section}</div>;
            }
            if (item.roles && !item.roles.includes(userRole)) {
              return null;
            }
            return (
              <NavLink key={i} to={item.to!} end={item.exact}
                className={({ isActive }) => isActive ? 'nav-item active' : 'nav-item'}
                onClick={() => setSidebarOpen(false)}>
                <span className="nav-icon">{item.icon}</span> {item.label}
              </NavLink>
            );
          })}
        </div>

        <div className="sidebar-footer">
          <div className="user-info">
            <div className="user-avatar">{userInitial}</div>
            <div className="user-details">
              <span className="user-name">{user?.fullname || user?.username}</span>
              <span className="user-role">{user?.role}</span>
            </div>
          </div>
          <button onClick={handleLogout} className="btn-logout">Cerrar Sesión</button>
        </div>
      </nav>

      <div className="sidebar-overlay" onClick={() => setSidebarOpen(false)} />
      <button className="menu-toggle" onClick={() => setSidebarOpen(true)}>☰</button>

      <main className="main-content">
        <Outlet />
      </main>
    </div>
  );
}
