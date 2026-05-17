using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class LoginRequest
{
	[Required(ErrorMessage = "Username is required")]
	[StringLength(50)]
	public string Username
	{
		[CompilerGenerated]
		get
		{
			return _003CUsername_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUsername_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Password is required")]
	public string Password
	{
		[CompilerGenerated]
		get
		{
			return _003CPassword_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPassword_003Ek__BackingField = value;
		}
	}

	public LoginRequest()
	{
		_003CUsername_003Ek__BackingField = string.Empty;
		_003CPassword_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
