using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class SalesByCategoryDto
{
	public int CategoryId
	{
		[CompilerGenerated]
		get
		{
			return _003CCategoryId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCategoryId_003Ek__BackingField = value;
		}
	}

	public string CategoryName
	{
		[CompilerGenerated]
		get
		{
			return _003CCategoryName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCategoryName_003Ek__BackingField = value;
		}
	}

	public int ProductCount
	{
		[CompilerGenerated]
		get
		{
			return _003CProductCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductCount_003Ek__BackingField = value;
		}
	}

	public int QuantitySold
	{
		[CompilerGenerated]
		get
		{
			return _003CQuantitySold_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CQuantitySold_003Ek__BackingField = value;
		}
	}

	public decimal TotalSales
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSales_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSales_003Ek__BackingField = value;
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

	public SalesByCategoryDto()
	{
		_003CCategoryName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
