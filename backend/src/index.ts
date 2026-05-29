import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { authRouter } from './routes/auth';
import { productsRouter } from './routes/products';
import { categoriesRouter } from './routes/categories';
import { salesRouter } from './routes/sales';
import { customersRouter } from './routes/customers';
import { usersRouter } from './routes/users';
import { suppliersRouter } from './routes/suppliers';
import { inventoryRouter } from './routes/inventory';
import { reportsRouter } from './routes/reports';
import { companyRouter } from './routes/company';
import { returnsRouter } from './routes/returns';
import { expensesRouter } from './routes/expenses';
import { facturasRouter } from './routes/facturas';
import { cashRegisterRouter } from './routes/cashregister';
import { patientsRouter } from './routes/patients';
import { prescriptionsRouter } from './routes/prescriptions';
import { alertsRouter } from './routes/alerts';
import { appointmentsRouter } from './routes/appointments';
import { campaignsRouter } from './routes/campaigns';
import { whatsappRouter } from './routes/whatsapp';
import { errorHandler } from './middleware/errorHandler';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 4000;

app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.use('/api/auth', authRouter);
app.use('/api/products', productsRouter);
app.use('/api/categories', categoriesRouter);
app.use('/api/sales', salesRouter);
app.use('/api/customers', customersRouter);
app.use('/api/users', usersRouter);
app.use('/api/suppliers', suppliersRouter);
app.use('/api/inventory', inventoryRouter);
app.use('/api/reports', reportsRouter);
app.use('/api/company', companyRouter);
app.use('/api/returns', returnsRouter);
app.use('/api/expenses', expensesRouter);
app.use('/api/facturas', facturasRouter);
app.use('/api/cashregister', cashRegisterRouter);
app.use('/api/patients', patientsRouter);
app.use('/api/prescriptions', prescriptionsRouter);
app.use('/api/alerts', alertsRouter);
app.use('/api/appointments', appointmentsRouter);
app.use('/api/campaigns', campaignsRouter);
app.use('/api/whatsapp', whatsappRouter);

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT} in ${process.env.NODE_ENV || 'development'} mode`);
});

export default app;
