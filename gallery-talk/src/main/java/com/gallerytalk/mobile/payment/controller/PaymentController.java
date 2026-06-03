package com.gallerytalk.mobile.payment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.payment.domain.PaymentVo;
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

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/payment")
@Controller
public class PaymentController {
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private SaleJobService saleJobService;
	
	@Autowired
	private PointService pointService;
	
	@Autowired
	private SaleService saleService;
	
	@Autowired
	private PrdctService prdctService;
	
	@RequestMapping(value = "listSaleOffHist")
	public String listSaleOffHist(SaleVo saleVo,ModelMap model,HttpSession session,String cstmrId) {
		logger.info("run listSaleOffHist saleVo:"+saleVo);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		logger.info("shopId:"+shopVo.getShopId());
		logger.info("staffId:"+staffVo.getStaffId());
		
		try{
			Map map = paymentService.listSaleOffHist(saleVo);
			Map map1 = paymentService.listSaleOffHistOld(saleVo);
			model.addAllAttributes(map);
			model.addAllAttributes(map1);
			model.addAttribute("shopVo", shopVo);
			

			//Map map2 = saleService.listSelectPastPurchasedNewPrdct(saleVo);
			//model.addAllAttributes(map2);			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "payment/listSaleOffHist";
	}

	@RequestMapping(value = "cancelPayment")
	@ResponseBody
	public String canclePayment(PaymentVo paymentVo,ModelMap model,String cstmrId, HttpSession session) {
		SaleJobVo saleJobVo = new SaleJobVo();
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		CstmrVo cstmrVo = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR));
		PointVo pointVo = new PointVo();
		try {
			pointVo.setSaleId(saleVo.getSaleId());
			logger.info("run canclePayment paymentVo:"+paymentVo);
			logger.info("saleId"+saleVo.getSaleId());
			logger.info("shopId:"+shopVo.getShopId());
			logger.info("staffId:"+staffVo.getStaffId());
			logger.info("cstmrId:"+cstmrVo.getCstmrId());
			
			paymentVo.setCancel(CommonCode.SALE_OFF_CANCEL);
			logger.info("before modifySaleCancel:"+paymentVo);
			//Need         	#{cancel}, #{cancelMemo}, #{cancelCd}, #{saleId}
			//Never use saleVo.saleId
			paymentService.modifySaleCancel(paymentVo);
			
			saleJobVo.setSaleId(paymentVo.getSaleId());
			saleJobVo.setStaffId(staffVo.getStaffId());
			saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_PAYMENT);
			saleJobVo.setCancel(CommonCode.SALE_OFF_CANCEL);
			//Nee saleId, staffId, ty_cd, cancel
			logger.info("before addsalejob:"+saleJobVo);
			saleJobService.addSaleJob(saleJobVo);
			saleVo.setSaleId(paymentVo.getSaleId());
			saleVo = saleService.selectSale(saleVo);
			calcInvn(saleVo, true);
			logger.info("before removePonintHist:"+pointVo);
			pointService.removePointHist(pointVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "success";
	}
	
	@RequestMapping(value = "checkInvn4Return")
	public String checkInvn4Return(PaymentVo paymentVo,ModelMap model,String cstmrId, HttpSession session) {
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		
		try {
			logger.info("shopId:"+shopVo.getShopId());
			logger.info("staffId:"+staffVo.getStaffId());
			Map map1 = paymentService.listSalePrdct(paymentVo);
//			if (null==map1)
//			{
//				return "fail";
//			}
			model.addAllAttributes(map1);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
//			return "fail";
		}
		
		return "payment/listCheckInvn";
	}
	
