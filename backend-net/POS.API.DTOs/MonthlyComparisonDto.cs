using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class MonthlyComparisonDto
{
	public int Month
	{
		[CompilerGenerated]
		get
		{
			return _003CMonth_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMonth_003Ek__BackingField = value;
		}
	}

	public string MonthName
	{
		[CompilerGenerated]
		get
		{
			return _003CMonthName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMonthName_003Ek__BackingField = value;
		}
	}

	public decimal Sales
	{
		[CompilerGenerated]
		get
		{
			return _003CSales_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSales_003Ek__BackingField = value;
		}
	}

	public decimal Expenses
	{
		[CompilerGenerated]
		get
		{
			return _003CExpenses_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CExpenses_003Ek__BackingField = value;
		}
	}

	public decimal Income
	{
		[CompilerGenerated]
		get
		{
			return _003CIncome_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CIncome_003Ek__BackingField = value;
		}
	}

	public MonthlyComparisonDto()
	{
		_003CMonthName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
