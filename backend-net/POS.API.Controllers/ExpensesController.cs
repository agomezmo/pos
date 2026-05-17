using System;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class ExpensesController : ControllerBase
{
	private readonly AppDbContext _context;

	public ExpensesController(AppDbContext context)
	{
		_context = context;
	}

	private int GetUserId()
	{
		return int.Parse(PrincipalExtensions.FindFirstValue(((ControllerBase)this).get_User(), "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"));
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__3))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll([FromQuery] System.DateTime? from, [FromQuery] System.DateTime? to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__3 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__3);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.from = from;
		_003CGetAll_003Ed__.to = to;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__3>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__4))]
	[HttpGet("{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__4 _003CGetById_003Ed__ = default(_003CGetById_003Ed__4);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__4>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__5))]
	[HttpPost]
	public System.Threading.Tasks.Task<IActionResult> Create([FromBody] CreateExpenseDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__5 _003CCreate_003Ed__ = default(_003CCreate_003Ed__5);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__5>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}
}
