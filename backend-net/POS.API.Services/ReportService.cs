using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using POS.API.DTOs;
using POS.API.Data;

namespace POS.API.Services;

public class ReportService
{
	private readonly AppDbContext _context;

	public ReportService(AppDbContext context)
	{
		_context = context;
	}

	[AsyncStateMachine(typeof(_003CGetSalesReport_003Ed__2))]
	public System.Threading.Tasks.Task<SalesReportDto> GetSalesReport(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSalesReport_003Ed__2 _003CGetSalesReport_003Ed__ = default(_003CGetSalesReport_003Ed__2);
		_003CGetSalesReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<SalesReportDto>.Create();
		_003CGetSalesReport_003Ed__._003C_003E4__this = this;
		_003CGetSalesReport_003Ed__.from = from;
		_003CGetSalesReport_003Ed__.to = to;
		_003CGetSalesReport_003Ed__._003C_003E1__state = -1;
		_003CGetSalesReport_003Ed__._003C_003Et__builder.Start<_003CGetSalesReport_003Ed__2>(ref _003CGetSalesReport_003Ed__);
		return _003CGetSalesReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetTopProducts_003Ed__3))]
	public System.Threading.Tasks.Task<List<TopProductsDto>> GetTopProducts(System.DateTime from, System.DateTime to, int topN = 10)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetTopProducts_003Ed__3 _003CGetTopProducts_003Ed__ = default(_003CGetTopProducts_003Ed__3);
		_003CGetTopProducts_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<TopProductsDto>>.Create();
		_003CGetTopProducts_003Ed__._003C_003E4__this = this;
		_003CGetTopProducts_003Ed__.from = from;
		_003CGetTopProducts_003Ed__.to = to;
		_003CGetTopProducts_003Ed__.topN = topN;
		_003CGetTopProducts_003Ed__._003C_003E1__state = -1;
		_003CGetTopProducts_003Ed__._003C_003Et__builder.Start<_003CGetTopProducts_003Ed__3>(ref _003CGetTopProducts_003Ed__);
		return _003CGetTopProducts_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetDailySummary_003Ed__4))]
	public System.Threading.Tasks.Task<DailySummaryDto> GetDailySummary(System.DateTime date)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetDailySummary_003Ed__4 _003CGetDailySummary_003Ed__ = default(_003CGetDailySummary_003Ed__4);
		_003CGetDailySummary_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<DailySummaryDto>.Create();
		_003CGetDailySummary_003Ed__._003C_003E4__this = this;
		_003CGetDailySummary_003Ed__.date = date;
		_003CGetDailySummary_003Ed__._003C_003E1__state = -1;
		_003CGetDailySummary_003Ed__._003C_003Et__builder.Start<_003CGetDailySummary_003Ed__4>(ref _003CGetDailySummary_003Ed__);
		return _003CGetDailySummary_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetInventoryReport_003Ed__5))]
	public System.Threading.Tasks.Task<InventoryReportDto> GetInventoryReport()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetInventoryReport_003Ed__5 _003CGetInventoryReport_003Ed__ = default(_003CGetInventoryReport_003Ed__5);
		_003CGetInventoryReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<InventoryReportDto>.Create();
		_003CGetInventoryReport_003Ed__._003C_003E4__this = this;
		_003CGetInventoryReport_003Ed__._003C_003E1__state = -1;
		_003CGetInventoryReport_003Ed__._003C_003Et__builder.Start<_003CGetInventoryReport_003Ed__5>(ref _003CGetInventoryReport_003Ed__);
		return _003CGetInventoryReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCustomerReport_003Ed__6))]
	public System.Threading.Tasks.Task<CustomerReportDto?> GetCustomerReport(int customerId, System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCustomerReport_003Ed__6 _003CGetCustomerReport_003Ed__ = default(_003CGetCustomerReport_003Ed__6);
		_003CGetCustomerReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<CustomerReportDto>.Create();
		_003CGetCustomerReport_003Ed__._003C_003E4__this = this;
		_003CGetCustomerReport_003Ed__.customerId = customerId;
		_003CGetCustomerReport_003Ed__.from = from;
		_003CGetCustomerReport_003Ed__.to = to;
		_003CGetCustomerReport_003Ed__._003C_003E1__state = -1;
		_003CGetCustomerReport_003Ed__._003C_003Et__builder.Start<_003CGetCustomerReport_003Ed__6>(ref _003CGetCustomerReport_003Ed__);
		return _003CGetCustomerReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetProfitReport_003Ed__7))]
	public System.Threading.Tasks.Task<ProfitReportDto> GetProfitReport(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetProfitReport_003Ed__7 _003CGetProfitReport_003Ed__ = default(_003CGetProfitReport_003Ed__7);
		_003CGetProfitReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ProfitReportDto>.Create();
		_003CGetProfitReport_003Ed__._003C_003E4__this = this;
		_003CGetProfitReport_003Ed__.from = from;
		_003CGetProfitReport_003Ed__.to = to;
		_003CGetProfitReport_003Ed__._003C_003E1__state = -1;
		_003CGetProfitReport_003Ed__._003C_003Et__builder.Start<_003CGetProfitReport_003Ed__7>(ref _003CGetProfitReport_003Ed__);
		return _003CGetProfitReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetHourlySalesHeatmap_003Ed__8))]
	public System.Threading.Tasks.Task<List<HourlySalesDto>> GetHourlySalesHeatmap(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetHourlySalesHeatmap_003Ed__8 _003CGetHourlySalesHeatmap_003Ed__ = default(_003CGetHourlySalesHeatmap_003Ed__8);
		_003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<HourlySalesDto>>.Create();
		_003CGetHourlySalesHeatmap_003Ed__._003C_003E4__this = this;
		_003CGetHourlySalesHeatmap_003Ed__.from = from;
		_003CGetHourlySalesHeatmap_003Ed__.to = to;
		_003CGetHourlySalesHeatmap_003Ed__._003C_003E1__state = -1;
		_003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder.Start<_003CGetHourlySalesHeatmap_003Ed__8>(ref _003CGetHourlySalesHeatmap_003Ed__);
		return _003CGetHourlySalesHeatmap_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetEmployeeSalesReport_003Ed__9))]
	public System.Threading.Tasks.Task<List<EmployeeSalesDto>> GetEmployeeSalesReport(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetEmployeeSalesReport_003Ed__9 _003CGetEmployeeSalesReport_003Ed__ = default(_003CGetEmployeeSalesReport_003Ed__9);
		_003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<EmployeeSalesDto>>.Create();
		_003CGetEmployeeSalesReport_003Ed__._003C_003E4__this = this;
		_003CGetEmployeeSalesReport_003Ed__.from = from;
		_003CGetEmployeeSalesReport_003Ed__.to = to;
		_003CGetEmployeeSalesReport_003Ed__._003C_003E1__state = -1;
		_003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder.Start<_003CGetEmployeeSalesReport_003Ed__9>(ref _003CGetEmployeeSalesReport_003Ed__);
		return _003CGetEmployeeSalesReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetReturnsAnalysis_003Ed__10))]
	public System.Threading.Tasks.Task<ReturnsAnalysisDto> GetReturnsAnalysis(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetReturnsAnalysis_003Ed__10 _003CGetReturnsAnalysis_003Ed__ = default(_003CGetReturnsAnalysis_003Ed__10);
		_003CGetReturnsAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ReturnsAnalysisDto>.Create();
		_003CGetReturnsAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetReturnsAnalysis_003Ed__.from = from;
		_003CGetReturnsAnalysis_003Ed__.to = to;
		_003CGetReturnsAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetReturnsAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetReturnsAnalysis_003Ed__10>(ref _003CGetReturnsAnalysis_003Ed__);
		return _003CGetReturnsAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetSalesByCategory_003Ed__11))]
	public System.Threading.Tasks.Task<List<SalesByCategoryDto>> GetSalesByCategory(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetSalesByCategory_003Ed__11 _003CGetSalesByCategory_003Ed__ = default(_003CGetSalesByCategory_003Ed__11);
		_003CGetSalesByCategory_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<SalesByCategoryDto>>.Create();
		_003CGetSalesByCategory_003Ed__._003C_003E4__this = this;
		_003CGetSalesByCategory_003Ed__.from = from;
		_003CGetSalesByCategory_003Ed__.to = to;
		_003CGetSalesByCategory_003Ed__._003C_003E1__state = -1;
		_003CGetSalesByCategory_003Ed__._003C_003Et__builder.Start<_003CGetSalesByCategory_003Ed__11>(ref _003CGetSalesByCategory_003Ed__);
		return _003CGetSalesByCategory_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetWeekdayAnalysis_003Ed__12))]
	public System.Threading.Tasks.Task<List<WeekdayAnalysisDto>> GetWeekdayAnalysis(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetWeekdayAnalysis_003Ed__12 _003CGetWeekdayAnalysis_003Ed__ = default(_003CGetWeekdayAnalysis_003Ed__12);
		_003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<WeekdayAnalysisDto>>.Create();
		_003CGetWeekdayAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetWeekdayAnalysis_003Ed__.from = from;
		_003CGetWeekdayAnalysis_003Ed__.to = to;
		_003CGetWeekdayAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetWeekdayAnalysis_003Ed__12>(ref _003CGetWeekdayAnalysis_003Ed__);
		return _003CGetWeekdayAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetDiscountImpact_003Ed__13))]
	public System.Threading.Tasks.Task<DiscountImpactDto> GetDiscountImpact(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetDiscountImpact_003Ed__13 _003CGetDiscountImpact_003Ed__ = default(_003CGetDiscountImpact_003Ed__13);
		_003CGetDiscountImpact_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<DiscountImpactDto>.Create();
		_003CGetDiscountImpact_003Ed__._003C_003E4__this = this;
		_003CGetDiscountImpact_003Ed__.from = from;
		_003CGetDiscountImpact_003Ed__.to = to;
		_003CGetDiscountImpact_003Ed__._003C_003E1__state = -1;
		_003CGetDiscountImpact_003Ed__._003C_003Et__builder.Start<_003CGetDiscountImpact_003Ed__13>(ref _003CGetDiscountImpact_003Ed__);
		return _003CGetDiscountImpact_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetPaymentTrends_003Ed__14))]
	public System.Threading.Tasks.Task<List<PaymentTrendDto>> GetPaymentTrends(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetPaymentTrends_003Ed__14 _003CGetPaymentTrends_003Ed__ = default(_003CGetPaymentTrends_003Ed__14);
		_003CGetPaymentTrends_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<PaymentTrendDto>>.Create();
		_003CGetPaymentTrends_003Ed__._003C_003E4__this = this;
		_003CGetPaymentTrends_003Ed__.from = from;
		_003CGetPaymentTrends_003Ed__.to = to;
		_003CGetPaymentTrends_003Ed__._003C_003E1__state = -1;
		_003CGetPaymentTrends_003Ed__._003C_003Et__builder.Start<_003CGetPaymentTrends_003Ed__14>(ref _003CGetPaymentTrends_003Ed__);
		return _003CGetPaymentTrends_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCashRegisterSessionsReport_003Ed__15))]
	public System.Threading.Tasks.Task<List<CashRegisterSessionReportDto>> GetCashRegisterSessionsReport(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCashRegisterSessionsReport_003Ed__15 _003CGetCashRegisterSessionsReport_003Ed__ = default(_003CGetCashRegisterSessionsReport_003Ed__15);
		_003CGetCashRegisterSessionsReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CashRegisterSessionReportDto>>.Create();
		_003CGetCashRegisterSessionsReport_003Ed__._003C_003E4__this = this;
		_003CGetCashRegisterSessionsReport_003Ed__.from = from;
		_003CGetCashRegisterSessionsReport_003Ed__.to = to;
		_003CGetCashRegisterSessionsReport_003Ed__._003C_003E1__state = -1;
		_003CGetCashRegisterSessionsReport_003Ed__._003C_003Et__builder.Start<_003CGetCashRegisterSessionsReport_003Ed__15>(ref _003CGetCashRegisterSessionsReport_003Ed__);
		return _003CGetCashRegisterSessionsReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetInventoryMovementReport_003Ed__16))]
	public System.Threading.Tasks.Task<InventoryMovementReportDto> GetInventoryMovementReport(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetInventoryMovementReport_003Ed__16 _003CGetInventoryMovementReport_003Ed__ = default(_003CGetInventoryMovementReport_003Ed__16);
		_003CGetInventoryMovementReport_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<InventoryMovementReportDto>.Create();
		_003CGetInventoryMovementReport_003Ed__._003C_003E4__this = this;
		_003CGetInventoryMovementReport_003Ed__.from = from;
		_003CGetInventoryMovementReport_003Ed__.to = to;
		_003CGetInventoryMovementReport_003Ed__._003C_003E1__state = -1;
		_003CGetInventoryMovementReport_003Ed__._003C_003Et__builder.Start<_003CGetInventoryMovementReport_003Ed__16>(ref _003CGetInventoryMovementReport_003Ed__);
		return _003CGetInventoryMovementReport_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetCustomerSegmentation_003Ed__17))]
	public System.Threading.Tasks.Task<List<CustomerSegmentationDto>> GetCustomerSegmentation()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetCustomerSegmentation_003Ed__17 _003CGetCustomerSegmentation_003Ed__ = default(_003CGetCustomerSegmentation_003Ed__17);
		_003CGetCustomerSegmentation_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<CustomerSegmentationDto>>.Create();
		_003CGetCustomerSegmentation_003Ed__._003C_003E4__this = this;
		_003CGetCustomerSegmentation_003Ed__._003C_003E1__state = -1;
		_003CGetCustomerSegmentation_003Ed__._003C_003Et__builder.Start<_003CGetCustomerSegmentation_003Ed__17>(ref _003CGetCustomerSegmentation_003Ed__);
		return _003CGetCustomerSegmentation_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetExpenseAnalysis_003Ed__18))]
	public System.Threading.Tasks.Task<ExpenseAnalysisDto> GetExpenseAnalysis(System.DateTime from, System.DateTime to)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetExpenseAnalysis_003Ed__18 _003CGetExpenseAnalysis_003Ed__ = default(_003CGetExpenseAnalysis_003Ed__18);
		_003CGetExpenseAnalysis_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<ExpenseAnalysisDto>.Create();
		_003CGetExpenseAnalysis_003Ed__._003C_003E4__this = this;
		_003CGetExpenseAnalysis_003Ed__.from = from;
		_003CGetExpenseAnalysis_003Ed__.to = to;
		_003CGetExpenseAnalysis_003Ed__._003C_003E1__state = -1;
		_003CGetExpenseAnalysis_003Ed__._003C_003Et__builder.Start<_003CGetExpenseAnalysis_003Ed__18>(ref _003CGetExpenseAnalysis_003Ed__);
		return _003CGetExpenseAnalysis_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetStockProjections_003Ed__19))]
	public System.Threading.Tasks.Task<List<StockProjectionDto>> GetStockProjections()
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetStockProjections_003Ed__19 _003CGetStockProjections_003Ed__ = default(_003CGetStockProjections_003Ed__19);
		_003CGetStockProjections_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<StockProjectionDto>>.Create();
		_003CGetStockProjections_003Ed__._003C_003E4__this = this;
		_003CGetStockProjections_003Ed__._003C_003E1__state = -1;
		_003CGetStockProjections_003Ed__._003C_003Et__builder.Start<_003CGetStockProjections_003Ed__19>(ref _003CGetStockProjections_003Ed__);
		return _003CGetStockProjections_003Ed__._003C_003Et__builder.get_Task();
	}

	[AsyncStateMachine(typeof(_003CGetMonthlyComparisonExtended_003Ed__20))]
	public System.Threading.Tasks.Task<List<MonthlyComparisonExtendedDto>> GetMonthlyComparisonExtended(int years = 2)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		_003CGetMonthlyComparisonExtended_003Ed__20 _003CGetMonthlyComparisonExtended_003Ed__ = default(_003CGetMonthlyComparisonExtended_003Ed__20);
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder = AsyncTaskMethodBuilder<List<MonthlyComparisonExtendedDto>>.Create();
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003E4__this = this;
		_003CGetMonthlyComparisonExtended_003Ed__.years = years;
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003E1__state = -1;
		_003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder.Start<_003CGetMonthlyComparisonExtended_003Ed__20>(ref _003CGetMonthlyComparisonExtended_003Ed__);
		return _003CGetMonthlyComparisonExtended_003Ed__._003C_003Et__builder.get_Task();
	}
}
