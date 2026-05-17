using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CatRegimenFiscalDto
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

	public CatRegimenFiscalDto()
	{
		_003CCodigo_003Ek__BackingField = string.Empty;
		_003CDescripcion_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
