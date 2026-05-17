using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class ReturnsAnalysisDto
{
	public int TotalReturns
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalReturns_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalReturns_003Ek__BackingField = value;
		}
	}

	public decimal TotalReturnedAmount
	{
		[CompilerGenerated]
		get
		{
			return _003CTotalReturnedAmount_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTotalReturnedAmount_003Ek__BackingField = value;
		}
	}

	public decimal ReturnRate
	{
		[CompilerGenerated]
		get
		{
			return _003CReturnRate_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CReturnRate_003Ek__BackingField = value;
		}
	}

	public List<ReturnReasonDto> TopReasons
	{
		[CompilerGenerated]
		get
		{
			return _003CTopReasons_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTopReasons_003Ek__BackingField = value;
		}
	}

	public List<ReturnProductDto> TopReturnedProducts
	{
		[CompilerGenerated]
		get
		{
			return _003CTopReturnedProducts_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CTopReturnedProducts_003Ek__BackingField = value;
		}
	}

	public ReturnsAnalysisDto()
	{
		_003CTopReasons_003Ek__BackingField = new List<ReturnReasonDto>();
		_003CTopReturnedProducts_003Ek__BackingField = new List<ReturnProductDto>();
		base._002Ector();
	}
}
