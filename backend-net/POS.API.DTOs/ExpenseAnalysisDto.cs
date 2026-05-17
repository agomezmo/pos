using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ExpenseAnalysisDto
{
	public decimal TotalExpenses
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalExpenses_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalExpenses_003Ek__BackingField = value;
		}
	}

	public decimal vsPreviousPeriod
	{
		[CompilerGenerated]
		get
		{
			return _003CvsPreviousPeriod_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CvsPreviousPeriod_003Ek__BackingField = value;
		}
	}

	public List<ExpenseCategoryDto> ByCategory
	{
		[CompilerGenerated]
		get
		{
			return _003CByCategory_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CByCategory_003Ek__BackingField = value;
		}
	}

	public List<ExpenseMonthlyDto> MonthlyTrend
	{
		[CompilerGenerated]
		get
		{
			return _003CMonthlyTrend_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMonthlyTrend_003Ek__BackingField = value;
		}
	}

	public ExpenseAnalysisDto()
	{
		_003CByCategory_003Ek__BackingField = new List<ExpenseCategoryDto>();
		_003CMonthlyTrend_003Ek__BackingField = new List<ExpenseMonthlyDto>();
		base._002Ector();
	}
}
