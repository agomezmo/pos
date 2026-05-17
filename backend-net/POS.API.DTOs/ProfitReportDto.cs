using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ProfitReportDto
{
	public decimal TotalRevenue
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalRevenue_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalRevenue_003Ek__BackingField = value;
		}
	}

	public decimal TotalCost
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalCost_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalCost_003Ek__BackingField = value;
		}
	}

	public decimal GrossProfit
	{
		[CompilerGenerated]
		get
		{
			return _003CGrossProfit_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CGrossProfit_003Ek__BackingField = value;
		}
	}

	public decimal GrossMargin
	{
		[CompilerGenerated]
		get
		{
			return _003CGrossMargin_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CGrossMargin_003Ek__BackingField = value;
		}
	}

	public int TotalSales
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
}
