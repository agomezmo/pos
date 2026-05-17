using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class CustomersController : ControllerBase
{
	private readonly AppDbContext _context;

	public CustomersController(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	[HttpGet]
	public System.Threading.Tasks.Task<IActionResult> GetAll()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__2>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__3))]
	[HttpGet("{id}")]
	public System.Threading.Tasks.Task<IActionResult> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__3 _003CGetById_003Ed__ = default(_003CGetById_003Ed__3);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__3>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__4))]
	[HttpPost]
	public System.Threading.Tasks.Task<IActionResult> Create([FromBody] CreateCustomerDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__4 _003CCreate_003Ed__ = default(_003CCreate_003Ed__4);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__4>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CUpdate_003Ed__5))]
	[HttpPut("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Update(int id, [FromBody] UpdateCustomerDto dto)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CUpdate_003Ed__5 _003CUpdate_003Ed__ = default(_003CUpdate_003Ed__5);
		_003CUpdate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CUpdate_003Ed__._003C_003E4__this = this;
		_003CUpdate_003Ed__.id = id;
		_003CUpdate_003Ed__.dto = dto;
		_003CUpdate_003Ed__._003C_003E1__state = -1;
		_003CUpdate_003Ed__._003C_003Et__builder.Start<_003CUpdate_003Ed__5>(ref _003CUpdate_003Ed__);
		return _003CUpdate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CDelete_003Ed__6))]
	[HttpDelete("{id}")]
	public System.Threading.Tasks.Task<IActionResult> Delete(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CDelete_003Ed__6 _003CDelete_003Ed__ = default(_003CDelete_003Ed__6);
		_003CDelete_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CDelete_003Ed__._003C_003E4__this = this;
		_003CDelete_003Ed__.id = id;
		_003CDelete_003Ed__._003C_003E1__state = -1;
		_003CDelete_003Ed__._003C_003Et__builder.Start<_003CDelete_003Ed__6>(ref _003CDelete_003Ed__);
		return _003CDelete_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CSearch_003Ed__7))]
	[HttpGet("search/{term}")]
	public System.Threading.Tasks.Task<IActionResult> Search(string term)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CSearch_003Ed__7 _003CSearch_003Ed__ = default(_003CSearch_003Ed__7);
		_003CSearch_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CSearch_003Ed__._003C_003E4__this = this;
		_003CSearch_003Ed__.term = term;
		_003CSearch_003Ed__._003C_003E1__state = -1;
		_003CSearch_003Ed__._003C_003Et__builder.Start<_003CSearch_003Ed__7>(ref _003CSearch_003Ed__);
		return _003CSearch_003Ed__._003C_003Et__builder.get_Task();
	}
}
