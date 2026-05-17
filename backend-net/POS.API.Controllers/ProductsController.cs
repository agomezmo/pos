using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Data;
using POS.API.Services;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class ProductsController : ControllerBase
{
	private readonly ProductService _productService;

	private readonly AppDbContext _context;

	public ProductsController(ProductService productService, AppDbContext context)
	{
		_productService = productService;
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__3))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll([FromQuery] bool includeInactive = false, [FromQuery] string? search = null)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__3 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__3);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.includeInactive = includeInactive;
		_003CGetAll_003Ed__.search = search;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__3>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__4))]
	[HttpGet("{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__4 _003CGetById_003Ed__ = default(_003CGetById_003Ed__4);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__4>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__5))]
	[HttpPost]
	public System.Threading.Tasks.Task<IActionResult> Create([FromBody] CreateProductDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__5 _003CCreate_003Ed__ = default(_003CCreate_003Ed__5);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__5>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CUpdate_003Ed__6))]
	[HttpPut("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Update(int id, [FromBody] UpdateProductDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CUpdate_003Ed__6 _003CUpdate_003Ed__ = default(_003CUpdate_003Ed__6);
		_003CUpdate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CUpdate_003Ed__._003C_003E4__this = this;
		_003CUpdate_003Ed__.id = id;
		_003CUpdate_003Ed__.dto = dto;
		_003CUpdate_003Ed__._003C_003E1__state = -1;
		_003CUpdate_003Ed__._003C_003Et__builder.Start<_003CUpdate_003Ed__6>(ref _003CUpdate_003Ed__);
		return _003CUpdate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CDelete_003Ed__7))]
	[HttpDelete("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Delete(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CDelete_003Ed__7 _003CDelete_003Ed__ = default(_003CDelete_003Ed__7);
		_003CDelete_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CDelete_003Ed__._003C_003E4__this = this;
		_003CDelete_003Ed__.id = id;
		_003CDelete_003Ed__._003C_003E1__state = -1;
		_003CDelete_003Ed__._003C_003Et__builder.Start<_003CDelete_003Ed__7>(ref _003CDelete_003Ed__);
		return _003CDelete_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CToggleActive_003Ed__8))]
	[HttpPatch("{id}/toggle-active")]
	public System.Threading.Tasks.Task<IActionResult> ToggleActive(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CToggleActive_003Ed__8 _003CToggleActive_003Ed__ = default(_003CToggleActive_003Ed__8);
		_003CToggleActive_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CToggleActive_003Ed__._003C_003E4__this = this;
		_003CToggleActive_003Ed__.id = id;
		_003CToggleActive_003Ed__._003C_003E1__state = -1;
		_003CToggleActive_003Ed__._003C_003Et__builder.Start<_003CToggleActive_003Ed__8>(ref _003CToggleActive_003Ed__);
		return _003CToggleActive_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetLowStock_003Ed__9))]
	[HttpGet("low-stock")]
	public System.Threading.Tasks.Task<IActionResult> GetLowStock([FromQuery] int threshold = 5)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetLowStock_003Ed__9 _003CGetLowStock_003Ed__ = default(_003CGetLowStock_003Ed__9);
		_003CGetLowStock_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetLowStock_003Ed__._003C_003E4__this = this;
		_003CGetLowStock_003Ed__.threshold = threshold;
		_003CGetLowStock_003Ed__._003C_003E1__state = -1;
		_003CGetLowStock_003Ed__._003C_003Et__builder.Start<_003CGetLowStock_003Ed__9>(ref _003CGetLowStock_003Ed__);
		return _003CGetLowStock_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByCategory_003Ed__10))]
	[HttpGet("category/{categoryId}")]
	public System.Threading.Tasks.Task<IActionResult> GetByCategory(int categoryId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByCategory_003Ed__10 _003CGetByCategory_003Ed__ = default(_003CGetByCategory_003Ed__10);
		_003CGetByCategory_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetByCategory_003Ed__._003C_003E4__this = this;
		_003CGetByCategory_003Ed__.categoryId = categoryId;
		_003CGetByCategory_003Ed__._003C_003E1__state = -1;
		_003CGetByCategory_003Ed__._003C_003Et__builder.Start<_003CGetByCategory_003Ed__10>(ref _003CGetByCategory_003Ed__);
		return _003CGetByCategory_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetExpiringSoon_003Ed__11))]
	[HttpGet("expiring-soon")]
	public System.Threading.Tasks.Task<IActionResult> GetExpiringSoon([FromQuery] int days = 60)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetExpiringSoon_003Ed__11 _003CGetExpiringSoon_003Ed__ = default(_003CGetExpiringSoon_003Ed__11);
		_003CGetExpiringSoon_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetExpiringSoon_003Ed__._003C_003E4__this = this;
		_003CGetExpiringSoon_003Ed__.days = days;
		_003CGetExpiringSoon_003Ed__._003C_003E1__state = -1;
		_003CGetExpiringSoon_003Ed__._003C_003Et__builder.Start<_003CGetExpiringSoon_003Ed__11>(ref _003CGetExpiringSoon_003Ed__);
		return _003CGetExpiringSoon_003Ed__._003C_003Et__builder.get_Task();
	}
}
