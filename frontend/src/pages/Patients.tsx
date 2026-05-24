import { useState, useEffect, FormEvent } from 'react';
import { patientsApi, customersApi } from '../services/api';

export default function Patients() {
  const [patients, setPatients] = useState<any[]>([]);
  const [customers, setCustomers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [form, setForm] = useState({ customerid: '', medicalhistory: '', allergies: '', bloodtype: '' });
  const [error, setError] = useState('');

  const fetchPatients = async () => {
    try {
      const [patRes, custRes] = await Promise.all([
        patientsApi.getAll(),
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
        <button className="btn-primary" onClick={openCreate}>+ Nuevo Paciente</button>
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
    </div>
  );
}
