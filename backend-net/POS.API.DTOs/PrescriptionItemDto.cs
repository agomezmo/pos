using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class PrescriptionItemDto
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

	public int PrescriptionId
	{
		[CompilerGenerated]
		get
		{
			return _003CPrescriptionId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPrescriptionId_003Ek__BackingField = value;
		}
	}

	public int ProductId
	{
		[CompilerGenerated]
		get
		{
			return _003CProductId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductId_003Ek__BackingField = value;
		}
	}

	public string ProductName
	{
		[CompilerGenerated]
		get
		{
			return _003CProductName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductName_003Ek__BackingField = value;
		}
	}

	public string? Dosage
	{
		[CompilerGenerated]
		get
		{
			return _003CDosage_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDosage_003Ek__BackingField = value;
		}
	}

	public string? Frequency
	{
		[CompilerGenerated]
		get
		{
			return _003CFrequency_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CFrequency_003Ek__BackingField = value;
		}
	}

	public string? Duration
	{
		[CompilerGenerated]
		get
		{
			return _003CDuration_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDuration_003Ek__BackingField = value;
		}
	}

	public string? Notes
	{
		[CompilerGenerated]
		get
		{
			return _003CNotes_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CNotes_003Ek__BackingField = value;
		}
	}

	public PrescriptionItemDto()
	{
		_003CProductName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
