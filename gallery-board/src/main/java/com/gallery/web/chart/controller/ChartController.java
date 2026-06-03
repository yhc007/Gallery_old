package com.gallery.web.chart.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.chart.domain.ChartVo;
import com.gallery.web.chart.service.ChartService;
import com.gallery.web.common.domain.MenuTreeVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/chart")
@Controller
public class ChartController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChartController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private ChartService chartservice;
	
	@RequestMapping(value = "chart")
	public String indexDlvrForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		//request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("",740,"center",0));
		
		model.addAttribute("tlist", tlist);
		//model.addAttribute("formnum", 5);
		
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<1){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:index/indexForm";
		}
		
		
		
		return rtnPage;
	}
	
	@RequestMapping(value = "getSales")
	public String getSales(ChartVo chartvo, ModelMap model) {
		//request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		System.out.println("chartvo : " + chartvo.toString());
		
		try {
			String ySales = chartservice.getYstdaySales(chartvo);
			model.addAttribute("sales",ySales);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
 
		 
		
		return "index/chartData";
	}
	
	@RequestMapping(value = "getPrdctRank")
	public String getPrdctRank(ChartVo chartVo, ModelMap model){
		
		System.out.println("rankController : " + chartVo.toString());
		try {
			Map map = chartservice.getPrdctRank(chartVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "index/prdctRank";
		
	}
	
	@RequestMapping(value = "getProfit")
	public String getPofit(ChartVo chartVo, ModelMap model){
		System.out.println("Profit  : " + chartVo.toString());
		try {
			Map map = chartservice.getProfit(chartVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "index/profit";
		
	}
	
	@RequestMapping(value = "getStaffSales")
	public String getStaffSales(ChartVo chartVo, ModelMap model){

		try {
			Map map = chartservice.getStaffChart(chartVo);
			model.addAllAttributes(map);
			System.out.println("staffSales : " + map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "index/staffChartData";
	}
	
	@RequestMapping(value = "shopSales")
	public String shopSales(ChartVo chartvo, ModelMap model) {
		//request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		System.out.println("chartvo : " + chartvo.toString());
		try {
			Map map = chartservice.getShopSales(chartvo);
			model.addAllAttributes(map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "index/shopData";
	}
	
	@RequestMapping(value = "getStaffJob")
	public String getStaffJob(ChartVo chartVo, ModelMap model){
		
		try {
			Map map = chartservice.getStaffJob(chartVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "index/staffJob";
	}
	
	@RequestMapping(value="getStaffList")
	public String getStaffList(ChartVo chartVo, ModelMap model){
		
		Map map;
		try {
			map = chartservice.getStaffList(chartVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "index/staffList";
		
	}
}
