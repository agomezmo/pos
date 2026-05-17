using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Services;

namespace POS.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AuthController : ControllerBase
{
	private readonly AuthService _authService;

	public AuthController(AuthService authService)
	{
		_authService = authService;
	}

	[AsyncStateMachine(typeof(_003CLogin_003Ed__2))]
	[HttpPost("login")]
	public System.Threading.Tasks.Task<IActionResult> Login([FromBody] LoginRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CLogin_003Ed__2 _003CLogin_003Ed__ = default(_003CLogin_003Ed__2);
		_003CLogin_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CLogin_003Ed__._003C_003E4__this = this;
		_003CLogin_003Ed__.request = request;
		_003CLogin_003Ed__._003C_003E1__state = -1;
		_003CLogin_003Ed__._003C_003Et__builder.Start<_003CLogin_003Ed__2>(ref _003CLogin_003Ed__);
		return _003CLogin_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CRegister_003Ed__3))]
	[HttpPost("register")]
	public System.Threading.Tasks.Task<IActionResult> Register([FromBody] RegisterRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CRegister_003Ed__3 _003CRegister_003Ed__ = default(_003CRegister_003Ed__3);
		_003CRegister_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CRegister_003Ed__._003C_003E4__this = this;
		_003CRegister_003Ed__.request = request;
		_003CRegister_003Ed__._003C_003E1__state = -1;
		_003CRegister_003Ed__._003C_003Et__builder.Start<_003CRegister_003Ed__3>(ref _003CRegister_003Ed__);
		return _003CRegister_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CChangePassword_003Ed__4))]
	[Authorize]
	[HttpPost("change-password")]
	public System.Threading.Tasks.Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CChangePassword_003Ed__4 _003CChangePassword_003Ed__ = default(_003CChangePassword_003Ed__4);
		_003CChangePassword_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CChangePassword_003Ed__._003C_003E4__this = this;
		_003CChangePassword_003Ed__.request = request;
		_003CChangePassword_003Ed__._003C_003E1__state = -1;
		_003CChangePassword_003Ed__._003C_003Et__builder.Start<_003CChangePassword_003Ed__4>(ref _003CChangePassword_003Ed__);
		return _003CChangePassword_003Ed__._003C_003Et__builder.get_Task();
	}
}
