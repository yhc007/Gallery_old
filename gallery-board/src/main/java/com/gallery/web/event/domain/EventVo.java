package com.gallery.web.event.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class EventVo extends PagingVo{
	Integer eventId;
	String eventName;
	
	
	String eventTyCd;
	public String getEventTyMsg(){
		return (String) CommonCode.codeMap.get(eventTyCd);
	}
	
	String eventStatTyCd;
	public String getEventStatTyMsg(){
		return (String) CommonCode.codeMap.get(eventStatTyCd);
	}
	
	
	Integer dscnt;
	Integer prdctCnt;
	
	
	
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
		if(startTime!=null){
			return startTime;
		}
		String rtn=syear+String.format("%02d", smonth)+String.format("%02d", sday);
		if(rtn.length()!=8){
			return null;
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

	
	String bigo;
	String prdctTyCd;
}
