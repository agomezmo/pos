using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.CompilerServices;

namespace POS.API.Models;

[Table("Appointments")]
public class Appointment
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

	public int? UserId
	{
		[CompilerGenerated]
		get
		{
			return _003CUserId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUserId_003Ek__BackingField = value;
		}
	}

	[ForeignKey("UserId")]
	public User? User
	{
		[CompilerGenerated]
		get
		{
			return _003CUser_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUser_003Ek__BackingField = value;
		}
	}

	public System.DateTime AppointmentDate
	{
		[CompilerGenerated]
		get
		{
			return _003CAppointmentDate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAppointmentDate_003Ek__BackingField = value;
		}
	}

	[Required]
	[StringLength(20)]
	public string Status
	{
		[CompilerGenerated]
		get
		{
			return _003CStatus_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CStatus_003Ek__BackingField = value;
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

	public Appointment()
	{
		_003CStatus_003Ek__BackingField = "Scheduled";
		_003CCreatedAt_003Ek__BackingField = System.DateTime.get_UtcNow();
		base._002Ector();
	}
}
