using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class TopProductsDto
{
	public int ProductId
	{
		[CompilerGenerated]
		get
		{
			return _003CProductId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductId_003Ek__BackingField = value;
		}
	}

	public string ProductName
	{
		[CompilerGenerated]
		get
		{
			return _003CProductName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductName_003Ek__BackingField = value;
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

	public TopProductsDto()
	{
		_003CProductName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
