using System;
using System.IdentityModel.Tokens.Jwt;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using POS.API.DTOs;
using POS.API.Data;
using POS.API.Models;

namespace POS.API.Services;

public class AuthService
{
	private readonly AppDbContext _context;

	private readonly IConfiguration _configuration;

	public AuthService(AppDbContext context, IConfiguration configuration)
	{
		_context = context;
		_configuration = configuration;
	}

	[AsyncStateMachine(typeof(_003CLogin_003Ed__3))]
	public System.Threading.Tasks.Task<LoginResponse?> Login(LoginRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CLogin_003Ed__3 _003CLogin_003Ed__ = default(_003CLogin_003Ed__3);
		_003CLogin_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<LoginResponse>.Create();
		_003CLogin_003Ed__._003C_003E4__this = this;
		_003CLogin_003Ed__.request = request;
		_003CLogin_003Ed__._003C_003E1__state = -1;
		_003CLogin_003Ed__._003C_003Et__builder.Start<_003CLogin_003Ed__3>(ref _003CLogin_003Ed__);
		return _003CLogin_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CRegister_003Ed__4))]
	public System.Threading.Tasks.Task<bool> Register(RegisterRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CRegister_003Ed__4 _003CRegister_003Ed__ = default(_003CRegister_003Ed__4);
		_003CRegister_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CRegister_003Ed__._003C_003E4__this = this;
		_003CRegister_003Ed__.request = request;
		_003CRegister_003Ed__._003C_003E1__state = -1;
		_003CRegister_003Ed__._003C_003Et__builder.Start<_003CRegister_003Ed__4>(ref _003CRegister_003Ed__);
		return _003CRegister_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CChangePassword_003Ed__5))]
	public System.Threading.Tasks.Task<bool> ChangePassword(int userId, ChangePasswordRequest request)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CChangePassword_003Ed__5 _003CChangePassword_003Ed__ = default(_003CChangePassword_003Ed__5);
		_003CChangePassword_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CChangePassword_003Ed__._003C_003E4__this = this;
		_003CChangePassword_003Ed__.userId = userId;
		_003CChangePassword_003Ed__.request = request;
		_003CChangePassword_003Ed__._003C_003E1__state = -1;
		_003CChangePassword_003Ed__._003C_003Et__builder.Start<_003CChangePassword_003Ed__5>(ref _003CChangePassword_003Ed__);
		return _003CChangePassword_003Ed__._003C_003Et__builder.get_Task();
	}

	private string GenerateJwtToken(User user)
	{
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Expected O, but got Unknown
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Expected O, but got Unknown
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Expected O, but got Unknown
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Expected O, but got Unknown
		SymmetricSecurityKey key = new SymmetricSecurityKey(Encoding.get_UTF8().GetBytes(_configuration.get_Item("Jwt:Key")));
		SigningCredentials signingCredentials = new SigningCredentials(key, "HS256");
		Claim[] claims = (Claim[])(object)new Claim[4]
		{
			new Claim("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier", user.Id.ToString()),
			new Claim("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name", user.Username),
			new Claim("http://schemas.microsoft.com/ws/2008/06/identity/claims/role", user.Role.Name),
			new Claim("FullName", user.FullName)
		};
		string issuer = _configuration.get_Item("Jwt:Issuer");
		string audience = _configuration.get_Item("Jwt:Audience");
		System.DateTime? expires = System.DateTime.get_UtcNow().AddMinutes(double.Parse(_configuration.get_Item("Jwt:DurationInMinutes")));
		SigningCredentials signingCredentials2 = signingCredentials;
		JwtSecurityToken token = new JwtSecurityToken(issuer, audience, claims, null, expires, signingCredentials2);
		return new JwtSecurityTokenHandler().WriteToken(token);
	}
}
