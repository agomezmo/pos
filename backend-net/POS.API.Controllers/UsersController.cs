using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize(Roles = "Admin")]
[Route("api/[controller]")]
[ApiController]
public class UsersController : ControllerBase
{
	private readonly AppDbContext _context;

	public UsersController(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
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
	public System.Threading.Tasks.Task<IActionResult> Create([FromBody] CreateUserDto dto)
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

	[AsyncStateMachine(typeof(_003CUpdate_003Ed__5))]
	[HttpPut("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Update(int id, [FromBody] UpdateUserDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CUpdate_003Ed__5 _003CUpdate_003Ed__ = default(_003CUpdate_003Ed__5);
		_003CUpdate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CUpdate_003Ed__._003C_003E4__this = this;
		_003CUpdate_003Ed__.id = id;
		_003CUpdate_003Ed__.dto = dto;
		_003CUpdate_003Ed__._003C_003E1__state = -1;
		_003CUpdate_003Ed__._003C_003Et__builder.Start<_003CUpdate_003Ed__5>(ref _003CUpdate_003Ed__);
		return _003CUpdate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CToggleActive_003Ed__6))]
	[HttpPatch("{id}/toggle-active")]
	public System.Threading.Tasks.Task<IActionResult> ToggleActive(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CToggleActive_003Ed__6 _003CToggleActive_003Ed__ = default(_003CToggleActive_003Ed__6);
		_003CToggleActive_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CToggleActive_003Ed__._003C_003E4__this = this;
		_003CToggleActive_003Ed__.id = id;
		_003CToggleActive_003Ed__._003C_003E1__state = -1;
		_003CToggleActive_003Ed__._003C_003Et__builder.Start<_003CToggleActive_003Ed__6>(ref _003CToggleActive_003Ed__);
		return _003CToggleActive_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CDelete_003Ed__7))]
	[HttpDelete("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Delete(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CDelete_003Ed__7 _003CDelete_003Ed__ = default(_003CDelete_003Ed__7);
		_003CDelete_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CDelete_003Ed__._003C_003E4__this = this;
		_003CDelete_003Ed__.id = id;
		_003CDelete_003Ed__._003C_003E1__state = -1;
		_003CDelete_003Ed__._003C_003Et__builder.Start<_003CDelete_003Ed__7>(ref _003CDelete_003Ed__);
		return _003CDelete_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetRoles_003Ed__8))]
	[HttpGet("roles")]
	public System.Threading.Tasks.Task<IActionResult> GetRoles()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetRoles_003Ed__8 _003CGetRoles_003Ed__ = default(_003CGetRoles_003Ed__8);
		_003CGetRoles_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetRoles_003Ed__._003C_003E4__this = this;
		_003CGetRoles_003Ed__._003C_003E1__state = -1;
		_003CGetRoles_003Ed__._003C_003Et__builder.Start<_003CGetRoles_003Ed__8>(ref _003CGetRoles_003Ed__);
		return _003CGetRoles_003Ed__._003C_003Et__builder.get_Task();
	}
}
