using System.Runtime.CompilerServices;

namespace POS.API.DTOs;

public class LowStockProductDto
{
	public int ProductId
	{
		[CompilerGenerated]
		get
		{
			return _003CProductId_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CProductId_003Ek__BackingField = value;
		}
	}

	public string Code
	{
		[CompilerGenerated]
		get
		{
			return _003CCode_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCode_003Ek__BackingField = value;
		}
	}

	public string Name
	{
		[CompilerGenerated]
		get
		{
			return _003CName_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CName_003Ek__BackingField = value;
		}
	}

	public int Stock
	{
		[CompilerGenerated]
		get
		{
			return _003CStock_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CStock_003Ek__BackingField = value;
		}
	}

	public int MinStock
	{
		[CompilerGenerated]
		get
		{
			return _003CMinStock_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CMinStock_003Ek__BackingField = value;
		}
	}

	public string Category
	{
		[CompilerGenerated]
		get
		{
			return _003CCategory_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			_003CCategory_003Ek__BackingField = value;
		}
	}

	public LowStockProductDto()
	{
		_003CCode_003Ek__BackingField = string.Empty;
		_003CName_003Ek__BackingField = string.Empty;
		_003CCategory_003Ek__BackingField = string.Empty;
		base._002Ector();
	}
}
