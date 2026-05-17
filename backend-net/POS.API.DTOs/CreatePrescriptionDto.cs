using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreatePrescriptionDto
{
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

	public CreatePrescriptionDto()
	{
		_003CDoctorName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
