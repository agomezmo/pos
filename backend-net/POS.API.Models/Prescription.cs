using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("Prescriptions")]
public class Prescription
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

	public int PatientId
	{
		[CompilerGenerated]
		get
		{
			return _003CPatientId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPatientId_003Ek__BackingField = value;
		}
	}

	[ForeignKey("PatientId")]
	public Patient Patient
	{
		[CompilerGenerated]
		get
		{
			return _003CPatient_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPatient_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(100)]
	public string DoctorName
	{
		[CompilerGenerated]
		get
		{
			return _003CDoctorName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDoctorName_003Ek__BackingField = value;
		}
	}

	[StringLength(30)]
	public string? DoctorLicense
	{
		[CompilerGenerated]
		get
		{
			return _003CDoctorLicense_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDoctorLicense_003Ek__BackingField = value;
		}
	}

	public string? Diagnosis
	{
		[CompilerGenerated]
		get
		{
			return _003CDiagnosis_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDiagnosis_003Ek__BackingField = value;
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

	public System.DateTime IssuedDate
	{
		[CompilerGenerated]
		get
		{
			return _003CIssuedDate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIssuedDate_003Ek__BackingField = value;
		}
	}

	public System.DateTime? ExpiryDate
	{
		[CompilerGenerated]
		get
		{
			return _003CExpiryDate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CExpiryDate_003Ek__BackingField = value;
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

	public System.Collections.Generic.ICollection<PrescriptionItem> PrescriptionItems
	{
		[CompilerGenerated]
		get
		{
			return _003CPrescriptionItems_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPrescriptionItems_003Ek__BackingField = value;
		}
	}

	public Prescription()
	{
		_003CDoctorName_003Ek__BackingField = string.Empty;
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		_003CPrescriptionItems_003Ek__BackingField = (System.Collections.Generic.ICollection<PrescriptionItem>)new List<PrescriptionItem>();
		base._002Ector();
	}
}
