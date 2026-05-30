import { useState, useEffect, FormEvent } from 'react';
import { patientsApi, customersApi } from '../services/api';
import CsvImportModal from '../components/CsvImportModal';

export default function Patients() {
  const [patients, setPatients] = useState<any[]>([]);
  const [customers, setCustomers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [form, setForm] = useState({ customerid: '', medicalhistory: '', allergies: '', bloodtype: '' });
  const [error, setError] = useState('');
  const [showImport, setShowImport] = useState(false);

  const handleCsvImport = async (rows: Record<string, string>[]) => {
    let success = 0;
    const errors: { row: number; message: string }[] = [];
    for (let i = 0; i < rows.length; i++) {
      const r = rows[i];
      try {
        await patientsApi.create({
          customerid: r.customer_id || r.customerid || '',
          medicalhistory: r.medical_history || r.medicalhistory || '',
          allergies: r.allergies || '',
          bloodtype: r.blood_type || r.bloodtype || '',
        });
        success++;
      } catch (err: any) {
        errors.push({ row: i + 2, message: err.response?.data?.error?.message || err.message || 'Error' });
      }
    }
    return { success, errors };
  };

  const fetchPatients = async () => {
    try {
      const [patRes, custRes] = await Promise.all([
        patientsApi.getAll().catch(() => ({ data: [] })),
        customersApi.getAll().catch(() => ({ data: [] })),
      ]);
      setPatients(Array.isArray(patRes.data) ? patRes.data : []);
      setCustomers(Array.isArray(custRes.data) ? custRes.data : []);
    } catch (err) { console.error(err); }
    finally { setLoading(false); }
  };

  useEffect(() => { fetchPatients(); }, []);

  const openCreate = () => {
    setEditId(null);
    setForm({ customerid: '', medicalhistory: '', allergies: '', bloodtype: '' });
    setShowModal(true);
  };

  const openEdit = (p: any) => {
    setEditId(p.id);
    setForm({
      customerid: p.customerid || '',
      medicalhistory: p.medicalhistory || '',
      allergies: p.allergies || '',
      bloodtype: p.bloodtype || '',
    });
    setShowModal(true);
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      if (editId) {
        await patientsApi.update(editId, form);
      } else {
        await patientsApi.create(form);
      }
      setShowModal(false);
      fetchPatients();
    } catch (err: any) {
      setError(err.response?.data?.error?.message || 'Error al guardar');
    }
  };

  if (loading) return <div className="page-loading">Cargando...</div>;

  return (
    <div className="page">
      <div className="page-header">
        <h1>Pacientes</h1>
        <div style={{ display: 'flex', gap: '0.5rem' }}>
          <button className="btn-secondary" onClick={() => setShowImport(true)}>📥 Importar CSV</button>
          <button className="btn-primary" onClick={openCreate}>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Nuevo Paciente
          </button>
        </div>
      </div>
      <div className="table-container">
        <table className="table">
          <thead>
            <tr>
              <th>Nombre</th><th>Teléfono</th><th>Tipo Sangre</th><th>Alergias</th><th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {patients.map(p => (
              <tr key={p.id}>
                <td><strong>{p.customer_name || p.fullname || '-'}</strong></td>
                <td>{p.customer_phone || p.phone || '-'}</td>
                <td><span className="badge badge-info">{p.bloodtype || '-'}</span></td>
                <td>{p.allergies || '-'}</td>
                <td><button className="btn-sm" onClick={() => openEdit(p)}>Editar</button></td>
              </tr>
            ))}
            {patients.length === 0 && <tr><td colSpan={5} className="empty">No hay pacientes</td></tr>}
          </tbody>
        </table>
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal modal-lg" onClick={e => e.stopPropagation()}>
            <h2>{editId ? 'Editar Paciente' : 'Nuevo Paciente'}</h2>
            {error && <div className="error-message">{error}</div>}
            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label>Cliente Asociado *</label>
                <select value={form.customerid} onChange={e => setForm({...form, customerid: e.target.value})} required>
                  <option value="">Seleccionar cliente...</option>
                  {customers.map(c => <option key={c.id} value={c.id}>{c.fullname} - {c.phone || ''}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label>Tipo de Sangre</label>
                <select value={form.bloodtype} onChange={e => setForm({...form, bloodtype: e.target.value})}>
                  <option value="">Seleccionar</option>
                  <option value="A+">A+</option><option value="A-">A-</option>
                  <option value="B+">B+</option><option value="B-">B-</option>
                  <option value="AB+">AB+</option><option value="AB-">AB-</option>
                  <option value="O+">O+</option><option value="O-">O-</option>
                </select>
              </div>
              <div className="form-group">
                <label>Alergias</label>
                <textarea value={form.allergies} onChange={e => setForm({...form, allergies: e.target.value})} placeholder="Lista de alergias conocidas..." />
              </div>
              <div className="form-group">
                <label>Historial Médico</label>
                <textarea value={form.medicalhistory} onChange={e => setForm({...form, medicalhistory: e.target.value})} />
              </div>
              <div className="modal-actions">
                <button className="btn-secondary" onClick={() => setShowModal(false)}>Cancelar</button>
                <button className="btn-primary">{editId ? 'Guardar' : 'Crear Paciente'}</button>
              </div>
            </form>
          </div>
        </div>
      )}
      <CsvImportModal
        show={showImport}
        onClose={() => { setShowImport(false); fetchPatients(); }}
        title="Pacientes"
        sampleCsv="customer_id,blood_type,allergies,medical_history
1,O+,Ninguna,Paciente con hipertension controlada
2,A-,Penicilina,Paciente diabetico tipo 2
3,AB+,Sulfa,Asma bronquial cronica"
        onImport={handleCsvImport}
      />
    </div>
  );
}
