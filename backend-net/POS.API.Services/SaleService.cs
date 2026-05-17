using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Services;

public class SaleService
{
	private readonly AppDbContext _context;

	public SaleService(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetAll_003Ed__2))]
	public System.Threading.Tasks.Task<ValueTuple<List<SaleListDto>, int>> GetAll(System.DateTime? dateFrom, System.DateTime? dateTo, int page = 1, int pageSize = 20)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetAll_003Ed__2 _003CGetAll_003Ed__ = default(_003CGetAll_003Ed__2);
		_003CGetAll_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ValueTuple<List<SaleListDto>, int>>.Create();
		_003CGetAll_003Ed__._003C_003E4__this = this;
		_003CGetAll_003Ed__.dateFrom = dateFrom;
		_003CGetAll_003Ed__.dateTo = dateTo;
		_003CGetAll_003Ed__.page = page;
		_003CGetAll_003Ed__.pageSize = pageSize;
		_003CGetAll_003Ed__._003C_003E1__state = -1;
		_003CGetAll_003Ed__._003C_003Et__builder.Start<_003CGetAll_003Ed__2>(ref _003CGetAll_003Ed__);
		return _003CGetAll_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetById_003Ed__3))]
	public System.Threading.Tasks.Task<SaleDto?> GetById(int id)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetById_003Ed__3 _003CGetById_003Ed__ = default(_003CGetById_003Ed__3);
		_003CGetById_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<SaleDto>.Create();
		_003CGetById_003Ed__._003C_003E4__this = this;
		_003CGetById_003Ed__.id = id;
		_003CGetById_003Ed__._003C_003E1__state = -1;
		_003CGetById_003Ed__._003C_003Et__builder.Start<_003CGetById_003Ed__3>(ref _003CGetById_003Ed__);
		return _003CGetById_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByReceiptNumber_003Ed__4))]
	public System.Threading.Tasks.Task<SaleDto?> GetByReceiptNumber(string receiptNumber)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByReceiptNumber_003Ed__4 _003CGetByReceiptNumber_003Ed__ = default(_003CGetByReceiptNumber_003Ed__4);
		_003CGetByReceiptNumber_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<SaleDto>.Create();
		_003CGetByReceiptNumber_003Ed__._003C_003E4__this = this;
		_003CGetByReceiptNumber_003Ed__.receiptNumber = receiptNumber;
		_003CGetByReceiptNumber_003Ed__._003C_003E1__state = -1;
		_003CGetByReceiptNumber_003Ed__._003C_003Et__builder.Start<_003CGetByReceiptNumber_003Ed__4>(ref _003CGetByReceiptNumber_003Ed__);
		return _003CGetByReceiptNumber_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCreate_003Ed__5))]
	public System.Threading.Tasks.Task<SaleDto?> Create(CreateSaleDto dto, int userId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCreate_003Ed__5 _003CCreate_003Ed__ = default(_003CCreate_003Ed__5);
		_003CCreate_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<SaleDto>.Create();
		_003CCreate_003Ed__._003C_003E4__this = this;
		_003CCreate_003Ed__.dto = dto;
		_003CCreate_003Ed__.userId = userId;
		_003CCreate_003Ed__._003C_003E1__state = -1;
		_003CCreate_003Ed__._003C_003Et__builder.Start<_003CCreate_003Ed__5>(ref _003CCreate_003Ed__);
		return _003CCreate_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByDateRange_003Ed__6))]
	public System.Threading.Tasks.Task<List<SaleListDto>> GetByDateRange(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByDateRange_003Ed__6 _003CGetByDateRange_003Ed__ = default(_003CGetByDateRange_003Ed__6);
		_003CGetByDateRange_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<SaleListDto>>.Create();
		_003CGetByDateRange_003Ed__._003C_003E4__this = this;
		_003CGetByDateRange_003Ed__.from = from;
		_003CGetByDateRange_003Ed__.to = to;
		_003CGetByDateRange_003Ed__._003C_003E1__state = -1;
		_003CGetByDateRange_003Ed__._003C_003Et__builder.Start<_003CGetByDateRange_003Ed__6>(ref _003CGetByDateRange_003Ed__);
		return _003CGetByDateRange_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetByCustomer_003Ed__7))]
	public System.Threading.Tasks.Task<List<SaleListDto>> GetByCustomer(int customerId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetByCustomer_003Ed__7 _003CGetByCustomer_003Ed__ = default(_003CGetByCustomer_003Ed__7);
		_003CGetByCustomer_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<SaleListDto>>.Create();
		_003CGetByCustomer_003Ed__._003C_003E4__this = this;
		_003CGetByCustomer_003Ed__.customerId = customerId;
		_003CGetByCustomer_003Ed__._003C_003E1__state = -1;
		_003CGetByCustomer_003Ed__._003C_003Et__builder.Start<_003CGetByCustomer_003Ed__7>(ref _003CGetByCustomer_003Ed__);
		return _003CGetByCustomer_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CCancel_003Ed__8))]
	public System.Threading.Tasks.Task<bool> Cancel(int saleId)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CCancel_003Ed__8 _003CCancel_003Ed__ = default(_003CCancel_003Ed__8);
		_003CCancel_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<bool>.Create();
		_003CCancel_003Ed__._003C_003E4__this = this;
		_003CCancel_003Ed__.saleId = saleId;
		_003CCancel_003Ed__._003C_003E1__state = -1;
		_003CCancel_003Ed__._003C_003Et__builder.Start<_003CCancel_003Ed__8>(ref _003CCancel_003Ed__);
		return _003CCancel_003Ed__._003C_003Et__builder.get_Task();
	}
}
