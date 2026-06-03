package com.gallerytalk.mobile.shop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.secu.domain.SecuVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.shop.service.ShopService;
import com.gallerytalk.mobile.staff.domain.StaffVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/shop")
@Controller
public class ShopController {
	
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private ShopService shopService;
	@Autowired
	private SaleService saleService;
	
	@RequestMapping(value = "indexShopForm")
	public String indexShopForm(HttpServletRequest request,ModelMap model,ShopVo shopVo) {
		logger.info("run indexShopForm.do");
		String DvcSN = shopVo.getSn();
		model.addAttribute("SN",DvcSN);
		
		try{
			Map map=shopService.listShopData(shopVo);
			shopService.recIP(request.getRemoteAddr());
			logger.info("map:"+map.toString());
			model.addAllAttributes(map);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "shop/indexShopForm";
	}
	
	@RequestMapping(value = "indexShopCstrmForm")
	public String indexShopCstmrForm(HttpServletRequest request,ModelMap model,HttpSession session) {
		session.setAttribute("currentPage", "1");
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		logger.info("run staffId:"+staffVo.getStaffId());
		logger.info("run staffVo:"+shopVo.getShopId());
		try{
			saleVo = saleService.selectSale(saleVo);
			logger.info("@@@@@@@@@@@@@@@@@@@@ get it 10 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			session.setAttribute(CommonCode.ATTR_SALE, saleVo);
			model.addAttribute("saleVo",saleVo);
			model.addAttribute("staffVo", staffVo);
			model.addAttribute("shopVo", shopVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "shop/indexShopCstmrForm";
	}
	
	@RequestMapping(value = "addShopAction")
	@ResponseBody
	public String addShopAction(ShopVo shopVo) {
		logger.debug("add "+shopVo.toString());
		try{
			String result=shopService.addShop(shopVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "modifyShopAction")
	@ResponseBody
	public String modifyShopAction(ShopVo shopVo) {
		logger.debug("modify "+shopVo.toString());
		try{
			shopService.modifyShop(shopVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeShopAction")
	@ResponseBody
	public String removeShopAction(ShopVo shopVo) {
		logger.debug("remove "+shopVo.toString());
		try{
			shopService.removeShop(shopVo);
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listShopData")
	public String listShopData(ShopVo shopVo,ModelMap model) {
		logger.debug("modify "+shopVo.toString());
		try{
			Map map=shopService.pagedListShopData(shopVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "shop/listShopData";
	}
	
	@RequestMapping(value = "mlistShopData")
	public String mlistShopData(HttpServletResponse response,ShopVo shopVo) throws Exception{
		shopService.mListShopData(response, shopVo);
		
		return "home";
	}
	
	@RequestMapping(value ="getShopData.do")
	@ResponseBody
	public ShopVo getCstmrData(ShopVo shopVo)throws Exception{
		ShopVo bb=shopService.selectShop(shopVo);
		logger.debug(bb.toString());
		return bb;
	} 
	
	@RequestMapping(value="getShopPwd")
	@ResponseBody
	public String getShopPwd(ShopVo shopVo){
		String result = "";
		try {
			result = shopService.getShopPwd(shopVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
		return result;
	}
	
	
}
