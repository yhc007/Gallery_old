package com.gallerytalk.mobile.check.domain;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CheckVo{
//	String histId;
	Integer histId;

	Integer cstmrId;
	String cstmrCd;
	Integer staffId;
	Integer visitShopId;
	
	String shopName;
	String staffName;
	
	String gsphRight;
	public String getGsphRight(){
		if( null == gsphRight || gsphRight.isEmpty())
		{
			gsphRight="0";
		}
		return gsphRight;
	}
	String gsphLeft;
	public String getGsphLeft(){
		if(null ==gsphLeft || gsphLeft.isEmpty())
		{
			gsphLeft="0";
		}
		return gsphLeft;
	}

	String gcylRight;
	public String getGcylRight(){
		if(null == gcylRight || gcylRight.isEmpty())
		{
			gcylRight="0";
		}
		return gcylRight;
	}
	String gcylLeft;
	public String getGcylLeft(){
		if(null == gcylLeft||gcylLeft.isEmpty())
		{
			gcylLeft="0";
		}
		return gcylLeft;
	}

	String gaxisRight;
	public String getGaxisRight(){
		if(null == gaxisRight || gaxisRight.isEmpty())
		{
			gaxisRight="0";
		}
		return gaxisRight;
	}
	String gaxisLeft;
	public String getGaxisLeft(){
		if(null == gaxisLeft || gaxisLeft.isEmpty())
		{
			gaxisLeft="0";
		}
		return gaxisLeft;
	}
	String addRight;
	public String getAddRight(){
		if(null == addRight||addRight.isEmpty())
		{
			addRight="0";
		}
		return addRight;
	}
	String addLeft;
	public String getAddLeft(){
		if(null == addLeft||addLeft.isEmpty())
		{
			addLeft="0";
		}
		return addLeft;
	}
	String npcRight;
	public String getNpcRight(){
		if(null == npcRight||npcRight.isEmpty())
		{
			npcRight="0";
		}
		return npcRight;
	}
	String npcLeft;
	public String getNpcLeft(){
		if(null == npcLeft||npcLeft.isEmpty())
		{
			npcLeft="0";
		}
		return npcLeft;
	}
	String npaRight;
	public String getNpaRight(){
		if(null == npaRight||npaRight.isEmpty())
		{
			npaRight="0";
		}
		return npaRight;
	}
	String npaLeft;
	public String getNpaLeft(){
		if(null == npaLeft||npaLeft.isEmpty())
		{
			npaLeft="0";
		}
		return npaLeft;
	}
	String pdRight;
	public String getPdRight(){
		if(null == pdRight||pdRight.isEmpty())
		{
			pdRight="0";
		}
		return pdRight;
	}
	String pdLeft;
	public String getPdLeft(){
		if(null == pdLeft||pdLeft.isEmpty())
		{
			pdLeft="0";
		}
		return pdLeft;
	}
	
	String lsphRight;
	public String getLsphRight(){
		if(null == lsphRight||lsphRight.isEmpty())
		{
			lsphRight="0";
		}
		return lsphRight;
	}
	String lsphLeft;
	public String getLsphLeft(){
		if(null == lsphLeft||lsphLeft.isEmpty())
		{
			lsphLeft="0";
		}
		return lsphLeft;
	}
	String lcylRight;
	public String getLcylRight(){
		if(null == lcylRight||lcylRight.isEmpty())
		{
			lcylRight="0";
		}
		return lcylRight;
	}
	String lcylLeft;
	public String getLcylLeft(){
		if(null == lcylLeft || lcylLeft.isEmpty())
		{
			lcylLeft="0";
		}
		return lcylLeft;
	}
	String laxisRight;
	public String getLaxisRight(){
		if(null== laxisRight||laxisRight.isEmpty())
		{
			laxisRight="0";
		}
		return laxisRight;
	}
	String laxisLeft;
	public String getLaxisLeft(){
		if(null == laxisLeft||laxisLeft.isEmpty())
		{
			laxisLeft="0";
		}
		return laxisLeft;
	}
	String prismRight;
	public String getPrismRight(){
		if(prismRight==null || prismRight.isEmpty() )
		{
			prismRight="0";
		}
		return prismRight;
	}
	String prismLeft;
	public String getPrismLeft(){
		if(null==prismLeft||prismLeft.isEmpty())
		{
			prismLeft="0";
		}
		return prismLeft;
	}
	String baseRight;
	public String getBaseRight(){
		if(null==baseRight||baseRight.isEmpty())
		{
			baseRight="0";
		}
		return baseRight;
	}
	String baseLeft;
	public String getBaseLeft(){
		if(null==baseLeft||baseLeft.isEmpty())
		{
			baseLeft="0";
		}
		return baseLeft;
	}
	String bcRight;
	public String getBcRight(){
		if(null==bcRight||bcRight.isEmpty())
		{
			bcRight="0";
		}
		return bcRight;
	}
	String bcLeft;
	public String getBcLeft(){
		if(null==bcLeft||bcLeft.isEmpty())
		{
			bcLeft="0";
		}
		return bcLeft;
	}
	String diaRight;
	public String getDiaRight(){
		if(null==diaRight||diaRight.isEmpty())
		{
			diaRight="0";
		}
		return diaRight;
	}
	String diaLeft;
	public String getDiaLeft(){
		if(null==diaLeft||diaLeft.isEmpty())
		{
			diaLeft="0";
		}
		return diaLeft;
	}
	String datetime;
	String domEye;
	public String getDomEye(){
		if(null==domEye||domEye.isEmpty())
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
	
	String dateTile;
	public String getDateTile()
	{
		if( null == dateTile || dateTile.isEmpty())
		{
			TimeZone tz;
		    Date today = new Date();
		    //DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss (z Z)");
		    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
		    tz = TimeZone.getTimeZone("Asia/Seoul");
		    df.setTimeZone(tz);
		    dateTile=df.format(today);
		}
		return dateTile;
	}
}
