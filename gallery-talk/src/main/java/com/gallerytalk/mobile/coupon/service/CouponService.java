package com.gallerytalk.mobile.coupon.service;

import java.text.SimpleDateFormat;

import com.gallerytalk.mobile.coupon.domain.CouponVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;


public interface CouponService {
	

	public CouponVo listBirthCoupon(CouponVo couponVo) throws Exception;
	public String checkBirthCoupon(CouponVo couponVo) throws Exception;
	public String modifyBirthCoupon(CouponVo couponVo) throws Exception;
	public String chkCoupon(CstmrVo cstmrVo)throws Exception;
	public void executeTestService();
}