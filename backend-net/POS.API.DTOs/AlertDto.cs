using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class AlertDto
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

	public string Type
	{
		[CompilerGenerated]
		get
		{
			return _003CType_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CType_003Ek__BackingField = value;
		}
	}

	public string Title
	{
		[CompilerGenerated]
		get
		{
			return _003CTitle_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTitle_003Ek__BackingField = value;
		}
	}

	public string? Message
	{
		[CompilerGenerated]
		get
		{
			return _003CMessage_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMessage_003Ek__BackingField = value;
		}
	}

	public string? ReferenceType
	{
		[CompilerGenerated]
		get
		{
			return _003CReferenceType_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReferenceType_003Ek__BackingField = value;
		}
	}

	public int? ReferenceId
	{
		[CompilerGenerated]
		get
		{
			return _003CReferenceId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReferenceId_003Ek__BackingField = value;
		}
	}

	public bool IsRead
	{
		[CompilerGenerated]
		get
		{
			return _003CIsRead_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIsRead_003Ek__BackingField = value;
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

	public AlertDto()
	{
		_003CType_003Ek__BackingField = string.Empty;
		_003CTitle_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
