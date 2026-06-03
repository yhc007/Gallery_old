package com.gallerytalk.mobile.sale.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SaleHistSearchVo{
	Integer saleId;
	Integer prdctId;
	Integer prdctCnt;
	String cstmrName;
	String result;
	String prdctTyCd;
	String searchTyCd;
	public SaleHistSearchVo(){
		
	}
	
	public SaleHistSearchVo(int saleId,int prdctId,int prdctCnt){
		this.saleId=saleId;
		this.prdctId=prdctId;
		this.prdctCnt=prdctCnt;
	}
	
	
	Integer syear;
	Integer smonth;
	Integer sday;
	Integer eyear;
	Integer emonth;
	Integer eday;
	
	String startTime;
	String endTime;
	
	public Integer getSyear(){
		if(startTime==null){
			return syear;
		}else{
			return Integer.valueOf(startTime.substring(0, 4));
		}
	}
	public Integer getSmonth(){
		if(startTime==null){
			return smonth;
		}else{
			return Integer.valueOf(startTime.substring(4, 6));
		}
	}
	public Integer getSday(){
		if(startTime==null){
			return sday;
		}else{
			return Integer.valueOf(startTime.substring(6, 8));
		}
	}
	public Integer getEyear(){
		if(endTime==null){
			return eyear;
		}else{
			return Integer.valueOf(endTime.substring(0, 4));
		}
	}
	public Integer getEmonth(){
		if(endTime==null){
			return emonth;
		}else{
			return Integer.valueOf(endTime.substring(4, 6));
		}
	}
	public Integer getEday(){
		if(endTime==null){
			return eday;
		}else{
			return Integer.valueOf(endTime.substring(6, 8));
		}
	}
	public String getStartTimeStr(){
		if(startTime==null){
			return null;
		}
		if(startTime.length()!=8){
			return null;
		}
		StringBuffer sb=new StringBuffer(startTime);
		return sb.insert(6, "-").insert(4, "-").toString();
	}
	public String getEndTimeStr(){
		if(endTime==null){
			return null;
		}
		if(endTime.length()!=8){
			return null;
		}
		StringBuffer sb=new StringBuffer(endTime);
		return sb.insert(6, "-").insert(4, "-").toString();
	}
	public String getStartTime(){
		String rtn=null;
		if(startTime!=null){
			return startTime;
		}
		if(searchTyCd.equals("y")){
			rtn=syear.toString();
		}else if(searchTyCd.equals("m")){
			rtn=syear+String.format("%02d", smonth);
		}else{
			rtn=syear+String.format("%02d", smonth)+String.format("%02d", sday);
			if(rtn.length()!=8){
				return null;
			}
		}
		return rtn;
	}
	
	public String getEndTime(){
		if(endTime!=null){
			return endTime;
		}
		String rtn=eyear+String.format("%02d", emonth)+String.format("%02d", eday);
		if(rtn.length()!=8){
			return null;
		}
		return rtn;
	}
}
