import { useState, useEffect } from 'react';
import { patientsApi } from '../services/api';
import api from '../services/api';

interface Appointment {
  id: number;
  patientid: number;
  userid: number | null;
  appointmentdate: string;
  status: string;
  notes: string;
  createdat: string;
  patient_name: string;
  patient_phone: string;
  doctor_name: string | null;
}

interface Patient {
  id: number;
  customerid: number;
  customer_name: string;
  customer_phone: string;
}

interface Doctor {
  id: number;
  fullname: string;
}

const STATUS_OPTIONS = ['Scheduled', 'Completed', 'Cancelled', 'NoShow'];
const STATUS_COLORS: Record<string, string> = {
  Scheduled: '#007bff',
  Completed: '#28a745',
  Cancelled: '#dc3545',
  NoShow: '#ffc107',
};

export default function Appointments() {
  const [appointments, setAppointments] = useState<Appointment[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [patients, setPatients] = useState<Patient[]>([]);
  const [doctors, setDoctors] = useState<Doctor[]>([]);
  const [editing, setEditing] = useState<Appointment | null>(null);
  const [filterStatus, setFilterStatus] = useState('');

  // Form state
  const [formPatientId, setFormPatientId] = useState('');
  const [formDoctorId, setFormDoctorId] = useState('');
  const [formDate, setFormDate] = useState('');
  const [formTime, setFormTime] = useState('');
  const [formNotes, setFormNotes] = useState('');

  const fetchAppointments = async () => {
    setLoading(true);
    try {
      const params: any = {};
      if (filterStatus) params.status = filterStatus;
      const res = await api.get('/appointments', { params });
      setAppointments(res.data.appointments || []);
    } catch (err) { console.error(err); }
    finally { setLoading(false); }
  };

  const fetchPatients = async () => {
    try {
      const res = await patientsApi.getAll({ limit: 200 });
      setPatients(Array.isArray(res.data) ? res.data : []);
    } catch (err) { console.error(err); }
  };

  const fetchDoctors = async () => {
    try {
      const res = await api.get('/users');
      const users = Array.isArray(res.data) ? res.data : (res.data.users || res.data.users || []);
      setDoctors(users.filter((u: any) => u.isactive !== false));
    } catch (err) { console.error(err); }
  };

  useEffect(() => { fetchAppointments(); }, [filterStatus]);
  useEffect(() => { fetchPatients(); fetchDoctors(); }, []);

  const resetForm = () => {
    setFormPatientId('');
    setFormDoctorId('');
    setFormDate('');
    setFormTime('');
    setFormNotes('');
    setEditing(null);
    setShowForm(false);
  };

  const openEdit = (apt: Appointment) => {
    const dt = new Date(apt.appointmentdate);
    setFormPatientId(String(apt.patientid));
    setFormDoctorId(apt.userid ? String(apt.userid) : '');
    setFormDate(dt.toISOString().split('T')[0]);
    setFormTime(dt.toTimeString().slice(0, 5));
    setFormNotes(apt.notes || '');
    setEditing(apt);
    setShowForm(true);
  };

  const handleSubmit = async () => {
    if (!formPatientId || !formDate) return;
    const dateTime = formTime ? `${formDate}T${formTime}:00` : `${formDate}T00:00:00`;
    const data = {
      patientid: parseInt(formPatientId),
      userid: formDoctorId ? parseInt(formDoctorId) : null,
      appointmentdate: dateTime,
      notes: formNotes,
    };

    try {
      if (editing) {
        await api.put(`/appointments/${editing.id}`, data);
      } else {
        await api.post('/appointments', data);
      }
      resetForm();
      fetchAppointments();
    } catch (err) { console.error(err); }
  };

  const updateStatus = async (id: number, status: string) => {
    try {
      await api.put(`/appointments/${id}`, { status });
      fetchAppointments();
    } catch (err) { console.error(err); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('¿Eliminar esta cita?')) return;
    try {
      await api.delete(`/appointments/${id}`);
      fetchAppointments();
    } catch (err) { console.error(err); }
  };

  return (
    <div className="page">
      <div className="page-header">
        <h1>Citas Médicas</h1>
        <button className="btn-primary" onClick={() => { resetForm(); setShowForm(true); }}>+ Nueva Cita</button>
      </div>

      <div className="search-bar">
        <label>Estado:</label>
        <select value={filterStatus} onChange={e => setFilterStatus(e.target.value)}>
          <option value="">Todos</option>
          {STATUS_OPTIONS.map(s => <option key={s} value={s}>{s}</option>)}
        </select>
      </div>

      {showForm && (
        <div className="modal-overlay" onClick={resetForm}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <h2>{editing ? 'Editar Cita' : 'Nueva Cita'}</h2>
            <div className="form-group">
              <label>Paciente *</label>
              <select value={formPatientId} onChange={e => setFormPatientId(e.target.value)}>
                <option value="">Seleccionar paciente...</option>
                {patients.map(p => (
                  <option key={p.id} value={p.id}>{p.customer_name} {p.customer_phone ? `(${p.customer_phone})` : ''}</option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label>Doctor</label>
              <select value={formDoctorId} onChange={e => setFormDoctorId(e.target.value)}>
                <option value="">Seleccionar doctor...</option>
                {doctors.map(d => (
                  <option key={d.id} value={d.id}>{d.fullname}</option>
                ))}
              </select>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label>Fecha *</label>
                <input type="date" value={formDate} onChange={e => setFormDate(e.target.value)} />
              </div>
              <div className="form-group">
                <label>Hora</label>
                <input type="time" value={formTime} onChange={e => setFormTime(e.target.value)} />
              </div>
            </div>
            <div className="form-group">
              <label>Notas</label>
              <textarea value={formNotes} onChange={e => setFormNotes(e.target.value)} rows={3} />
            </div>
            <div className="modal-actions">
              <button className="btn-primary" onClick={handleSubmit}>{editing ? 'Guardar' : 'Crear'}</button>
              <button className="btn-secondary" onClick={resetForm}>Cancelar</button>
            </div>
          </div>
        </div>
      )}

      {loading ? (
        <div className="page-loading">Cargando...</div>
      ) : (
        <div className="table-container">
          <table className="table">
            <thead>
              <tr>
                <th>Paciente</th>
                <th>Teléfono</th>
                <th>Doctor</th>
                <th>Fecha y Hora</th>
                <th>Estado</th>
                <th>Notas</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {appointments.map(a => (
                <tr key={a.id}>
                  <td>{a.patient_name}</td>
                  <td>{a.patient_phone || '-'}</td>
                  <td>{a.doctor_name || '-'}</td>
                  <td style={{ whiteSpace: 'nowrap' }}>
                    <div>{new Date(a.appointmentdate).toLocaleDateString()}</div>
                    <div style={{ fontSize: '0.75rem', color: '#888' }}>{new Date(a.appointmentdate).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</div>
                  </td>
                  <td>
                    <span className="badge" style={{ background: STATUS_COLORS[a.status] || '#6c757d', color: '#fff' }}>
                      {a.status}
                    </span>
                  </td>
                  <td style={{ maxWidth: '150px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                    {a.notes || '-'}
                  </td>
                  <td>
                    <div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap' }}>
                      <button className="btn-sm" onClick={() => openEdit(a)}>Editar</button>
                      {a.status === 'Scheduled' && (
                        <>
                          <button className="btn-sm" style={{ background: '#28a745', color: '#fff' }} onClick={() => updateStatus(a.id, 'Completed')}>Completar</button>
                          <button className="btn-sm" style={{ background: '#ffc107', color: '#000' }} onClick={() => updateStatus(a.id, 'Cancelled')}>Cancelar</button>
                        </>
                      )}
                      <button className="btn-sm btn-danger" onClick={() => handleDelete(a.id)}>×</button>
                    </div>
                  </td>
                </tr>
              ))}
              {appointments.length === 0 && <tr><td colSpan={7} className="empty">No hay citas programadas</td></tr>}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
