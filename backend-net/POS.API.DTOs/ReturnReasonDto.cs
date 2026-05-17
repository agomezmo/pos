using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ReturnReasonDto
{
	public string Reason
	{
		[CompilerGenerated]
		get
		{
			return _003CReason_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReason_003Ek__BackingField = value;
		}
	}

	public int Count
	{
		[CompilerGenerated]
		get
		{
			return _003CCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCount_003Ek__BackingField = value;
		}
	}

	public decimal TotalAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalAmount_003Ek__BackingField = value;
		}
	}

	public ReturnReasonDto()
	{
		_003CReason_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
