using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("factura_items")]
public class FacturaItem
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

	public int FacturaId
	{
		[CompilerGenerated]
		get
		{
			return _003CFacturaId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFacturaId_003Ek__BackingField = value;
		}
	}

	[ForeignKey("FacturaId")]
	public Factura Factura
	{
		[CompilerGenerated]
		get
		{
			return _003CFactura_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFactura_003Ek__BackingField = value;
		}
	}

	public int? SaleItemId
	{
		[CompilerGenerated]
		get
		{
			return _003CSaleItemId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSaleItemId_003Ek__BackingField = value;
		}
	}

	public int? ProductoId
	{
		[CompilerGenerated]
		get
		{
			return _003CProductoId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductoId_003Ek__BackingField = value;
		}
	}

	[ForeignKey("ProductoId")]
	public Product? Producto
	{
		[CompilerGenerated]
		get
		{
			return _003CProducto_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProducto_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,6)")]
	public decimal Cantidad
	{
		[CompilerGenerated]
		get
		{
			return _003CCantidad_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCantidad_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(8)]
	public string ClaveProdServ
	{
		[CompilerGenerated]
		get
		{
			return _003CClaveProdServ_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CClaveProdServ_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(3)]
	public string ClaveUnidad
	{
		[CompilerGenerated]
		get
		{
			return _003CClaveUnidad_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CClaveUnidad_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(20)]
	public string Unidad
	{
		[CompilerGenerated]
		get
		{
			return _003CUnidad_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUnidad_003Ek__BackingField = value;
		}
	}

	[StringLength(50)]
	public string? NoIdentificacion
	{
		[CompilerGenerated]
		get
		{
			return _003CNoIdentificacion_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CNoIdentificacion_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(1000)]
	public string Descripcion
	{
		[CompilerGenerated]
		get
		{
			return _003CDescripcion_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDescripcion_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal ValorUnitario
	{
		[CompilerGenerated]
		get
		{
			return _003CValorUnitario_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CValorUnitario_003Ek__BackingField = value;
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
	public decimal Importe
	{
		[CompilerGenerated]
		get
		{
			return _003CImporte_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CImporte_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(5,2)")]
	public decimal IvaTasa
	{
		[CompilerGenerated]
		get
		{
			return _003CIvaTasa_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIvaTasa_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal IvaBase
	{
		[CompilerGenerated]
		get
		{
			return _003CIvaBase_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIvaBase_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal IvaImporte
	{
		[CompilerGenerated]
		get
		{
			return _003CIvaImporte_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIvaImporte_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(5,2)")]
	public decimal IepsTasa
	{
		[CompilerGenerated]
		get
		{
			return _003CIepsTasa_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIepsTasa_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal IepsBase
	{
		[CompilerGenerated]
		get
		{
			return _003CIepsBase_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIepsBase_003Ek__BackingField = value;
		}
	}

	[Column(TypeName = "decimal(18,2)")]
	public decimal IepsImporte
	{
		[CompilerGenerated]
		get
		{
			return _003CIepsImporte_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIepsImporte_003Ek__BackingField = value;
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

	public FacturaItem()
	{
		_003CCantidad_003Ek__BackingField = 1m;
		_003CClaveProdServ_003Ek__BackingField = "51101700";
		_003CClaveUnidad_003Ek__BackingField = "H87";
		_003CUnidad_003Ek__BackingField = "Pieza";
		_003CDescripcion_003Ek__BackingField = string.Empty;
		_003CIvaTasa_003Ek__BackingField = 16.00m;
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		base._002Ector();
	}
}
