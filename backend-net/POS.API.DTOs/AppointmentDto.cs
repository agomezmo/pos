using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class AppointmentDto
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

	public string PatientName
	{
		[CompilerGenerated]
		get
		{
			return _003CPatientName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPatientName_003Ek__BackingField = value;
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

	public string? UserName
	{
		[CompilerGenerated]
		get
		{
			return _003CUserName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CUserName_003Ek__BackingField = value;
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

	public AppointmentDto()
	{
		_003CPatientName_003Ek__BackingField = string.Empty;
		_003CStatus_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
