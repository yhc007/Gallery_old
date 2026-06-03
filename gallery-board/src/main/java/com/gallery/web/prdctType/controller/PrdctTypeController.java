package com.gallery.web.prdctType.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.event.domain.EventPrdctVo;
import com.gallery.web.event.domain.EventVo;
import com.gallery.web.event.service.EventService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;
import com.gallery.web.prdctType.service.copy.PrdctTypeService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/pdrctType")
@Controller
public class PrdctTypeController {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdctTypeController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private PrdctTypeService prdctTypeService;
	
	@RequestMapping(value ="mListPrdctTypeData.do")
	public String mListBrandData(HttpServletRequest request, HttpServletResponse response)throws Exception{
		 prdctTypeService.mListPrdctTypeData(response);
		return "home";
	}
}
