package com.gallerytalk.mobile.cstmrHstry.controller;

import java.net.URLEncoder;
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

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.common.domain.CommonFunction;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmrHstry.domain.CstmrHstryVo;
import com.gallerytalk.mobile.cstmrHstry.service.CstmrHstryService;
import com.gallerytalk.mobile.payment.service.PaymentService;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/cstmrHstry")
@Controller
public class CstmrHstryController {
	
	private static final Logger logger = LoggerFactory.getLogger(CstmrHstryController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private CstmrHstryService cstmrHstryService;
	//@Autowired
	//private BrandService brandService;
	@Autowired
	private SaleService saleService;
	//@Autowired
	//private SaleJobService saleJobService;
	@Autowired
	private PrdctService prdctService;
	
	@Autowired
	private PaymentService paymentService;
	
	
	@RequestMapping(value = "indexCstmrHstryForm.do")
	public String indexCstmrHstryForm(ModelMap model,HttpServletRequest request,HttpSession session) {
		logger.info("run indexCstmrHstryForm");
				
		model.addAttribute("cstmrId", ((CstmrVo)session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId());
		model.addAttribute("histId", ((SaleVo)session.getAttribute(CommonCode.ATTR_SALE)).getHistId());
		model.addAttribute("cstmrName", ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName());
		
		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		logger.info("ATTR getSale"+getSale);

		try {
			getSale = saleService.selectSale(getSale);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("saleVoH", getSale);
		model.addAttribute("shopVoH", shopVo);
		model.addAttribute("staffVoH", staffVo);

		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);

		return "cstmrHstry/indexCstmrHstryForm";
	}
	
	@RequestMapping(value = "listPaymentNew")
	public String listPaymentNew(ModelMap model,HttpServletRequest request, HttpSession session) {
		logger.info("call listPaymentNew");

		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrVo cstmrVo = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR));
		Integer cstmrId = cstmrVo.getCstmrId();
		String cstmrName = cstmrVo.getCstmrName();
		model.addAttribute("cstmrVo", cstmrVo);
		model.addAttribute("cstmrId", cstmrId);
		model.addAttribute("cstmrName", cstmrName);
		model.addAttribute("shopVoH", shopVo);
		model.addAttribute("staffVoH", staffVo);

		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		try {
			saleVo = saleService.selectSale(saleVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info("saleVo:" + saleVo);
		//model.addAttribute("saleVoH", saleVo);
		//model.addAttribute("payCardH", saleVo.getPayCard());
		//model.addAttribute("payCashH", saleVo.getPayCash());

		
		//model = CommonFunction.setButton(saleVo.getResult(), model,CommonCode.ARRAY_PAYMENT);
		return "cstmrHstry/listPaymentNew";
	}
	
	@RequestMapping(value = "listVisitData")
	public String listVisitData(ModelMap model,HttpServletRequest request,CheckVo checkVo,HttpSession session) {
		logger.info("call listVisitData");
		
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrHstryVo cstmrHstryVo = new CstmrHstryVo();
		cstmrHstryVo.setCstmrId(checkVo.getCstmrId());
		try{
			Map map=cstmrHstryService.listVisitData(cstmrHstryVo);
			model.addAllAttributes(map);
			model.addAttribute("staffVoH", staffVo);
			
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "cstmrHstry/listVisitData";
	}
	
	@RequestMapping(value = "listVisitDataForFrame")
	public String listVisitDataForFrame(ModelMap model,HttpServletRequest request,CheckVo checkVo,HttpSession session) {
		logger.info("call listVisitData");
		
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrHstryVo cstmrHstryVo = new CstmrHstryVo();
		cstmrHstryVo.setCstmrId(checkVo.getCstmrId());
		try{
			Map map=cstmrHstryService.listVisitData(cstmrHstryVo);
			model.addAllAttributes(map);
			model.addAttribute("staffVoH", staffVo);
			
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "cstmrHstry/dateFrame";
	}
	
	@RequestMapping(value = "listCstmrInfo")
	public String listCstmrInfo(ModelMap model,HttpServletRequest request,CstmrHstryVo cstmrHstryVo,HttpSession session) {
		logger.info("call listCstmrInfo");
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrVo cstmrVo = new CstmrVo();
		cstmrVo.setCstmrId(cstmrHstryVo.getCstmrId());
		try{
			cstmrVo=cstmrHstryService.getCstmrById(cstmrVo);
			session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);
			//model.addAllAttributes(map);
			//model.addAttribute("staffVo", staffVo);
			model.addAttribute("cstmrVo", cstmrVo);
			
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return "cstmrHstry/listCstmrInfo";
	}
	
	@RequestMapping(value = "listPaymentedPrdctData")
	public String listPaymentedPrdctData(PrdctVo prdctVo, ModelMap model,HttpSession session) throws Exception {

		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);

		saleVo.setSaleId(Integer.parseInt(prdctVo.getSaleId()));

		Map map, map2, map3, map4, map5, map6, map7;

		try {
			map3 = prdctService.listPartnerData();
			
			map2 = cstmrHstryService.getNewPrdct(prdctVo);
			map = cstmrHstryService.listSelectedPrdctData(prdctVo);
			map4 = cstmrHstryService.listSelectedPrdctDataLens(prdctVo);
			map5 = cstmrHstryService.listSelectedPrdctDataClens(prdctVo);
			map6 = cstmrHstryService.listSelectedPrdctDataAcc(prdctVo);
			
			saleVo = saleService.selectSale(saleVo);
			
			map7 = paymentService.selectCardComInfo();

			model.addAttribute("saleVoH", saleVo);
			model.addAttribute("cstmrVo", cstmrVo);

			model.addAttribute("shopVo", shopVo);
			model.addAttribute("staffVo", staffVo);

			
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
			model.addAllAttributes(map6);
			model.addAllAttributes(map7);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "cstmrHstry/listPaymentedPrdctData";
	}
	

	@RequestMapping(value = "getCheckDataForSale")
	@ResponseBody
	public CheckVo getCheckDataForSale(ModelMap model,HttpServletRequest request,HttpSession session) {
		logger.info("call getCheckDataForSale");
		try{
			return cstmrHstryService.selectVisitInfoForSale(session);
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return new CheckVo();
	}
	
	@RequestMapping(value = "getCheckData")
	@ResponseBody
	public CstmrHstryVo getCheckData(ModelMap model,HttpServletRequest request,CstmrHstryVo cstmrHstryVo, HttpSession session) {
		
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		cstmrHstryVo.setCstmrId(cstmrVo.getCstmrId());
		
		try{
			//model.addAttribute("staffVo", staffVo);
			cstmrHstryVo = cstmrHstryService.selectVisitInfo(cstmrHstryVo);
			return cstmrHstryVo; 
		}catch(Exception e){
			logger.error(e.getLocalizedMessage());
		}
		return new CstmrHstryVo();
	}
	
	@RequestMapping(value="getLastData")
	@ResponseBody
	public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo){
		try {
			cstmrHstryVo = cstmrHstryService.getLastData(cstmrHstryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cstmrHstryVo;
	}
	
	@RequestMapping(value = "getCstmrHstryMemo")
	@ResponseBody
	public String getCstmrHstryMemo(CstmrHstryVo cstmrHstryVo){
		String memo = "";
		try {
			memo = URLEncoder.encode(cstmrHstryService.getCstmrhstryMemo(cstmrHstryVo),"utf-8");
			memo = memo.replaceAll("\\+", "%20");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memo;
	}
	
	@RequestMapping(value = "cstmrHstryMemoUpdate")
	@ResponseBody
	public void cstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo){
		try {
			cstmrHstryService.CstmrHstryMemoUpdate(cstmrHstryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
