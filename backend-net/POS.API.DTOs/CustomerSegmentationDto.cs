using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CustomerSegmentationDto
{
	public string Segment
	{
		[CompilerGenerated]
		get
		{
			return _003CSegment_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSegment_003Ek__BackingField = value;
		}
	}

	public int CustomerCount
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerCount_003Ek__BackingField = value;
		}
	}

	public decimal TotalSpent
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSpent_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSpent_003Ek__BackingField = value;
		}
	}

	public decimal AveragePerCustomer
	{
		[CompilerGenerated]
		get
		{
			return _003CAveragePerCustomer_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAveragePerCustomer_003Ek__BackingField = value;
		}
	}

	public int AverageTransactions
	{
		[CompilerGenerated]
		get
		{
			return _003CAverageTransactions_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAverageTransactions_003Ek__BackingField = value;
		}
	}

	public CustomerSegmentationDto()
	{
		_003CSegment_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
