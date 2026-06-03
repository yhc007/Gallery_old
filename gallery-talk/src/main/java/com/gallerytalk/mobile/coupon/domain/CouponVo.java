package com.gallerytalk.mobile.coupon.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallerytalk.mobile.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class CouponVo extends PagingVo{
	String cstmrCd;
	String cstmrName;
	String cellphone;
	String telephone;

	String couponCd;
	String cstmrMail;
	Integer shopNum;
	String usingDate;
	String wMemo;
	
}
