using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class SalesDetailDto
{
	public System.DateTime CreatedAt
	{
		[CompilerGenerated]
		get
		{
			return _003CCreatedAt_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCreatedAt_003Ek__BackingField = value;
		}
	}

	public string ReceiptNumber
	{
		[CompilerGenerated]
		get
		{
			return _003CReceiptNumber_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceiptNumber_003Ek__BackingField = value;
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

	public int Quantity
	{
		[CompilerGenerated]
		get
		{
			return _003CQuantity_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CQuantity_003Ek__BackingField = value;
		}
	}

	public decimal UnitPrice
	{
		[CompilerGenerated]
		get
		{
			return _003CUnitPrice_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUnitPrice_003Ek__BackingField = value;
		}
	}

	public decimal Total
	{
		[CompilerGenerated]
		get
		{
			return _003CTotal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotal_003Ek__BackingField = value;
		}
	}

	public decimal Subtotal
	{
		[CompilerGenerated]
		get
		{
			return _003CSubtotal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSubtotal_003Ek__BackingField = value;
		}
	}

	public decimal Tax
	{
		[CompilerGenerated]
		get
		{
			return _003CTax_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTax_003Ek__BackingField = value;
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

	public SalesDetailDto()
	{
		_003CReceiptNumber_003Ek__BackingField = string.Empty;
		_003CProductName_003Ek__BackingField = string.Empty;
		_003CPaymentMethod_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
