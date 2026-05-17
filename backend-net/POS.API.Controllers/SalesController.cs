using System;
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
public class SalesController : ControllerBase
{
	private readonly SaleService _saleService;

	public SalesController(SaleService saleService)
	{
		_saleService = saleService;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll([FromQuery] System.DateTime? dateFrom, [FromQuery] System.DateTime? dateTo, [FromQuery] int page = 1, [FromQuery] int pageSize = 20)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.dateFrom = dateFrom;
		_003CGetAll_003Ed__.dateTo = dateTo;
		_003CGetAll_003Ed__.page = page;
		_003CGetAll_003Ed__.pageSize = pageSize;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__2>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__3))]
	[HttpGet("{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__3 _003CGetById_003Ed__ = default(_003CGetById_003Ed__3);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__3>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__4))]
	[HttpPost]
	public System.Threading.Tasks.Task<IActionResult> Create([FromBody] CreateSaleDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__4 _003CCreate_003Ed__ = default(_003CCreate_003Ed__4);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__4>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByReceiptNumber_003Ed__5))]
	[HttpGet("by-receipt/{receiptNumber}")]
	public System.Threading.Tasks.Task<IActionResult> GetByReceiptNumber(string receiptNumber)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByReceiptNumber_003Ed__5 _003CGetByReceiptNumber_003Ed__ = default(_003CGetByReceiptNumber_003Ed__5);
		_003CGetByReceiptNumber_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetByReceiptNumber_003Ed__._003C_003E4__this = this;
		_003CGetByReceiptNumber_003Ed__.receiptNumber = receiptNumber;
		_003CGetByReceiptNumber_003Ed__._003C_003E1__state = -1;
		_003CGetByReceiptNumber_003Ed__._003C_003Et__builder.Start<_003CGetByReceiptNumber_003Ed__5>(ref _003CGetByReceiptNumber_003Ed__);
		return _003CGetByReceiptNumber_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByCustomer_003Ed__6))]
	[HttpGet("by-customer/{customerId}")]
	public System.Threading.Tasks.Task<IActionResult> GetByCustomer(int customerId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByCustomer_003Ed__6 _003CGetByCustomer_003Ed__ = default(_003CGetByCustomer_003Ed__6);
		_003CGetByCustomer_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetByCustomer_003Ed__._003C_003E4__this = this;
		_003CGetByCustomer_003Ed__.customerId = customerId;
		_003CGetByCustomer_003Ed__._003C_003E1__state = -1;
		_003CGetByCustomer_003Ed__._003C_003Et__builder.Start<_003CGetByCustomer_003Ed__6>(ref _003CGetByCustomer_003Ed__);
		return _003CGetByCustomer_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCancel_003Ed__7))]
	[HttpPost("{id}/cancel")]
	public System.Threading.Tasks.Task<IActionResult> Cancel(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCancel_003Ed__7 _003CCancel_003Ed__ = default(_003CCancel_003Ed__7);
		_003CCancel_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCancel_003Ed__._003C_003E4__this = this;
		_003CCancel_003Ed__.id = id;
		_003CCancel_003Ed__._003C_003E1__state = -1;
		_003CCancel_003Ed__._003C_003Et__builder.Start<_003CCancel_003Ed__7>(ref _003CCancel_003Ed__);
		return _003CCancel_003Ed__._003C_003Et__builder.get_Task();
	}
}
