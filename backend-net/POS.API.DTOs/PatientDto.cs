using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class PatientDto
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

	public string CustomerName
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerName_003Ek__BackingField = value;
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

	public PatientDto()
	{
		_003CCustomerName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
