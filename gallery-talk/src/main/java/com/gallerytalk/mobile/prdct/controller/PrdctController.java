package com.gallerytalk.mobile.prdct.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.common.domain.CommonFunction;
import com.gallerytalk.mobile.coupon.domain.CouponVo;
import com.gallerytalk.mobile.coupon.service.CouponService;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.service.CstmrService;
import com.gallerytalk.mobile.payment.service.PaymentService;
import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.point.service.PointService;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
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
@RequestMapping(value = "/prdct")
@Controller
public class PrdctController {

	private static final Logger logger = LoggerFactory.getLogger(PrdctController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@Autowired
	private PrdctService prdctService;
	@Autowired
	private SaleService saleService;
	@Autowired
	private SaleJobService saleJobService;
	@Autowired
	private CstmrService cstmrService;
	@Autowired
	private StaffService staffService;

	
	@Autowired
	private PaymentService paymentService;

	@Autowired
	private PointService pointService;
	
	@Autowired
	private CouponService couponService;
	
	
	

	@RequestMapping(value = "popupPrdctForm")
	public String popupPrdctForm(ModelMap model, PrdctVo prdctVo) {
		logger.debug("CALL popup ->" + prdctVo);

		try {
			model.addAttribute("prdctVo", prdctService.selectPrdct(prdctVo));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "prdct/popupPrdctForm";
	}

	@RequestMapping(value = "listPrdctData")
	public String listPrdctData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
		logger.debug("listPrdctData " + prdctVo.toString());
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		try {
			prdctVo.setShopId(shopVo.getShopId());
			Map map = prdctService.listPrdctData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "prdct/listPrdctData";
	}

	@RequestMapping(value = "listSelectedPrdctData")
	public String listSelectedPrdctData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
		try {
			SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
			logger.info("run listSelectedPrdctData");
			logger.info("cstmrId:"+prdctVo.getCstmrId());
			logger.info("saleId:"+prdctVo.getSaleId());
			// Map map2 =
			// prdctService.getNewPrdct(saleVo.getSaleId().toString());

			Map map = prdctService.listSelectedPrdctData(prdctVo);
			Map map2 = prdctService.getNewPrdct(prdctVo);
			Map map3 = prdctService.listSelectedPrdctDataLens(prdctVo);
			Map map4 = prdctService.listSelectedPrdctDataClens(prdctVo);
			Map map5 = prdctService.listSelectedPrdctDataAcc(prdctVo);

			logger.info("map : " + map);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "prdct/listSelectedPrdctData";
	}
	
	@RequestMapping(value = "listSelectedPrdctDataPrint")
	public String listSelectedPrdctDataPrint(PrdctVo prdctVo, ModelMap model,
			String cstmrId, HttpSession session) {
		try {
			SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
			// Map map2 =
			// prdctService.getNewPrdct(saleVo.getSaleId().toString());
			Map map2 = prdctService.getNewPrdct(prdctVo);
			Map map = prdctService.listSelectedPrdctData(prdctVo);
			Map map3 = prdctService.listSelectedPrdctDataLens(prdctVo);
			Map map4 = prdctService.listSelectedPrdctDataClens(prdctVo);
			Map map5 = prdctService.listSelectedPrdctDataAcc(prdctVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print/listSelectedPrdctDataPrint";
	}


	@RequestMapping(value = "listPaymentedPrdctData")
	public String listPaymentedPrdctData(PrdctVo prdctVo, ModelMap model,
			HttpSession session) throws Exception {
		logger.info("Run listPaymentPrdctData");
		logger.info("prdctVo:"+prdctVo);

		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);

		Map map, map2, map3, map4, map5, map6, map7;

		try {
			map = prdctService.listSelectedPrdctData(prdctVo);
			map2 = prdctService.getNewPrdct(prdctVo);
			map3 = prdctService.listPartnerData();
			map4 = prdctService.listSelectedPrdctDataLens(prdctVo);
			map5 = prdctService.listSelectedPrdctDataClens(prdctVo);
			map6 = prdctService.listSelectedPrdctDataAcc(prdctVo);
			// map2 = prdctService.getNewPrdct(saleVo.getSaleId().toString());
			
			logger.info("map-prdct:"+map);
			saleVo = saleService.selectSale(saleVo);
			
			map7 = paymentService.selectCardComInfo();

			model.addAttribute("saleVo", saleVo);
			model.addAttribute("cstmrVo", cstmrVo);
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
		return "prdct/listPaymentedPrdctData";
	}

	@RequestMapping(value = "listDeliveredPrdctData")
	public String listDeliveredPrdctData(PrdctVo prdctVo, ModelMap model,HttpSession session) {
		logger.debug("listPrdctData " + prdctVo.toString());
		try {

			SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
			// Map map2 =
			// prdctService.getNewPrdct(saleVo.getSaleId().toString());
			Map map2 = prdctService.getNewPrdct(prdctVo);

			Map map = prdctService.listSelectedPrdctData(prdctVo);

			Map map3 = prdctService.listSelectedPrdctDataLens(prdctVo);
			Map map4 = prdctService.listSelectedPrdctDataClens(prdctVo);
			Map map5 = prdctService.listSelectedPrdctDataAcc(prdctVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "prdct/listDeliveredPrdctData";
	}

	@RequestMapping(value = "listAssembledPrdctData")
	public String listAssembledPrdctData(PrdctVo prdctVo, ModelMap model,
			String cstmrId, HttpSession session) {
		logger.info("run listAssembledPrdctData");
		logger.info("prdctVo:"+prdctVo);
		
		try {

			SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

			Map map = prdctService.listSelectedPrdctData(prdctVo);

			Map map3 = prdctService.listSelectedPrdctDataLens(prdctVo);
			Map map4 = prdctService.listSelectedPrdctDataClens(prdctVo);
			Map map5 = prdctService.listSelectedPrdctDataAcc(prdctVo);
			Map map2 = prdctService.getNewPrdct(prdctVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "prdct/listAssembledPrdctData";
	}

	@RequestMapping(value = "listPaymentData")
	public String listPaymentData(PrdctVo prdctVo, ModelMap model,
			String cstmrId, HttpSession session) {
		logger.debug("listPaymentData " + prdctVo.toString());
		logger.info("run listPaymentData");
		logger.info("prdctVo:"+prdctVo);

		System.out.println("listSelectedPrdctData cstmrId=" + cstmrId);
		try {
			SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
			// Map map2 =
			// prdctService.getNewPrdct(saleVo.getSaleId().toString());
			Map map2 = prdctService.getNewPrdct(prdctVo);
			Map map = prdctService.listSelectedPrdctData(prdctVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "prdct/listPaymentData";
	}

	@RequestMapping(value = "popupSelectPrdctForm.do")
	public String popupSelectPrdctForm(PrdctVo prdctVo) throws Exception {
		return "prdct/popupSelectPrdctForm";
	}

	@RequestMapping(value = "getPrdctData.do")
	@ResponseBody
	public PrdctVo getCstmrData(PrdctVo prdctVo) throws Exception {
		PrdctVo bb = prdctService.selectPrdct(prdctVo);
		logger.debug(bb.toString());
		return bb;
	}

	@RequestMapping(value = "updateAssemblyCheck.do")
	@ResponseBody
	public String updateAssemblyCheck(PrdctVo prdctVo, HttpSession session)
			throws Exception {
		
		logger.info("Run updateAssemblyCheck.do");
		
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

		String checkPrdctId = prdctVo.getListCheckedPrdctId();
		String unCheckPrdctId = prdctVo.getListUnCheckedPrdctId();

		String checkPrdctIdNew = prdctVo.getListCheckedPrdctIdNew();
		String unCheckPrdctIdNew = prdctVo.getListUnCheckedPrdctIdNew();


		String checkInformId = prdctVo.getListInformPrdctId();
		String checkUnInformId = prdctVo.getListUnInformPrdctId();

		String checkInformIdNew = prdctVo.getListInformPrdctIdNew();
		String checkUnInformIdNew = prdctVo.getListUnInformPrdctIdNew();


		logger.info("checkPrdctId:" + checkPrdctId);
		logger.info("unCheckPrdctId:" + unCheckPrdctId);
		logger.info("checkPrdctIdNew:" + checkPrdctIdNew);
		logger.info("unCheckPrdctIdNew:" + unCheckPrdctIdNew);

		logger.info("new inform : " + checkUnInformIdNew);

		String delim = "[,]";
		String[] listCheckedPrdctId;
		String[] listUnCheckedPrdctId;
		String[] listCheckedPrdctIdNew;
		String[] listUnCheckedPrdctIdNew;


		String[] listInformPrdctId;
		String[] listUnInformPrdctId;
		String[] listInformPrdctIdNew;
		String[] listUnInformPrdctIdNew;

		SaleJobVo saleJobVo = new SaleJobVo();
		SalePrdctVo salePrdctVo = new SalePrdctVo();
		if (!checkInformId.isEmpty()) {
			listInformPrdctId = checkInformId.split(delim);
			System.out.println("listInformPrdctId" + listInformPrdctId.length);
			for (int i = 0, length = listInformPrdctId.length; i < length; i++) {
				salePrdctVo.setPrdctId(Integer.parseInt(listInformPrdctId[i]));
				salePrdctVo.setSaleId(saleVo.getSaleId());
				salePrdctVo
						.setInform(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_YES);
				System.out.println("infom : " + salePrdctVo.getInform());
				prdctService.modifyInformPrdctOff(salePrdctVo);
			}
		}

		if (!checkUnInformId.isEmpty()) {
			listUnInformPrdctId = checkUnInformId.split(delim);
			System.out.println("listUnInformPrdctId"
					+ listUnInformPrdctId.length);
			for (int i = 0, length = listUnInformPrdctId.length; i < length; i++) {

				salePrdctVo
						.setPrdctId(Integer.parseInt(listUnInformPrdctId[i]));
				salePrdctVo.setSaleId(saleVo.getSaleId());
				salePrdctVo
						.setInform(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_NO);
				System.out.println("inform : " + salePrdctVo.getInform());
				prdctService.modifyInformPrdctOff(salePrdctVo);
			}
		}

		if (!checkInformIdNew.isEmpty()) {

			listInformPrdctIdNew = checkInformIdNew.split(delim);
			for (int i = 0, length = listInformPrdctIdNew.length; i < length; i++) {
				System.out.println("@@@");
				salePrdctVo.setPrdctId(Integer.parseInt(listInformPrdctIdNew[i]));
				salePrdctVo.setSaleId(saleVo.getSaleId());
				salePrdctVo.setInform(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_YES);
				prdctService.modifyInformPrdctOffNew(salePrdctVo);
			}
		}

		if (!checkUnInformIdNew.isEmpty()) {
			listUnInformPrdctIdNew = checkUnInformIdNew.split(delim);
			for (int i = 0, length = listUnInformPrdctIdNew.length; i < length; i++) {
				System.out.println("###");
				salePrdctVo.setPrdctId(Integer.parseInt(listUnInformPrdctIdNew[i]));
				salePrdctVo.setSaleId(saleVo.getSaleId());
				salePrdctVo.setInform(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_NO);
				prdctService.modifyInformPrdctOffNew(salePrdctVo);
			}
		}


		try {
			if (!checkPrdctId.isEmpty()) {
				listCheckedPrdctId = checkPrdctId.split(delim);
				for (int i = 0, length = listCheckedPrdctId.length; i < length; i++) {
					salePrdctVo.setPrdctId(Integer
							.parseInt(listCheckedPrdctId[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setAsmbly(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_YES);
					System.out.println("asmbly : " + salePrdctVo.getAsmbly());
					prdctService.modifyAsmblySalePrdctOff(salePrdctVo);

					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					saleJobVo.setPrdctId(Integer
							.parseInt(listCheckedPrdctId[i]));
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_ASSEMBLY);
					saleJobVo.setActionTy(Character
							.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));
					saleJobService.addSaleJob(saleJobVo);
				}
			}
			if (!unCheckPrdctId.isEmpty()) {
				listUnCheckedPrdctId = unCheckPrdctId.split(delim);
				for (int i = 0, length = listUnCheckedPrdctId.length; i < length; i++) {
					salePrdctVo.setPrdctId(Integer
							.parseInt(listUnCheckedPrdctId[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setAsmbly(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_NO);
					prdctService.modifyAsmblySalePrdctOff(salePrdctVo);

					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					saleJobVo.setPrdctId(Integer
							.parseInt(listUnCheckedPrdctId[i]));
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_ASSEMBLY);
					saleJobVo
							.setActionTy(Character
									.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));
					saleJobService.addSaleJob(saleJobVo);
				}
			}
			if (!checkPrdctIdNew.isEmpty()) {
				listCheckedPrdctIdNew = checkPrdctIdNew.split(delim);
				for (int i = 0, length = listCheckedPrdctIdNew.length; i < length; i++) {
					logger.info(i + "번째.check. prdctName:"
							+ listCheckedPrdctIdNew[i]);
					;
					salePrdctVo.setPrdctId(Integer.parseInt(listCheckedPrdctIdNew[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setAsmbly(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_YES);
					prdctService.modifyAsmblySaleNewPrdctOff(salePrdctVo);
					System.out.println("new asmbly : "
							+ salePrdctVo.getAsmbly());
					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					//saleJobVo.setPrdctId(null);
					saleJobVo.setPrdctName(listCheckedPrdctIdNew[i]);
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_ASSEMBLY);
					saleJobVo.setActionTy(Character
							.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));
					saleJobService.addSaleJob(saleJobVo);
				}
			}
			if (!unCheckPrdctIdNew.isEmpty()) {
				listUnCheckedPrdctIdNew = unCheckPrdctIdNew.split(delim);
				for (int i = 0, length = listUnCheckedPrdctIdNew.length; i < length; i++) {
					logger.info(i + "번째.unchecked prdctName:"
							+ listUnCheckedPrdctIdNew[i]);
					;
					salePrdctVo.setPrdctId(Integer.parseInt(listUnCheckedPrdctIdNew[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setAsmbly(CommonCode.CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_NO);
					System.out.println("new asmbly : "
							+ salePrdctVo.getAsmbly());
					prdctService.modifyAsmblySaleNewPrdctOff(salePrdctVo);

					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					//saleJobVo.setPrdctId(null);
					saleJobVo.setPrdctName(listUnCheckedPrdctIdNew[i]);
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_ASSEMBLY);
					saleJobVo
							.setActionTy(Character
									.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));
					saleJobService.addSaleJob(saleJobVo);
				}
			}
			salePrdctVo.setSaleId(saleVo.getSaleId());
			if ("ok" == prdctService.checkAssemblySaleId(salePrdctVo)) {
				saleVo.setResult(saleService.modifyResult(saleVo,
						CommonCode.ARRAY_ASSEMBLY, CommonCode.COMPLETED));
			} else {
				saleVo.setResult(saleService.modifyResult(saleVo,
						CommonCode.ARRAY_ASSEMBLY, CommonCode.INCOMPLETED));
			}
			
			
			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";

	}

	@RequestMapping(value = "updateDeliveryCheck.do")
	@ResponseBody
	public String updateDeliveryCheck(PrdctVo prdctVo, HttpSession session ) throws Exception {
		logger.info("run updateDeliveryCheck - prdctVo : "+prdctVo);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		
		String checkPrdctId = prdctVo.getListCheckedPrdctId();
		String unCheckPrdctId = prdctVo.getListUnCheckedPrdctId();
		String checkPrdctIdNew = prdctVo.getListCheckedPrdctIdNew();
		String unCheckPrdctIdNew = prdctVo.getListUnCheckedPrdctIdNew();

		logger.info("checkPrdctId:" + checkPrdctId);
		logger.info("unCheckPrdctId:" + unCheckPrdctId);
		logger.info("checkPrdctIdNew:" + checkPrdctIdNew);
		logger.info("unCheckPrdctIdNew:" + unCheckPrdctIdNew);
		
		logger.info("saleVo:"+saleVo);
		logger.info("staffVo:"+staffVo);
		logger.info("shopVo:"+shopVo);

		String delim = "[,]";
		String[] listCheckedPrdctId;
		String[] listUnCheckedPrdctId;
		String[] listCheckedPrdctIdNew;
		String[] listUnCheckedPrdctIdNew;

		SalePrdctVo salePrdctVo = new SalePrdctVo();
		SaleJobVo saleJobVo = new SaleJobVo();
		salePrdctVo.setSaleId(saleVo.getSaleId());

		try {
			if (!checkPrdctId.isEmpty()) {
				listCheckedPrdctId = checkPrdctId.split(delim);
				for (int i = 0, length = listCheckedPrdctId.length; i < length; i++) {
					if('F'==listCheckedPrdctId[i].charAt(0)){
						salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_FRAME);
						listCheckedPrdctId[i]=listCheckedPrdctId[i].replaceFirst("F","");
					}else if('L'==listCheckedPrdctId[i].charAt(0)){
						salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_LENS);
						listCheckedPrdctId[i]=listCheckedPrdctId[i].replaceFirst("L","");
					}else if('C'==listCheckedPrdctId[i].charAt(0)){
						salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_CLENS);
						listCheckedPrdctId[i]=listCheckedPrdctId[i].replaceFirst("C","");
					}else if('A'==listCheckedPrdctId[i].charAt(0)){
						salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_ACC);
						listCheckedPrdctId[i]=listCheckedPrdctId[i].replaceFirst("A","");
					}
					
					salePrdctVo.setPrdctId(Integer.parseInt(listCheckedPrdctId[i]));

					if(prdctService.checkDeliverySaleIdEachType(salePrdctVo).equals("no")){
						salePrdctVo.setPrdctId(Integer.parseInt(listCheckedPrdctId[i]));
						salePrdctVo.setSaleId(saleVo.getSaleId());
						salePrdctVo.setDlvry(CommonCode.CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_YES);
						salePrdctVo.setShopId(shopVo.getShopId());
						salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_ADD);
						
						saleJobVo.setSaleId(saleVo.getSaleId());
						saleJobVo.setStaffId(staffVo.getStaffId());
						saleJobVo.setPrdctId(Integer.parseInt(listCheckedPrdctId[i]));
						saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_DELIVERY);
						saleJobVo.setActionTy(Character.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));
						
						saleService.decCntInvn(salePrdctVo);
						saleService.addInvnHist(salePrdctVo);
						prdctService.modifyDlvrySalePrdctOff(salePrdctVo);
						saleJobService.addSaleJob(saleJobVo);
						
					}//duple.
					else{
						logger.info("prdct is checked");
						continue;
					}
					
				}
			}
			if (!unCheckPrdctId.isEmpty()) {
					listUnCheckedPrdctId = unCheckPrdctId.split(delim);
					for (int i = 0, length = listUnCheckedPrdctId.length; i < length; i++) {
						if('F'==listUnCheckedPrdctId[i].charAt(0)){
							salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_FRAME);
							listUnCheckedPrdctId[i]=listUnCheckedPrdctId[i].replaceFirst("F","");
						}else if('L'==listUnCheckedPrdctId[i].charAt(0)){
							salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_LENS);
							listUnCheckedPrdctId[i]=listUnCheckedPrdctId[i].replaceFirst("L","");
						}else if('C'==listUnCheckedPrdctId[i].charAt(0)){
							salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_CLENS);
							listUnCheckedPrdctId[i]=listUnCheckedPrdctId[i].replaceFirst("C","");
						}else if('A'==listUnCheckedPrdctId[i].charAt(0)){
							salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_ACC);
							listUnCheckedPrdctId[i]=listUnCheckedPrdctId[i].replaceFirst("A","");
						}
						salePrdctVo.setPrdctId(Integer.parseInt(listUnCheckedPrdctId[i]));
						//get last check status.
						if(prdctService.checkDeliverySaleIdEachType(salePrdctVo).equals("yes")){
							salePrdctVo.setPrdctId(Integer.parseInt(listUnCheckedPrdctId[i]));
							salePrdctVo.setSaleId(saleVo.getSaleId());
							salePrdctVo.setDlvry(CommonCode.CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_NO);
							salePrdctVo.setShopId(shopVo.getShopId());
							salePrdctVo.setShopId(shopVo.getShopId());
							salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_ADD);
							
							saleService.incCntInvn(salePrdctVo);
							saleService.addInvnHist(salePrdctVo);
							prdctService.modifyDlvrySalePrdctOff(salePrdctVo);
							
							saleJobVo.setSaleId(saleVo.getSaleId());
							saleJobVo.setStaffId(staffVo.getStaffId());
							saleJobVo.setPrdctId(Integer.parseInt(listUnCheckedPrdctId[i]));
							saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_DELIVERY);
							saleJobVo.setActionTy(Character.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));
							saleJobService.addSaleJob(saleJobVo);
						}//duple.
						else{
							logger.info("prdct is unchecked");
							continue;
						}
					}
				}
			//Important.
			saleVo.setShopId(shopVo.getShopId());
			//calcInvn(saleVo,false);

			logger.info("checkPrdctIdNew:"+checkPrdctIdNew);
			if (!checkPrdctIdNew.isEmpty()) {
				logger.info("Run checkPrdctIdNew:"+checkPrdctIdNew);
				listCheckedPrdctIdNew = checkPrdctIdNew.split(delim);
				for (int i = 0, length = listCheckedPrdctIdNew.length; i < length; i++) {
					logger.info(i + "번째.check. prdctName:"
							+ listCheckedPrdctIdNew[i]);

					salePrdctVo.setPrdctId(Integer.parseInt(listCheckedPrdctIdNew[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setDlvry(CommonCode.CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_YES);
					prdctService.modifyDlvrySaleNewPrdctOff(salePrdctVo);

					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					//saleJobVo.setPrdctId(null);
					saleJobVo.setPrdctName(listCheckedPrdctIdNew[i]);
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_DELIVERY);
					saleJobVo.setActionTy(Character
							.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));
					saleJobService.addSaleJob(saleJobVo);
				}
			}
			logger.info("unCheckPrdctIdNew:"+unCheckPrdctIdNew);
			if (!unCheckPrdctIdNew.isEmpty()) {
				logger.info("run unCheckPrdctIdNew case:"+unCheckPrdctIdNew);
				listUnCheckedPrdctIdNew = unCheckPrdctIdNew.split(delim);
				for (int i = 0, length = listUnCheckedPrdctIdNew.length; i < length; i++) {
					logger.info(i + "번째.unchecked prdctName:"
							+ listUnCheckedPrdctIdNew[i]);

					salePrdctVo.setPrdctId(Integer.parseInt(listUnCheckedPrdctIdNew[i]));
					salePrdctVo.setSaleId(saleVo.getSaleId());
					salePrdctVo
							.setDlvry(CommonCode.CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_NO);
					logger.info("new asmbly : "
							+ salePrdctVo.getAsmbly());
					prdctService.modifyDlvrySaleNewPrdctOff(salePrdctVo);

					saleJobVo.setSaleId(saleVo.getSaleId());
					saleJobVo.setStaffId(staffVo.getStaffId());
					//saleJobVo.setPrdctId(null);
					saleJobVo.setPrdctName(listUnCheckedPrdctIdNew[i]);
					saleJobVo
							.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_DELIVERY);
					saleJobVo
							.setActionTy(Character
									.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));
					saleJobService.addSaleJob(saleJobVo);
				}
			}

			salePrdctVo.setSaleId(saleVo.getSaleId());
			if ("ok" == prdctService.checkDeliverySaleId(salePrdctVo)) {
				saleVo.setResult(saleService.modifyResult(saleVo,
						CommonCode.ARRAY_DELIVERY, CommonCode.COMPLETED));
			} else {
				saleVo.setResult(saleService.modifyResult(saleVo,
						CommonCode.ARRAY_DELIVERY, CommonCode.INCOMPLETED));
			}
			saleVo = saleService.selectSale(saleVo);
			
			salePrdctVo.setSaleId(saleVo.getSaleId());
			if ("ok" == prdctService.checkDeliverySaleId(salePrdctVo)) {
				saleVo.setResult(saleService.modifyResult(saleVo, CommonCode.ARRAY_DELIVERY, CommonCode.COMPLETED));
			} else {
				saleVo.setResult(saleService.modifyResult(saleVo,CommonCode.ARRAY_DELIVERY, CommonCode.INCOMPLETED));
			}
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "updatePayment.do")
	@ResponseBody
	public String updatePayment(SaleJobVo saleJobVo, HttpSession session) throws Exception {

		logger.info("run updatePayment");
		logger.info("saleJobVo:" + saleJobVo);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);

		SalePrdctVo salePrdctVo = new SalePrdctVo();
		salePrdctVo.setSaleId(saleVo.getSaleId());

		// strPrdctId=,18,260, strPrdctDscnt=,11,10, strPrdctEarn=,11,0,
		// strPrdctIdNew=,12,13, strPrdctDscntNew=,11,15,
		// strPrdctEarnNew=,11,10)

		// need DscntPrdct, earnPrdct, saleId, prdctId
		// prdctService.modifyDscntEarnSalePrdctOff(salePrdctVo);

		// for(int i=0,)
		// salePrdctVo.setDscnt(saleJobVo.getPartnerDscnt());
		try {
			salePrdctVo.setSaleId(saleVo.getSaleId());
			String[] arrPrdctId = saleJobVo.getStrPrdctId().split(",");
			String[] arrPrdctDscnt = saleJobVo.getStrPrdctDscnt().split(",");
			String[] arrPrdctEarn = saleJobVo.getStrPrdctEarn().split(",");
			String[] arrPrdctUsing = saleJobVo.getStrPrdctUsing().split(",");

			logger.info("arrPrdctId[0]:"+arrPrdctId[0]);
			for (int i = 0, size = arrPrdctId.length; i < size; i++) {
				if (arrPrdctId[i].isEmpty()) {
					break;
				}
				salePrdctVo.setDscntPrcnt(Integer.parseInt(arrPrdctDscnt[i]));
				salePrdctVo.setEarnPrcnt(Integer.parseInt(arrPrdctEarn[i]));
				salePrdctVo.setUsingPoint(Integer.parseInt(arrPrdctUsing[i]));

				if('F'==arrPrdctId[i].charAt(0)){
					salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_FRAME);
					arrPrdctId[i]=arrPrdctId[i].replaceFirst("F","");
					salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctId[i]));
					prdctService.modifyDscntEarnSalePrdctOff(salePrdctVo);
				}else if('L'==arrPrdctId[i].charAt(0)){
					salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_LENS);
					arrPrdctId[i]=arrPrdctId[i].replaceFirst("L","");
					salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctId[i]));
					prdctService.modifyDscntEarnSalePrdctOff(salePrdctVo);
				}else if('C'==arrPrdctId[i].charAt(0)){
					salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_CLENS);
					arrPrdctId[i]=arrPrdctId[i].replaceFirst("C","");
					salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctId[i]));
					prdctService.modifyDscntEarnSalePrdctOff(salePrdctVo);
				}else if('A'==arrPrdctId[i].charAt(0)){
					salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_ACC);
					arrPrdctId[i]=arrPrdctId[i].replaceFirst("A","");
					salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctId[i]));
					prdctService.modifyDscntEarnSalePrdctOff(salePrdctVo);
				}else if('N'==arrPrdctId[i].charAt(0)){
					//salePrdctVo.setItemTy(CommonCode.NUMBER_PRDCT_TY_ACC);
					arrPrdctId[i]=arrPrdctId[i].replaceFirst("N","");
					salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctId[i]));
					prdctService.modifyDscntEarnNewPrdct(salePrdctVo);
				}
				if (arrPrdctId[i].equals("")) {
					break;
				}
			}

