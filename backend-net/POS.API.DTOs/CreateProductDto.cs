using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateProductDto
{
	[Required(ErrorMessage = "Code is required")]
	[StringLength(50)]
	public string Code
	{
		[CompilerGenerated]
		get
		{
			return _003CCode_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCode_003Ek__BackingField = value;
		}
	}

	[StringLength(50)]
	public string? Barcode
	{
		[CompilerGenerated]
		get
		{
			return _003CBarcode_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CBarcode_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Name is required")]
	[StringLength(200)]
	public string Name
	{
		[CompilerGenerated]
		get
		{
			return _003CName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CName_003Ek__BackingField = value;
		}
	}

	[StringLength(500)]
	public string? Description
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

	[Required(ErrorMessage = "Category is required")]
	public int CategoryId
	{
		[CompilerGenerated]
		get
		{
			return _003CCategoryId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCategoryId_003Ek__BackingField = value;
		}
	}

	public int? SupplierId
	{
		[CompilerGenerated]
		get
		{
			return _003CSupplierId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSupplierId_003Ek__BackingField = value;
		}
	}

	[Range(0.0, 999999999.99, ErrorMessage = "Purchase price must be positive")]
	public decimal PurchasePrice
	{
		[CompilerGenerated]
		get
		{
			return _003CPurchasePrice_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPurchasePrice_003Ek__BackingField = value;
		}
	}

	[Range(0.0, 999999999.99, ErrorMessage = "Sale price must be positive")]
	public decimal SalePrice
	{
		[CompilerGenerated]
		get
		{
			return _003CSalePrice_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSalePrice_003Ek__BackingField = value;
		}
	}

	[Range(0.0, 999999999.99, ErrorMessage = "Wholesale price must be positive")]
	public decimal WholesalePrice
	{
		[CompilerGenerated]
		get
		{
			return _003CWholesalePrice_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CWholesalePrice_003Ek__BackingField = value;
		}
	}

	[Range(0, 2147483647, ErrorMessage = "Stock must be a non-negative integer")]
	public int Stock
	{
		[CompilerGenerated]
		get
		{
			return _003CStock_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CStock_003Ek__BackingField = value;
		}
	}

	[Range(0, 2147483647, ErrorMessage = "Min stock must be a non-negative integer")]
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

	[Required(ErrorMessage = "Unit is required")]
	[StringLength(20)]
	public string Unit
	{
		[CompilerGenerated]
		get
		{
			return _003CUnit_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUnit_003Ek__BackingField = value;
		}
	}

	public bool RequiresPrescription
	{
		[CompilerGenerated]
		get
		{
			return _003CRequiresPrescription_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRequiresPrescription_003Ek__BackingField = value;
		}
	}

	public bool RequiresTax
	{
		[CompilerGenerated]
		get
		{
			return _003CRequiresTax_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRequiresTax_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Expiry date is required")]
	public System.DateTime? ExpiryDate
	{
		[CompilerGenerated]
		get
		{
			return _003CExpiryDate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CExpiryDate_003Ek__BackingField = value;
		}
	}

	public CreateProductDto()
	{
		_003CCode_003Ek__BackingField = string.Empty;
		_003CName_003Ek__BackingField = string.Empty;
		_003CUnit_003Ek__BackingField = string.Empty;
		_003CRequiresTax_003Ek__BackingField = true;
		base._002Ector();
	}
}
