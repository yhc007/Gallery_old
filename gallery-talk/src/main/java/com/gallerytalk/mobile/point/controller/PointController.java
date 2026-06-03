package com.gallerytalk.mobile.point.controller;

import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.point.service.PointService;
import com.gallerytalk.mobile.sale.domain.SaleVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/point")
@Controller
public class PointController {
	
	private static final Logger logger = LoggerFactory.getLogger(PointController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private PointService pointService;
	
	
	@RequestMapping(value = "calcBalancePoint")
	@ResponseBody
	public String calcBalancePoint() {
		logger.debug("run calcBalancePoint");
		String result;
		try{
			result=pointService.addBalancePoint();
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	@RequestMapping(value = "getCstmrPoint")
	@ResponseBody
	public String getCstmrPoint(PointVo pointVo) {
		logger.info("run getCstmrPoint pointVo:"+pointVo);
		String result ="";
		try{
			pointVo=pointService.selectPointByCstmrCd(pointVo);
			
			result = String.format("%d",(int)(pointVo.getTotalPoint()*100))+","+pointVo.getFmlyCd()+","+pointVo.getFmlyName();
			logger.info(result);
			result = URLEncoder.encode(result,"utf-8");
			result = result.replaceAll("\\+", "%20");

			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	@RequestMapping(value = "listPointHist")
	public String listPointHist(PointVo pointVo,ModelMap model) {
		logger.info("run listPointHist pointVo:"+pointVo);
		try{
			Map map = pointService.listPointHistory(pointVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "point/listPointHist";
	}	

	
}