	@RequestMapping(value = "updatePrdctCancel.do")
	@ResponseBody
	public String updateDeliveryCheck(PaymentVo paymentVo, HttpSession session ) throws Exception {
		logger.info("run updateDeliveryCheck - prdctVo : "+paymentVo);
		SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		
		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
		
		PointVo pointVo = new PointVo();
		pointVo.setSaleId(paymentVo.getSaleId());

		String listPrdctId = paymentVo.getListPrdctId();
		String listPrdctTy = paymentVo.getListPrdctTy();
		String listShop = paymentVo.getListShop();
		String listPrdctDtr = paymentVo.getListPrdctDtr();
		String listPrdctShp = paymentVo.getListPrdctShp();
		String listPrdctCnt = paymentVo.getListPrdctCnt();
		
		String delim = "[,]";
		String[] arrListPrdctId;
		String[] arrListPrdctTy;
		String[] arrListShop;
		String[] arrListPrdctDtr;
		String[] arrListPrdctShp;
		String[] arrListPrdctCnt;
		
		List <SalePrdctVo> listSalePrdctVo= new ArrayList<SalePrdctVo>();
		List <SaleJobVo> listSaleJobVo= new ArrayList<SaleJobVo>();

		try {
			//It can check session.
			logger.info("shopVo:"+shopVo.getShopId());
			logger.info("staffId:"+staffVo.getStaffId());

			if (!listPrdctId.isEmpty()) {
				arrListPrdctId = listPrdctId.split(delim);
				arrListPrdctTy = listPrdctTy.split(delim);
				arrListShop = listShop.split(delim);
				arrListPrdctDtr = listPrdctDtr.split(delim);
				arrListPrdctShp = listPrdctShp.split(delim);
				arrListPrdctCnt = listPrdctCnt.split(delim);
				
				for (int i = 0, length = arrListPrdctId.length; i < length; i++) {
					
					if(1==Integer.parseInt(arrListPrdctShp[i])){
						SalePrdctVo salePrdctVo = new SalePrdctVo();

						salePrdctVo.setSaleId(paymentVo.getSaleId());
						salePrdctVo.setItemTy(Integer.parseInt(arrListPrdctTy[i]));
						salePrdctVo.setPrdctId(Integer.parseInt(arrListPrdctId[i]));
						salePrdctVo.setShopId(Integer.parseInt(arrListShop[i]));
						
						salePrdctVo.setPrdctCnt(Integer.parseInt(arrListPrdctCnt[i]));
						salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_ADD);
						salePrdctVo.setStaffId(staffVo.getStaffId());
						
						listSalePrdctVo.add(salePrdctVo);
					}
				}
				//paymentService.incCntInvn(listSalePrdctVo);
				//paymentService.addInvnHist(listSalePrdctVo);
			}
			
			SaleJobVo saleJobVo = new SaleJobVo();
			saleJobVo.setSaleId(paymentVo.getSaleId());
			saleJobVo.setStaffId(staffVo.getStaffId());
			saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_PAYMENT);
			saleJobVo.setCancel(CommonCode.SALE_OFF_RETURN);
			saleJobVo.setDatetime(paymentVo.getCancelDate());
			logger.info("datetime:"+saleJobVo.getDatetime());
			//saleJobService.addSaleJob(listSaleJobVo);
			//pointService.removePointHist(pointVo);
			paymentVo.setCancel(CommonCode.SALE_OFF_RETURN);
			//paymentService.modifySaleCancel(paymentVo);
			paymentService.cancelPayment(listSalePrdctVo,saleJobVo, pointVo, paymentVo);
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	
	
	private void calcInvn(SaleVo saleVo, boolean isAdd)
	{
		logger.info("run payment calcInvn saleVo:"+saleVo);
		logger.info("run payment calcInvn isAdd:"+isAdd);
		
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
					logger.info("isAdd_step1:"+isAdd);
					// for Check.
					//String checkRemoveDuple;
					//String checkAddDuple;
					salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_ADD);
					salePrdctVo.setItemTy(tmpPrdctVo.getItemTy());
//					checkRemoveDuple = saleService.checkInvnHist(salePrdctVo);
//					salePrdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_REMOVE);
//					checkAddDuple=saleService.checkInvnHist(salePrdctVo);
//					
//					//구매 기록 없음.
//					logger.info("checkRemoveDuple:"+checkRemoveDuple);
//					logger.info("checkRemoveDuple.equals(ok):"+(checkRemoveDuple.equals("ok")));
//					if(checkRemoveDuple.equals("ok")){
//						logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals OK ");
//						continue;
//					}
//					
//					//취소 기록 있음. 더블 터치 가능성 있음. 중복되므로 무시.
//					logger.info("checkAddDuple:"+checkAddDuple);
//					logger.info("checkAddDuple.equals(udple):"+(checkAddDuple.equals("duple")));
//					if(checkAddDuple.equals("duple")){
//						logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals DUPLE ");
//						continue;
//					}
					saleService.incCntInvn(salePrdctVo);
					saleService.addInvnHist(salePrdctVo);
				}//end of if(delivery complete)
			}				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}