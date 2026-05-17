using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class CompanyController : ControllerBase
{
	private readonly AppDbContext _context;

	public CompanyController(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetInfo_003Ed__2))]
	[HttpGet("info")]
	public System.Threading.Tasks.Task<IActionResult> GetInfo()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetInfo_003Ed__2 _003CGetInfo_003Ed__ = default(_003CGetInfo_003Ed__2);
		_003CGetInfo_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetInfo_003Ed__._003C_003E4__this = this;
		_003CGetInfo_003Ed__._003C_003E1__state = -1;
		_003CGetInfo_003Ed__._003C_003Et__builder.Start<_003CGetInfo_003Ed__2>(ref _003CGetInfo_003Ed__);
		return _003CGetInfo_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CUpdateInfo_003Ed__3))]
	[HttpPut("info")]
	public System.Threading.Tasks.Task<IActionResult> UpdateInfo([FromBody] CompanyInfoDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CUpdateInfo_003Ed__3 _003CUpdateInfo_003Ed__ = default(_003CUpdateInfo_003Ed__3);
		_003CUpdateInfo_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CUpdateInfo_003Ed__._003C_003E4__this = this;
		_003CUpdateInfo_003Ed__.dto = dto;
		_003CUpdateInfo_003Ed__._003C_003E1__state = -1;
		_003CUpdateInfo_003Ed__._003C_003Et__builder.Start<_003CUpdateInfo_003Ed__3>(ref _003CUpdateInfo_003Ed__);
		return _003CUpdateInfo_003Ed__._003C_003Et__builder.get_Task();
	}
}
