package com.gallery.dlvr;

import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.text.SimpleDateFormat;
import java.util.Date;

@Data
@Alias("dlvrVo")
public class DlvrVo extends PagingVo{
	Integer dlvrId;
	Integer saleId;
	String dlvrStatTyCd;
	String addr;
	String phone;
	String bigo;
	Date regtime;
	public String getRegtime(){
		if(regtime==null)return null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(regtime);
	}
	Date uptime;
	public String getUptime(){
		if(uptime==null)return null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(uptime);
	}
	String cstmrName;

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
}
