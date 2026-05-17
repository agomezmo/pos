using System.Runtime.CompilerServices;

namespace POS.API.Controllers;

public class UpdateStatusDto
{
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

	public UpdateStatusDto()
	{
		_003CStatus_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
