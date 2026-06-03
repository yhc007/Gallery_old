package com.gallerytalk.mobile.sale.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.servlet.ModelAndView;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.service.CstmrService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;
import com.gallerytalk.mobile.saleJob.service.SaleJobService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

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
	
	@Autowired
	private SaleJobService saleJobService;
	
	@Autowired
	private CstmrService cstmrService;
	
	@RequestMapping(value = "indexSaleForm")
	public ModelAndView indexSaleForm(HttpServletRequest request,ModelMap model,HttpSession session,CstmrVo cstmrVo, StaffVo staffVo, ShopVo shopVo) {
		logger.info("Run indexSaleForm cstmrVo:"+cstmrVo);
		
		shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);

		Integer cstmrId= cstmrVo.getCstmrId();
		try {
			cstmrVo = cstmrService.getCstmrById(cstmrVo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);
		
		logger.info("run indexSaleForm.");
		logger.info("run shopVo:"+shopVo);
		logger.info("run staffVo:"+staffVo);
		logger.info("run cstmrVo:"+cstmrVo);
		
		SaleVo saleVo = new SaleVo();
		saleVo.setCstmrId(cstmrId);
		saleVo.setShopId(shopVo.getShopId());
		
		Integer checkResult;
		SaleVo getSaleId = new SaleVo();
		SaleVo getSale = new SaleVo();
		String dateTime;
		
		SaleJobVo saleJobVo = new SaleJobVo();
		String getJobId;
		
		TimeZone tz;
	    Date today = new Date();
	    //DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss (z Z)");
	    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
	    tz = TimeZone.getTimeZone("Asia/Seoul");
	    df.setTimeZone(tz);
	    saleVo.setDatetime(df.format(today));
	    saleVo.setShopId(shopVo.getShopId());
		
		try{
			//count that result='11111'
			checkResult = saleService.checkSaleCstrm(saleVo);
			logger.info("result:"+checkResult);
			switch (checkResult){
			case 0:
				//change addSale timing to prdct select or eyeCheck.
				
				//getSaleId=saleService.addSaleProcess(saleVo);
				//getSale=saleService.selectSale(getSaleId);
				//saleJobVo.setSaleId(getSaleId.getSaleId());
				//saleJobVo.setStaffId(staffVo.getStaffId());
				//saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
				//getJobId = saleJobService.addSaleJob(saleJobVo);
				
//				dateTime=getSale.getDatetime();
//				dateTime=dateTime.format("%s년%s월%s일", dateTime.substring(0, 4),dateTime.substring(4, 6),dateTime.substring(6, 8));
//				getSale.setDatetime(dateTime);
				//getSale.setDatetime(df.format(today));
				
			    //System.out.println("오늘:"+df.format(date));
			    
				session.setAttribute(CommonCode.ATTR_SALE, saleVo);
				logger.info("@@@@@@@@@@@@@@@@@@@@ get it 6 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				break;

			case 1:
				getSale=saleService.selectSaleForCstmrAndResult(saleVo);
				getSale.setDatetime(df.format(today));
				session.setAttribute(CommonCode.ATTR_SALE, getSale);
				logger.info("@@@@@@@@@@@@@@@@@@@@ get it 7 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				
				break;
				
			default :
				getSale=saleService.selectSaleForCstmrAndResult(saleVo);
				//dateTime=getSale.getDatetime();
				//dateTime=dateTime.format("%s년%s월%s일", dateTime.substring(0, 4),dateTime.substring(4, 6),dateTime.substring(6, 8));
				//getSale.setDatetime(dateTime);
				getSale.setDatetime(df.format(today));
				session.setAttribute(CommonCode.ATTR_SALE, getSale);
				break;
			}
		}catch(Exception e){
			//logger.error(e.getLocalizedMessage());
			e.printStackTrace();
		}
		
		String currentPage = (String)session.getAttribute("currentPage");
		String addr = "";
		if(currentPage.equals("1")||currentPage==null){
			addr = "redirect:/prdct/indexPrdctProcessForm.do";
		}else if(currentPage.equals("2")){
			addr = "redirect:/check/indexCheckEyesForm.do";
		}else if(currentPage.equals("3")){
			addr = "redirect:/prdct/indexPrdctAssemblyForm.do";
		}else if(currentPage.equals("4")){
			addr = "redirect:/prdct/indexPrdctPaymentForm.do";
		}else if(currentPage.equals("5")){
			addr = "redirect:/prdct/indexPrdctDeliveryForm.do";
		}
		return new ModelAndView(addr);
		
	}
	
	@RequestMapping(value = "indexSetFmlyCd")
	public ModelAndView indexFmlyCd(HttpServletRequest request,ModelMap model,HttpSession session,CstmrVo cstmrVo, StaffVo staffVo, ShopVo shopVo) {
		logger.info("Run indexSetFmlyCd cstmrVo1:"+cstmrVo);
		
		shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		
		CstmrVo fmlyCstmrVo = cstmrVo;
		logger.info("Run indexSetFmlyCd cp to fmlyCstmrVo:"+fmlyCstmrVo);
		cstmrVo = (CstmrVo)session.getAttribute(CommonCode.ATTR_CSTMR);
		logger.info("Run indexSetFmlyCd ogn cstmrVo:"+cstmrVo);
		Integer cstmrId= cstmrVo.getCstmrId();
		try {
			cstmrVo = cstmrService.getCstmrById(cstmrVo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		cstmrVo.setFmlyCd(fmlyCstmrVo.getCstmrCd());
		try {
			cstmrService.modifyCstmrFmlyCd(cstmrVo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);
		return new ModelAndView("redirect:/prdct/indexPrdctPaymentForm.do");
	}
	
	@RequestMapping(value = "listPurchased")
	public String listPastPurchased(SaleVo saleVo,ModelMap model,String cstmrId) {
		logger.info("run listPurchased saleVo:"+saleVo);
		try{
			Map map = saleService.listSelectPastPurchased(saleVo);
			Map map2 = saleService.listSelectPastPurchasedNewPrdct(saleVo);
			Map map3 = saleService.listPastPurchasedOld(saleVo);

			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "sale/listPurchased";
	}
	
	@RequestMapping(value = "editSaleDate")
	@ResponseBody
	public String editSaleDate(SaleVo saleVo,ModelMap model,String cstmrId) {
		logger.info("run editSaleDate - saleVo:"+saleVo);
		CheckVo checkVo = new CheckVo();
		checkVo.setHistId(saleVo.getHistId());
		checkVo.setDatetime(saleVo.getDatetime());
		try{
			String result = saleService.modifySaleAndCheckDate(saleVo,checkVo);
			
			return result;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value="getPayCardInfo")
	public String getPayCardInfo(SaleVo saleVo, ModelMap model){
		try {
			Map map = saleService.getPayCardInfo(saleVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/listPayCardData";
	}
	
	@RequestMapping(value = "getSaleMemo")
	@ResponseBody
	public String getSaleMemo(SaleVo saleVo){
		String memo = "";
		try {
			memo = URLEncoder.encode(saleService.getSaleMemo(saleVo),"utf-8");
			memo = memo.replaceAll("\\+", "%20");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memo;
	}
	
	@RequestMapping(value = "saleMemoUpdate")
	@ResponseBody
	public String saleMemoUpdate(SaleVo saleVo){
		String memo = saleVo.getMemo();
		
		logger.info("run saleMemoUpdate memo1:"+memo);
//		try {
//			memo = URLDecoder.decode(memo,"utf-8");
//		} catch (UnsupportedEncodingException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		logger.info("run saleMemoUpdate memo2:"+memo);
		
		try {
			saleService.SaleMemoUpdate(saleVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}
}
