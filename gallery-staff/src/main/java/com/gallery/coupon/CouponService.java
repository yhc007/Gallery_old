package com.gallery.coupon;

import com.gallery.cstmr.CstmrVo;

import java.util.List;


public interface CouponService {
	CouponVo listBirthCoupon(CouponVo couponVo) throws Exception;
	String checkBirthCoupon(CouponVo couponVo) throws Exception;
	String modifyBirthCoupon(CouponVo couponVo) throws Exception;
	String chkCoupon(CstmrVo cstmrVo)throws Exception;
//    @Deprecated
//	String useCoupon(CstmrVo cstmrVo)throws Exception;
//    @Deprecated
//    String useOthrPrsnCpn(CouponVo couponVo)throws Exception;
	CouponVo checkValidationBirthCoupon(CouponVo couponVo) throws Exception;
	String existBirthCoupon(CouponVo couponVo) throws Exception;
	String cancelBirthCoupon(CouponVo couponVo) throws Exception ;
	String checkNusingCoupon(CouponVo couponVo) throws Exception ;
	List<CouponVo> listCstmr4Coupon(CstmrVo cstmrVo) throws Exception ;
}
