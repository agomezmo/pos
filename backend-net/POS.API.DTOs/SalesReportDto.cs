using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class SalesReportDto
{
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

	public decimal TotalSubtotal
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalSubtotal_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalSubtotal_003Ek__BackingField = value;
		}
	}

	public decimal TotalTax
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalTax_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalTax_003Ek__BackingField = value;
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

	public List<PaymentMethodBreakdownDto> PaymentMethodBreakdown
	{
		[CompilerGenerated]
		get
		{
			return _003CPaymentMethodBreakdown_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CPaymentMethodBreakdown_003Ek__BackingField = value;
		}
	}

	public SalesReportDto()
	{
		_003CPaymentMethodBreakdown_003Ek__BackingField = new List<PaymentMethodBreakdownDto>();
		base._002Ector();
	}
}