//			String[] arrPrdctIdNew = saleJobVo.getStrPrdctIdNew().split(",");
//			String[] arrPrdctDscntNew = saleJobVo.getStrPrdctDscntNew().split(",");
//			String[] arrPrdctEarnNew = saleJobVo.getStrPrdctEarnNew().split(",");
//
//			for (int i = 0, size = arrPrdctId.length; i < size; i++) {
//				logger.info("arrPrdctIdNew[" + i + "]" + arrPrdctIdNew[i]);
//				logger.info("arrPrdctDscntNew[" + i + "]" + arrPrdctDscntNew[i]);
//				logger.info("arrPrdctEarnNew[" + i + "]" + arrPrdctEarnNew[i]);
//
//				if (arrPrdctIdNew[i].equals("")) {
//					break;
//				}
//
//				salePrdctVo.setPrdctId(Integer.parseInt(arrPrdctIdNew[i]));
//				salePrdctVo
//						.setDscntPrcnt(Integer.parseInt(arrPrdctDscntNew[i]));
//				salePrdctVo.setEarnPrcnt(Integer.parseInt(arrPrdctEarnNew[i]));
//				prdctService.modifyDscntEarnNewPrdct(salePrdctVo);
//			}

			PointVo pointVo = new PointVo();
			pointVo.setSaleId(saleVo.getSaleId());
			pointVo.setCstmrCd(cstmrVo.getCstmrCd());
			pointVo.setFmlyCd(saleJobVo.getFmlyCd());
			pointVo.setShopId(shopVo.getShopId());
			Date now = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
			pointVo.setDateTime(format.format(now));

			int mPoint= saleJobVo.getPayPoint() / 100 ;
			logger.info("pointVo Minus:" + mPoint);
			if(mPoint != 0){
				pointVo.setPoint(mPoint);
				pointVo.setPointStatus(CommonCode.POINT_STATUS_MINUS);
				
				pointService.addPointHist(pointVo);
			}
			
			int pPoint= saleJobVo.getEarnPoint() / 100 ;
			logger.info("pointVo Plus:" + pPoint);
			if(pPoint != 0){
				pointVo.setPoint(pPoint);
				pointVo.setPointStatus(CommonCode.POINT_STATUS_PLUS);
				pointService.addPointHist(pointVo);
			}
			
			logger.info("saleVo : " + saleVo);
			
			saleVo.setPayCard(saleJobVo.getPayCard());
			saleVo.setPayCash(saleJobVo.getPayCash());
			saleVo.setPayPoint(saleJobVo.getPayPoint());
			saleVo.setPartnerDscnt(saleJobVo.getPartnerDscnt());
			saleVo.setPartnerId(saleJobVo.getPartnerId());
			logger.info("PartnerId:" + saleJobVo.getPartnerId());
			saleVo.setDscntPrice(saleJobVo.getDscntPrice());
			saleVo.setEtcDscnt(saleJobVo.getEtcDscnt());
			saleVo.setEtcDscntMemo(saleJobVo.getEtcDscntMemo());
			saleVo.setEarnPrcnt(saleJobVo.getEarnPrcnt());
			saleVo.setCardTy(saleJobVo.getCardTy());
			saleVo.setCardDate(saleJobVo.getCardDate());

			logger.info("saleVo before update." + saleVo);
			if (Integer.parseInt(saleJobVo.getPennyPrice()) == 0) {
				saleService.modifyResultPayPrc(saleVo,
						CommonCode.ARRAY_PAYMENT, CommonCode.COMPLETED);
			} else {
				saleService.modifyResultPayPrc(saleVo,
						CommonCode.ARRAY_PAYMENT, CommonCode.INCOMPLETED);
			}

			saleJobVo.setSaleId(saleVo.getSaleId());
			saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_PAYMENT);
			saleJobVo.setDatetime(saleJobVo.getDateTile());
			saleJobVo.setStaffId(staffVo.getStaffId());

			logger.info("Before addSleJob saleJobVo : " + saleJobVo);
			saleJobService.addSaleJob(saleJobVo);

			cstmrVo.setFmlyCd(saleJobVo.getFmlyCd());
			logger.info("Before cstmrVo" + cstmrVo);
			cstmrService.modifyCstmrFmlyCd(cstmrVo);
			CouponVo couponVo = new CouponVo();
			couponVo.setCstmrCd(cstmrVo.getCstmrCd());
			
			String checkCoupon = couponService.checkBirthCoupon(couponVo);
			if(saleJobVo.getChkUseCoupon() == 1 &&checkCoupon.equals("duple"))
			{
				couponVo.setCouponCd(saleJobVo.getCouponCd());
				couponVo.setShopNum(shopVo.getShopNum());
				Date now1 = new Date();
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				
				couponVo.setUsingDate(format1.format(now1));
				couponVo.setWMemo(staffVo.getStaffName()+"-("+cstmrVo.getCstmrCd()+")");
				logger.info("before update couponVo:"+couponVo);
				couponService.modifyBirthCoupon(couponVo);
			}
			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "addSalePrdct.do")
	@ResponseBody
	public String addSalePrdct(SalePrdctVo salePrdctVo, HttpSession session) {

		logger.info("Run addPrdct salePrdctVo:" + salePrdctVo);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		//if disconnected session, makes error.
		//
		saleVo.setShopId(shopVo.getShopId());
		saleVo.setCstmrId(cstmrVo.getCstmrId());
		String dateTile = salePrdctVo.getDateTile(); 
		
		SaleJobVo saleJobVo = new SaleJobVo();
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
		logger.info("saleVo2:"+saleVo);
		
		saleJobVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setStaffId(staffVo.getStaffId());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
		try {
			saleJobService.addSaleJob(saleJobVo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		salePrdctVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setDatetime(dateTile);
		saleJobVo.setSaleId(salePrdctVo.getSaleId());
		saleJobVo.setStaffId(staffVo.getStaffId());
		saleJobVo.setPrdctName(salePrdctVo.getPrdctName());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
		saleJobVo.setActionTy(Character.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));

		String result;
		try {
			result = prdctService.checkSalePrdctCount(salePrdctVo);
			if (result.equals("ok")) {
				logger.info("case OK");

				prdctService.addSalePrdct(salePrdctVo);
				saleJobService.addSaleJob(saleJobVo);
				logger.info("before modifyResultOgnPrc saleVo :"+saleVo);
				logger.info("before modifyResultOgnPrc prc*cnt = "+salePrdctVo.getPrc() * salePrdctVo.getPrdctCnt());
				saleVo.setResult(saleService.modifyResultOgnPrc(saleVo,
						CommonCode.ARRAY_SELECT, CommonCode.COMPLETED,
						salePrdctVo.getPrc() * salePrdctVo.getPrdctCnt(), true));
				session.setAttribute(CommonCode.ATTR_SALE, saleVo);

				return "success";
			} else if (result.equals("duple")) {
				salePrdctVo = prdctService.getSalePrdct(salePrdctVo);
				incCntSalePrdct(salePrdctVo, session);
				return "success";
			} else {
				logger.error("result Value Error!");
			}

			salePrdctVo = prdctService.getSalePrdct(salePrdctVo);
			logger.info(" cannon " + salePrdctVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "addSalePrdctNew.do")
	@ResponseBody
	public String addSalePrdctNew(SalePrdctVo salePrdctVo, HttpSession session) {

		logger.info("Run addPrdctNew salePrdctVo:" + salePrdctVo);

		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);

		SaleJobVo saleJobVo = new SaleJobVo();
		//if session disconnected, make error.
		

		String dateTile = salePrdctVo.getDateTile(); 
		//make new sale
		if(saleVo.getSaleId() == null){
			saleVo.setResult(CommonCode.RESULT_INIT);
			saleVo.setDatetime(dateTile);
			try {
				saleVo.setShopId(shopVo.getShopId());
				saleVo.setCstmrId(cstmrVo.getCstmrId());
				if(0 == saleService.checkSaleCstrm(saleVo)){
					saleVo=saleService.addSaleProcess(saleVo);
					saleVo.setResult(CommonCode.RESULT_INIT);
					session.setAttribute(CommonCode.ATTR_SALE, saleVo);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "fail";
			}
		}
		logger.info("saleVo2:"+saleVo);
		
		salePrdctVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setSaleId(salePrdctVo.getSaleId());
		saleJobVo.setStaffId(staffVo.getStaffId());
		saleJobVo.setPrdctName(salePrdctVo.getPrdctName());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
		saleJobVo.setActionTy(Character.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_ADD));

		try {
			logger.info("case OK");

			prdctService.addSalePrdctNew(salePrdctVo);
			saleJobService.addSaleJob(saleJobVo);

			saleVo.setResult(saleService.modifyResultOgnPrc(saleVo,
					CommonCode.ARRAY_SELECT, CommonCode.COMPLETED,
					salePrdctVo.getPrc(), true));

			session.setAttribute(CommonCode.ATTR_SALE, saleVo);

			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
			return "fail";
		}
		//return "fail";
	}

	@RequestMapping(value = "checkSalePrdctCount.do")
	@ResponseBody
	public String checkSalePrdctCount(SalePrdctVo salePrdctVo) {
		try {
			return prdctService.checkSalePrdctCount(salePrdctVo);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "removeSalePrdct.do")
	@ResponseBody
	public String removeSalePrdct(SalePrdctVo salePrdctVo, HttpSession session) {

		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

		salePrdctVo.setSaleId(saleVo.getSaleId());
		try {
			salePrdctVo = saleService.selectSalePrdctOff(salePrdctVo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			logger.error(e1.getLocalizedMessage());
		}

		SaleJobVo saleJobVo = new SaleJobVo();
		saleJobVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setStaffId(staffVo.getStaffId());
		//saleJobVo.setPrdctId(salePrdctVo.getSaleId());
		saleJobVo.setPrdctId(salePrdctVo.getPrdctId());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
		saleJobVo.setActionTy(Character
				.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));

		logger.info("salePrdctVo1:" + salePrdctVo);
		try {
			prdctService.removeSalePrdct(salePrdctVo);
			saleJobService.addSaleJob(saleJobVo);

			logger.info("salePrdctVo2:" + salePrdctVo);
			// selected prdct is none, change result code to '0'
			String checkResult = prdctService
					.checkSalePrdctSaleIdCount(salePrdctVo);
			// if(prdctService.checkSalePrdctCount(salePrdctVo).equals("ok"))
			logger.info("checkResult:" + checkResult);
			logger.info("salePrdctVo3:" + salePrdctVo);
			if (checkResult.equals("ok")) {
				saleVo.setResult(saleService
						.modifyResultOgnPrc(saleVo, CommonCode.ARRAY_SELECT,
								CommonCode.INCOMPLETED, salePrdctVo.getPrc()
										* salePrdctVo.getPrdctCnt(), false));
			} else {
				saleVo.setResult(saleService
						.modifyResultOgnPrc(saleVo, CommonCode.ARRAY_SELECT,
								CommonCode.COMPLETED, salePrdctVo.getPrc()
										* salePrdctVo.getPrdctCnt(), false));
			}
			logger.info("@@@@@@@@@@@@@@@@@@@@ get it 4 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			session.setAttribute(CommonCode.ATTR_SALE, saleVo);
			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "removeNewSalePrdct.do")
	@ResponseBody
	public String removeNewSalePrdct(SalePrdctVo salePrdctVo,
			HttpSession session) {
		
		logger.info("Run removeNewSalePrdct.do.... salePrdctVo : "+salePrdctVo);

		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

		salePrdctVo.setSaleId(saleVo.getSaleId());
//		try {
//			salePrdctVo = saleService.selectNewSalePrdctOff(salePrdctVo);
//		} catch (Exception e1) {
//			System.out.println("selectVo" + salePrdctVo.toString());
//			// TODO Auto-generated catch block
//			logger.error(e1.getLocalizedMessage());
//		}

		SaleJobVo saleJobVo = new SaleJobVo();
		saleJobVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setStaffId(staffVo.getStaffId());
		saleJobVo.setPrdctId(salePrdctVo.getPrdctId());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_SELECT);
		saleJobVo.setActionTy(Character
				.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_REMOVE));

		logger.info("salePrdctVo1:" + salePrdctVo);
		try {
			prdctService.removeNewSalePrdct(salePrdctVo);
			saleJobService.addSaleJob(saleJobVo);

			logger.info("salePrdctVo2:" + salePrdctVo);
			// selected prdct is none, change result code to '0'
			String checkResult = prdctService
					.checkNewSalePrdctSaleIdCount(salePrdctVo);
			// if(prdctService.checkSalePrdctCount(salePrdctVo).equals("ok"))
			logger.info("checkResult:" + checkResult);

			logger.info("salePrdctVo3:" + salePrdctVo);
			if (checkResult.equals("ok")) {
				saleVo.setResult(saleService
						.modifyResultOgnPrc(saleVo, CommonCode.ARRAY_SELECT,
								CommonCode.INCOMPLETED, salePrdctVo.getPrc()
										* salePrdctVo.getPrdctCnt(), false));
			} else {
				saleVo.setResult(saleService
						.modifyResultOgnPrc(saleVo, CommonCode.ARRAY_SELECT,
								CommonCode.COMPLETED, salePrdctVo.getPrc()
										* salePrdctVo.getPrdctCnt(), false));
			}
			logger.info("@@@@@@@@@@@@@@@@@@@@ get it 5 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			session.setAttribute(CommonCode.ATTR_SALE, saleVo);
			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "incCntSalePrdct.do")
	@ResponseBody
	public String incCntSalePrdct(SalePrdctVo salePrdctVo, HttpSession session) {

		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		logger.info("Run incCntSalePrdct salePrdctVo:" + salePrdctVo);
		logger.info("Run incCntSalePrdct saleVo:" + saleVo);

		salePrdctVo.setSaleId(saleVo.getSaleId());
		String result;
		Integer prc;
		prc = salePrdctVo.getPrc();

		try {
			prdctService.incCntSalePrdctOff(salePrdctVo);
			result = saleService.modifyResultOgnPrc(saleVo,
					CommonCode.ARRAY_SELECT, CommonCode.COMPLETED, prc, true);
			saleVo.setResult(result);

			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "decCntSalePrdct.do")
	@ResponseBody
	public String decCntSalePrdct(SalePrdctVo salePrdctVo, HttpSession session) {

		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		logger.info("Run decCntSalePrdct salePrdctVo:" + salePrdctVo);

		salePrdctVo.setSaleId(saleVo.getSaleId());
		SalePrdctVo salePrdctVo2 = salePrdctVo;
		try {
			prdctService.decCntSalePrdctOff(salePrdctVo);

			saleVo.setResult(saleService.modifyResultOgnPrc(saleVo,
					CommonCode.ARRAY_SELECT, CommonCode.COMPLETED,
					salePrdctVo2.getPrc(), false));

			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "incCntSalePrdctNew.do")
	@ResponseBody
	public String incCntSalePrdctNew(SalePrdctVo salePrdctVo,
			HttpSession session) {

		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		logger.info("run incCntSalePrdctNew salePrdctVo:" + salePrdctVo);

		salePrdctVo.setSaleId(saleVo.getSaleId());
		SalePrdctVo salePrdctVo2 = salePrdctVo;
		try {
			prdctService.incCntSalePrdctOffNew(salePrdctVo);

			saleVo.setResult(saleService.modifyResultOgnPrc(saleVo,
					CommonCode.ARRAY_SELECT, CommonCode.COMPLETED,
					salePrdctVo2.getPrc(), true));

			return "success";
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}

	@RequestMapping(value = "decCntSalePrdctNew.do")
	@ResponseBody
	public String decCntSalePrdctNew(SalePrdctVo salePrdctVo,
			HttpSession session) {

		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

		logger.info("run decCntSalePrdctNew salePrdctVo:" + salePrdctVo);

		salePrdctVo.setSaleId(saleVo.getSaleId());
		SalePrdctVo salePrdctVo2 = salePrdctVo;
		try {
			prdctService.decCntSalePrdctOffNew(salePrdctVo);

			saleVo.setResult(saleService.modifyResultOgnPrc(saleVo,
					CommonCode.ARRAY_SELECT, CommonCode.COMPLETED,
					salePrdctVo2.getPrc(), false));

			return "success";

		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return "fail";
	}
	
	private void calcInvn(SaleVo saleVo, boolean isAdd)
	{
		logger.info("run calcInvn saleVo:"+saleVo);
		logger.info("run calcInvn isAdd:"+isAdd);
		
		try {
			List <PrdctVo> listSalePrdct=prdctService.listSalePrdctOff(saleVo);
			SalePrdctVo salePrdctVo = new SalePrdctVo();
			
			logger.info("size:"+listSalePrdct.size());
			for(int i=0, size=listSalePrdct.size();i<size;i++)
			{
				PrdctVo tmpPrdctVo = listSalePrdct.get(i);
				logger.info("calc invn - tmpPrdctVo["+i+"]:"+tmpPrdctVo);
				salePrdctVo.setPrdctId(tmpPrdctVo.getPrdctId());
				salePrdctVo.setCstmrId(saleVo.getCstmrId());
				salePrdctVo.setShopId(saleVo.getShopId());
				salePrdctVo.setCnt(tmpPrdctVo.getPrdctCnt());
				salePrdctVo.setSaleId(saleVo.getSaleId());

				//cancel prdct.
				//logger.info("tmpPrdctVo.getDlvry().intValue():"+tmpPrdctVo.getDlvry().intValue());
				int statDlvry = tmpPrdctVo.getDlvry().intValue();
				logger.info("statDlvry:"+statDlvry);
				logger.info("statDlvry == (CommonCode.INT_COMPLETED):"+(statDlvry == (CommonCode.INT_COMPLETED)));
				if(statDlvry == (CommonCode.INT_COMPLETED))
				{
					//#{cnt}, #{prdctId}, #{shopId};
					//#{prdctId},#{cnt},#{invnTyCd},#{cstmrId},#{shopId},DATE_FORMAT(now(),'%Y%m%d')
					if(isAdd){
						logger.info("isAdd_step1:"+isAdd);
						// for Check.
						String checkRemoveDuple;
						String checkAddDuple;
						salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_REMOVE);
						salePrdctVo.setItemTy(tmpPrdctVo.getItemTy());
						checkRemoveDuple = saleService.checkInvnHist(salePrdctVo);
						salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_ADD);
						checkAddDuple=saleService.checkInvnHist(salePrdctVo);
						
						//구매 기록 없음.
						logger.info("checkRemoveDuple:"+checkRemoveDuple);
						logger.info("checkRemoveDuple.equals(ok):"+(checkRemoveDuple.equals("ok")));
						if(checkRemoveDuple.equals("ok")){
							logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals OK ");
							continue;
						}
						
						//취소 기록 있음. 더블 터치 가능성 있음. 중복되므로 무시.
						logger.info("checkAddDuple:"+checkAddDuple);
						logger.info("checkAddDuple.equals(udple):"+(checkAddDuple.equals("duple")));
						if(checkAddDuple.equals("duple")){
							logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals DUPLE ");
							continue;
						}
						logger.info("tmpPrdctVo.getItemTy().intValue():"+tmpPrdctVo.getItemTy().intValue());
						logger.info("tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_FRAME:"+(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_FRAME));
						if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_FRAME){
							logger.info("tmpPrdctVo.getItemTy().equals(1)");
							saleService.incCntFrameInvn(salePrdctVo);
							saleService.addFrameInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_LENS){
							logger.info("tmpPrdctVo.getItemTy().equals(2)");
							saleService.incCntLensInvn(salePrdctVo);
							saleService.addLensInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_CLENS){
							logger.info("tmpPrdctVo.getItemTy().equals(3)");
							saleService.incCntCLensInvn(salePrdctVo);
							saleService.addCLensInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_ACC){
							logger.info("tmpPrdctVo.getItemTy().equals(4)");
							saleService.incCntAccInvn(salePrdctVo);
							saleService.addAccInvnHist(salePrdctVo);
						}else{
							logger.info("Error!");
						}
						String result = saleService.removeInvnHist(salePrdctVo);
						logger.info("remove result :"+result);
					}else{
						logger.info("isAdd_step1:"+isAdd);
						salePrdctVo.setItemTy(tmpPrdctVo.getItemTy());
						salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_REMOVE);
						
						//Defend to Double Touch.
						if(saleService.checkInvnHist(salePrdctVo).equals("duple")){
							logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals DUPLE ");
							continue;
						}
						
						if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_FRAME){
							logger.info("tmpPrdctVo.getItemTy().equals(1)");
							saleService.decCntFrameInvn(salePrdctVo);
							saleService.addFrameInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_LENS){
							logger.info("tmpPrdctVo.getItemTy().equals(2)");
							saleService.decCntLensInvn(salePrdctVo);
							saleService.addLensInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_CLENS){
							logger.info("tmpPrdctVo.getItemTy().equals(3)");
							saleService.decCntCLensInvn(salePrdctVo);
							saleService.addCLensInvnHist(salePrdctVo);
						}else if(tmpPrdctVo.getItemTy().intValue()==CommonCode.NUMBER_PRDCT_TY_ACC){
							logger.info("tmpPrdctVo.getItemTy().equals(4)");
							saleService.decCntAccInvn(salePrdctVo);
							saleService.addAccInvnHist(salePrdctVo);
						}else{
							logger.info("Invn-Cnt-Error!");
						}
					}
				}//end of if(delivery complete)
				
			}

			saleVo = saleService.selectSale(saleVo);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="getPaymentInfo")
	public String getPaymentInfo(SaleVo saleVo, ModelMap model){
		try {
			Map map = prdctService.getNewPaymentInfo(saleVo);
			Map map2 = prdctService.getFramePaymentInfo(saleVo);
			Map map3 = prdctService.getLensPaymentInfo(saleVo);
			Map map4 = prdctService.getClensPaymentInfo(saleVo);
			Map map5 = prdctService.getAccPaymentInfo(saleVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/listPaymentInfoForPrint";
	}
	
	@RequestMapping(value="getBillInfo")
	@ResponseBody
	public SaleVo getBillInfo(SaleVo saleVo){
		try {
			saleVo = prdctService.getBillInfo(saleVo);
			logger.info("@@@@@@@@@@@@@@@@:" + saleVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return saleVo;
	}
}