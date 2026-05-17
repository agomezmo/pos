using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CatClaveProdServDto
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

	public CatClaveProdServDto()
	{
		_003CCodigo_003Ek__BackingField = string.Empty;
		_003CDescripcion_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
