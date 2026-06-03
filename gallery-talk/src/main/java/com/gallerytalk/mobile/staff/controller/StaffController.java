package com.gallerytalk.mobile.staff.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.common.domain.MenuTreeVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.shop.service.ShopService;
import com.gallerytalk.mobile.staff.domain.StaffVo;
import com.gallerytalk.mobile.staff.service.StaffService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/staff")
@Controller
public class StaffController {
	
	private static final Logger logger = LoggerFactory.getLogger(StaffController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private StaffService staffService;
	
	@Autowired
	private ShopService shopService;
	
	
	@RequestMapping(value ="setUserRegId.do")
	public void setUserRegId(StaffVo staffVo, HttpServletResponse response)throws Exception{
		logger.info("run setUserRegId");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		String str="";
		ObjectMapper om = new ObjectMapper();
		Map map = new HashMap();
		try {
			map=staffService.setUserRegId(staffVo);
			str=om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("");
			str = "error";
			map.put("result",str);
		}
			writer.write(str);
			writer.flush();
			writer.close();
	}
}
