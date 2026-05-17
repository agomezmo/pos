using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class UpdateUserDto
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

	[Required(ErrorMessage = "Full name is required")]
	[StringLength(100)]
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

	[EmailAddress(ErrorMessage = "Invalid email")]
	[StringLength(100)]
	public string? Email
	{
		[CompilerGenerated]
		get
		{
			return _003CEmail_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmail_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Role is required")]
	[Range(1, 2147483647)]
	public int RoleId
	{
		[CompilerGenerated]
		get
		{
			return _003CRoleId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRoleId_003Ek__BackingField = value;
		}
	}

	[MinLength(6, ErrorMessage = "Password must be at least 6 characters")]
	public string? Password
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

	public UpdateUserDto()
	{
		_003CUsername_003Ek__BackingField = string.Empty;
		_003CFullName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
