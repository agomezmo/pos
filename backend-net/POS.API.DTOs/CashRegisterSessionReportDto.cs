using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CashRegisterSessionReportDto
{
	public int SessionId
	{
		[CompilerGenerated]
		get
		{
			return _003CSessionId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CSessionId_003Ek__BackingField = value;
		}
	}

	public string CashRegister
	{
		[CompilerGenerated]
		get
		{
			return _003CCashRegister_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCashRegister_003Ek__BackingField = value;
		}
	}

	public string Employee
	{
		[CompilerGenerated]
		get
		{
			return _003CEmployee_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CEmployee_003Ek__BackingField = value;
		}
	}

	public System.DateTime OpenedAt
	{
		[CompilerGenerated]
		get
		{
			return _003COpenedAt_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003COpenedAt_003Ek__BackingField = value;
		}
	}

	public System.DateTime? ClosedAt
	{
		[CompilerGenerated]
		get
		{
			return _003CClosedAt_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CClosedAt_003Ek__BackingField = value;
		}
	}

	public decimal OpeningAmount
	{
		[CompilerGenerated]
		get
		{
			return _003COpeningAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003COpeningAmount_003Ek__BackingField = value;
		}
	}

	public decimal? ClosingAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CClosingAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CClosingAmount_003Ek__BackingField = value;
		}
	}

	public decimal ExpectedAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CExpectedAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CExpectedAmount_003Ek__BackingField = value;
		}
	}

	public decimal? Difference
	{
		[CompilerGenerated]
		get
		{
			return _003CDifference_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDifference_003Ek__BackingField = value;
		}
	}

	public string Status
	{
		[CompilerGenerated]
		get
		{
			return _003CStatus_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CStatus_003Ek__BackingField = value;
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

	public CashRegisterSessionReportDto()
	{
		_003CCashRegister_003Ek__BackingField = string.Empty;
		_003CEmployee_003Ek__BackingField = string.Empty;
		_003CStatus_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
