using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ExpenseCategoryDto
{
	public string Category
	{
		[CompilerGenerated]
		get
		{
			return _003CCategory_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCategory_003Ek__BackingField = value;
		}
	}

	public decimal TotalAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalAmount_003Ek__BackingField = value;
		}
	}

	public int Count
	{
		[CompilerGenerated]
		get
		{
			return _003CCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCount_003Ek__BackingField = value;
		}
	}

	public decimal Percentage
	{
		[CompilerGenerated]
		get
		{
			return _003CPercentage_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPercentage_003Ek__BackingField = value;
		}
	}

	public ExpenseCategoryDto()
	{
		_003CCategory_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
