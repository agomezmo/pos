using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class StockProjectionDto
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

	public int CurrentStock
	{
		[CompilerGenerated]
		get
		{
			return _003CCurrentStock_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCurrentStock_003Ek__BackingField = value;
		}
	}

	public int MinStock
	{
		[CompilerGenerated]
		get
		{
			return _003CMinStock_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMinStock_003Ek__BackingField = value;
		}
	}

	public int MonthlyConsumption
	{
		[CompilerGenerated]
		get
		{
			return _003CMonthlyConsumption_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMonthlyConsumption_003Ek__BackingField = value;
		}
	}

	public int DaysUntilStockout
	{
		[CompilerGenerated]
		get
		{
			return _003CDaysUntilStockout_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDaysUntilStockout_003Ek__BackingField = value;
		}
	}

	public string RiskLevel
	{
		[CompilerGenerated]
		get
		{
			return _003CRiskLevel_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRiskLevel_003Ek__BackingField = value;
		}
	}

	public StockProjectionDto()
	{
		_003CProductName_003Ek__BackingField = string.Empty;
		_003CCategory_003Ek__BackingField = string.Empty;
		_003CRiskLevel_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
