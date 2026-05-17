using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateExpenseDto
{
	[Required(ErrorMessage = "Category is required")]
	[StringLength(100)]
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

	[StringLength(500)]
	public string Description
	{
		[CompilerGenerated]
		get
		{
			return _003CDescription_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDescription_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Amount is required")]
	[Range(0.01, 999999999.99, ErrorMessage = "Amount must be positive")]
	public decimal Amount
	{
		[CompilerGenerated]
		get
		{
			return _003CAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAmount_003Ek__BackingField = value;
		}
	}

	[StringLength(50)]
	public string? PaymentMethod
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

	[StringLength(100)]
	public string? Reference
	{
		[CompilerGenerated]
		get
		{
			return _003CReference_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReference_003Ek__BackingField = value;
		}
	}

	public CreateExpenseDto()
	{
		_003CCategory_003Ek__BackingField = string.Empty;
		_003CDescription_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
