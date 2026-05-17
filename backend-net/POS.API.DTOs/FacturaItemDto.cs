using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class FacturaItemDto
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

	public string? ProductoNombre
	{
		[CompilerGenerated]
		get
		{
			return _003CProductoNombre_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductoNombre_003Ek__BackingField = value;
		}
	}

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

	public FacturaItemDto()
	{
		_003CClaveProdServ_003Ek__BackingField = "51101700";
		_003CClaveUnidad_003Ek__BackingField = "H87";
		_003CUnidad_003Ek__BackingField = "Pieza";
		_003CDescripcion_003Ek__BackingField = string.Empty;
		_003CIvaTasa_003Ek__BackingField = 16.00m;
		base._002Ector();
	}
}
