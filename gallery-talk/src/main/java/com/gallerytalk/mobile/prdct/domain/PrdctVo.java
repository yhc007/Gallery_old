package com.gallerytalk.mobile.prdct.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PrdctVo{
	Integer cardComId;
	String cardComName;
	Integer prdctId;
	Integer cstmrId;
	Integer shopId;
	Integer prdctCnt;
	String prdctName;
	String prdctTyCd;
	String colorName;
	String ty1;
	String ty2;
	Integer brandId;
	String mnfCountry;
	String whDate;
	Integer itemTy;
	String prdctStatTyCd;
	String prdctVisibleCd;
	String color;
	Integer puchasPrc;
	Integer trdePrc;
	String saleId;
	//String listCheckedPrdctIdFrame;
	//String listUnCheckedPrdctIdFrame;
	String listCheckedPrdctId;
	String listUnCheckedPrdctId;
	String listCheckedPrdctIdNew;
	String listUnCheckedPrdctIdNew;

	String listCheckedPrdctIdLens;
	String listUnCheckedPrdctIdLens;
	String listCheckedPrdctIdClens;
	String listUnCheckedPrdctIdClens;
	String listCheckedPrdctIdAcc;
	String listUnCheckedPrdctIdAcc;


	String listInformPrdctId;
	String listUnInformPrdctId;
	String listInformPrdctIdNew;
	String listUnInformPrdctIdNew;

	String listInformPrdctIdLens;
	String listUnInformPrdctIdLens;
	String listInformPrdctIdClens;
	String listUnInformPrdctIdClens;
	String listInformPrdctIdAcc;
	String listUnInformPrdctIdAcc;

	String listCheckedEarnedPrdctId;
	String listUnCheckedEarnedPrdctId;
	String listCheckedEarnedPrdctIdNew;
	String listUnCheckedEarnedPrdctIdNew;

	String listCheckedEarnedPrdctIdLens;
	String listUnCheckedEarnedPrdctIdLens;
	String listCheckedEarnedPrdctIdClens;
	String listUnCheckedEarnedPrdctIdClens;
	String listCheckedEarnedPrdctIdAcc;
	String listUnCheckedEarnedPrdctIdAcc;


	String listCheckedDscntPrdctId;
	String listUnCheckedDscntPrdctId;
	String listCheckedDscntPrdctIdNew;
	String listUnCheckedDscntPrdctIdNew;

	Integer eventId;
	String eventName;
	Integer dscntPrcnt;

	String regTime;
	String updTime;

	String urlStr;
	String imgPath;
	//String stillPath;
	String videoCd;
	Integer multiImgCnt;
	String brandName;

	Integer invnHistId;
	Integer remainCnt;
	public Integer getRemainCnt(){
		if(remainCnt==null)return 0;
		return remainCnt;
	}

	String bigo;
	Integer cnt;
	String invnTyCd;
	Integer dlvry;

}

