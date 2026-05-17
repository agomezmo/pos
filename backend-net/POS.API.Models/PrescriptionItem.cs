using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("PrescriptionItems")]
public class PrescriptionItem
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

	[ForeignKey("PrescriptionId")]
	public Prescription Prescription
	{
		[CompilerGenerated]
		get
		{
			return _003CPrescription_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPrescription_003Ek__BackingField = value;
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

	[ForeignKey("ProductId")]
	public Product Product
	{
		[CompilerGenerated]
		get
		{
			return _003CProduct_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProduct_003Ek__BackingField = value;
		}
	}

	[StringLength(200)]
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

	[StringLength(100)]
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

	[StringLength(50)]
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
}
