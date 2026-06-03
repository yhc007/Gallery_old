package com.gallery.payment;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("paymentVo")
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
