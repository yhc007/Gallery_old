package com.gallerytalk.mobile.check.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.brand.service.BrandService;
import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.check.service.CheckService;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.common.domain.CommonFunction;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.service.CstmrService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;
import com.gallerytalk.mobile.saleJob.service.SaleJobService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;
import com.gallerytalk.mobile.staff.service.StaffService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/check")
@Controller
public class CheckController {
	
	private static final Logger logger = LoggerFactory.getLogger(CheckController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private CheckService checkService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private SaleService saleService;
	@Autowired
	private SaleJobService saleJobService;
	@Autowired
	private CstmrService cstmrService;
	@Autowired
	private StaffService staffService;

	

	
	@RequestMapping(value = "listVisitData")
	public String listVisitData(ModelMap model,HttpServletRequest request,CheckVo checkVo,HttpSession session) {

		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		try{
			Map map=checkService.listVisitData(checkVo);
			model.addAllAttributes(map);
			model.addAttribute("staffVo", staffVo);
			
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "check/listVisitData";
	}
	
	@RequestMapping(value = "insertVisitAction")
	@ResponseBody
	public String insertVisitAction(ModelMap model,HttpServletRequest request,CheckVo checkVo,HttpSession session) {
		logger.info("run insertVisitAction:"+checkVo.toString());
		String msgReturn;
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		saleVo.setShopId(shopVo.getShopId());
		saleVo.setCstmrId(cstmrVo.getCstmrId());
		String dateTile = checkVo.getDateTile();
		checkVo.setStaffId(staffVo.getStaffId());
		checkVo.setVisitShopId(staffVo.getShopId());

		//make new sale
		if(saleVo.getSaleId() == null){
			saleVo.setResult(CommonCode.RESULT_INIT);
			saleVo.setDatetime(dateTile);
			try {
				if(0 == saleService.checkSaleCstrm(saleVo)){
					saleVo=saleService.addSaleProcess(saleVo);
					saleVo.setResult(CommonCode.RESULT_INIT);
					saleVo.setDatetime(dateTile);
					session.setAttribute(CommonCode.ATTR_SALE, saleVo);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try{
			checkVo.setDatetime(checkVo.getDateTile());
			msgReturn = checkService.addVisit(checkVo,session);
			saleVo.setResult(saleService.modifyResult(saleVo,CommonCode.ARRAY_CHECK,CommonCode.COMPLETED));
			logger.info("@@@@@@@@@@@@@@@@@@@@ get it1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			session.setAttribute(CommonCode.ATTR_SALE, saleVo);
			return msgReturn;
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}
	
	@RequestMapping(value = "updateVisitAction")
	@ResponseBody
	public String updateVisitAction(ModelMap model,HttpServletRequest request,CheckVo checkVo,HttpSession session) {
		logger.info("run updateVisitAciton");
		logger.info(checkVo.toString());
		try{
			return checkService.updateVisit(checkVo,session);
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "getCheckDataForSale")
	@ResponseBody
	public CheckVo getCheckDataForSale(ModelMap model,HttpServletRequest request,HttpSession session) {
		
		try{
			return checkService.selectVisitInfoForSale(session);
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return new CheckVo();
	}
	
	@RequestMapping(value = "getCheckData")
	@ResponseBody
	public CheckVo getCheckData(ModelMap model,HttpServletRequest request,CheckVo checkVo, HttpSession session) {
		logger.info("run getCheckData");
		try{
			//model.addAttribute("staffVo", staffVo);
			
			checkVo = checkService.selectVisitInfo(checkVo);
			return checkVo; 
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return new CheckVo();
	}
	
}
