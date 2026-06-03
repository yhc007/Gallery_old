package com.gallery.app.cstmr.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CstmrVo {
	Integer cstmrId;
	String cstmrLoginId;
	String cstmrLoginPw;
	String checkPw;
	String newPw;
	String cstmrCd;
	String cstmrName;
	Integer couponId;
	String couponName;
	String couponCd;
	String startDate;
	String endDate;
	Integer dscntPrcnt;
	Integer dscntPrc;
	String couponBigo;
	Integer coupon;
	Integer buyCount;
	Integer point;
	
	public Integer getDscntPrcnt(){
		if(dscntPrcnt==null){
			dscntPrcnt = 0;
		}
		return dscntPrcnt;
	}
	
	public Integer getDscntPrc(){
		if(dscntPrc==null){
			dscntPrc = 0;
		}
		return dscntPrc;
	}
	
	public String getCstmrName(){
		
		if(cstmrName==null)return null;
		String rtn=null;
		try{
			rtn= URLDecoder.decode(cstmrName,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	
	public String getAddr(){
		if(addr==null)return null;
		String rtn=null;
		try{
			rtn= URLDecoder.decode(addr,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	
	public String getEmail(){
		if(email==null)return null;
		String rtn=null;
		try{
			rtn= URLDecoder.decode(email,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	Integer regShopId;
	String regDate;
	String telephone;
	String cellphone;
	String sexCd;
	String birthDay;
	public String getBirthDay(){
		if(birthDay==null){
			if(byear!=null&&bmonth!=null&&bday!=null){
				return byear+bmonth+bday;
			}else{
				return birthDay;
			}
		}else{
			return birthDay;
		}
	}
	String byear;
	String bmonth;
	String bday;
	String birthDayTyCd;
	String zipCd;
	String email;
	String addr;
	String bigo;
	String getSmsYn;
	
	//eye Check date
	String datetime;
	String gsphLeft;
	String gsphRight;
	
	String facebook;
	String twitter;
	String instagram;
	
}
