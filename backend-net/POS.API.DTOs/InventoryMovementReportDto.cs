using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class InventoryMovementReportDto
{
	public int TotalEntries
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalEntries_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalEntries_003Ek__BackingField = value;
		}
	}

	public int TotalExits
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalExits_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalExits_003Ek__BackingField = value;
		}
	}

	public int TotalAdjustments
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalAdjustments_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalAdjustments_003Ek__BackingField = value;
		}
	}

	public List<InventoryMovementDetailDto> Movements
	{
		[CompilerGenerated]
		get
		{
			return _003CMovements_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMovements_003Ek__BackingField = value;
		}
	}

	public InventoryMovementReportDto()
	{
		_003CMovements_003Ek__BackingField = new List<InventoryMovementDetailDto>();
		base._002Ector();
	}
}
