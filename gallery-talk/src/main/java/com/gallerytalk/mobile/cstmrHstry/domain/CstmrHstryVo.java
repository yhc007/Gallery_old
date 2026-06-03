package com.gallerytalk.mobile.cstmrHstry.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CstmrHstryVo{
//	String histId;
	Integer histId;

	Integer cstmrId;
	String cstmrCd;
	Integer staffId;
	String cstmrMemo;
	Integer visitShopId;
	
	String shopName;
	String staffName;
	
	String gsphRight;
	public String getGsphRight(){
		if(gsphRight.isEmpty())
		{
			gsphRight="0";
		}
		return gsphRight;
	}
	String gsphLeft;
	public String getGsphLeft(){
		if(gsphLeft.isEmpty())
		{
			gsphLeft="0";
		}
		return gsphLeft;
	}

	String gcylRight;
	public String getGcylRight(){
		if(gcylRight.isEmpty())
		{
			gcylRight="0";
		}
		return gcylRight;
	}
	String gcylLeft;
	public String getGcylLeft(){
		if(gcylLeft.isEmpty())
		{
			gcylLeft="0";
		}
		return gcylLeft;
	}

	String gaxisRight;
	public String getGaxisRight(){
		if(gaxisRight.isEmpty())
		{
			gaxisRight="0";
		}
		return gaxisRight;
	}
	String gaxisLeft;
	public String getGaxisLeft(){
		if(gaxisLeft.isEmpty())
		{
			gaxisLeft="0";
		}
		return gaxisLeft;
	}
	String addRight;
	public String getAddRight(){
		if(addRight.isEmpty())
		{
			addRight="0";
		}
		return addRight;
	}
	String addLeft;
	public String getAddLeft(){
		if(addLeft.isEmpty())
		{
			addLeft="0";
		}
		return addLeft;
	}
	String npcRight;
	public String getNpcRight(){
		if(npcRight.isEmpty())
		{
			npcRight="0";
		}
		return npcRight;
	}
	String npcLeft;
	public String getNpcLeft(){
		if(npcLeft.isEmpty())
		{
			npcLeft="0";
		}
		return npcLeft;
	}
	String npaRight;
	public String getNpaRight(){
		if(npaRight.isEmpty())
		{
			npaRight="0";
		}
		return npaRight;
	}
	String npaLeft;
	public String getNpaLeft(){
		if(npaLeft.isEmpty())
		{
			npaLeft="0";
		}
		return npaLeft;
	}
	String pdRight;
	public String getPdRight(){
		if(pdRight.isEmpty())
		{
			pdRight="0";
		}
		return pdRight;
	}
	String pdLeft;
	public String getPdLeft(){
		if(pdLeft.isEmpty())
		{
			pdLeft="0";
		}
		return pdLeft;
	}
	
	String lsphRight;
	public String getLsphRight(){
		if(lsphRight.isEmpty())
		{
			lsphRight="0";
		}
		return lsphRight;
	}
	String lsphLeft;
	public String getLsphLeft(){
		if(lsphLeft.isEmpty())
		{
			lsphLeft="0";
		}
		return lsphLeft;
	}
	String lcylRight;
	public String getLcylRight(){
		if(lcylRight.isEmpty())
		{
			lcylRight="0";
		}
		return lcylRight;
	}
	String lcylLeft;
	public String getLcylLeft(){
		if(lcylLeft.isEmpty())
		{
			lcylLeft="0";
		}
		return lcylLeft;
	}
	String laxisRight;
	public String getLaxisRight(){
		if(laxisRight.isEmpty())
		{
			laxisRight="0";
		}
		return laxisRight;
	}
	String laxisLeft;
	public String getLaxisLeft(){
		if(laxisLeft.isEmpty())
		{
			laxisLeft="0";
		}
		return laxisLeft;
	}
	String prismRight;
	public String getPrismRight(){
		if(prismRight.isEmpty() || prismRight==null)
		{
			prismRight="0";
		}
		return prismRight;
	}
	String prismLeft;
	public String getPrismLeft(){
		if(prismLeft.isEmpty())
		{
			prismLeft="0";
		}
		return prismLeft;
	}
	String baseRight;
	public String getBaseRight(){
		if(baseRight.isEmpty())
		{
			baseRight="0";
		}
		return baseRight;
	}
	String baseLeft;
	public String getBaseLeft(){
		if(baseLeft.isEmpty())
		{
			baseLeft="0";
		}
		return baseLeft;
	}
	String bcRight;
	public String getBcRight(){
		if(bcRight.isEmpty())
		{
			bcRight="0";
		}
		return bcRight;
	}
	String bcLeft;
	public String getBcLeft(){
		if(bcLeft.isEmpty())
		{
			bcLeft="0";
		}
		return bcLeft;
	}
	String diaRight;
	public String getDiaRight(){
		if(diaRight.isEmpty())
		{
			diaRight="0";
		}
		return diaRight;
	}
	String diaLeft;
	public String getDiaLeft(){
		if(diaLeft.isEmpty())
		{
			diaLeft="0";
		}
		return diaLeft;
	}
	String datetime;
	String domEye;
	public String getDomEye(){
		if(domEye.isEmpty())
		{
			domEye="0";
		}
		return domEye;
	}
	
	public String getDateStr(){
		String date=getDatetime();
		if(date==null){
			return null;
		}else if(date.length()!=8){
			System.out.println("date len d m "+date.length()+":"+date);
			return null;
		}
		return date.substring(0,4)+"."+date.substring(4,6)+"."+date.substring(6,8);
	}
		
	
	Integer ognPrice;
	Integer partnerDscnt;
	Integer isOld;
	
	Integer payCash;
	Integer payCard;
	Integer cardTy;
	Integer payPoint;
	Integer oldDigit;
	Integer etcDscnt;
	String etcDscntMemo;
	public String getEtcDscntMemo(){
		if(etcDscntMemo==null || etcDscntMemo.isEmpty())
		{
			etcDscntMemo="";
		}
		return etcDscntMemo;
	}
	
	Integer gpayment;
	Integer clpayment;
	
	String cardDate;
	String cname;
	String damdangName;
	
	
	Integer saleId;
	String saleMemo;
	
	Integer prdctId;
	Integer itemTy;
	String 	prdctName;
	String  colorName;
	Integer prdctCnt;
	Integer eventId;
	Integer dscnt;
	Integer pointRule;
	Integer prc;
	//String prc;
	Integer asmbly;
	Integer dlvry;
	Integer Inform;
	
	Integer dscntPrcnt;
	Integer earnPrcnt;
	Integer usingPoint;
	
	Integer cnt;
	Integer shopId;
	String invnTyCd;
	Integer CstmrId;
	

	
	String imgPath;
	String brandName;
	String endtime;

	public Integer getDscnt(){
		if(dscnt==null){
			return 0;
		}
		return dscnt;
	}
	String salePrdctId;
	String salePrdctDscnt;
	String salePrdctEarn;
	
	String gframe1;
	String gframe2;
	String gframe3;
	String glens1;
	String glens2;
	String glens3;
	String clensL;
	String clensR;

	public String getGframe1(){
		if(gframe1==null || gframe1.isEmpty())
		{
			gframe1="";
		}
		return gframe1;
	}
	public String getGframe2(){
		if(gframe2==null ||gframe2.isEmpty())
		{
			gframe2="";
		}
		return gframe2;
	}
	public String getGframe3(){
		if(gframe3==null || gframe3.isEmpty())
		{
			gframe3="";
		}
		return gframe3;
	}
	public String getGlens1(){
		if(glens1==null || glens1.isEmpty())
		{
			glens1="";
		}
		return glens1;
	}
	public String getGlens2(){
		if(glens2==null || glens2.isEmpty())
		{
			glens2="";
		}
		return glens2;
	}
	public String getGlens3(){
		if(glens3==null ||glens3.isEmpty())
		{
			glens3="";
		}
		return glens3;
	}
	public String getClensL(){
		if(clensL==null || clensL.isEmpty())
		{
			clensL="";
		}
		return clensL;
	}
	public String getClensR(){
		if(clensR==null || clensR.isEmpty())
		{
			clensR="";
		}
		return clensR;
	}
}
