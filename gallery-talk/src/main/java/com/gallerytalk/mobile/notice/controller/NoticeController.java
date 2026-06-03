package com.gallerytalk.mobile.notice.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVoSecu;
import com.gallerytalk.mobile.cstmr.service.CstmrService;
import com.gallerytalk.mobile.cstmrHstry.domain.CstmrHstryVo;
import com.gallerytalk.mobile.cstmrHstry.service.CstmrHstryService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.shop.service.ShopService;
import com.gallerytalk.mobile.staff.domain.StaffVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/notice")
@Controller
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private CstmrService cstmrService;
	
	@Autowired
	private ShopService shopService;
	
	private CstmrHstryService cstmrHstryService;
	
	@RequestMapping(value = "notice1")
	public String indexCstmrForm(Model model,HttpServletResponse response,HttpSession session) throws Exception {
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrVo cstmrVo = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR));
		
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);
		
		return "notice/notice1";
	}
	
	
}
