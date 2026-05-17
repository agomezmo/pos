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
public class CashRegisterController : ControllerBase
{
	private readonly CashRegisterService _cashRegisterService;

	public CashRegisterController(CashRegisterService cashRegisterService)
	{
		_cashRegisterService = cashRegisterService;
	}

	[AsyncStateMachine(typeof(_003CGetAllRegisters_003Ed__2))]
	[HttpGet("registers")]
	public System.Threading.Tasks.Task<IActionResult> GetAllRegisters()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAllRegisters_003Ed__2 _003CGetAllRegisters_003Ed__ = default(_003CGetAllRegisters_003Ed__2);
		_003CGetAllRegisters_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAllRegisters_003Ed__._003C_003E4__this = this;
		_003CGetAllRegisters_003Ed__._003C_003E1__state = -1;
		_003CGetAllRegisters_003Ed__._003C_003Et__builder.Start<_003CGetAllRegisters_003Ed__2>(ref _003CGetAllRegisters_003Ed__);
		return _003CGetAllRegisters_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreateRegister_003Ed__3))]
	[HttpPost("registers")]
	public System.Threading.Tasks.Task<IActionResult> CreateRegister([FromBody] CreateCashRegisterDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreateRegister_003Ed__3 _003CCreateRegister_003Ed__ = default(_003CCreateRegister_003Ed__3);
		_003CCreateRegister_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCreateRegister_003Ed__._003C_003E4__this = this;
		_003CCreateRegister_003Ed__.dto = dto;
		_003CCreateRegister_003Ed__._003C_003E1__state = -1;
		_003CCreateRegister_003Ed__._003C_003Et__builder.Start<_003CCreateRegister_003Ed__3>(ref _003CCreateRegister_003Ed__);
		return _003CCreateRegister_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003COpenSession_003Ed__4))]
	[HttpPost("sessions/open")]
	public System.Threading.Tasks.Task<IActionResult> OpenSession([FromQuery] int registerId, [FromBody] OpenSessionDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003COpenSession_003Ed__4 _003COpenSession_003Ed__ = default(_003COpenSession_003Ed__4);
		_003COpenSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003COpenSession_003Ed__._003C_003E4__this = this;
		_003COpenSession_003Ed__.registerId = registerId;
		_003COpenSession_003Ed__.dto = dto;
		_003COpenSession_003Ed__._003C_003E1__state = -1;
		_003COpenSession_003Ed__._003C_003Et__builder.Start<_003COpenSession_003Ed__4>(ref _003COpenSession_003Ed__);
		return _003COpenSession_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCloseSession_003Ed__5))]
	[HttpPost("sessions/{id}/close")]
	public System.Threading.Tasks.Task<IActionResult> CloseSession(int id, [FromBody] CloseSessionDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCloseSession_003Ed__5 _003CCloseSession_003Ed__ = default(_003CCloseSession_003Ed__5);
		_003CCloseSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCloseSession_003Ed__._003C_003E4__this = this;
		_003CCloseSession_003Ed__.id = id;
		_003CCloseSession_003Ed__.dto = dto;
		_003CCloseSession_003Ed__._003C_003E1__state = -1;
		_003CCloseSession_003Ed__._003C_003Et__builder.Start<_003CCloseSession_003Ed__5>(ref _003CCloseSession_003Ed__);
		return _003CCloseSession_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSession_003Ed__6))]
	[HttpGet("sessions/{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetSession(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSession_003Ed__6 _003CGetSession_003Ed__ = default(_003CGetSession_003Ed__6);
		_003CGetSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetSession_003Ed__._003C_003E4__this = this;
		_003CGetSession_003Ed__.id = id;
		_003CGetSession_003Ed__._003C_003E1__state = -1;
		_003CGetSession_003Ed__._003C_003Et__builder.Start<_003CGetSession_003Ed__6>(ref _003CGetSession_003Ed__);
		return _003CGetSession_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCurrentSession_003Ed__7))]
	[HttpGet("sessions/current/{registerId}")]
	public System.Threading.Tasks.Task<IActionResult> GetCurrentSession(int registerId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCurrentSession_003Ed__7 _003CGetCurrentSession_003Ed__ = default(_003CGetCurrentSession_003Ed__7);
		_003CGetCurrentSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetCurrentSession_003Ed__._003C_003E4__this = this;
		_003CGetCurrentSession_003Ed__.registerId = registerId;
		_003CGetCurrentSession_003Ed__._003C_003E1__state = -1;
		_003CGetCurrentSession_003Ed__._003C_003Et__builder.Start<_003CGetCurrentSession_003Ed__7>(ref _003CGetCurrentSession_003Ed__);
		return _003CGetCurrentSession_003Ed__._003C_003Et__builder.get_Task();
	}
}
