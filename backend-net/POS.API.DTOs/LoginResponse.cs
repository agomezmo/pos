using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class LoginResponse
{
	public string Token
	{
		[CompilerGenerated]
		get
		{
			return _003CToken_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CToken_003Ek__BackingField = value;
		}
	}

	public UserInfo User
	{
		[CompilerGenerated]
		get
		{
			return _003CUser_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUser_003Ek__BackingField = value;
		}
	}

	public LoginResponse()
	{
		_003CToken_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
