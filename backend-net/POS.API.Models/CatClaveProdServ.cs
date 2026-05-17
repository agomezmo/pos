using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("cat_clave_prod_serv")]
public class CatClaveProdServ
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
	[StringLength(8)]
	public string Codigo
	{
		[CompilerGenerated]
		get
		{
			return _003CCodigo_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCodigo_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(500)]
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

	public bool IsActive
	{
		[CompilerGenerated]
		get
		{
			return _003CIsActive_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIsActive_003Ek__BackingField = value;
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

	public CatClaveProdServ()
	{
		_003CCodigo_003Ek__BackingField = string.Empty;
		_003CDescripcion_003Ek__BackingField = string.Empty;
		_003CIvaTasa_003Ek__BackingField = 16.00m;
		_003CIsActive_003Ek__BackingField = true;
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		base._002Ector();
	}
}
