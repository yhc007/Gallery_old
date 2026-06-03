package com.gallery.chart;

import java.util.Map;


public interface ChartService {
	String getYstdaySales (ChartVo chartVo) throws Exception;
	Map getShopSales (ChartVo chartvo) throws Exception;
	Map getPrdctRank(ChartVo chartVo)throws Exception;
	Map getProfit(ChartVo chartVo)throws Exception;
	Map getStaffChart(ChartVo chartVo) throws Exception;
	Map getStaffJob(ChartVo chartVo)throws Exception;
	Map getStaffList(ChartVo chartVo)throws Exception;
}
