using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class EmployeeSalesDto
{
	public int UserId
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

	public string EmployeeName
	{
		[CompilerGenerated]
		get
		{
			return _003CEmployeeName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmployeeName_003Ek__BackingField = value;
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

	public decimal TotalSales
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSales_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSales_003Ek__BackingField = value;
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

	public int ReturnsCount
	{
		[CompilerGenerated]
		get
		{
			return _003CReturnsCount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReturnsCount_003Ek__BackingField = value;
		}
	}

	public EmployeeSalesDto()
	{
		_003CEmployeeName_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
