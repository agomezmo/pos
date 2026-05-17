using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using POS.API.DTOs;
using POS.API.Data;
using POS.API.Models;

namespace POS.API.Services;

public class FacturaService
{
	private readonly AppDbContext _db;

	public FacturaService(AppDbContext db)
	{
		_db = db;
	}

	[AsyncStateMachine(typeof(_003CGetRegimenesFiscales_003Ed__2))]
	public System.Threading.Tasks.Task<List<CatRegimenFiscalDto>> GetRegimenesFiscales()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetRegimenesFiscales_003Ed__2 _003CGetRegimenesFiscales_003Ed__ = default(_003CGetRegimenesFiscales_003Ed__2);
		_003CGetRegimenesFiscales_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatRegimenFiscalDto>>.Create();
		_003CGetRegimenesFiscales_003Ed__._003C_003E4__this = this;
		_003CGetRegimenesFiscales_003Ed__._003C_003E1__state = -1;
		_003CGetRegimenesFiscales_003Ed__._003C_003Et__builder.Start<_003CGetRegimenesFiscales_003Ed__2>(ref _003CGetRegimenesFiscales_003Ed__);
		return _003CGetRegimenesFiscales_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetUsosCfdi_003Ed__3))]
	public System.Threading.Tasks.Task<List<CatUsoCfdiDto>> GetUsosCfdi()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetUsosCfdi_003Ed__3 _003CGetUsosCfdi_003Ed__ = default(_003CGetUsosCfdi_003Ed__3);
		_003CGetUsosCfdi_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatUsoCfdiDto>>.Create();
		_003CGetUsosCfdi_003Ed__._003C_003E4__this = this;
		_003CGetUsosCfdi_003Ed__._003C_003E1__state = -1;
		_003CGetUsosCfdi_003Ed__._003C_003Et__builder.Start<_003CGetUsosCfdi_003Ed__3>(ref _003CGetUsosCfdi_003Ed__);
		return _003CGetUsosCfdi_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetFormasPago_003Ed__4))]
	public System.Threading.Tasks.Task<List<CatFormaPagoDto>> GetFormasPago()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetFormasPago_003Ed__4 _003CGetFormasPago_003Ed__ = default(_003CGetFormasPago_003Ed__4);
		_003CGetFormasPago_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatFormaPagoDto>>.Create();
		_003CGetFormasPago_003Ed__._003C_003E4__this = this;
		_003CGetFormasPago_003Ed__._003C_003E1__state = -1;
		_003CGetFormasPago_003Ed__._003C_003Et__builder.Start<_003CGetFormasPago_003Ed__4>(ref _003CGetFormasPago_003Ed__);
		return _003CGetFormasPago_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetMetodosPago_003Ed__5))]
	public System.Threading.Tasks.Task<List<CatMetodoPagoDto>> GetMetodosPago()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetMetodosPago_003Ed__5 _003CGetMetodosPago_003Ed__ = default(_003CGetMetodosPago_003Ed__5);
		_003CGetMetodosPago_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatMetodoPagoDto>>.Create();
		_003CGetMetodosPago_003Ed__._003C_003E4__this = this;
		_003CGetMetodosPago_003Ed__._003C_003E1__state = -1;
		_003CGetMetodosPago_003Ed__._003C_003Et__builder.Start<_003CGetMetodosPago_003Ed__5>(ref _003CGetMetodosPago_003Ed__);
		return _003CGetMetodosPago_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetClavesProdServ_003Ed__6))]
	public System.Threading.Tasks.Task<List<CatClaveProdServDto>> GetClavesProdServ()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetClavesProdServ_003Ed__6 _003CGetClavesProdServ_003Ed__ = default(_003CGetClavesProdServ_003Ed__6);
		_003CGetClavesProdServ_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatClaveProdServDto>>.Create();
		_003CGetClavesProdServ_003Ed__._003C_003E4__this = this;
		_003CGetClavesProdServ_003Ed__._003C_003E1__state = -1;
		_003CGetClavesProdServ_003Ed__._003C_003Et__builder.Start<_003CGetClavesProdServ_003Ed__6>(ref _003CGetClavesProdServ_003Ed__);
		return _003CGetClavesProdServ_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetClavesUnidad_003Ed__7))]
	public System.Threading.Tasks.Task<List<CatClaveUnidadDto>> GetClavesUnidad()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetClavesUnidad_003Ed__7 _003CGetClavesUnidad_003Ed__ = default(_003CGetClavesUnidad_003Ed__7);
		_003CGetClavesUnidad_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CatClaveUnidadDto>>.Create();
		_003CGetClavesUnidad_003Ed__._003C_003E4__this = this;
		_003CGetClavesUnidad_003Ed__._003C_003E1__state = -1;
		_003CGetClavesUnidad_003Ed__._003C_003Et__builder.Start<_003CGetClavesUnidad_003Ed__7>(ref _003CGetClavesUnidad_003Ed__);
		return _003CGetClavesUnidad_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__8))]
	public System.Threading.Tasks.Task<List<FacturaListDto>> GetAll(int page = 1, int pageSize = 20)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__8 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__8);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<FacturaListDto>>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.page = page;
		_003CGetAll_003Ed__.pageSize = pageSize;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__8>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__9))]
	public System.Threading.Tasks.Task<FacturaDto?> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__9 _003CGetById_003Ed__ = default(_003CGetById_003Ed__9);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<FacturaDto>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__9>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetBySale_003Ed__10))]
	public System.Threading.Tasks.Task<List<FacturaListDto>> GetBySale(int saleId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetBySale_003Ed__10 _003CGetBySale_003Ed__ = default(_003CGetBySale_003Ed__10);
		_003CGetBySale_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<FacturaListDto>>.Create();
		_003CGetBySale_003Ed__._003C_003E4__this = this;
		_003CGetBySale_003Ed__.saleId = saleId;
		_003CGetBySale_003Ed__._003C_003E1__state = -1;
		_003CGetBySale_003Ed__._003C_003Et__builder.Start<_003CGetBySale_003Ed__10>(ref _003CGetBySale_003Ed__);
		return _003CGetBySale_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByUuid_003Ed__11))]
	public System.Threading.Tasks.Task<FacturaDto?> GetByUuid(string uuid)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByUuid_003Ed__11 _003CGetByUuid_003Ed__ = default(_003CGetByUuid_003Ed__11);
		_003CGetByUuid_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<FacturaDto>.Create();
		_003CGetByUuid_003Ed__._003C_003E4__this = this;
		_003CGetByUuid_003Ed__.uuid = uuid;
		_003CGetByUuid_003Ed__._003C_003E1__state = -1;
		_003CGetByUuid_003Ed__._003C_003Et__builder.Start<_003CGetByUuid_003Ed__11>(ref _003CGetByUuid_003Ed__);
		return _003CGetByUuid_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGenerarDesdeVenta_003Ed__12))]
	public System.Threading.Tasks.Task<FacturaDto?> GenerarDesdeVenta(GenerarFacturaDto dto, int userId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGenerarDesdeVenta_003Ed__12 _003CGenerarDesdeVenta_003Ed__ = default(_003CGenerarDesdeVenta_003Ed__12);
		_003CGenerarDesdeVenta_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<FacturaDto>.Create();
		_003CGenerarDesdeVenta_003Ed__._003C_003E4__this = this;
		_003CGenerarDesdeVenta_003Ed__.dto = dto;
		_003CGenerarDesdeVenta_003Ed__.userId = userId;
		_003CGenerarDesdeVenta_003Ed__._003C_003E1__state = -1;
		_003CGenerarDesdeVenta_003Ed__._003C_003Et__builder.Start<_003CGenerarDesdeVenta_003Ed__12>(ref _003CGenerarDesdeVenta_003Ed__);
		return _003CGenerarDesdeVenta_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCancelar_003Ed__13))]
	public System.Threading.Tasks.Task<bool> Cancelar(int id, string? motivo)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCancelar_003Ed__13 _003CCancelar_003Ed__ = default(_003CCancelar_003Ed__13);
		_003CCancelar_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CCancelar_003Ed__._003C_003E4__this = this;
		_003CCancelar_003Ed__.id = id;
		_003CCancelar_003Ed__.motivo = motivo;
		_003CCancelar_003Ed__._003C_003E1__state = -1;
		_003CCancelar_003Ed__._003C_003Et__builder.Start<_003CCancelar_003Ed__13>(ref _003CCancelar_003Ed__);
		return _003CCancelar_003Ed__._003C_003Et__builder.get_Task();
	}

	private static FacturaDto MapToDto(Factura f)
	{
		return new FacturaDto
		{
			Id = f.Id,
			SaleId = f.SaleId,
			ReceiptNumber = f.Sale?.ReceiptNumber,
			Uuid = f.Uuid,
			Folio = f.Folio,
			Serie = f.Serie,
			EmisorRfc = f.EmisorRfc,
			EmisorNombre = f.EmisorNombre,
			EmisorRegimenFiscal = f.EmisorRegimenFiscal,
			EmisorCodigoPostal = f.EmisorCodigoPostal,
			ReceptorRfc = f.ReceptorRfc,
			ReceptorNombre = f.ReceptorNombre,
			ReceptorUsoCfdi = f.ReceptorUsoCfdi,
			ReceptorCodigoPostal = f.ReceptorCodigoPostal,
			Subtotal = f.Subtotal,
			Descuento = f.Descuento,
			Iva = f.Iva,
			Ieps = f.Ieps,
			Total = f.Total,
			FormaPago = f.FormaPago,
			MetodoPago = f.MetodoPago,
			Moneda = f.Moneda,
			LugarExpedicion = f.LugarExpedicion,
			FechaEmision = f.FechaEmision,
			FechaTimbrado = f.FechaTimbrado,
			Estado = f.Estado,
			MotivoCancelacion = f.MotivoCancelacion,
			CreatedBy = f.CreatedBy,
			CreatedByName = f.CreatedByUser?.FullName,
			CreatedAt = f.CreatedAt,
			Items = Enumerable.ToList<FacturaItemDto>(Enumerable.Select<FacturaItem, FacturaItemDto>((System.Collections.Generic.IEnumerable<FacturaItem>)f.Items, (Func<FacturaItem, FacturaItemDto>)((FacturaItem i) => new FacturaItemDto
			{
				Id = i.Id,
				FacturaId = i.FacturaId,
				SaleItemId = i.SaleItemId,
				ProductoId = i.ProductoId,
				Cantidad = i.Cantidad,
				ClaveProdServ = i.ClaveProdServ,
				ClaveUnidad = i.ClaveUnidad,
				Unidad = i.Unidad,
				NoIdentificacion = i.NoIdentificacion,
				Descripcion = i.Descripcion,
				ValorUnitario = i.ValorUnitario,
				Descuento = i.Descuento,
				Importe = i.Importe,
				IvaTasa = i.IvaTasa,
				IvaBase = i.IvaBase,
				IvaImporte = i.IvaImporte,
				IepsTasa = i.IepsTasa,
				IepsBase = i.IepsBase,
				IepsImporte = i.IepsImporte
			})))
		};
	}

	private static string MapPaymentMethodToFormaPago(string paymentMethod)
	{
		string text = paymentMethod.ToLower();
		if (!(text == "efectivo"))
		{
			if (!(text == "tarjeta"))
			{
				if (!(text == "transferencia"))
				{
					if (text == "cheque")
					{
						return "02";
					}
					return "01";
				}
				return "03";
			}
			return "04";
		}
		return "01";
	}
}
