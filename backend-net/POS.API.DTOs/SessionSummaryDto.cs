using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class SessionSummaryDto
{
	public decimal OpeningAmount
	{
		[CompilerGenerated]
		get
		{
			return _003COpeningAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003COpeningAmount_003Ek__BackingField = value;
		}
	}

	public decimal ClosingAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CClosingAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CClosingAmount_003Ek__BackingField = value;
		}
	}

	public decimal ExpectedAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CExpectedAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CExpectedAmount_003Ek__BackingField = value;
		}
	}

	public decimal Difference
	{
		[CompilerGenerated]
		get
		{
			return _003CDifference_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDifference_003Ek__BackingField = value;
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

	public decimal TotalSalesAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSalesAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSalesAmount_003Ek__BackingField = value;
		}
	}
}
