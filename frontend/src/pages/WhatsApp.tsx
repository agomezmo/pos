import { useState, useEffect, useCallback } from 'react';
import api from '../services/api';

interface WaStatus {
  status: string;
  ready: boolean;
  hasQr: boolean;
  error: string | null;
}

const STATUS_LABELS: Record<string, { label: string; color: string; icon: string }> = {
  uninitialized: { label: 'Apagado', color: '#6b7280', icon: '⚫' },
  initializing: { label: 'Iniciando...', color: '#f59e0b', icon: '⏳' },
  qr_ready: { label: 'Esperando código QR', color: '#f59e0b', icon: '📱' },
  connected: { label: 'Conectado', color: '#22c55e', icon: '✅' },
  disconnected: { label: 'Desconectado', color: '#ef4444', icon: '❌' },
  error: { label: 'Error', color: '#ef4444', icon: '⚠️' },
};

export default function WhatsApp() {
  const [status, setStatus] = useState<WaStatus | null>(null);
  const [qrImage, setQrImage] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [reconnecting, setReconnecting] = useState(false);
  const [disconnecting, setDisconnecting] = useState(false);

  const fetchStatus = useCallback(async () => {
    try {
      const res = await api.get('/whatsapp/status');
      setStatus(res.data);
      if (res.data.hasQr) {
        try {
          const qrRes = await api.get('/whatsapp/qr');
          if (qrRes.data.qr) setQrImage(qrRes.data.qr);
        } catch { }
      } else {
        setQrImage(null);
      }
    } catch (err) {
      console.error('Error fetching WhatsApp status:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchStatus();
    const interval = setInterval(fetchStatus, 5000);
    return () => clearInterval(interval);
  }, [fetchStatus]);

  const handleReconnect = async () => {
    setReconnecting(true);
    try {
      await api.post('/whatsapp/reconnect');
      setQrImage(null);
      setTimeout(() => fetchStatus(), 3000);
    } catch (err: any) {
      alert(err.response?.data?.error || 'Error al reconectar');
    } finally {
      setReconnecting(false);
    }
  };

  const handleDisconnect = async () => {
    if (!confirm('¿Desvincular la cuenta de WhatsApp? Se eliminará la sesión guardada y deberás escanear el QR nuevamente para conectar.')) return;
    setDisconnecting(true);
    try {
      await api.post('/whatsapp/logout');
      setQrImage(null);
      alert('Sesión de WhatsApp eliminada. La página se actualizará para mostrar el nuevo QR.');
      fetchStatus();
    } catch (err: any) {
      alert(err.response?.data?.error || 'Error al desvincular');
    } finally {
      setDisconnecting(false);
    }
  };

  const st = status ? STATUS_LABELS[status.status] || STATUS_LABELS.uninitialized : STATUS_LABELS.uninitialized;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-800">WhatsApp</h1>
        <div style={{ display: 'flex', gap: '0.5rem' }}>
          {status?.ready && (
            <button onClick={handleDisconnect} disabled={disconnecting}
              className="btn-secondary" style={{ color: 'var(--danger)', borderColor: 'var(--danger)' }}>
              {disconnecting ? 'Desvinculando...' : 'Desvincular cuenta'}
            </button>
          )}
          <button onClick={handleReconnect} disabled={reconnecting}
            className="btn-primary">
            {reconnecting ? 'Reconectando...' : 'Reconectar'}
          </button>
        </div>
      </div>

      {/* Status Card */}
      <div className="card">
        <div className="flex items-center gap-4 mb-6">
          <span style={{ fontSize: '2.5rem' }}>{st.icon}</span>
          <div>
            <h2 className="text-lg font-semibold" style={{ color: st.color }}>{st.label}</h2>
            <p className="text-sm text-gray-500">
              {status?.ready
                ? 'WhatsApp conectado y listo para enviar mensajes'
                : status?.status === 'qr_ready'
                  ? 'Escanea el código QR con tu WhatsApp para conectar'
                  : status?.status === 'initializing'
                    ? 'Inicializando cliente de WhatsApp...'
                    : status?.error
                      ? `Error: ${status.error}`
                      : 'WhatsApp no está conectado'}
            </p>
          </div>
        </div>

        {status?.ready && (
          <div className="bg-green-50 border border-green-200 rounded-lg p-4 text-green-700 text-sm">
            ✅ El cliente de WhatsApp está conectado. Los mensajes de campañas se enviarán
            desde el número vinculado.
          </div>
        )}

        {status?.status === 'qr_ready' && qrImage && (
          <div className="flex flex-col items-center py-6">
            <div className="bg-white p-4 rounded-xl shadow-lg border">
              <img src={qrImage} alt="WhatsApp QR Code" width={320} height={320} />
            </div>
            <p className="mt-4 text-sm text-gray-500 text-center max-w-md">
              <strong>Instrucciones:</strong> Abre WhatsApp en tu teléfono, ve a
              <strong> Menú → WhatsApp Web</strong> y escanea este código QR.
              Una vez conectado, el estado cambiará automáticamente a "Conectado".
            </p>
          </div>
        )}

        {status?.status === 'qr_ready' && !qrImage && (
          <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 text-yellow-700 text-sm">
            📱 El código QR está disponible. Revisa los logs del servidor para verlo,
            o espera unos segundos mientras se genera la imagen.
          </div>
        )}
      </div>

      {/* Info Card */}
      <div className="card">
        <h3 className="font-semibold mb-3">Acerca de WhatsApp</h3>
        <div className="space-y-2 text-sm text-gray-600">
          <p>
            Esta integración usa <strong>whatsapp-web.js</strong>, una librería gratuita
            que se conecta a WhatsApp Web. El QR debe escanearse con el teléfono que
            usará la farmacia para enviar mensajes.
          </p>
          <p>
            <strong>Nota:</strong> La sesión se mantiene guardada en el servidor.
            Si el servidor se reinicia, el cliente intentará reconectarse automáticamente
            sin necesidad de escanear el QR nuevamente.
          </p>
          <ul className="list-disc pl-5 space-y-1">
            <li>Los mensajes se envían desde el número de WhatsApp conectado</li>
            <li>Si la conexión se pierde, usa el botón "Reconectar"</li>
            <li>También puedes configurar la <strong>Meta WhatsApp Cloud API</strong>
              (WhatsApp Business oficial) en el archivo <code>.env</code></li>
          </ul>
        </div>
      </div>
    </div>
  );
}
