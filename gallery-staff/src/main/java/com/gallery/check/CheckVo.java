package com.gallery.check;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

@Data
@Alias("checkVo")
public class CheckVo{
//	String histId;
	Integer histId;
	String histName;
	String editHstVal;

	Integer cstmrId;
	String cstmrCd;
	Integer staffId;
	Integer visitShopId;

	String shopName;
	String staffName;

	String gsphRight;
	public String getGsphRight(){
//		if( null == gsphRight || gsphRight.isEmpty())
		if( null == gsphRight)
		{
			gsphRight=null;
		}
		return gsphRight;
	}
	String gsphLeft;
	public String getGsphLeft(){
		//if(null ==gsphLeft || gsphLeft.isEmpty())
		if(null ==gsphLeft)
		{
			gsphLeft=null;
		}
		return gsphLeft;
	}

	String gcylRight;
	public String getGcylRight(){
		//if(null == gcylRight || gcylRight.isEmpty())
		if(null == gcylRight)
		{
			gcylRight=null;
		}
		return gcylRight;
	}
	String gcylLeft;
	public String getGcylLeft(){
		//if(null == gcylLeft||gcylLeft.isEmpty())
		if(null == gcylLeft)
		{
			gcylLeft=null;
		}
		return gcylLeft;
	}

	String gaxisRight;
	public String getGaxisRight(){
		//if(null == gaxisRight || gaxisRight.isEmpty())
		if(null == gaxisRight)
		{
			gaxisRight=null;
		}
		return gaxisRight;
	}
	String gaxisLeft;
	public String getGaxisLeft(){
		//if(null == gaxisLeft || gaxisLeft.isEmpty())
		if(null == gaxisLeft)
		{
			gaxisLeft=null;
		}
		return gaxisLeft;
	}
	String addRight;
	public String getAddRight(){
		//if(null == addRight||addRight.isEmpty())
		if(null == addRight)
		{
			addRight=null;
		}
		return addRight;
	}
	String addLeft;
	public String getAddLeft(){
		//if(null == addLeft||addLeft.isEmpty())
		if(null == addLeft)
		{
			addLeft=null;
		}
		return addLeft;
	}
	String npcRight;
	public String getNpcRight(){
		//if(null == npcRight||npcRight.isEmpty())
		if(null == npcRight)
		{
			npcRight=null;
		}
		return npcRight;
	}
	String npcLeft;
	public String getNpcLeft(){
		//if(null == npcLeft||npcLeft.isEmpty())
		if(null == npcLeft)
		{
			npcLeft=null;
		}
		return npcLeft;
	}
	String npaRight;
	public String getNpaRight(){
		//if(null == npaRight||npaRight.isEmpty())
		if(null == npaRight)
		{
			npaRight=null;
		}
		return npaRight;
	}
	String npaLeft;
	public String getNpaLeft(){
		//if(null == npaLeft||npaLeft.isEmpty())
		if(null == npaLeft)
		{
			npaLeft=null;
		}
		return npaLeft;
	}
	String pdRight;
	public String getPdRight(){
		//if(null == pdRight||pdRight.isEmpty())
		if(null == pdRight)
		{
			pdRight=null;
		}
		return pdRight;
	}
	String pdLeft;
	public String getPdLeft(){
		//if(null == pdLeft||pdLeft.isEmpty())
		if(null == pdLeft)
		{
			pdLeft=null;
		}
		return pdLeft;
	}

	String lsphRight;
	public String getLsphRight(){
		//if(null == lsphRight||lsphRight.isEmpty())
		if(null == lsphRight)
		{
			lsphRight=null;
		}
		return lsphRight;
	}
	String lsphLeft;
	public String getLsphLeft(){
		//if(null == lsphLeft||lsphLeft.isEmpty())
		if(null == lsphLeft)
		{
			lsphLeft=null;
		}
		return lsphLeft;
	}
	String lcylRight;
	public String getLcylRight(){
		//if(null == lcylRight||lcylRight.isEmpty())
		if(null == lcylRight)
		{
			lcylRight=null;
		}
		return lcylRight;
	}
	String lcylLeft;
	public String getLcylLeft(){
		//if(null == lcylLeft || lcylLeft.isEmpty())
		if(null == lcylLeft)
		{
			lcylLeft=null;
		}
		return lcylLeft;
	}
	String laxisRight;
	public String getLaxisRight(){
		//if(null== laxisRight||laxisRight.isEmpty())
		if(null== laxisRight)
		{
			laxisRight=null;
		}
		return laxisRight;
	}
	String laxisLeft;
	public String getLaxisLeft(){
		//if(null == laxisLeft||laxisLeft.isEmpty())
		if(null == laxisLeft)
		{
			laxisLeft=null;
		}
		return laxisLeft;
	}
	String prismRight;
	public String getPrismRight(){
		//if(prismRight==null || prismRight.isEmpty() )
		if(prismRight==null)
		{
			prismRight=null;
		}
		return prismRight;
	}
	String prismLeft;
	public String getPrismLeft(){
		//if(null==prismLeft||prismLeft.isEmpty())
		if(null==prismLeft)
		{
			prismLeft=null;
		}
		return prismLeft;
	}
	String baseRight;
	public String getBaseRight(){
		//if(null==baseRight||baseRight.isEmpty())
		if(null==baseRight)
		{
			baseRight=null;
		}
		return baseRight;
	}
	String baseLeft;
	public String getBaseLeft(){
		//if(null==baseLeft||baseLeft.isEmpty())
		if(null==baseLeft)
		{
			baseLeft=null;
		}
		return baseLeft;
	}
	String bcRight;
	public String getBcRight(){
		//if(null==bcRight||bcRight.isEmpty())
		if(null==bcRight)
		{
			bcRight=null;
		}
		return bcRight;
	}
	String bcLeft;
	public String getBcLeft(){
		//if(null==bcLeft||bcLeft.isEmpty())
		if(null==bcLeft)
		{
			bcLeft=null;
		}
		return bcLeft;
	}
	String diaRight;
	public String getDiaRight(){
		//if(null==diaRight||diaRight.isEmpty())
		if(null==diaRight)
		{
			diaRight=null;
		}
		return diaRight;
	}
	String diaLeft;
	public String getDiaLeft(){
		//if(null==diaLeft||diaLeft.isEmpty())
		if(null==diaLeft)
		{
			diaLeft=null;
		}
		return diaLeft;
	}
	String datetime;
	String domEye;
	public String getDomEye(){
		//if(null==domEye||domEye.isEmpty())
		if(null==domEye)
		{
			domEye=null;
		}
		return domEye;
	}

	public String getDateStr(){
		String date=getDatetime();
		if(date==null){
			return null;
		}else if(date.length()!=8){
			//System.out.println("date len d m "+date.length()+":"+date);
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
