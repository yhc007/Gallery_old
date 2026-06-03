package com.gallerytalk.mobile.secu.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.point.service.PointService;
import com.gallerytalk.mobile.secu.domain.SecuVo;
import com.gallerytalk.mobile.secu.service.SecuService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/secu")
@Controller
public class SecuController {
	
	private static final Logger logger = LoggerFactory.getLogger(SecuController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private PointService pointService;
	
	@Autowired
	private SecuService secuService;
	
	@RequestMapping(value = "reg")
	@ResponseBody
	public String regMac(SecuVo secuVo) {
		logger.info("run regMac:"+secuVo);
		String rtn;
		if(secuVo.getSn() == null || secuVo.getMac() == null){
			return "fail";
		}
		try {
			if(secuService.checkSn(secuVo).equals("success")){
				rtn = secuService.regMac(secuVo);
				logger.info("rtn:"+rtn);
				return rtn;
			}else{
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	@RequestMapping(value = "indexSecuTest")
	public String indexSecuTest(SecuVo secuVo, HttpSession session, ModelMap model) {
		logger.info("run indexSecuTest:"+secuVo);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		String DvcSN = secuVo.getSn();
		
		model.addAttribute("staffVo", staffVo);
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("SN",DvcSN);
		
		return "secu/indexSecuTest";
	}
	
	@RequestMapping(value = "dvc")
	@ResponseBody
	public String checkDvc(SecuVo secuVo) throws Exception {
		logger.info("run checkMac:"+secuVo);
		String rtn = secuService.checkDvc(secuVo);
		return rtn;
	}
	
	@RequestMapping(value = "auth")
	@ResponseBody
	public String checkMac(SecuVo secuVo) throws Exception {
		logger.info("run checkMac:"+secuVo);
		String rtn = secuService.checkMac(secuVo);
		return rtn;
	}
	
}