using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class WeekdayAnalysisDto
{
	public string DayOfWeek
	{
		[CompilerGenerated]
		get
		{
			return _003CDayOfWeek_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDayOfWeek_003Ek__BackingField = value;
		}
	}

	public int DayNumber
	{
		[CompilerGenerated]
		get
		{
			return _003CDayNumber_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDayNumber_003Ek__BackingField = value;
		}
	}

	public int TransactionCount
	{
		[CompilerGenerated]
		get
		{
			return _003CTransactionCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTransactionCount_003Ek__BackingField = value;
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

	public decimal AverageTicket
	{
		[CompilerGenerated]
		get
		{
			return _003CAverageTicket_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAverageTicket_003Ek__BackingField = value;
		}
	}

	public int AvgTransactionsPerDay
	{
		[CompilerGenerated]
		get
		{
			return _003CAvgTransactionsPerDay_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAvgTransactionsPerDay_003Ek__BackingField = value;
		}
	}

	public WeekdayAnalysisDto()
	{
		_003CDayOfWeek_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
