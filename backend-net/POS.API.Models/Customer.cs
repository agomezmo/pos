using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("Customers")]
public class Customer
{
	[Key]
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

	[Required]
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

	[Required]
	[StringLength(20)]
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

	[Required]
	[StringLength(100)]
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

	[ForeignKey("RegimenFiscalId")]
	public CatRegimenFiscal? RegimenFiscal
	{
		[CompilerGenerated]
		get
		{
			return _003CRegimenFiscal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRegimenFiscal_003Ek__BackingField = value;
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

	[ForeignKey("UsoCfdiId")]
	public CatUsoCfdi? UsoCfdi
	{
		[CompilerGenerated]
		get
		{
			return _003CUsoCfdi_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUsoCfdi_003Ek__BackingField = value;
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

	public System.DateTime? UpdatedAt
	{
		[CompilerGenerated]
		get
		{
			return _003CUpdatedAt_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUpdatedAt_003Ek__BackingField = value;
		}
	}

	public System.Collections.Generic.ICollection<Sale> Sales
	{
		[CompilerGenerated]
		get
		{
			return _003CSales_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSales_003Ek__BackingField = value;
		}
	}

	public Patient? Patient
	{
		[CompilerGenerated]
		get
		{
			return _003CPatient_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPatient_003Ek__BackingField = value;
		}
	}

	public Customer()
	{
		_003CDocumentType_003Ek__BackingField = string.Empty;
		_003CDocumentNumber_003Ek__BackingField = string.Empty;
		_003CFullName_003Ek__BackingField = string.Empty;
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		_003CSales_003Ek__BackingField = (System.Collections.Generic.ICollection<Sale>)new List<Sale>();
		base._002Ector();
	}
}
