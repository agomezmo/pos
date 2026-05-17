using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("facturas")]
public class Factura
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

	[ForeignKey("SaleId")]
	public Sale Sale
	{
		[CompilerGenerated]
		get
		{
			return _003CSale_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSale_003Ek__BackingField = value;
		}
	}

	[StringLength(36)]
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

	[Required]
	[StringLength(20)]
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

	[StringLength(5)]
	public string Serie
	{
		[CompilerGenerated]
		get
		{
			return _003CSerie_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSerie_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(13)]
	public string EmisorRfc
	{
		[CompilerGenerated]
		get
		{
			return _003CEmisorRfc_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmisorRfc_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(255)]
	public string EmisorNombre
	{
		[CompilerGenerated]
		get
		{
			return _003CEmisorNombre_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmisorNombre_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(3)]
	public string EmisorRegimenFiscal
	{
		[CompilerGenerated]
		get
		{
			return _003CEmisorRegimenFiscal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmisorRegimenFiscal_003Ek__BackingField = value;
		}
	}

	[StringLength(5)]
	public string? EmisorCodigoPostal
	{
		[CompilerGenerated]
		get
		{
			return _003CEmisorCodigoPostal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmisorCodigoPostal_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(13)]
	public string ReceptorRfc
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

	[Required]
	[StringLength(255)]
	public string ReceptorNombre
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

	[Required]
	[StringLength(3)]
	public string ReceptorUsoCfdi
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

	[StringLength(5)]
	public string? ReceptorCodigoPostal
	{
		[CompilerGenerated]
		get
		{
			return _003CReceptorCodigoPostal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReceptorCodigoPostal_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
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

	[Column(TypeName = "decimal(18,2)")]
	public decimal Descuento
	{
		[CompilerGenerated]
		get
		{
			return _003CDescuento_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDescuento_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal Iva
	{
		[CompilerGenerated]
		get
		{
			return _003CIva_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIva_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal Ieps
	{
		[CompilerGenerated]
		get
		{
			return _003CIeps_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIeps_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
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

	[StringLength(2)]
	public string FormaPago
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
	public string MetodoPago
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

	[StringLength(3)]
	public string Moneda
	{
		[CompilerGenerated]
		get
		{
			return _003CMoneda_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMoneda_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,6)")]
	public decimal TipoCambio
	{
		[CompilerGenerated]
		get
		{
			return _003CTipoCambio_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTipoCambio_003Ek__BackingField = value;
		}
	}

	[StringLength(5)]
	public string? LugarExpedicion
	{
		[CompilerGenerated]
		get
		{
			return _003CLugarExpedicion_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CLugarExpedicion_003Ek__BackingField = value;
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

	public System.DateTime? FechaTimbrado
	{
		[CompilerGenerated]
		get
		{
			return _003CFechaTimbrado_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFechaTimbrado_003Ek__BackingField = value;
		}
	}

	public string? XmlTimbrado
	{
		[CompilerGenerated]
		get
		{
			return _003CXmlTimbrado_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CXmlTimbrado_003Ek__BackingField = value;
		}
	}

	public string? XmlCadenaOriginal
	{
		[CompilerGenerated]
		get
		{
			return _003CXmlCadenaOriginal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CXmlCadenaOriginal_003Ek__BackingField = value;
		}
	}

	public string? SatCfdiHash
	{
		[CompilerGenerated]
		get
		{
			return _003CSatCfdiHash_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSatCfdiHash_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(20)]
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

	public string? MotivoCancelacion
	{
		[CompilerGenerated]
		get
		{
			return _003CMotivoCancelacion_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMotivoCancelacion_003Ek__BackingField = value;
		}
	}

	public int? CreatedBy
	{
		[CompilerGenerated]
		get
		{
			return _003CCreatedBy_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCreatedBy_003Ek__BackingField = value;
		}
	}

	[ForeignKey("CreatedBy")]
	public User? CreatedByUser
	{
		[CompilerGenerated]
		get
		{
			return _003CCreatedByUser_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCreatedByUser_003Ek__BackingField = value;
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

	public System.Collections.Generic.ICollection<FacturaItem> Items
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

	public System.Collections.Generic.ICollection<FacturaRelacion> Relaciones
	{
		[CompilerGenerated]
		get
		{
			return _003CRelaciones_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CRelaciones_003Ek__BackingField = value;
		}
	}

	public Factura()
	{
		_003CFolio_003Ek__BackingField = string.Empty;
		_003CSerie_003Ek__BackingField = "F";
		_003CEmisorRfc_003Ek__BackingField = string.Empty;
		_003CEmisorNombre_003Ek__BackingField = string.Empty;
		_003CEmisorRegimenFiscal_003Ek__BackingField = string.Empty;
		_003CReceptorRfc_003Ek__BackingField = string.Empty;
		_003CReceptorNombre_003Ek__BackingField = string.Empty;
		_003CReceptorUsoCfdi_003Ek__BackingField = string.Empty;
		_003CFormaPago_003Ek__BackingField = "01";
		_003CMetodoPago_003Ek__BackingField = "PUE";
		_003CMoneda_003Ek__BackingField = "MXN";
		_003CTipoCambio_003Ek__BackingField = 1m;
		_003CFechaEmision_003Ek__BackingField = System.DateTime.get_UtcNow();
		_003CEstado_003Ek__BackingField = "Pendiente";
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		_003CItems_003Ek__BackingField = (System.Collections.Generic.ICollection<FacturaItem>)new List<FacturaItem>();
		_003CRelaciones_003Ek__BackingField = (System.Collections.Generic.ICollection<FacturaRelacion>)new List<FacturaRelacion>();
		base._002Ector();
	}
}
