package com.gallery.prdct;

import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Data
@Alias("prdctVo")
public class PrdctVo{

	private static final Logger logger = LoggerFactory.getLogger(PrdctVo.class);

	Integer cardComId;
	String cardComName;
	Integer prdctId;
	String content;
	Integer cstmrId;
	Integer shopId;
	Integer prdctCnt;
	String prdctName;
	String prdctTyCd;
	String iNum;
	Integer no;
	String telephone;
	String inputTime;
	String outputTime;
	String cstmrName;
	String curve;
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
	public String getPrdctName(){
		String tmp;
		if(prdctName==null)return "";
		else{
			tmp = prdctName.replace("'", "`");
			return tmp;
		}
	}
	String bigo;
	Integer cnt;
	String invnTyCd;
	Integer dlvry;

	String feature1;
	String feature2;
	String feature3;
	String mtrl;
	String purpose;
	Integer prc;
	Integer earnPrcnt;

	Integer dscnt;
	Integer pointRule;
	Integer partnerDscnt;
	Integer asmbly;
	Integer Inform;
	Integer isNew;

	Integer usingPoint;
	Integer CstmrId;

	Integer staffId;

	Integer dtrCnt;
	Integer addCnt;

	String endtime;
	String datetime;
	String dateTile;
}

