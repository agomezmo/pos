using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class FacturaListDto
{
	public int Id
	{
		[CompilerGenerated]
		get
		{
			return _003CId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CId_003Ek__BackingField = value;
		}
	}

	public string Folio
	{
		[CompilerGenerated]
		get
		{
			return _003CFolio_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFolio_003Ek__BackingField = value;
		}
	}

	public string? Uuid
	{
		[CompilerGenerated]
		get
		{
			return _003CUuid_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUuid_003Ek__BackingField = value;
		}
	}

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

	public string Estado
	{
		[CompilerGenerated]
		get
		{
			return _003CEstado_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEstado_003Ek__BackingField = value;
		}
	}

	public System.DateTime FechaEmision
	{
		[CompilerGenerated]
		get
		{
			return _003CFechaEmision_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFechaEmision_003Ek__BackingField = value;
		}
	}

	public string? ReceiptNumber
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

	public FacturaListDto()
	{
		_003CFolio_003Ek__BackingField = string.Empty;
		_003CEstado_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
