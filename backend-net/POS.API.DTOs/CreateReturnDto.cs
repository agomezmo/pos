using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CreateReturnDto
{
	public int SaleId
	{
		[CompilerGenerated]
		get
		{
			return _003CSaleId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSaleId_003Ek__BackingField = value;
		}
	}

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

	public List<CreateReturnItemDto> Items
	{
		[CompilerGenerated]
		get
		{
			return _003CItems_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CItems_003Ek__BackingField = value;
		}
	}

	public CreateReturnDto()
	{
		_003CReason_003Ek__BackingField = string.Empty;
		_003CItems_003Ek__BackingField = new List<CreateReturnItemDto>();
		base._002Ector();
	}
}
