using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ExpenseMonthlyDto
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

	public decimal Amount
	{
		[CompilerGenerated]
		get
		{
			return _003CAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CAmount_003Ek__BackingField = value;
		}
	}

	public ExpenseMonthlyDto()
	{
		_003CMonthName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
