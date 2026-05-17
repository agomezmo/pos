using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class InventoryReportDto
{
	public int TotalProducts
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalProducts_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalProducts_003Ek__BackingField = value;
		}
	}

	public int ActiveProducts
	{
		[CompilerGenerated]
		get
		{
			return _003CActiveProducts_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CActiveProducts_003Ek__BackingField = value;
		}
	}

	public int LowStockProducts
	{
		[CompilerGenerated]
		get
		{
			return _003CLowStockProducts_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CLowStockProducts_003Ek__BackingField = value;
		}
	}

	public int OutOfStockProducts
	{
		[CompilerGenerated]
		get
		{
			return _003COutOfStockProducts_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003COutOfStockProducts_003Ek__BackingField = value;
		}
	}

	public decimal TotalStockValue
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalStockValue_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalStockValue_003Ek__BackingField = value;
		}
	}

	public List<LowStockProductDto> LowStockItems
	{
		[CompilerGenerated]
		get
		{
			return _003CLowStockItems_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CLowStockItems_003Ek__BackingField = value;
		}
	}

	public InventoryReportDto()
	{
		_003CLowStockItems_003Ek__BackingField = new List<LowStockProductDto>();
		base._002Ector();
	}
}
