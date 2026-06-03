package com.gallery.web.sale.controller;

import java.net.URLDecoder;
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
import com.gallery.web.sale.domain.SaleHistSearchVo;
import com.gallery.web.sale.domain.SaleVo;
import com.gallery.web.sale.service.SaleService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/sale")
@Controller
public class SaleController {
	
	private static final Logger logger = LoggerFactory.getLogger(SaleController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private SaleService saleService;
	
	
	@RequestMapping(value = "indexSaleForm")
	public String indexSaleForm(HttpServletRequest request,ModelMap model) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("브랜드 관리",120,"center",0));
		tlist.add(new MenuTreeVo("브랜드 등록/수정",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		return "tiles:sale/indexSaleForm";
	}
	
	
	@RequestMapping(value = "findShopName")
	public String findShopName(HttpServletRequest request,ModelMap model, HttpSession session) {
		try {
			Integer shopId = (Integer)session.getAttribute("shopId");
			Map map=saleService.findShopName(shopId);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return "sale/shopSelectOptionData";
	}
	
	@RequestMapping(value = "indexSalesHistForm")
	public String indexSalesHistForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
		
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("이력 관리",120,"center",0));
		tlist.add(new MenuTreeVo("매출 조회",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 3);
		
		Date date = new Date();
		model.addAttribute("cyear", 1900+date.getYear());
		model.addAttribute("cmonth", date.getMonth()+1);
		model.addAttribute("cday", date.getDate());
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:sale/indexSalesHistForm";
		}
		return rtnPage;
	}
	
