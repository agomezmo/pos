using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class DiscountImpactDto
{
	public int TotalTransactions
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalTransactions_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalTransactions_003Ek__BackingField = value;
		}
	}

	public int TransactionsWithDiscount
	{
		[CompilerGenerated]
		get
		{
			return _003CTransactionsWithDiscount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTransactionsWithDiscount_003Ek__BackingField = value;
		}
	}

	public decimal DiscountPercentage
	{
		[CompilerGenerated]
		get
		{
			return _003CDiscountPercentage_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDiscountPercentage_003Ek__BackingField = value;
		}
	}

	public decimal TotalDiscountGiven
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalDiscountGiven_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalDiscountGiven_003Ek__BackingField = value;
		}
	}

	public decimal TotalSalesBeforeDiscount
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSalesBeforeDiscount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSalesBeforeDiscount_003Ek__BackingField = value;
		}
	}

	public decimal ImpactOnMargin
	{
		[CompilerGenerated]
		get
		{
			return _003CImpactOnMargin_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CImpactOnMargin_003Ek__BackingField = value;
		}
	}
}
