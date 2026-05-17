using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class PaymentTrendDto
{
	public string Period
	{
		[CompilerGenerated]
		get
		{
			return _003CPeriod_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPeriod_003Ek__BackingField = value;
		}
	}

	public string PaymentMethod
	{
		[CompilerGenerated]
		get
		{
			return _003CPaymentMethod_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPaymentMethod_003Ek__BackingField = value;
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

	public PaymentTrendDto()
	{
		_003CPeriod_003Ek__BackingField = string.Empty;
		_003CPaymentMethod_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