	@RequestMapping(value = "indexSaleHistForm")
	public String indexSaleHistForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
		
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("이력 관리",120,"center",0));
		tlist.add(new MenuTreeVo("판매 이력",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 2);
		
		Date date = new Date();
		model.addAttribute("cyear", 1900+date.getYear());
		model.addAttribute("cmonth", date.getMonth()+1);
		//model.addAttribute("cday", String.format("%02d", date.getDay()) );
		model.addAttribute("cday", date.getDate());
		
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:sale/indexSaleHistForm";
		}
		return rtnPage;
	}
	
	@RequestMapping(value = "indexPrdctSaleHistForm")
	public String indexPrdctSaleHistForm(HttpServletRequest request,ModelMap model) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
		
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("이력 관리",120,"center",0));
		tlist.add(new MenuTreeVo("상품 판매 이력",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 3);
		
		Date date = new Date();
		model.addAttribute("cyear", 1900+date.getYear());
		model.addAttribute("cmonth", date.getMonth()+1);
		//model.addAttribute("cday", String.format("%02d", date.getDay()) );
		model.addAttribute("cday", date.getDate());
		return "tiles:sale/indexPrdctSaleHistForm";
	}
	
	
	@RequestMapping(value = "addSaleAction")
	@ResponseBody
	public String addSaleAction(SaleVo saleVo,HttpServletResponse response) {
		logger.info("add "+saleVo.toString());
		try{
			String result=saleService.addSale(saleVo,response);
			return result;
		}catch(Exception e){
			logger.info(e.getLocalizedMessage());
		}
		return "{ \"result\":\"fail\"}";
	}
	
	
	@RequestMapping(value = "modifySaleAction")
	@ResponseBody
	public String modifySaleAction(SaleVo saleVo) {
		logger.debug("modify "+saleVo.toString());
		try{
			saleService.modifySale(saleVo);
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listSaleData")
	public String listSaleData(SaleVo saleVo,ModelMap model) {
		logger.debug("modify "+saleVo.toString());
		try{
			Map map=saleService.pagedListSaleData(saleVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listSaleData";
	}
	
	
	@RequestMapping(value = "csv")
	public String csv(String csv) {
		try{
			System.out.println("controller : " + csv);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "csv/csv"; 
	}
	
	
	@RequestMapping(value ="getSaleData.do")
	@ResponseBody
	public SaleVo getSaleData(SaleVo saleVo)throws Exception{
		SaleVo bb=saleService.selectSale(saleVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	
	@RequestMapping(value ="mListSaleData.do")
	public String mListSaleData(HttpServletRequest request, HttpServletResponse response)throws Exception{
		saleService.mListSaleData(response);
		return "home";
	}
	
	
	@RequestMapping(value ="listSaleHistData.do")
	public String listSaleHistData(HttpServletRequest request, HttpServletResponse response,SaleHistSearchVo searchVo,ModelMap model)throws Exception{
		System.out.println("listSaleHistData :"+searchVo);
		try{
			Map map=saleService.listSaleHistData(searchVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listSaleHistData";
	}
	
	
	@RequestMapping(value ="listSalesHistData.do")
	public String listSalesHistData(HttpServletRequest request, HttpServletResponse response,SaleHistSearchVo searchVo,ModelMap model)throws Exception{
		System.out.println("listSalesHistData :"+searchVo);
		try{
			Map map=saleService.listSalesHistData(searchVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listSalesHistData";
	}
	
	
	@RequestMapping(value ="listSalesHistDatatoCsv.do")
	public String listSalesHistDatatoCsv(HttpServletRequest request, HttpServletResponse response,SaleHistSearchVo searchVo,ModelMap model)throws Exception{
		System.out.println("listSalesHistData :"+searchVo);
		try{
			Map map=saleService.listSalesHistDatatoCsv(searchVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listSalesHistCsvData";
	}
	
	@RequestMapping(value ="listPrdctSaleHistData.do")
	public String listPrdctSaleHistData(HttpServletRequest request, HttpServletResponse response,SaleHistSearchVo searchVo,ModelMap model)throws Exception{
		
		try{
			Map map=saleService.listPrdctSaleHistData(searchVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listPrdctSaleHistData";
	}
	
	@RequestMapping(value ="mSaleResult.do")
	public String mSaleResult(HttpServletRequest request, HttpServletResponse response,SaleVo saleVo)throws Exception{
		logger.debug("mSaleResult "+saleVo.toString());
		saleService.modifySale(saleVo);
		return "home";
	}
	
	@RequestMapping(value ="mSaleCallback.do")
	@ResponseBody
	public String mSaleCallBack(HttpServletRequest request, HttpServletResponse response,SaleVo saleVo){
		logger.info("mSaleCallBack "+saleVo.toString());
		try{
		 return saleService.modifySale(saleVo);
		}catch(Exception e){
			logger.info(e.getLocalizedMessage());
			return "0003";
		}
	}
	
	@RequestMapping(value ="mSaleTest.do")
	public String mSaleTest(ModelMap model,HttpServletRequest request, HttpServletResponse response,SaleVo saleVo)throws Exception{
		return "sale/mSaleRedirectSuccess";
	}
	@RequestMapping(value ="mSaleRedirect.do")
	public String mSaleRedirect(ModelMap model,HttpServletRequest request, HttpServletResponse response,SaleVo saleVo)throws Exception{
		logger.info("@@@@@@@@@@@@ cannon @@@@@@@@@@@@ mSaleRedirect :"+saleVo.toString());
		if(saleVo.getVpresult()!=null && saleVo.getVpresult().equals("00"))
		{
			return "sale/mSaleRedirectCancel";
		}
		try{
			saleService.modifySale(saleVo);
		}catch(Exception e){
			e.printStackTrace();
			return "sale/mSaleRedirectFail";
		}
		
		if(saleVo.getCJSResultCode().equals("0")||saleVo.getCJSResultCode().equals("0000")||saleVo.getCJSResultCode().equals("sucess")){
			if(saleVo.getAmountTotal()==null){
				saleVo.setAmountTotal("0");
			}
			if(saleVo.getCJSAmountTotal()==null){
				saleVo.setCJSAmountTotal("0");
			}
			if(!saleVo.getAmountTotal().equals("0")){
				model.put("price", saleVo.getAmountTotal());
			}else{
				model.put("price", saleVo.getCJSAmountTotal());
			}
			return "sale/mSaleRedirectSuccess";
		}else if(saleVo.getCJSResultCode().equals("2005")){
			
			return "sale/mSaleRedirectCancel";
		}else{
			return "sale/mSaleRedirectFail";
		}
	}
	

}
