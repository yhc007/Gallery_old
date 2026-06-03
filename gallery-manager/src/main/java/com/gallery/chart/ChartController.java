package com.gallery.chart;

import com.gallery.common.MenuTreeVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/chart")
@Controller
@RequiredArgsConstructor
public class ChartController {

    private static final Logger logger = LoggerFactory.getLogger(ChartController.class);
    private final ChartService chartservice;

    @RequestMapping(value = "chart.do")
    public String indexDlvrForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("", 740, "center", 0));
        model.addAttribute("tlist", tlist);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 1) ? "tiles:access/denied" : "tiles:index/indexForm";
    }

    @RequestMapping(value = "getSales.do")
    public String getSales(ChartVo chartvo, ModelMap model) {
        try {
            String ySales = chartservice.getYstdaySales(chartvo);
            model.addAttribute("sales", ySales);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/chartData";
    }

    @RequestMapping(value = "getPrdctRank.do")
    public String getPrdctRank(ChartVo chartVo, ModelMap model) {
        try {
            Map map = chartservice.getPrdctRank(chartVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/prdctRank";
    }

    @RequestMapping(value = "getProfit.do")
    public String getPofit(ChartVo chartVo, ModelMap model) {
        try {
            Map map = chartservice.getProfit(chartVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/profit";
    }

    @RequestMapping(value = "getStaffSales.do")
    public String getStaffSales(ChartVo chartVo, ModelMap model) {
        try {
            Map map = chartservice.getStaffChart(chartVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/staffChartData";
    }

    @RequestMapping(value = "shopSales.do")
    public String shopSales(ChartVo chartvo, ModelMap model) {
        try {
            Map map = chartservice.getShopSales(chartvo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/shopData";
    }

    @RequestMapping(value = "getStaffJob.do")
    public String getStaffJob(ChartVo chartVo, ModelMap model) {
        try {
            Map map = chartservice.getStaffJob(chartVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/staffJob";
    }

    @RequestMapping(value = "getStaffList.do")
    public String getStaffList(ChartVo chartVo, ModelMap model) {
        try {
            Map map = chartservice.getStaffList(chartVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index/staffList";
    }
}
