using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateCustomerDto
{
	[StringLength(20)]
	public string DocumentType
	{
		[CompilerGenerated]
		get
		{
			return _003CDocumentType_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDocumentType_003Ek__BackingField = value;
		}
	}

	[StringLength(50)]
	public string DocumentNumber
	{
		[CompilerGenerated]
		get
		{
			return _003CDocumentNumber_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDocumentNumber_003Ek__BackingField = value;
		}
	}

	[Required(ErrorMessage = "Full name is required")]
	[StringLength(200)]
	public string FullName
	{
		[CompilerGenerated]
		get
		{
			return _003CFullName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFullName_003Ek__BackingField = value;
		}
	}

	[StringLength(20)]
	public string? Phone
	{
		[CompilerGenerated]
		get
		{
			return _003CPhone_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPhone_003Ek__BackingField = value;
		}
	}

	[EmailAddress(ErrorMessage = "Invalid email format")]
	[StringLength(100)]
	public string? Email
	{
		[CompilerGenerated]
		get
		{
			return _003CEmail_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmail_003Ek__BackingField = value;
		}
	}

	[StringLength(200)]
	public string? Address
	{
		[CompilerGenerated]
		get
		{
			return _003CAddress_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAddress_003Ek__BackingField = value;
		}
	}

	public System.DateTime? BirthDate
	{
		[CompilerGenerated]
		get
		{
			return _003CBirthDate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CBirthDate_003Ek__BackingField = value;
		}
	}

	[StringLength(13)]
	public string? Rfc
	{
		[CompilerGenerated]
		get
		{
			return _003CRfc_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRfc_003Ek__BackingField = value;
		}
	}

	[StringLength(255)]
	public string? RazonSocial
	{
		[CompilerGenerated]
		get
		{
			return _003CRazonSocial_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRazonSocial_003Ek__BackingField = value;
		}
	}

	public int? RegimenFiscalId
	{
		[CompilerGenerated]
		get
		{
			return _003CRegimenFiscalId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRegimenFiscalId_003Ek__BackingField = value;
		}
	}

	public int? UsoCfdiId
	{
		[CompilerGenerated]
		get
		{
			return _003CUsoCfdiId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUsoCfdiId_003Ek__BackingField = value;
		}
	}

	[StringLength(5)]
	public string? CodigoPostal
	{
		[CompilerGenerated]
		get
		{
			return _003CCodigoPostal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCodigoPostal_003Ek__BackingField = value;
		}
	}

	public CreateCustomerDto()
	{
		_003CDocumentType_003Ek__BackingField = string.Empty;
		_003CDocumentNumber_003Ek__BackingField = string.Empty;
		_003CFullName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
