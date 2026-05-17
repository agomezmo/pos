using System;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class InventoryController : ControllerBase
{
	private readonly AppDbContext _context;

	public InventoryController(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll([FromQuery] System.DateTime? desde, [FromQuery] System.DateTime? hasta, [FromQuery] int page = 1, [FromQuery] int pageSize = 50)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.desde = desde;
		_003CGetAll_003Ed__.hasta = hasta;
		_003CGetAll_003Ed__.page = page;
		_003CGetAll_003Ed__.pageSize = pageSize;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__2>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}
}
