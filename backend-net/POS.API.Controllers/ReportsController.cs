using System;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.API.Data;
using POS.API.Services;

namespace POS.API.Controllers;

[Authorize]
[Route("api/[controller]")]
[ApiController]
public class ReportsController : ControllerBase
{
	private readonly ReportService _reportService;

	private readonly AppDbContext _context;

	public ReportsController(ReportService reportService, AppDbContext context)
	{
		_reportService = reportService;
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetSalesReport_003Ed__3))]
	[HttpGet("sales")]
	public System.Threading.Tasks.Task<IActionResult> GetSalesReport([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSalesReport_003Ed__3 _003CGetSalesReport_003Ed__ = default(_003CGetSalesReport_003Ed__3);
		_003CGetSalesReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetSalesReport_003Ed__._003C_003E4__this = this;
		_003CGetSalesReport_003Ed__.from = from;
		_003CGetSalesReport_003Ed__.to = to;
		_003CGetSalesReport_003Ed__._003C_003E1__state = -1;
		_003CGetSalesReport_003Ed__._003C_003Et__builder.Start<_003CGetSalesReport_003Ed__3>(ref _003CGetSalesReport_003Ed__);
		return _003CGetSalesReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetTopProducts_003Ed__4))]
	[HttpGet("top-products")]
	public System.Threading.Tasks.Task<IActionResult> GetTopProducts([FromQuery] System.DateTime from, [FromQuery] System.DateTime to, [FromQuery] int topN = 10)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetTopProducts_003Ed__4 _003CGetTopProducts_003Ed__ = default(_003CGetTopProducts_003Ed__4);
		_003CGetTopProducts_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetTopProducts_003Ed__._003C_003E4__this = this;
		_003CGetTopProducts_003Ed__.from = from;
		_003CGetTopProducts_003Ed__.to = to;
		_003CGetTopProducts_003Ed__.topN = topN;
		_003CGetTopProducts_003Ed__._003C_003E1__state = -1;
		_003CGetTopProducts_003Ed__._003C_003Et__builder.Start<_003CGetTopProducts_003Ed__4>(ref _003CGetTopProducts_003Ed__);
		return _003CGetTopProducts_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetDailySummary_003Ed__5))]
	[HttpGet("daily-summary")]
	public System.Threading.Tasks.Task<IActionResult> GetDailySummary([FromQuery] System.DateTime date)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetDailySummary_003Ed__5 _003CGetDailySummary_003Ed__ = default(_003CGetDailySummary_003Ed__5);
		_003CGetDailySummary_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetDailySummary_003Ed__._003C_003E4__this = this;
		_003CGetDailySummary_003Ed__.date = date;
		_003CGetDailySummary_003Ed__._003C_003E1__state = -1;
		_003CGetDailySummary_003Ed__._003C_003Et__builder.Start<_003CGetDailySummary_003Ed__5>(ref _003CGetDailySummary_003Ed__);
		return _003CGetDailySummary_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetInventoryReport_003Ed__6))]
	[HttpGet("inventory")]
	public System.Threading.Tasks.Task<IActionResult> GetInventoryReport()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetInventoryReport_003Ed__6 _003CGetInventoryReport_003Ed__ = default(_003CGetInventoryReport_003Ed__6);
		_003CGetInventoryReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetInventoryReport_003Ed__._003C_003E4__this = this;
		_003CGetInventoryReport_003Ed__._003C_003E1__state = -1;
		_003CGetInventoryReport_003Ed__._003C_003Et__builder.Start<_003CGetInventoryReport_003Ed__6>(ref _003CGetInventoryReport_003Ed__);
		return _003CGetInventoryReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetProfitReport_003Ed__7))]
	[HttpGet("profit")]
	public System.Threading.Tasks.Task<IActionResult> GetProfitReport([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetProfitReport_003Ed__7 _003CGetProfitReport_003Ed__ = default(_003CGetProfitReport_003Ed__7);
		_003CGetProfitReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetProfitReport_003Ed__._003C_003E4__this = this;
		_003CGetProfitReport_003Ed__.from = from;
		_003CGetProfitReport_003Ed__.to = to;
		_003CGetProfitReport_003Ed__._003C_003E1__state = -1;
		_003CGetProfitReport_003Ed__._003C_003Et__builder.Start<_003CGetProfitReport_003Ed__7>(ref _003CGetProfitReport_003Ed__);
		return _003CGetProfitReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCustomerReport_003Ed__8))]
	[HttpGet("customer/{customerId}")]
	public System.Threading.Tasks.Task<IActionResult> GetCustomerReport(int customerId, [FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCustomerReport_003Ed__8 _003CGetCustomerReport_003Ed__ = default(_003CGetCustomerReport_003Ed__8);
		_003CGetCustomerReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetCustomerReport_003Ed__._003C_003E4__this = this;
		_003CGetCustomerReport_003Ed__.customerId = customerId;
		_003CGetCustomerReport_003Ed__.from = from;
		_003CGetCustomerReport_003Ed__.to = to;
		_003CGetCustomerReport_003Ed__._003C_003E1__state = -1;
		_003CGetCustomerReport_003Ed__._003C_003Et__builder.Start<_003CGetCustomerReport_003Ed__8>(ref _003CGetCustomerReport_003Ed__);
		return _003CGetCustomerReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSalesDetail_003Ed__9))]
	[HttpGet("sales-detail")]
	public System.Threading.Tasks.Task<IActionResult> GetSalesDetail([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSalesDetail_003Ed__9 _003CGetSalesDetail_003Ed__ = default(_003CGetSalesDetail_003Ed__9);
		_003CGetSalesDetail_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetSalesDetail_003Ed__._003C_003E4__this = this;
		_003CGetSalesDetail_003Ed__.from = from;
		_003CGetSalesDetail_003Ed__.to = to;
		_003CGetSalesDetail_003Ed__._003C_003E1__state = -1;
		_003CGetSalesDetail_003Ed__._003C_003Et__builder.Start<_003CGetSalesDetail_003Ed__9>(ref _003CGetSalesDetail_003Ed__);
		return _003CGetSalesDetail_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetMonthlyComparison_003Ed__10))]
	[HttpGet("monthly-comparison")]
	public System.Threading.Tasks.Task<IActionResult> GetMonthlyComparison([FromQuery] int year)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetMonthlyComparison_003Ed__10 _003CGetMonthlyComparison_003Ed__ = default(_003CGetMonthlyComparison_003Ed__10);
		_003CGetMonthlyComparison_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetMonthlyComparison_003Ed__._003C_003E4__this = this;
		_003CGetMonthlyComparison_003Ed__.year = year;
		_003CGetMonthlyComparison_003Ed__._003C_003E1__state = -1;
		_003CGetMonthlyComparison_003Ed__._003C_003Et__builder.Start<_003CGetMonthlyComparison_003Ed__10>(ref _003CGetMonthlyComparison_003Ed__);
		return _003CGetMonthlyComparison_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetHourlySalesHeatmap_003Ed__11))]
	[HttpGet("hourly-heatmap")]
	public System.Threading.Tasks.Task<IActionResult> GetHourlySalesHeatmap([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetHourlySalesHeatmap_003Ed__11 _003CGetHourlySalesHeatmap_003Ed__ = default(_003CGetHourlySalesHeatmap_003Ed__11);
		_003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetHourlySalesHeatmap_003Ed__._003C_003E4__this = this;
		_003CGetHourlySalesHeatmap_003Ed__.from = from;
		_003CGetHourlySalesHeatmap_003Ed__.to = to;
		_003CGetHourlySalesHeatmap_003Ed__._003C_003E1__state = -1;
		_003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder.Start<_003CGetHourlySalesHeatmap_003Ed__11>(ref _003CGetHourlySalesHeatmap_003Ed__);
		return _003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetEmployeeSalesReport_003Ed__12))]
	[HttpGet("employee-sales")]
	public System.Threading.Tasks.Task<IActionResult> GetEmployeeSalesReport([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetEmployeeSalesReport_003Ed__12 _003CGetEmployeeSalesReport_003Ed__ = default(_003CGetEmployeeSalesReport_003Ed__12);
		_003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetEmployeeSalesReport_003Ed__._003C_003E4__this = this;
		_003CGetEmployeeSalesReport_003Ed__.from = from;
		_003CGetEmployeeSalesReport_003Ed__.to = to;
		_003CGetEmployeeSalesReport_003Ed__._003C_003E1__state = -1;
		_003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder.Start<_003CGetEmployeeSalesReport_003Ed__12>(ref _003CGetEmployeeSalesReport_003Ed__);
		return _003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetReturnsAnalysis_003Ed__13))]
	[HttpGet("returns-analysis")]
	public System.Threading.Tasks.Task<IActionResult> GetReturnsAnalysis([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetReturnsAnalysis_003Ed__13 _003CGetReturnsAnalysis_003Ed__ = default(_003CGetReturnsAnalysis_003Ed__13);
		_003CGetReturnsAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetReturnsAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetReturnsAnalysis_003Ed__.from = from;
		_003CGetReturnsAnalysis_003Ed__.to = to;
		_003CGetReturnsAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetReturnsAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetReturnsAnalysis_003Ed__13>(ref _003CGetReturnsAnalysis_003Ed__);
		return _003CGetReturnsAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSalesByCategory_003Ed__14))]
	[HttpGet("sales-by-category")]
	public System.Threading.Tasks.Task<IActionResult> GetSalesByCategory([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSalesByCategory_003Ed__14 _003CGetSalesByCategory_003Ed__ = default(_003CGetSalesByCategory_003Ed__14);
		_003CGetSalesByCategory_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetSalesByCategory_003Ed__._003C_003E4__this = this;
		_003CGetSalesByCategory_003Ed__.from = from;
		_003CGetSalesByCategory_003Ed__.to = to;
		_003CGetSalesByCategory_003Ed__._003C_003E1__state = -1;
		_003CGetSalesByCategory_003Ed__._003C_003Et__builder.Start<_003CGetSalesByCategory_003Ed__14>(ref _003CGetSalesByCategory_003Ed__);
		return _003CGetSalesByCategory_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetWeekdayAnalysis_003Ed__15))]
	[HttpGet("weekday-analysis")]
	public System.Threading.Tasks.Task<IActionResult> GetWeekdayAnalysis([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetWeekdayAnalysis_003Ed__15 _003CGetWeekdayAnalysis_003Ed__ = default(_003CGetWeekdayAnalysis_003Ed__15);
		_003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetWeekdayAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetWeekdayAnalysis_003Ed__.from = from;
		_003CGetWeekdayAnalysis_003Ed__.to = to;
		_003CGetWeekdayAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetWeekdayAnalysis_003Ed__15>(ref _003CGetWeekdayAnalysis_003Ed__);
		return _003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetDiscountImpact_003Ed__16))]
	[HttpGet("discount-impact")]
	public System.Threading.Tasks.Task<IActionResult> GetDiscountImpact([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetDiscountImpact_003Ed__16 _003CGetDiscountImpact_003Ed__ = default(_003CGetDiscountImpact_003Ed__16);
		_003CGetDiscountImpact_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetDiscountImpact_003Ed__._003C_003E4__this = this;
		_003CGetDiscountImpact_003Ed__.from = from;
		_003CGetDiscountImpact_003Ed__.to = to;
		_003CGetDiscountImpact_003Ed__._003C_003E1__state = -1;
		_003CGetDiscountImpact_003Ed__._003C_003Et__builder.Start<_003CGetDiscountImpact_003Ed__16>(ref _003CGetDiscountImpact_003Ed__);
		return _003CGetDiscountImpact_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetPaymentTrends_003Ed__17))]
	[HttpGet("payment-trends")]
	public System.Threading.Tasks.Task<IActionResult> GetPaymentTrends([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetPaymentTrends_003Ed__17 _003CGetPaymentTrends_003Ed__ = default(_003CGetPaymentTrends_003Ed__17);
		_003CGetPaymentTrends_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetPaymentTrends_003Ed__._003C_003E4__this = this;
		_003CGetPaymentTrends_003Ed__.from = from;
		_003CGetPaymentTrends_003Ed__.to = to;
		_003CGetPaymentTrends_003Ed__._003C_003E1__state = -1;
		_003CGetPaymentTrends_003Ed__._003C_003Et__builder.Start<_003CGetPaymentTrends_003Ed__17>(ref _003CGetPaymentTrends_003Ed__);
		return _003CGetPaymentTrends_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCashRegisterSessions_003Ed__18))]
	[HttpGet("cash-register-sessions")]
	public System.Threading.Tasks.Task<IActionResult> GetCashRegisterSessions([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCashRegisterSessions_003Ed__18 _003CGetCashRegisterSessions_003Ed__ = default(_003CGetCashRegisterSessions_003Ed__18);
		_003CGetCashRegisterSessions_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetCashRegisterSessions_003Ed__._003C_003E4__this = this;
		_003CGetCashRegisterSessions_003Ed__.from = from;
		_003CGetCashRegisterSessions_003Ed__.to = to;
		_003CGetCashRegisterSessions_003Ed__._003C_003E1__state = -1;
		_003CGetCashRegisterSessions_003Ed__._003C_003Et__builder.Start<_003CGetCashRegisterSessions_003Ed__18>(ref _003CGetCashRegisterSessions_003Ed__);
		return _003CGetCashRegisterSessions_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetInventoryMovements_003Ed__19))]
	[HttpGet("inventory-movements")]
	public System.Threading.Tasks.Task<IActionResult> GetInventoryMovements([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetInventoryMovements_003Ed__19 _003CGetInventoryMovements_003Ed__ = default(_003CGetInventoryMovements_003Ed__19);
		_003CGetInventoryMovements_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetInventoryMovements_003Ed__._003C_003E4__this = this;
		_003CGetInventoryMovements_003Ed__.from = from;
		_003CGetInventoryMovements_003Ed__.to = to;
		_003CGetInventoryMovements_003Ed__._003C_003E1__state = -1;
		_003CGetInventoryMovements_003Ed__._003C_003Et__builder.Start<_003CGetInventoryMovements_003Ed__19>(ref _003CGetInventoryMovements_003Ed__);
		return _003CGetInventoryMovements_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCustomerSegmentation_003Ed__20))]
	[HttpGet("customer-segmentation")]
	public System.Threading.Tasks.Task<IActionResult> GetCustomerSegmentation()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCustomerSegmentation_003Ed__20 _003CGetCustomerSegmentation_003Ed__ = default(_003CGetCustomerSegmentation_003Ed__20);
		_003CGetCustomerSegmentation_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetCustomerSegmentation_003Ed__._003C_003E4__this = this;
		_003CGetCustomerSegmentation_003Ed__._003C_003E1__state = -1;
		_003CGetCustomerSegmentation_003Ed__._003C_003Et__builder.Start<_003CGetCustomerSegmentation_003Ed__20>(ref _003CGetCustomerSegmentation_003Ed__);
		return _003CGetCustomerSegmentation_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetExpenseAnalysis_003Ed__21))]
	[HttpGet("expense-analysis")]
	public System.Threading.Tasks.Task<IActionResult> GetExpenseAnalysis([FromQuery] System.DateTime from, [FromQuery] System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetExpenseAnalysis_003Ed__21 _003CGetExpenseAnalysis_003Ed__ = default(_003CGetExpenseAnalysis_003Ed__21);
		_003CGetExpenseAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetExpenseAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetExpenseAnalysis_003Ed__.from = from;
		_003CGetExpenseAnalysis_003Ed__.to = to;
		_003CGetExpenseAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetExpenseAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetExpenseAnalysis_003Ed__21>(ref _003CGetExpenseAnalysis_003Ed__);
		return _003CGetExpenseAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetStockProjections_003Ed__22))]
	[HttpGet("stock-projections")]
	public System.Threading.Tasks.Task<IActionResult> GetStockProjections()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetStockProjections_003Ed__22 _003CGetStockProjections_003Ed__ = default(_003CGetStockProjections_003Ed__22);
		_003CGetStockProjections_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetStockProjections_003Ed__._003C_003E4__this = this;
		_003CGetStockProjections_003Ed__._003C_003E1__state = -1;
		_003CGetStockProjections_003Ed__._003C_003Et__builder.Start<_003CGetStockProjections_003Ed__22>(ref _003CGetStockProjections_003Ed__);
		return _003CGetStockProjections_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetMonthlyComparisonExtended_003Ed__23))]
	[HttpGet("monthly-comparison-extended")]
	public System.Threading.Tasks.Task<IActionResult> GetMonthlyComparisonExtended([FromQuery] int years = 2)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetMonthlyComparisonExtended_003Ed__23 _003CGetMonthlyComparisonExtended_003Ed__ = default(_003CGetMonthlyComparisonExtended_003Ed__23);
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<IActionResult>.Create();
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003E4__this = this;
		_003CGetMonthlyComparisonExtended_003Ed__.years = years;
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003E1__state = -1;
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder.Start<_003CGetMonthlyComparisonExtended_003Ed__23>(ref _003CGetMonthlyComparisonExtended_003Ed__);
		return _003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder.get_Task();
	}
}
