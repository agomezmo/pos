using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Services;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class FacturasController : ControllerBase
{
	private readonly FacturaService _facturaService;

	public FacturasController(FacturaService facturaService)
	{
		_facturaService = facturaService;
	}

	[AsyncStateMachine(typeof(_003CGetRegimenesFiscales_003Ed__2))]
	[HttpGet("catalogos/regimen-fiscal")]
	public System.Threading.Tasks.Task<IActionResult> GetRegimenesFiscales()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetRegimenesFiscales_003Ed__2 _003CGetRegimenesFiscales_003Ed__ = default(_003CGetRegimenesFiscales_003Ed__2);
		_003CGetRegimenesFiscales_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetRegimenesFiscales_003Ed__._003C_003E4__this = this;
		_003CGetRegimenesFiscales_003Ed__._003C_003E1__state = -1;
		_003CGetRegimenesFiscales_003Ed__._003C_003Et__builder.Start<_003CGetRegimenesFiscales_003Ed__2>(ref _003CGetRegimenesFiscales_003Ed__);
		return _003CGetRegimenesFiscales_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetUsosCfdi_003Ed__3))]
	[HttpGet("catalogos/uso-cfdi")]
	public System.Threading.Tasks.Task<IActionResult> GetUsosCfdi()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetUsosCfdi_003Ed__3 _003CGetUsosCfdi_003Ed__ = default(_003CGetUsosCfdi_003Ed__3);
		_003CGetUsosCfdi_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetUsosCfdi_003Ed__._003C_003E4__this = this;
		_003CGetUsosCfdi_003Ed__._003C_003E1__state = -1;
		_003CGetUsosCfdi_003Ed__._003C_003Et__builder.Start<_003CGetUsosCfdi_003Ed__3>(ref _003CGetUsosCfdi_003Ed__);
		return _003CGetUsosCfdi_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetFormasPago_003Ed__4))]
	[HttpGet("catalogos/forma-pago")]
	public System.Threading.Tasks.Task<IActionResult> GetFormasPago()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetFormasPago_003Ed__4 _003CGetFormasPago_003Ed__ = default(_003CGetFormasPago_003Ed__4);
		_003CGetFormasPago_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetFormasPago_003Ed__._003C_003E4__this = this;
		_003CGetFormasPago_003Ed__._003C_003E1__state = -1;
		_003CGetFormasPago_003Ed__._003C_003Et__builder.Start<_003CGetFormasPago_003Ed__4>(ref _003CGetFormasPago_003Ed__);
		return _003CGetFormasPago_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetMetodosPago_003Ed__5))]
	[HttpGet("catalogos/metodo-pago")]
	public System.Threading.Tasks.Task<IActionResult> GetMetodosPago()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetMetodosPago_003Ed__5 _003CGetMetodosPago_003Ed__ = default(_003CGetMetodosPago_003Ed__5);
		_003CGetMetodosPago_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetMetodosPago_003Ed__._003C_003E4__this = this;
		_003CGetMetodosPago_003Ed__._003C_003E1__state = -1;
		_003CGetMetodosPago_003Ed__._003C_003Et__builder.Start<_003CGetMetodosPago_003Ed__5>(ref _003CGetMetodosPago_003Ed__);
		return _003CGetMetodosPago_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetClavesProdServ_003Ed__6))]
	[HttpGet("catalogos/clave-prod-serv")]
	public System.Threading.Tasks.Task<IActionResult> GetClavesProdServ()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetClavesProdServ_003Ed__6 _003CGetClavesProdServ_003Ed__ = default(_003CGetClavesProdServ_003Ed__6);
		_003CGetClavesProdServ_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetClavesProdServ_003Ed__._003C_003E4__this = this;
		_003CGetClavesProdServ_003Ed__._003C_003E1__state = -1;
		_003CGetClavesProdServ_003Ed__._003C_003Et__builder.Start<_003CGetClavesProdServ_003Ed__6>(ref _003CGetClavesProdServ_003Ed__);
		return _003CGetClavesProdServ_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetClavesUnidad_003Ed__7))]
	[HttpGet("catalogos/clave-unidad")]
	public System.Threading.Tasks.Task<IActionResult> GetClavesUnidad()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetClavesUnidad_003Ed__7 _003CGetClavesUnidad_003Ed__ = default(_003CGetClavesUnidad_003Ed__7);
		_003CGetClavesUnidad_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetClavesUnidad_003Ed__._003C_003E4__this = this;
		_003CGetClavesUnidad_003Ed__._003C_003E1__state = -1;
		_003CGetClavesUnidad_003Ed__._003C_003Et__builder.Start<_003CGetClavesUnidad_003Ed__7>(ref _003CGetClavesUnidad_003Ed__);
		return _003CGetClavesUnidad_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__8))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll([FromQuery] int page = 1, [FromQuery] int pageSize = 20)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__8 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__8);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.page = page;
		_003CGetAll_003Ed__.pageSize = pageSize;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__8>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__9))]
	[HttpGet("{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__9 _003CGetById_003Ed__ = default(_003CGetById_003Ed__9);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__9>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetBySale_003Ed__10))]
	[HttpGet("por-venta/{saleId}")]
	public System.Threading.Tasks.Task<IActionResult> GetBySale(int saleId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetBySale_003Ed__10 _003CGetBySale_003Ed__ = default(_003CGetBySale_003Ed__10);
		_003CGetBySale_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetBySale_003Ed__._003C_003E4__this = this;
		_003CGetBySale_003Ed__.saleId = saleId;
		_003CGetBySale_003Ed__._003C_003E1__state = -1;
		_003CGetBySale_003Ed__._003C_003Et__builder.Start<_003CGetBySale_003Ed__10>(ref _003CGetBySale_003Ed__);
		return _003CGetBySale_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByUuid_003Ed__11))]
	[HttpGet("por-uuid/{uuid}")]
	public System.Threading.Tasks.Task<IActionResult> GetByUuid(string uuid)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByUuid_003Ed__11 _003CGetByUuid_003Ed__ = default(_003CGetByUuid_003Ed__11);
		_003CGetByUuid_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetByUuid_003Ed__._003C_003E4__this = this;
		_003CGetByUuid_003Ed__.uuid = uuid;
		_003CGetByUuid_003Ed__._003C_003E1__state = -1;
		_003CGetByUuid_003Ed__._003C_003Et__builder.Start<_003CGetByUuid_003Ed__11>(ref _003CGetByUuid_003Ed__);
		return _003CGetByUuid_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGenerar_003Ed__12))]
	[HttpPost("generar")]
	public System.Threading.Tasks.Task<IActionResult> Generar([FromBody] GenerarFacturaDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGenerar_003Ed__12 _003CGenerar_003Ed__ = default(_003CGenerar_003Ed__12);
		_003CGenerar_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGenerar_003Ed__._003C_003E4__this = this;
		_003CGenerar_003Ed__.dto = dto;
		_003CGenerar_003Ed__._003C_003E1__state = -1;
		_003CGenerar_003Ed__._003C_003Et__builder.Start<_003CGenerar_003Ed__12>(ref _003CGenerar_003Ed__);
		return _003CGenerar_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCancelar_003Ed__13))]
	[HttpPost("{id}/cancelar")]
	public System.Threading.Tasks.Task<IActionResult> Cancelar(int id, [FromBody] CancelarFacturaDto? dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCancelar_003Ed__13 _003CCancelar_003Ed__ = default(_003CCancelar_003Ed__13);
		_003CCancelar_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCancelar_003Ed__._003C_003E4__this = this;
		_003CCancelar_003Ed__.id = id;
		_003CCancelar_003Ed__.dto = dto;
		_003CCancelar_003Ed__._003C_003E1__state = -1;
		_003CCancelar_003Ed__._003C_003Et__builder.Start<_003CCancelar_003Ed__13>(ref _003CCancelar_003Ed__);
		return _003CCancelar_003Ed__._003C_003Et__builder.get_Task();
	}
}
