package com.gallery.web.shop.controller;

import java.util.ArrayList;
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
import com.gallery.web.shop.domain.ShopVo;
import com.gallery.web.shop.service.ShopService;

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
	
	@RequestMapping(value = "indexShopForm")
	public String indexShopForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("매장 관리",120,"center",0));
		tlist.add(new MenuTreeVo("매장 등록/수정",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:shop/indexShopForm";
		}
		
		
		return rtnPage;
	}
	
	@RequestMapping(value = "findShopName")
	public String findShopName(ShopVo shopVo, ModelMap model){
		Map map = null;
		try {
			map = shopService.findShopName(shopVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAllAttributes(map);
		return "tiles:prdct/shopInfo";
		
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
		logger.info("info run mlistShopData shopVo:"+shopVo);
		
		shopService.mListShopData(response, shopVo);
		
		return "home";
	}
	
	@RequestMapping(value ="getShopData")
	@ResponseBody
	public ShopVo getCstmrData(ShopVo shopVo)throws Exception{
		ShopVo bb=shopService.selectShop(shopVo);
		logger.debug(bb.toString());
		logger.info("json : " + bb.toString());
		return bb;
	} 
	
	@RequestMapping(value="shopList")
	public String shopList(ShopVo shopVo, ModelMap model){
		try {
			Map map = shopService.shopList(shopVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shop/shopList";
	}
	
	@RequestMapping(value="selectAllShop")
	public String selectAllShop(ModelMap model){
		try {
			Map map = shopService.selectAllShop();
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shop/shopList";
	}
	
	@RequestMapping(value="getInum")
	public String getInum(ShopVo shopVo, ModelMap model){
		try {
			Map map = shopService.getinum(shopVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shop/listComDataForGcm";
	}
	
	@RequestMapping(value="getShopId")
	public String getShopId(ShopVo shopVo, ModelMap model){
		try {
			Map map = shopService.getShopId(shopVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shop/listShopDataForGcm";
	};
}
