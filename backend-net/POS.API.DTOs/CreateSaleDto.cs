using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateSaleDto
{
	public int? CustomerId
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerId_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "At least one item is required")]
	[MinLength(1, ErrorMessage = "Sale must have at least one item")]
	public List<CreateSaleItemDto> Items
	{
		[CompilerGenerated]
		get
		{
			return _003CItems_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CItems_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Payment method is required")]
	[StringLength(50)]
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

	[Range(0.0, 999999999.99)]
	public decimal AmountReceived
	{
		[CompilerGenerated]
		get
		{
			return _003CAmountReceived_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAmountReceived_003Ek__BackingField = value;
		}
	}

	[Range(0.0, 999999999.99)]
	public decimal Change
	{
		[CompilerGenerated]
		get
		{
			return _003CChange_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CChange_003Ek__BackingField = value;
		}
	}

	public int? CashRegisterSessionId
	{
		[CompilerGenerated]
		get
		{
			return _003CCashRegisterSessionId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCashRegisterSessionId_003Ek__BackingField = value;
		}
	}

	[StringLength(500)]
	public string? Notes
	{
		[CompilerGenerated]
		get
		{
			return _003CNotes_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CNotes_003Ek__BackingField = value;
		}
	}

	public CreateSaleDto()
	{
		_003CItems_003Ek__BackingField = new List<CreateSaleItemDto>();
		_003CPaymentMethod_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
