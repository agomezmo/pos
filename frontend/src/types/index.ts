export interface User {
  id: number;
  username: string;
  email: string;
  fullname: string;
  role: string;
}

export interface AuthResponse {
  token: string;
  user: User;
}

export interface Product {
  id: number;
  code: string;
  barcode: string;
  name: string;
  description: string;
  categoryId: number;
  categoryName: string;
  supplierId: number;
  supplierName: string;
  purchasePrice: number;
  salePrice: number;
  stock: number;
  minStock: number;
  unit: string;
  isActive: boolean;
  requiresPrescription: boolean;
  wholesalePrice: number;
  expiryDate: string;
  requiresTax: boolean;
}

export interface Category {
  id: number;
  name: string;
  description: string;
  isActive: boolean;
}

export interface Customer {
  id: number;
  documentType: string;
  documentNumber: string;
  fullName: string;
  phone: string;
  email: string;
  address: string;
  rfc: string;
  razonSocial: string;
  codigoPostal: string;
  regimenFiscalId: number;
  regimenFiscalDesc: string;
  usoCfdiId: number;
  usoCfdiDesc: string;
}

export interface Supplier {
  id: number;
  name: string;
  contactName: string;
  phone: string;
  email: string;
  address: string;
}

export interface Sale {
  id: number;
  receiptNumber: string;
  userId: number;
  userName: string;
  customerId: number;
  customerName: string;
  subtotal: number;
  tax: number;
  discount: number;
  total: number;
  paymentMethod: string;
  paymentStatus: string;
  notes: string;
  createdAt: string;
  items: SaleItem[];
  payments: Payment[];
}

export interface SaleItem {
  id: number;
  saleId: number;
  productId: number;
  productName: string;
  productCode: string;
  quantity: number;
  unitPrice: number;
  discount: number;
  subtotal: number;
}

export interface Payment {
  id: number;
  saleId: number;
  amount: number;
  paymentMethod: string;
  reference: string;
  createdAt: string;
}

export interface CreateSaleDto {
  customerId?: number;
  items: CreateSaleItemDto[];
  paymentMethod: string;
  amountReceived: number;
  discount: number;
  notes: string;
}

export interface CreateSaleItemDto {
  productId: number;
  quantity: number;
  unitPrice: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  page: number;
  limit: number;
  total: number;
}
