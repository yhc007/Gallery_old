package com.gallery.saleJob;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("saleJobVo")
public class SaleJobVo {
	Integer jobId;

	Integer saleId;
	Integer staffId;
	Integer prdctId;
	Integer cstmrId;
	Integer shopId;
	Integer payCash;
	Integer payCard;
	Integer cardTy;
	Integer addPoint;
	String cardDate;
	Integer payPoint;
	Integer partnerDscnt;
	Integer dscntPrice;
	Integer partnerId;
	Integer etcDscnt;
	String etcDscntMemo;
	String prdctName;
	String fmlyCd;
	Integer dlvryCnt;
//	String earnCheckedId;
//	String dscntCheckedId;
//	String earnUnCheckedId;
//	String dscntUnCheckedId;

	String couponCd;
	Integer chkUseCoupon;

	String pennyPrice;

	String tyCd;
	String cstmrName;
	String result;
	String actionTy;

	String staffName;

	public String startTime;
	public String endTime;

	String cstmrCd;
	Integer earnPoint;
	Integer earnPrcnt;
	String dateTile;

	double point;
	String pointStatus;
	String datetime;

	String strPrdctId;
	String strPrdctDscnt;
	String strPrdctEarn;
	String strPrdctUsing;
	String strPrdctIdNew;
	String strPrdctDscntNew;
	String strPrdctEarnNew;

	Integer cancel;

}
