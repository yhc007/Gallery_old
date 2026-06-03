package com.gallery.web.chart.service;

import java.util.Map;

import com.gallery.web.chart.domain.ChartVo;




public interface ChartService {
	public String getYstdaySales (ChartVo chartVo) throws Exception;
	public Map getShopSales (ChartVo chartvo) throws Exception;
	public Map getPrdctRank(ChartVo chartVo)throws Exception;
	public Map getProfit(ChartVo chartVo)throws Exception;
	public Map getStaffChart(ChartVo chartVo) throws Exception;
	public Map getStaffJob(ChartVo chartVo)throws Exception;
	public Map getStaffList(ChartVo chartVo)throws Exception;
}
