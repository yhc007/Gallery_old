package com.gallerytalk.mobile.coupon.controller;

import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.coupon.domain.CouponVo;
import com.gallerytalk.mobile.coupon.service.CouponService;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.point.service.PointService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/coupon")
@Controller
public class CouponController {
	
	private static final Logger logger = LoggerFactory.getLogger(CouponController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private PointService pointService;
	
	@Autowired
	private CouponService couponService;
	
	
	@RequestMapping(value = "calcBalancePoint")
	@ResponseBody
	public String calcBalancePoint() {
		logger.debug("run calcBalancePoint");
		String result;
		try{
			result=pointService.addBalancePoint();
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	@RequestMapping(value = "getCstmrPoint")
	@ResponseBody
	public String getCstmrPoint(PointVo pointVo) {
		logger.info("run getCstmrPoint pointVo:"+pointVo);
		String result ="";
		try{
			pointVo=pointService.selectPointByCstmrCd(pointVo);
			
			result = String.format("%d",(int)(pointVo.getTotalPoint()*1000))+","+pointVo.getFmlyCd()+","+pointVo.getFmlyName();
			logger.info(result);
			result = URLEncoder.encode(result,"utf-8");
			result = result.replaceAll("\\+", "%20");

			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	@RequestMapping(value = "getBirthCoupon")
	@ResponseBody
	public CouponVo getBirthCoupon(CouponVo couponVo,ModelMap model) {
		logger.info("run getBirthCoupon couponVo:"+couponVo);
		logger.info("run getBirthCoupon cstmrCd:"+couponVo.getCstmrCd());
		CouponVo returnVo = new CouponVo();
		String checkBirthCoupon;
		try {
			checkBirthCoupon=couponService.checkBirthCoupon(couponVo);
			if(checkBirthCoupon.equals("duple")){
				logger.info("saleService.checkFrameInvnHist(salePrdctVo).equals duple ");
				returnVo = couponService.listBirthCoupon(couponVo);
				return returnVo;
			}else{
				
				returnVo.setCouponCd("NOEXIST");
				return returnVo;
			}
				
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		returnVo.setCouponCd("NOEXIST");
		return returnVo;
	}
	
//	@RequestMapping(value = "getCheckData")
//	@ResponseBody
//	public CstmrHstryVo getCheckData(ModelMap model,HttpServletRequest request,CstmrHstryVo cstmrHstryVo, HttpSession session) {
//		logger.info("run getCheckData");
//		CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
//		cstmrHstryVo.setCstmrId(cstmrVo.getCstmrId());
//		
//		try{
//			//model.addAttribute("staffVo", staffVo);
//			cstmrHstryVo = cstmrHstryService.selectVisitInfo(cstmrHstryVo);
//			return cstmrHstryVo; 
//		}catch(Exception e){
//			logger.error(e.getLocalizedMessage());
//		}
//		return new CstmrHstryVo();
//	}

	
	@RequestMapping(value="chkCoupon")
	@ResponseBody
	public String chkCoupon(CstmrVo cstmrVo){
		String result = "";
		try {
			result = couponService.chkCoupon(cstmrVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
}