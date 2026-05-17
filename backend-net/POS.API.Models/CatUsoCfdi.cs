using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("cat_uso_cfdi")]
public class CatUsoCfdi
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
	[StringLength(3)]
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
	[StringLength(255)]
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

	public bool PersonaFisica
	{
		[CompilerGenerated]
		get
		{
			return _003CPersonaFisica_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPersonaFisica_003Ek__BackingField = value;
		}
	}

	public bool PersonaMoral
	{
		[CompilerGenerated]
		get
		{
			return _003CPersonaMoral_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPersonaMoral_003Ek__BackingField = value;
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

	public CatUsoCfdi()
	{
		_003CCodigo_003Ek__BackingField = string.Empty;
		_003CDescripcion_003Ek__BackingField = string.Empty;
		_003CPersonaFisica_003Ek__BackingField = true;
		_003CPersonaMoral_003Ek__BackingField = true;
		_003CIsActive_003Ek__BackingField = true;
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		base._002Ector();
	}
}
