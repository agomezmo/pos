using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class GenerarFacturaDto
{
	[Required]
	public int SaleId
	{
		[CompilerGenerated]
		get
		{
			return _003CSaleId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSaleId_003Ek__BackingField = value;
		}
	}

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

	[StringLength(13)]
	public string? ReceptorRfc
	{
		[CompilerGenerated]
		get
		{
			return _003CReceptorRfc_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceptorRfc_003Ek__BackingField = value;
		}
	}

	[StringLength(255)]
	public string? ReceptorNombre
	{
		[CompilerGenerated]
		get
		{
			return _003CReceptorNombre_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceptorNombre_003Ek__BackingField = value;
		}
	}

	[StringLength(3)]
	public string? ReceptorUsoCfdi
	{
		[CompilerGenerated]
		get
		{
			return _003CReceptorUsoCfdi_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceptorUsoCfdi_003Ek__BackingField = value;
		}
	}

	[StringLength(2)]
	public string? FormaPago
	{
		[CompilerGenerated]
		get
		{
			return _003CFormaPago_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFormaPago_003Ek__BackingField = value;
		}
	}

	[StringLength(3)]
	public string? MetodoPago
	{
		[CompilerGenerated]
		get
		{
			return _003CMetodoPago_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMetodoPago_003Ek__BackingField = value;
		}
	}
}
