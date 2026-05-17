using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class SettingsController : ControllerBase
{
	private readonly AppDbContext _context;

	public SettingsController(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGet_003Ed__2))]
	[HttpGet("{key}")]
	public System.Threading.Tasks.Task<IActionResult> Get(string key)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGet_003Ed__2 _003CGet_003Ed__ = default(_003CGet_003Ed__2);
		_003CGet_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGet_003Ed__._003C_003E4__this = this;
		_003CGet_003Ed__.key = key;
		_003CGet_003Ed__._003C_003E1__state = -1;
		_003CGet_003Ed__._003C_003Et__builder.Start<_003CGet_003Ed__2>(ref _003CGet_003Ed__);
		return _003CGet_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetTaxRate_003Ed__3))]
	[HttpGet("tax-rate")]
	public System.Threading.Tasks.Task<IActionResult> GetTaxRate()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetTaxRate_003Ed__3 _003CGetTaxRate_003Ed__ = default(_003CGetTaxRate_003Ed__3);
		_003CGetTaxRate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetTaxRate_003Ed__._003C_003E4__this = this;
		_003CGetTaxRate_003Ed__._003C_003E1__state = -1;
		_003CGetTaxRate_003Ed__._003C_003Et__builder.Start<_003CGetTaxRate_003Ed__3>(ref _003CGetTaxRate_003Ed__);
		return _003CGetTaxRate_003Ed__._003C_003Et__builder.get_Task();
	}
}
