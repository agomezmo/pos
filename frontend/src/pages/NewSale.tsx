import { useState, useEffect, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { productsApi, customersApi, salesApi, companyApi } from '../services/api';

interface CartItem {
  productid: number;
  code: string;
  name: string;
  quantity: number;
  unitprice: number;
  subtotal: number;
  requiresprescription: boolean;
}

interface Customer { id: number; fullname: string; rfc: string; }

export default function NewSale() {
  const navigate = useNavigate();
  const [cart, setCart] = useState<CartItem[]>([]);
  const [search, setSearch] = useState('');
  const [products, setProducts] = useState<any[]>([]);
  const [showResults, setShowResults] = useState(false);
  const [customer, setCustomer] = useState<Customer | null>(null);
  const [customerSearch, setCustomerSearch] = useState('');
  const [customerResults, setCustomerResults] = useState<Customer[]>([]);
  const [showCustomerSearch, setShowCustomerSearch] = useState(false);
  const [paymentMethod, setPaymentMethod] = useState('Efectivo');
  const [amountReceived, setAmountReceived] = useState(0);
  const [discount, setDiscount] = useState(0);
  const [notes, setNotes] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const [saleData, setSaleData] = useState<any>(null);
  const [companyData, setCompanyData] = useState<any>(null);
  const searchRef = useRef<HTMLInputElement>(null);
  const barcodeInput = useRef<HTMLInputElement>(null);
  const barcodeTimerRef = useRef<ReturnType<typeof setTimeout>>();
  const [barcode, setBarcode] = useState('');

  const subtotal = cart.reduce((sum, item) => sum + item.subtotal, 0);
  const tax = cart.reduce((sum, item) => sum + (item.subtotal * 0.16), 0);
  const total = subtotal + tax - discount;
  const change = Math.max(0, amountReceived - total);

  const [allProducts, setAllProducts] = useState<any[]>([]);

  // Load initial products on mount
  useEffect(() => {
    productsApi.getAll({ limit: 200 }).then(res => {
      const prods = res.data.products || res.data || [];
      setAllProducts(prods);
      setProducts(prods);
      setShowResults(true);
    }).catch(() => {});
    companyApi.get().then(res => setCompanyData(res.data)).catch(() => {});
  }, []);

  useEffect(() => {
    if (!search.trim()) {
      setProducts(allProducts);
      setShowResults(true);
      return;
    }
    const handler = setTimeout(() => {
      const q = search.toLowerCase();
      const filtered = allProducts.filter((p: any) =>
        p.name.toLowerCase().includes(q) ||
        (p.code && p.code.toLowerCase().includes(q)) ||
        (p.barcode && p.barcode.toLowerCase().includes(q))
      );
      setProducts(filtered);
      setShowResults(true);
    }, 300);
    return () => clearTimeout(handler);
  }, [search, allProducts]);

  const searchCustomers = async (q: string) => {
    if (!q.trim()) { setCustomerResults([]); return; }
    try {
      const res = await customersApi.getAll({ search: q });
      setCustomerResults(res.data || []);
    } catch { setCustomerResults([]); }
  };

  useEffect(() => {
    const timer = setTimeout(() => searchCustomers(customerSearch), 300);
    return () => clearTimeout(timer);
  }, [customerSearch]);

  const addToCart = (product: any) => {
    setCart(prev => {
      const existing = prev.find(item => item.productid === product.id);
      if (existing) {
        return prev.map(item =>
          item.productid === product.id
            ? { ...item, quantity: item.quantity + 1, subtotal: (item.quantity + 1) * Number(item.unitprice) }
            : item
        );
      }
      const price = Number(product.saleprice);
      return [...prev, {
        productid: product.id,
        code: product.code,
        name: product.name,
        quantity: 1,
        unitprice: price,
        subtotal: price,
        requiresprescription: product.requiresprescription,
      }];
    });
    setSearch('');
    searchRef.current?.focus();
  };

  const handleBarcode = () => {
    if (!barcode.trim()) return;
    const q = barcode.trim().toLowerCase();
    const product = allProducts.find(p =>
      (p.barcode && p.barcode.toLowerCase() === q) ||
      (p.code && p.code.toLowerCase() === q)
    );
    if (product) {
      addToCart(product);
      setBarcode('');
      barcodeInput.current?.focus();
    }
  };

  // Auto-submit barcode when scanner sends digits rapidly (no Enter key)
  useEffect(() => {
    if (barcode.length < 8) return;
    if (barcodeTimerRef.current) clearTimeout(barcodeTimerRef.current);
    barcodeTimerRef.current = setTimeout(() => {
      handleBarcode();
    }, 150);
    return () => { if (barcodeTimerRef.current) clearTimeout(barcodeTimerRef.current); };
  }, [barcode]);

  const updateQuantity = (productId: number, qty: number) => {
    if (qty <= 0) {
      setCart(prev => prev.filter(item => item.productid !== productId));
      return;
    }
    setCart(prev => prev.map(item =>
      item.productid === productId
        ? { ...item, quantity: qty, subtotal: qty * Number(item.unitprice) }
        : item
    ));
  };

  const handleCheckout = async () => {
    if (cart.length === 0) { setError('Agrega productos al carrito'); return; }
    setLoading(true);
    setError('');
    try {
      const saleRes = await salesApi.create({
        customerid: customer?.id || undefined,
        items: cart.map(item => ({
          productid: item.productid,
          quantity: item.quantity,
          unitprice: item.unitprice,
        })),
        paymentmethod: paymentMethod,
        amountreceived: amountReceived,
        discount,
        notes,
      });
      setSaleData(saleRes.data);

      try {
        const companyRes = await companyApi.get();
        setCompanyData(companyRes.data);
      } catch {
        setCompanyData({ name: 'Mi Empresa', address: '', phone: '', codigopostal: '', rfc: '', email: '', receiptfooter: '' });
      }

      setSuccess(true);
    } catch (err: any) {
      setError(err.response?.data?.error?.message || 'Error al procesar la venta');
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    const sale = saleData?.sale || saleData;
    const items = sale?.items || cart;
    const ticketTotal = sale?.total ?? total;
    const ticketSubtotal = sale?.subtotal ?? subtotal;
    const ticketTax = sale?.tax ?? tax;
    const ticketDiscount = sale?.discount ?? discount;

    const printTicket = () => {
      const printWindow = window.open('', '_blank');
      if (!printWindow) return;
      const ticketLines = items.map((item: any) =>
        `<tr><td>${item.product_name || item.name}</td><td>${item.quantity}</td><td>$${Number(item.unitprice).toFixed(2)}</td><td>$${Number(item.subtotal || item.quantity * item.unitprice).toFixed(2)}</td></tr>`
      ).join('');
      printWindow.document.write(`
        <html><head><title>Ticket de Venta</title>
        <style>
          body { font-family: 'Courier New', monospace; font-size: 12px; width: 80mm; margin: 0 auto; padding: 10px; }
          h2 { text-align: center; margin: 5px 0; }
          .center { text-align: center; }
          .header { text-align: center; margin-bottom: 10px; border-bottom: 1px dashed #000; padding-bottom: 10px; }
          table { width: 100%; border-collapse: collapse; }
          th, td { text-align: left; padding: 3px 2px; }
          th { border-bottom: 1px solid #000; }
          .right { text-align: right; }
          .total-row td { border-top: 1px solid #000; font-weight: bold; }
          .footer { text-align: center; margin-top: 10px; border-top: 1px dashed #000; padding-top: 10px; font-size: 10px; }
          .receta { color: red; font-size: 10px; }
          @media print { body { width: 100%; } }
        </style></head><body>
        <div class="header">
          <h2>${companyData?.name || 'Mi Empresa'}</h2>
          ${companyData?.rfc ? `<p>RFC: ${companyData.rfc}</p>` : ''}
          ${companyData?.address ? `<p>${companyData.address}</p>` : ''}
          ${companyData?.phone ? `<p>Tel: ${companyData.phone}</p>` : ''}
          ${companyData?.codigopostal ? `<p>CP: ${companyData.codigopostal}</p>` : ''}
          ${companyData?.email ? `<p>${companyData.email}</p>` : ''}
          <p>Folio: ${sale?.receiptnumber || sale?.id || ''}</p>
          <p>${new Date().toLocaleString()}</p>
        </div>
        <table>
          <thead><tr><th>Producto</th><th>Cant</th><th>Precio</th><th>Subtotal</th></tr></thead>
          <tbody>${ticketLines}</tbody>
          <tfoot>
            <tr class="total-row"><td colspan="3" class="right">Subtotal:</td><td>$${Number(ticketSubtotal).toFixed(2)}</td></tr>
            <tr><td colspan="3" class="right">IVA (16%):</td><td>$${Number(ticketTax).toFixed(2)}</td></tr>
            ${ticketDiscount > 0 ? `<tr><td colspan="3" class="right">Descuento:</td><td>-$${Number(ticketDiscount).toFixed(2)}</td></tr>` : ''}
            <tr class="total-row"><td colspan="3" class="right">TOTAL:</td><td>$${Number(ticketTotal).toFixed(2)}</td></tr>
          </tfoot>
        </table>
        <div class="footer">
          <p>¡Gracias por su compra!</p>
          ${companyData?.receiptfooter ? `<p>${companyData.receiptfooter}</p>` : ''}
          <p>${sale?.paymentmethod || paymentMethod} - Recibí: $${Number(sale?.amountreceived || amountReceived).toFixed(2)} ${sale?.amountreceived || amountReceived > 0 ? 'Cambio: $' + Number((sale?.amountreceived || amountReceived) - ticketTotal).toFixed(2) : ''}</p>
        </div>
        </body></html>
      `);
      printWindow.document.close();
      printWindow.focus();
      setTimeout(() => printWindow.print(), 500);
    };

    return (
      <div className="page">
        <div className="success-screen">
          <div className="success-icon">✅</div>
          <h1>Venta Registrada Exitosamente</h1>
          <p>Folio: <strong>{sale?.receiptnumber || sale?.id || ''}</strong></p>

          <div className="ticket-preview" style={{margin: '1rem auto', maxWidth: '400px', border: '1px solid #ccc', padding: '1rem', fontFamily: 'monospace', fontSize: '12px', textAlign: 'center'}}>
            <h3 style={{margin: '0 0 5px'}}>{companyData?.name || 'Mi Empresa'}</h3>
            {companyData?.rfc && <p style={{margin: '2px 0'}}>RFC: {companyData.rfc}</p>}
            {companyData?.address && <p style={{margin: '2px 0'}}>{companyData.address}</p>}
            {companyData?.phone && <p style={{margin: '2px 0'}}>Tel: {companyData.phone}</p>}
            {companyData?.codigopostal && <p style={{margin: '2px 0'}}>CP: {companyData.codigopostal}</p>}
            {companyData?.email && <p style={{margin: '2px 0'}}>{companyData.email}</p>}
            <hr style={{margin: '8px 0'}} />
            <table style={{width: '100%', borderCollapse: 'collapse', textAlign: 'left'}}>
              <thead>
                <tr style={{borderBottom: '1px solid #000'}}>
                  <th>Producto</th><th>Cant</th><th>P/U</th><th>Subtotal</th>
                </tr>
              </thead>
              <tbody>
                {items.map((item: any, idx: number) => (
                  <tr key={idx}>
                    <td>{item.product_name || item.name}</td>
                    <td>{item.quantity}</td>
                    <td>${Number(item.unitprice).toFixed(2)}</td>
                    <td>${Number(item.subtotal || item.quantity * item.unitprice).toFixed(2)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            <hr style={{margin: '8px 0'}} />
            <div style={{textAlign: 'right'}}>
              <p style={{margin: '2px 0'}}>Subtotal: ${Number(ticketSubtotal).toFixed(2)}</p>
              <p style={{margin: '2px 0'}}>IVA (16%): ${Number(ticketTax).toFixed(2)}</p>
              {ticketDiscount > 0 && <p style={{margin: '2px 0'}}>Descuento: -${Number(ticketDiscount).toFixed(2)}</p>}
              <p style={{margin: '5px 0', fontWeight: 'bold', fontSize: '14px'}}>TOTAL: ${Number(ticketTotal).toFixed(2)}</p>
            </div>
          </div>

          <div style={{display: 'flex', gap: '10px', justifyContent: 'center', marginTop: '1rem'}}>
            <button className="btn-primary" onClick={printTicket}>
              🖨️ Imprimir Ticket
            </button>
            <button className="btn-secondary" onClick={() => navigate('/sales')}>
              Ir a Ventas
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="page pos-page">
      <div className="page-header">
        <h1>Nueva Venta</h1>
        <button className="btn-secondary" onClick={() => navigate('/sales')}>
          ← Historial
        </button>
      </div>

      <div className="pos-layout">
        <div className="pos-left">
          {/* Búsqueda por código de barras */}
          <div className="barcode-section">
            <label>Código de Barras</label>
            <div className="barcode-input">
              <input
                ref={barcodeInput}
                type="text"
                value={barcode}
                onChange={e => setBarcode(e.target.value)}
                onKeyDown={e => e.key === 'Enter' && handleBarcode()}
                placeholder="Escanea o escribe código de barras..."
                autoFocus
              />
              <button className="btn-primary" onClick={handleBarcode}>+</button>
            </div>
          </div>

          {/* Buscador de productos */}
          <div className="product-search-section">
            <label>Buscar Producto</label>
            <input
              ref={searchRef}
              type="text"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Nombre, código o SKU..."
              onFocus={() => setShowResults(true)}
            />
            {showResults && products.length > 0 && (
              <div className="search-results">
                {products.map(p => (
                  <div key={p.id} className="search-result-item" onClick={() => addToCart(p)}>
                    <div className="srp-info">
                      <strong>{p.name}</strong>
                      <span className="srp-code">{p.code} {p.barcode ? `| ${p.barcode}` : ''}</span>
                    </div>
                    <div className="srp-details">
                      <span className="srp-price">${Number(p.saleprice).toFixed(2)}</span>
                      <span className="srp-stock">Stock: {p.stock} {p.unit}</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Seleccionar cliente */}
          <div className="customer-section">
            <label>Cliente</label>
            {customer ? (
              <div className="selected-customer">
                <span>{customer.fullname} {customer.rfc ? `(${customer.rfc})` : ''}</span>
                <button className="btn-sm" onClick={() => setCustomer(null)}>Cambiar</button>
              </div>
            ) : (
              <div className="customer-search">
                <input
                  type="text"
                  value={customerSearch}
                  onChange={e => setCustomerSearch(e.target.value)}
                  placeholder="Buscar cliente por nombre o RFC..."
                  onFocus={() => setShowCustomerSearch(true)}
                />
                {showCustomerSearch && customerResults.length > 0 && (
                  <div className="search-results">
                    {customerResults.map(c => (
                      <div key={c.id} className="search-result-item"
                        onClick={() => { setCustomer(c); setShowCustomerSearch(false); setCustomerSearch(''); }}>
                        <strong>{c.fullname}</strong>
                        <span>{c.rfc || 'Sin RFC'}</span>
                      </div>
                    ))}
                  </div>
                )}
                <button className="btn-sm" onClick={() => navigate('/customers')}>+ Nuevo</button>
              </div>
            )}
          </div>
        </div>

        <div className="pos-right">
          {/* Carrito */}
          <div className="cart-section">
            <h2>Carrito ({cart.length} items)</h2>
            <div className="cart-items">
              {cart.length === 0 ? (
                <div className="empty-cart">
                  <p>Agrega productos al carrito</p>
                  <p className="hint">Usa el código de barras o busca productos</p>
                </div>
              ) : (
                <table className="table cart-table">
                  <thead>
                    <tr>
                      <th>Producto</th>
                      <th>Código</th>
                      <th>Cant</th>
                      <th>Precio</th>
                      <th>Subtotal</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {cart.map(item => (
                      <tr key={item.productid}>
                        <td>{item.name}</td>
                        <td>{item.code}</td>
                        <td>
                          <div className="qty-control">
                            <button onClick={() => updateQuantity(item.productid, item.quantity - 1)}>-</button>
                            <input
                              type="number"
                              value={item.quantity}
                              min="1"
                              onChange={e => updateQuantity(item.productid, parseInt(e.target.value) || 1)}
                            />
                            <button onClick={() => updateQuantity(item.productid, item.quantity + 1)}>+</button>
                          </div>
                        </td>
                        <td>${Number(item.unitprice).toFixed(2)}</td>
                        <td>${Number(item.subtotal).toFixed(2)}</td>
                        <td>
                          <button className="btn-sm btn-danger" onClick={() => updateQuantity(item.productid, 0)}>×</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>

          {/* Resumen y pago */}
          <div className="checkout-section">
            <div className="totals">
              <div className="total-row"><span>Subtotal:</span><span>${Number(subtotal).toFixed(2)}</span></div>
              <div className="total-row"><span>IVA (16%):</span><span>${Number(tax).toFixed(2)}</span></div>
              <div className="total-row">
                <span>Descuento:</span>
                <input type="number" value={discount} min="0" step="0.01"
                  onChange={e => setDiscount(parseFloat(e.target.value) || 0)} />
              </div>
              <div className="total-row total-final"><span>Total:</span><span>${Number(total).toFixed(2)}</span></div>
            </div>

            <div className="payment-section">
              <div className="form-group">
                <label>Método de Pago</label>
                <select value={paymentMethod} onChange={e => setPaymentMethod(e.target.value)}>
                  <option value="Efectivo">Efectivo</option>
                  <option value="Tarjeta">Tarjeta</option>
                  <option value="Transferencia">Transferencia</option>
                  <option value="Cheque">Cheque</option>
                  <option value="Credito">Crédito</option>
                </select>
              </div>
              {paymentMethod === 'Efectivo' && (
                <div className="form-group">
                  <label>Recibí</label>
                  <input type="number" value={amountReceived} min="0" step="0.01"
                    onChange={e => setAmountReceived(parseFloat(e.target.value) || 0)} />
                  {amountReceived > 0 && (
                    <div className="change-display">Cambio: ${Number(change).toFixed(2)}</div>
                  )}
                </div>
              )}
              <div className="form-group">
                <label>Notas</label>
                <textarea value={notes} onChange={e => setNotes(e.target.value)} rows={2} />
              </div>
            </div>

            {error && <div className="error-message">{error}</div>}

            <button
              className="btn-primary btn-checkout"
              onClick={handleCheckout}
              disabled={loading || cart.length === 0}
            >
              {loading ? 'Procesando...' : `Cobrar $${Number(total).toFixed(2)}`}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
