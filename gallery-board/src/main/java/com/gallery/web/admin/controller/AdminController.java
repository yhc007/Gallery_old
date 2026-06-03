package com.gallery.web.admin.controller;

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

import com.gallery.web.admin.domain.AdminVo;
import com.gallery.web.admin.service.AdminService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/admin")
@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private AdminService adminService;
	@Autowired
	private PrdctService prdctService;
	
	
	@RequestMapping("com")
	public String com(HttpSession session){
		return "com/index";
	}
	@RequestMapping(value="comLogin")
	@ResponseBody
	public String comLogin(AdminVo adminVo, HttpSession session, ModelMap model){
	String result  = "";
	
		try {
			result = adminService.comLogin(adminVo, session);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="goIndexPage")
	public String goIndexPage(){
		return "admin/index";
	}

}

