using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class CloseSessionDto
{
	[Range(0.0, 999999999.99)]
	public decimal ClosingAmount
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

	[StringLength(500)]
	public string? Notes
	{
		[CompilerGenerated]
		get
		{
			return _003CNotes_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CNotes_003Ek__BackingField = value;
		}
	}
}
