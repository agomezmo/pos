using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("CompanyInfo")]
public class CompanyInfo
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

	[StringLength(500)]
	public string? LogoUrl
	{
		[CompilerGenerated]
		get
		{
			return _003CLogoUrl_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CLogoUrl_003Ek__BackingField = value;
		}
	}

	[StringLength(20)]
	public string? TaxId
	{
		[CompilerGenerated]
		get
		{
			return _003CTaxId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTaxId_003Ek__BackingField = value;
		}
	}

	[StringLength(300)]
	public string? ReceiptFooter
	{
		[CompilerGenerated]
		get
		{
			return _003CReceiptFooter_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceiptFooter_003Ek__BackingField = value;
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

	public string? CertificadoSat
	{
		[CompilerGenerated]
		get
		{
			return _003CCertificadoSat_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCertificadoSat_003Ek__BackingField = value;
		}
	}

	public string? CertificadoKey
	{
		[CompilerGenerated]
		get
		{
			return _003CCertificadoKey_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCertificadoKey_003Ek__BackingField = value;
		}
	}

	[StringLength(255)]
	public string? CertificadoPassword
	{
		[CompilerGenerated]
		get
		{
			return _003CCertificadoPassword_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCertificadoPassword_003Ek__BackingField = value;
		}
	}

	[StringLength(3)]
	public string? RegimenFiscalCode
	{
		[CompilerGenerated]
		get
		{
			return _003CRegimenFiscalCode_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRegimenFiscalCode_003Ek__BackingField = value;
		}
	}

	[StringLength(5)]
	public string? SerieFactura
	{
		[CompilerGenerated]
		get
		{
			return _003CSerieFactura_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSerieFactura_003Ek__BackingField = value;
		}
	}

	public int FolioActual
	{
		[CompilerGenerated]
		get
		{
			return _003CFolioActual_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFolioActual_003Ek__BackingField = value;
		}
	}

	public CompanyInfo()
	{
		_003CName_003Ek__BackingField = string.Empty;
		_003CSerieFactura_003Ek__BackingField = "F";
		base._002Ector();
	}
}
