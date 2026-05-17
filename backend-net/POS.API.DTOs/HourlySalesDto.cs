using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class HourlySalesDto
{
	public int Hour
	{
		[CompilerGenerated]
		get
		{
			return _003CHour_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CHour_003Ek__BackingField = value;
		}
	}

	public int TransactionCount
	{
		[CompilerGenerated]
		get
		{
			return _003CTransactionCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTransactionCount_003Ek__BackingField = value;
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
}
