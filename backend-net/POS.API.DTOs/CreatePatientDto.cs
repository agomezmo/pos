using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreatePatientDto
{
	public int CustomerId
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerId_003Ek__BackingField = value;
		}
	}

	public string? MedicalHistory
	{
		[CompilerGenerated]
		get
		{
			return _003CMedicalHistory_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMedicalHistory_003Ek__BackingField = value;
		}
	}

	public string? Allergies
	{
		[CompilerGenerated]
		get
		{
			return _003CAllergies_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAllergies_003Ek__BackingField = value;
		}
	}

	public string? BloodType
	{
		[CompilerGenerated]
		get
		{
			return _003CBloodType_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CBloodType_003Ek__BackingField = value;
		}
	}
}
