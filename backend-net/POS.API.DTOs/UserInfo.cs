using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class UserInfo
{
	public int Id
	{
		[CompilerGenerated]
		get
		{
			return _003CId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CId_003Ek__BackingField = value;
		}
	}

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

	public string FullName
	{
		[CompilerGenerated]
		get
		{
			return _003CFullName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFullName_003Ek__BackingField = value;
		}
	}

	public string Role
	{
		[CompilerGenerated]
		get
		{
			return _003CRole_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRole_003Ek__BackingField = value;
		}
	}

	public UserInfo()
	{
		_003CUsername_003Ek__BackingField = string.Empty;
		_003CFullName_003Ek__BackingField = string.Empty;
		_003CRole_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
