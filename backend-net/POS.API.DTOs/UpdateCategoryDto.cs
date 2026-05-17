using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class UpdateCategoryDto
{
	[Required(ErrorMessage = "Category name is required")]
	[StringLength(100)]
	public string Name
	{
		[CompilerGenerated]
		get
		{
			return _003CName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CName_003Ek__BackingField = value;
		}
	}

	[StringLength(500)]
	public string? Description
	{
		[CompilerGenerated]
		get
		{
			return _003CDescription_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDescription_003Ek__BackingField = value;
		}
	}

	public bool IsActive
	{
		[CompilerGenerated]
		get
		{
			return _003CIsActive_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIsActive_003Ek__BackingField = value;
		}
	}

	public UpdateCategoryDto()
	{
		_003CName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
