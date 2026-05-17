using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateAppointmentDto
{
	[Required(ErrorMessage = "Patient is required")]
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

	[Required(ErrorMessage = "Appointment date is required")]
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

	[StringLength(500)]
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
