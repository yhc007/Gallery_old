package com.gallerytalk.mobile.saleJob.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;
import com.gallerytalk.mobile.saleJob.service.SaleJobService;
import com.gallerytalk.mobile.shop.domain.ShopVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/saleJob")
@Controller
public class SaleJobController {
	
	private static final Logger logger = LoggerFactory.getLogger(SaleJobController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private SaleService saleService;
	
	@Autowired
	private SaleJobService saleJobService;
	
	@RequestMapping(value = "listVisitingCstmrData")
	public String listVisitingCstmrData(SaleJobVo saleJobVo,ModelMap model, HttpSession session) {
		logger.info("run listVisitingCstmrData");
		logger.info("SalejobVo:"+saleJobVo);
		
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		
		saleJobVo.setShopId(shopVo.getShopId());
		try{
			Map map=saleJobService.listVisitingCstmrData(saleJobVo);

			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return "saleJob/listVisitingCstmrData";
	}
	
	@RequestMapping(value="delVisitData")
	@ResponseBody
	public String delVisitData(SaleJobVo saleJobVo){
		String result = "";
		try {
			result = saleJobService.delVisitData(saleJobVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
