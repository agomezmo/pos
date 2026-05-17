using System;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CustomerReportDto
{
	public int CustomerId
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerId_003Ek__BackingField = value;
		}
	}

	public string CustomerName
	{
		[CompilerGenerated]
		get
		{
			return _003CCustomerName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCustomerName_003Ek__BackingField = value;
		}
	}

	public string DocumentNumber
	{
		[CompilerGenerated]
		get
		{
			return _003CDocumentNumber_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CDocumentNumber_003Ek__BackingField = value;
		}
	}

	public int TotalSales
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

	public System.DateTime? LastPurchase
	{
		[CompilerGenerated]
		get
		{
			return _003CLastPurchase_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CLastPurchase_003Ek__BackingField = value;
		}
	}

	public CustomerReportDto()
	{
		_003CCustomerName_003Ek__BackingField = string.Empty;
		_003CDocumentNumber_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
