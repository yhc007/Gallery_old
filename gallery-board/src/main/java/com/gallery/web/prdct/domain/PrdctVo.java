package com.gallery.web.prdct.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class PrdctVo extends PagingVo{
	String frameDevide;
	String lensDevide;
	String clensDevide;
	String accDevide;
	String etcDevide;
	String revenue;
	String salePrc;
	String frameTotal;
	String lensTotal;
	String returnPrc;
	String pay;
	String sales;
	String devidePay;
	String clensTotal;
	String accTotal;
	String etcTotal;
	String cstmrLoginId;
	String oldPrdctId;
	String edit;
	String tyId;
	String memo;
	String dueMonth;
	String receive;
	String spec;
	String total;
	String modifyTime;
	String addr;
	String no;
	String BC;
	String diam;
	String detail;
	String returnCd;
	String returnReason;
	String returnCnt;
	String type;
	String id;
	String deliverTime;
	String telephone;
	String name;
	Integer comTy;
	String countryName;
	String country;
	String shopTy;
	String state;
	String sdate;
	String edate;
	String tyId1;
	String tyId2;
	String tyName;
	String mtrl;
	String url;
	String invnId;
	String ty1;
	String ty2;
	String allPrdct;
	String unit;
	String InvnHistId;
	String comName;
	String rate;
	Integer prdctId;
	String prdctName;
	String prdctTyCd;
	Integer brandId;
	String mnfCountry;
	String colorName1;
	String colorName2;
	String cntryId;
	String cntryName;
	String whDate;
	String prdctStatTyCd;
	String prdctVisibleCd;
	String shopId;
	String shopName;
	String color;
	Integer puchasPrc;
	Integer trdePrc;
	Integer iNum;
	String cName;
	String test1;
	Integer eventId;
	String tax;
	String eventName;
	Integer datetime;
	Integer dscnt;
	String sort;
	String prdctTy;
	Integer prdctType;
	String prdctTyName;
	String prdctShape;
	String prdctShapeName;
	String colorName;
	String allow;
	String colorId;
	String colorId2;
	String mtrlId;
	String mtrlName;
	String devide;
	String admin_allow;
	String due_month;
	/*public String getAllow(){
		if(allow.equals("0")){
			allow = "미승인";
		}else if(allow.equals("1")){
			allow = "승인";
		}else if(allow.equals("-1")){
			allow = "반려";
		}else if(allow==null){
			allow = "";
		}
		return allow;
	}*/
	public Integer getDscnt(){
		if(dscnt==null){
			return 0;
		}
		return dscnt;
	}
	
	String regTime;
	String updTime;
	
	String test;
	String test2;
	String urlStr;
	String imgPath;
	//String stillPath;
	String videoCd;
	Integer multiImgCnt;
	String brandName;
	String invnHistId;
	Integer remainCnt;
	public Integer getRemainCnt(){
		if(remainCnt==null)return 0;
		return remainCnt;
	}
	
	String invnTyCd;
//	public String getInvnTyCd(){
//		if(invnTyCd.equals("")){
//			invnTyCd = "";
//		}
//		else if(invnTyCd.equals("00900001")){
//			invnTyCd = "������";
//		}else{
//			invnTyCd = "������";
//		}
//		return invnTyCd;
//		
//	}
	String bigo;
	Integer cnt;
	
	public String getInvnTyCdMsg(){
		return (String)CommonCode.codeMap.get(invnTyCd);
	}
	
	Integer cstmrId;
	public String getPrdctStatTyCdMsg(){
		return (String)CommonCode.codeMap.get(prdctStatTyCd);
	}
	public String getPrdctTyCdMsg(){
		return (String)CommonCode.codeMap.get(prdctTyCd);
	}
	
	Integer jjim;
}
