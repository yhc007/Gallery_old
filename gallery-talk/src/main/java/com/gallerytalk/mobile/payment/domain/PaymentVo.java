package com.gallerytalk.mobile.payment.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentVo{
	Integer cardComId;
	String cardComName;
	
	Integer saleId; 
	Integer cancel;
	String cancelMemo;
	String cancelCd;
	String cancelDate;

	Integer prdctId;
	Integer shopId;
	String itemTy;
	Integer prdctCnt;
	
	String prdctName;
	String shopName;
	Integer prc;
	
	String listPrdctId;
	String listPrdctTy;
	String listPrdctCnt;
	String listShop;
	String listPrdctDtr;
	String listPrdctShp;
	
}