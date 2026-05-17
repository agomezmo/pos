using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Services;

public class ProductService
{
	private readonly AppDbContext _context;

	public ProductService(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	public System.Threading.Tasks.Task<List<ProductListDto>> GetAll(bool includeInactive = false)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<ProductListDto>>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.includeInactive = includeInactive;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__2>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__3))]
	public System.Threading.Tasks.Task<ProductDto?> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__3 _003CGetById_003Ed__ = default(_003CGetById_003Ed__3);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ProductDto>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__3>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByCategory_003Ed__4))]
	public System.Threading.Tasks.Task<List<ProductListDto>> GetByCategory(int categoryId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByCategory_003Ed__4 _003CGetByCategory_003Ed__ = default(_003CGetByCategory_003Ed__4);
		_003CGetByCategory_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<ProductListDto>>.Create();
		_003CGetByCategory_003Ed__._003C_003E4__this = this;
		_003CGetByCategory_003Ed__.categoryId = categoryId;
		_003CGetByCategory_003Ed__._003C_003E1__state = -1;
		_003CGetByCategory_003Ed__._003C_003Et__builder.Start<_003CGetByCategory_003Ed__4>(ref _003CGetByCategory_003Ed__);
		return _003CGetByCategory_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetLowStock_003Ed__5))]
	public System.Threading.Tasks.Task<List<ProductListDto>> GetLowStock(int threshold)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetLowStock_003Ed__5 _003CGetLowStock_003Ed__ = default(_003CGetLowStock_003Ed__5);
		_003CGetLowStock_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<ProductListDto>>.Create();
		_003CGetLowStock_003Ed__._003C_003E4__this = this;
		_003CGetLowStock_003Ed__.threshold = threshold;
		_003CGetLowStock_003Ed__._003C_003E1__state = -1;
		_003CGetLowStock_003Ed__._003C_003Et__builder.Start<_003CGetLowStock_003Ed__5>(ref _003CGetLowStock_003Ed__);
		return _003CGetLowStock_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__6))]
	public System.Threading.Tasks.Task<ProductDto> Create(CreateProductDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__6 _003CCreate_003Ed__ = default(_003CCreate_003Ed__6);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ProductDto>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__6>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CUpdate_003Ed__7))]
	public System.Threading.Tasks.Task<ProductDto?> Update(int id, UpdateProductDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CUpdate_003Ed__7 _003CUpdate_003Ed__ = default(_003CUpdate_003Ed__7);
		_003CUpdate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ProductDto>.Create();
		_003CUpdate_003Ed__._003C_003E4__this = this;
		_003CUpdate_003Ed__.id = id;
		_003CUpdate_003Ed__.dto = dto;
		_003CUpdate_003Ed__._003C_003E1__state = -1;
		_003CUpdate_003Ed__._003C_003Et__builder.Start<_003CUpdate_003Ed__7>(ref _003CUpdate_003Ed__);
		return _003CUpdate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CDelete_003Ed__8))]
	public System.Threading.Tasks.Task<bool> Delete(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CDelete_003Ed__8 _003CDelete_003Ed__ = default(_003CDelete_003Ed__8);
		_003CDelete_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CDelete_003Ed__._003C_003E4__this = this;
		_003CDelete_003Ed__.id = id;
		_003CDelete_003Ed__._003C_003E1__state = -1;
		_003CDelete_003Ed__._003C_003Et__builder.Start<_003CDelete_003Ed__8>(ref _003CDelete_003Ed__);
		return _003CDelete_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CToggleActive_003Ed__9))]
	public System.Threading.Tasks.Task<bool> ToggleActive(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CToggleActive_003Ed__9 _003CToggleActive_003Ed__ = default(_003CToggleActive_003Ed__9);
		_003CToggleActive_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CToggleActive_003Ed__._003C_003E4__this = this;
		_003CToggleActive_003Ed__.id = id;
		_003CToggleActive_003Ed__._003C_003E1__state = -1;
		_003CToggleActive_003Ed__._003C_003Et__builder.Start<_003CToggleActive_003Ed__9>(ref _003CToggleActive_003Ed__);
		return _003CToggleActive_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CSearch_003Ed__10))]
	public System.Threading.Tasks.Task<List<ProductListDto>> Search(string term)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CSearch_003Ed__10 _003CSearch_003Ed__ = default(_003CSearch_003Ed__10);
		_003CSearch_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<ProductListDto>>.Create();
		_003CSearch_003Ed__._003C_003E4__this = this;
		_003CSearch_003Ed__.term = term;
		_003CSearch_003Ed__._003C_003E1__state = -1;
		_003CSearch_003Ed__._003C_003Et__builder.Start<_003CSearch_003Ed__10>(ref _003CSearch_003Ed__);
		return _003CSearch_003Ed__._003C_003Et__builder.get_Task();
	}
}
