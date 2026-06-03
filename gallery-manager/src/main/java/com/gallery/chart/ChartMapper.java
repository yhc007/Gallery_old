package com.gallery.chart;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChartMapper {
    List<ChartVo> getShopSales(ChartVo value);
    List<ChartVo> getPrdctRank(ChartVo value);
    List<ChartVo> getProfit(ChartVo value);
    List<ChartVo> getStaffChart(ChartVo value);
    List<ChartVo> getStaffJob(ChartVo value);
    List<ChartVo> getStaffList(ChartVo value);
    Integer getYstDaySales(ChartVo value);
    Integer getTDaySales(ChartVo value);
}
