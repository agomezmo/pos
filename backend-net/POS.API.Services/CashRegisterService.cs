using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Services;

public class CashRegisterService
{
	private readonly AppDbContext _context;

	public CashRegisterService(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAllRegisters_003Ed__2))]
	public System.Threading.Tasks.Task<List<CashRegisterDto>> GetAllRegisters()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAllRegisters_003Ed__2 _003CGetAllRegisters_003Ed__ = default(_003CGetAllRegisters_003Ed__2);
		_003CGetAllRegisters_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CashRegisterDto>>.Create();
		_003CGetAllRegisters_003Ed__._003C_003E4__this = this;
		_003CGetAllRegisters_003Ed__._003C_003E1__state = -1;
		_003CGetAllRegisters_003Ed__._003C_003Et__builder.Start<_003CGetAllRegisters_003Ed__2>(ref _003CGetAllRegisters_003Ed__);
		return _003CGetAllRegisters_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreateRegister_003Ed__3))]
	public System.Threading.Tasks.Task<CashRegisterDto> CreateRegister(CreateCashRegisterDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreateRegister_003Ed__3 _003CCreateRegister_003Ed__ = default(_003CCreateRegister_003Ed__3);
		_003CCreateRegister_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CashRegisterDto>.Create();
		_003CCreateRegister_003Ed__._003C_003E4__this = this;
		_003CCreateRegister_003Ed__.dto = dto;
		_003CCreateRegister_003Ed__._003C_003E1__state = -1;
		_003CCreateRegister_003Ed__._003C_003Et__builder.Start<_003CCreateRegister_003Ed__3>(ref _003CCreateRegister_003Ed__);
		return _003CCreateRegister_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003COpenSession_003Ed__4))]
	public System.Threading.Tasks.Task<CashRegisterSessionDto?> OpenSession(int registerId, int userId, OpenSessionDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003COpenSession_003Ed__4 _003COpenSession_003Ed__ = default(_003COpenSession_003Ed__4);
		_003COpenSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CashRegisterSessionDto>.Create();
		_003COpenSession_003Ed__._003C_003E4__this = this;
		_003COpenSession_003Ed__.registerId = registerId;
		_003COpenSession_003Ed__.userId = userId;
		_003COpenSession_003Ed__.dto = dto;
		_003COpenSession_003Ed__._003C_003E1__state = -1;
		_003COpenSession_003Ed__._003C_003Et__builder.Start<_003COpenSession_003Ed__4>(ref _003COpenSession_003Ed__);
		return _003COpenSession_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCloseSession_003Ed__5))]
	public System.Threading.Tasks.Task<CashRegisterSessionDto?> CloseSession(int sessionId, CloseSessionDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCloseSession_003Ed__5 _003CCloseSession_003Ed__ = default(_003CCloseSession_003Ed__5);
		_003CCloseSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CashRegisterSessionDto>.Create();
		_003CCloseSession_003Ed__._003C_003E4__this = this;
		_003CCloseSession_003Ed__.sessionId = sessionId;
		_003CCloseSession_003Ed__.dto = dto;
		_003CCloseSession_003Ed__._003C_003E1__state = -1;
		_003CCloseSession_003Ed__._003C_003Et__builder.Start<_003CCloseSession_003Ed__5>(ref _003CCloseSession_003Ed__);
		return _003CCloseSession_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSessionStatus_003Ed__6))]
	public System.Threading.Tasks.Task<CashRegisterSessionDto?> GetSessionStatus(int sessionId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSessionStatus_003Ed__6 _003CGetSessionStatus_003Ed__ = default(_003CGetSessionStatus_003Ed__6);
		_003CGetSessionStatus_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CashRegisterSessionDto>.Create();
		_003CGetSessionStatus_003Ed__._003C_003E4__this = this;
		_003CGetSessionStatus_003Ed__.sessionId = sessionId;
		_003CGetSessionStatus_003Ed__._003C_003E1__state = -1;
		_003CGetSessionStatus_003Ed__._003C_003Et__builder.Start<_003CGetSessionStatus_003Ed__6>(ref _003CGetSessionStatus_003Ed__);
		return _003CGetSessionStatus_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSessionsByDate_003Ed__7))]
	public System.Threading.Tasks.Task<List<CashRegisterSessionDto>> GetSessionsByDate(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSessionsByDate_003Ed__7 _003CGetSessionsByDate_003Ed__ = default(_003CGetSessionsByDate_003Ed__7);
		_003CGetSessionsByDate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CashRegisterSessionDto>>.Create();
		_003CGetSessionsByDate_003Ed__._003C_003E4__this = this;
		_003CGetSessionsByDate_003Ed__.from = from;
		_003CGetSessionsByDate_003Ed__.to = to;
		_003CGetSessionsByDate_003Ed__._003C_003E1__state = -1;
		_003CGetSessionsByDate_003Ed__._003C_003Et__builder.Start<_003CGetSessionsByDate_003Ed__7>(ref _003CGetSessionsByDate_003Ed__);
		return _003CGetSessionsByDate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCurrentSession_003Ed__8))]
	public System.Threading.Tasks.Task<CashRegisterSessionDto?> GetCurrentSession(int registerId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCurrentSession_003Ed__8 _003CGetCurrentSession_003Ed__ = default(_003CGetCurrentSession_003Ed__8);
		_003CGetCurrentSession_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CashRegisterSessionDto>.Create();
		_003CGetCurrentSession_003Ed__._003C_003E4__this = this;
		_003CGetCurrentSession_003Ed__.registerId = registerId;
		_003CGetCurrentSession_003Ed__._003C_003E1__state = -1;
		_003CGetCurrentSession_003Ed__._003C_003Et__builder.Start<_003CGetCurrentSession_003Ed__8>(ref _003CGetCurrentSession_003Ed__);
		return _003CGetCurrentSession_003Ed__._003C_003Et__builder.get_Task();
	}
}
