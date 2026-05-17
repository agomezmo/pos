using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("Patients")]
public class Patient
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

	[ForeignKey("CustomerId")]
	public Customer Customer
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomer_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomer_003Ek__BackingField = value;
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

	[StringLength(5)]
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

	public System.Collections.Generic.ICollection<Prescription> Prescriptions
	{
		[CompilerGenerated]
		get
		{
			return _003CPrescriptions_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPrescriptions_003Ek__BackingField = value;
		}
	}

	public System.Collections.Generic.ICollection<Appointment> Appointments
	{
		[CompilerGenerated]
		get
		{
			return _003CAppointments_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAppointments_003Ek__BackingField = value;
		}
	}

	public Patient()
	{
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		_003CPrescriptions_003Ek__BackingField = (System.Collections.Generic.ICollection<Prescription>)new List<Prescription>();
		_003CAppointments_003Ek__BackingField = (System.Collections.Generic.ICollection<Appointment>)new List<Appointment>();
		base._002Ector();
	}
}
