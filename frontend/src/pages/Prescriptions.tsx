import { useState, useEffect } from 'react';
import { prescriptionsApi, patientsApi, productsApi } from '../services/api';
import CsvImportModal from '../components/CsvImportModal';

export default function Prescriptions() {
  const [prescriptions, setPrescriptions] = useState<any[]>([]);
  const [patients, setPatients] = useState<any[]>([]);
  const [products, setProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [detail, setDetail] = useState<any>(null);
  const [showModal, setShowModal] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [error, setError] = useState('');
  const [showImport, setShowImport] = useState(false);

  const handleCsvImport = async (rows: Record<string, string>[]) => {
    let success = 0;
    const errors: { row: number; message: string }[] = [];
    for (let i = 0; i < rows.length; i++) {
      const r = rows[i];
      try {
        await prescriptionsApi.create({
          patientid: parseInt(r.patient_id || r.patientid) || 0,
          doctorname: r.doctor_name || r.doctorname || '',
          doctorlicense: r.doctor_license || r.doctorlicense || '',
          diagnosis: r.diagnosis || '',
          issueddate: r.issue_date || r.issueddate || new Date().toISOString().split('T')[0],
          expirydate: r.expiry_date || r.expirydate || '',
          notes: r.notes || '',
          items: r.medications ? r.medications.split(';').map((m: string) => {
            const parts = m.split('|');
            return {
              productid: parseInt(parts[0]) || 0,
              dosage: parts[1] || '',
              frequency: parts[2] || '',
              duration: parts[3] || '',
              quantity: parseInt(parts[4]) || 1,
            };
          }) : [],
        });
        success++;
      } catch (err: any) {
        errors.push({ row: i + 2, message: err.response?.data?.error?.message || err.message || 'Error' });
      }
    }
    return { success, errors };
  };

  const [form, setForm] = useState({
    patientid: '',
    doctorname: '',
    doctorlicense: '',
    diagnosis: '',
    notes: '',
    issueddate: new Date().toISOString().split('T')[0],
    expirydate: '',
    items: [] as any[],
  });

  const fetchPrescriptions = async () => {
    try {
      const res = await prescriptionsApi.getAll();
      setPrescriptions(Array.isArray(res.data) ? res.data : []);
    } catch (err) { console.error(err); }
    finally { setLoading(false); }
  };

  useEffect(() => { fetchPrescriptions(); }, []);

  const openCreate = async () => {
    setEditId(null);
    setForm({
      patientid: '',
      doctorname: '',
      doctorlicense: '',
      diagnosis: '',
      notes: '',
      issueddate: new Date().toISOString().split('T')[0],
      expirydate: '',
      items: [],
    });
    setError('');
    try {
      const [patRes, prodRes] = await Promise.all([
        patientsApi.getAll({ limit: 200 }),
        productsApi.getAll({ limit: 500 }),
      ]);
      setPatients(Array.isArray(patRes.data) ? patRes.data : patRes.data?.patients || []);
      setProducts(prodRes.data?.products || prodRes.data || []);
    } catch (err) {}
    setShowModal(true);
  };

  const addItem = () => {
    setForm(prev => ({
      ...prev,
      items: [...prev.items, { productid: '', dosage: '', frequency: '', duration: '', notes: '' }],
    }));
  };

  const removeItem = (idx: number) => {
    setForm(prev => ({
      ...prev,
      items: prev.items.filter((_, i) => i !== idx),
    }));
  };

  const updateItem = (idx: number, field: string, value: any) => {
    setForm(prev => {
      const items = [...prev.items];
      items[idx] = { ...items[idx], [field]: value };
      return { ...prev, items };
    });
  };

  const viewDetail = async (id: number) => {
    try {
      const res = await prescriptionsApi.getById(id);
      setDetail(res.data);
    } catch (err) { console.error(err); }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    if (!form.patientid) { setError('Selecciona un paciente'); return; }
    if (!form.doctorname) { setError('Ingresa el nombre del médico'); return; }
    try {
      const payload = {
        ...form,
        patientid: parseInt(form.patientid),
        items: form.items
          .filter(i => i.productid)
          .map(i => ({ ...i, productid: parseInt(i.productid) })),
      };
      await prescriptionsApi.create(payload);
      setShowModal(false);
      fetchPrescriptions();
    } catch (err: any) {
      setError(err.response?.data?.error?.message || 'Error al guardar la receta');
    }
  };

  if (loading) return <div className="page-loading">Cargando...</div>;

  return (
    <div className="page">
      <div className="page-header">
        <h1>Recetas Médicas</h1>
        <div style={{ display: 'flex', gap: '0.5rem' }}>
          <button className="btn-secondary" onClick={() => setShowImport(true)}>📥 Importar CSV</button>
          <button className="btn-primary" onClick={openCreate}>+ Nueva Receta</button>
        </div>
      </div>
      <div className="table-container">
        <table className="table">
          <thead>
            <tr>
              <th>Paciente</th><th>Médico</th><th>Cédula</th><th>Diagnóstico</th><th>Emisión</th><th>Vencimiento</th><th>Estado</th><th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {prescriptions.map(p => (
              <tr key={p.id}>
                <td><strong>{p.patient_name}</strong></td>
                <td>{p.doctorname}</td>
                <td>{p.doctorlicense}</td>
                <td>{p.diagnosis?.substring(0, 50)}...</td>
                <td>{new Date(p.issueddate).toLocaleDateString()}</td>
                <td>{p.expirydate ? new Date(p.expirydate).toLocaleDateString() : '-'}</td>
                <td><span className={`badge badge-${p.isactive ? 'success' : 'secondary'}`}>{p.isactive ? 'Vigente' : 'Vencida'}</span></td>
                <td><button className="btn-sm" onClick={() => viewDetail(p.id)}>Ver</button></td>
              </tr>
            ))}
            {prescriptions.length === 0 && <tr><td colSpan={8} className="empty">No hay recetas</td></tr>}
          </tbody>
        </table>
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal modal-lg" onClick={e => e.stopPropagation()}>
            <h2>Nueva Receta Médica</h2>
            {error && <div className="error-message">{error}</div>}
            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label>Paciente *</label>
                <select value={form.patientid} onChange={e => setForm({...form, patientid: e.target.value})} required>
                  <option value="">Seleccionar paciente...</option>
                  {patients.map((p: any) => (
                    <option key={p.id} value={p.id}>{p.customer_name || p.fullname || p.name}</option>
                  ))}
                </select>
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Nombre del Médico *</label>
                  <input value={form.doctorname} onChange={e => setForm({...form, doctorname: e.target.value})} required placeholder="Dr. Juan Pérez" />
                </div>
                <div className="form-group">
                  <label>Cédula Profesional</label>
                  <input value={form.doctorlicense} onChange={e => setForm({...form, doctorlicense: e.target.value})} placeholder="LIC12345" />
                </div>
              </div>
              <div className="form-group">
                <label>Diagnóstico</label>
                <textarea value={form.diagnosis} onChange={e => setForm({...form, diagnosis: e.target.value})} rows={2} placeholder="Descripción del diagnóstico" />
              </div>
              <div className="form-row">
                <div className="form-group">
                  <label>Fecha de Emisión</label>
                  <input type="date" value={form.issueddate} onChange={e => setForm({...form, issueddate: e.target.value})} />
                </div>
                <div className="form-group">
                  <label>Fecha de Vencimiento</label>
                  <input type="date" value={form.expirydate} onChange={e => setForm({...form, expirydate: e.target.value})} />
                </div>
              </div>

              <h3 style={{ marginTop: '1rem', marginBottom: '0.5rem' }}>Medicamentos Recetados</h3>
              {form.items.map((item, idx) => (
                <div key={idx} className="form-row" style={{ gap: '0.5rem', alignItems: 'flex-end', marginBottom: '0.5rem', padding: '0.5rem', background: '#f8f9fa', borderRadius: '6px' }}>
                  <div className="form-group" style={{ flex: 2 }}>
                    <label>Producto</label>
                    <select value={item.productid} onChange={e => updateItem(idx, 'productid', e.target.value)}>
                      <option value="">Seleccionar...</option>
                      {products.map((p: any) => (
                        <option key={p.id} value={p.id}>{p.name} ({p.code})</option>
                      ))}
                    </select>
                  </div>
                  <div className="form-group" style={{ flex: 1 }}>
                    <label>Dosis</label>
                    <input value={item.dosage} onChange={e => updateItem(idx, 'dosage', e.target.value)} placeholder="1 tableta" />
                  </div>
                  <div className="form-group" style={{ flex: 1 }}>
                    <label>Frecuencia</label>
                    <input value={item.frequency} onChange={e => updateItem(idx, 'frequency', e.target.value)} placeholder="C/8 horas" />
                  </div>
                  <div className="form-group" style={{ flex: 1 }}>
                    <label>Duración</label>
                    <input value={item.duration} onChange={e => updateItem(idx, 'duration', e.target.value)} placeholder="7 días" />
                  </div>
                  <button type="button" className="btn-sm btn-danger" onClick={() => removeItem(idx)} style={{ marginBottom: '0.25rem' }}>×</button>
                </div>
              ))}
              <button type="button" className="btn-sm" onClick={addItem} style={{ marginBottom: '1rem' }}>+ Agregar Medicamento</button>

              <div className="form-group">
                <label>Notas</label>
                <textarea value={form.notes} onChange={e => setForm({...form, notes: e.target.value})} rows={2} placeholder="Instrucciones adicionales..." />
              </div>

              <div className="modal-actions">
                <button type="button" className="btn-secondary" onClick={() => setShowModal(false)}>Cancelar</button>
                <button type="submit" className="btn-primary">Guardar Receta</button>
              </div>
            </form>
          </div>
        </div>
      )}

      {detail && (
        <div className="modal-overlay" onClick={() => setDetail(null)}>
          <div className="modal modal-lg" onClick={e => e.stopPropagation()}>
            <h2>Receta - {detail.patient_name}</h2>
            <div className="detail-grid">
              <div><strong>Médico:</strong> {detail.doctorname} ({detail.doctorlicense})</div>
              <div><strong>Diagnóstico:</strong> {detail.diagnosis}</div>
              <div><strong>Emisión:</strong> {new Date(detail.issueddate).toLocaleDateString()}</div>
              <div><strong>Vence:</strong> {detail.expirydate ? new Date(detail.expirydate).toLocaleDateString() : 'No especificado'}</div>
            </div>
            <h3 style={{marginTop:'1rem'}}>Medicamentos</h3>
            <table className="table">
              <thead>
                <tr><th>Producto</th><th>Dosis</th><th>Frecuencia</th><th>Duración</th><th>Cantidad</th></tr>
              </thead>
              <tbody>
                {(detail.items || []).map((i: any) => (
                  <tr key={i.id}>
                    <td>{i.product_name}</td>
                    <td>{i.dosage}</td>
                    <td>{i.frequency}</td>
                    <td>{i.duration}</td>
                    <td>{i.quantity}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            {detail.notes && <p style={{marginTop:'1rem'}}><strong>Notas:</strong> {detail.notes}</p>}
            <div className="modal-actions">
              <button className="btn-secondary" onClick={() => setDetail(null)}>Cerrar</button>
            </div>
          </div>
        </div>
      )}
      <CsvImportModal
        show={showImport}
        onClose={() => { setShowImport(false); fetchPrescriptions(); }}
        title="Recetas"
        sampleCsv="patient_id,doctor_name,doctor_license,diagnosis,issue_date,expiry_date,notes,medications
38,Dr. Lopez,MED12345,Hipertension arterial,2026-05-01,2026-08-01,Tomar con alimentos,90|1 tableta|C/12h|30 dias|60
39,Dr. Garcia,MED67890,Infeccion respiratoria,2026-05-15,2026-06-15,,90|1 capsula|C/8h|7 dias|21;91|1 tableta|C/12h|5 dias|10
40,Dr. Hernandez,MED11111,Diabetes tipo 2,2026-05-20,2026-11-20,No suspender tratamiento,92|1 tableta|C/12h|60 dias|120"
        onImport={handleCsvImport}
      />
    </div>
  );
}
