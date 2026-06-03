package com.gallery.chart;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ChartServiceImpl implements ChartService {
    private final ChartMapper chartMapper;

    @Override
    public String getYstdaySales(ChartVo chartVo) {
        Integer ystdsales = chartMapper.getYstDaySales(chartVo);
        Integer tsales = chartMapper.getTDaySales(chartVo);
        if (ystdsales == null) {
            ystdsales = 0;
        }
        if (tsales == null) {
            tsales = 0;
        }
        return ystdsales + "/" + tsales;
    }

    @Override
    public Map getShopSales(ChartVo chartvo) {
        Map resultMap = new HashMap();
        List<ChartVo> salesInfo = chartMapper.getShopSales(chartvo);
        resultMap.put("shopSales", salesInfo);

        return resultMap;
    }

    @Override
    public Map getPrdctRank(ChartVo chartVo) {
        Map resultMap = new HashMap();
        List<ChartVo>  rankInfo = chartMapper.getPrdctRank(chartVo);
        resultMap.put("prdctRank", rankInfo);

        return resultMap;
    }

    @Override
    public Map getProfit(ChartVo chartVo) {
        Map resultMap = new HashMap();
        List<ChartVo>  rankInfo = chartMapper.getProfit(chartVo);
        resultMap.put("profit", rankInfo);

        return resultMap;
    }

    @Override
    public Map getStaffChart(ChartVo chartVo) {
        Map resultMap = new HashMap();
        List<ChartVo>  staffList = chartMapper.getStaffChart(chartVo);
        resultMap.put("staffChart", staffList);

        return resultMap;
    }

    @Override
    public Map getStaffJob(ChartVo chartVo) {
        Map resultMap = new HashMap();
        List<ChartVo>  staffJobList = chartMapper.getStaffJob(chartVo);
        resultMap.put("staffJob", staffJobList);

        return resultMap;
    }

    @Override
    public Map getStaffList(ChartVo chartVo) {
        Map result = new HashMap();
        List<ChartVo>  staffList = chartMapper.getStaffList(chartVo);
        result.put("staffList", staffList);

        return result;
    }
}
