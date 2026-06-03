package com.gallerytalk.mobile.cstmr.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.controller.CstmrController;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CstmrVo {
	
	private static final Logger logger = LoggerFactory.getLogger(CstmrController.class);
	
	String visitCnt;
	String totalPrc;
	Integer cstmrId;
	String cstmrLoginId;
	String cstmrLoginPw;
	String cstmrCd;
	String point;
	String fmlyCd;
	String cstmrName;
	String memo;
	public String getMemo(){
		String rtn = null;
		if(memo==null){
			return null;
		}
		try {
			rtn = URLDecoder.decode(memo, "utf-8");
		} catch (Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCstmrName(){
		
		String rtn=null;
		if(cstmrName==null)return null;
		try{
			rtn= URLDecoder.decode(cstmrName,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	Integer regShopId;
	String strRegShop;
	String regDate;
	String telephone;
	String lastNumTel;
	String cellphone;
	
	public String getTelephone(){
		if(telephone==null)return null;
//		else{
//			return telephone.replaceAll("-", "");
//		}
		return telephone;
	}
	public String getCellphone(){
		if(cellphone==null)return null;
//		else{
//			return telephone.replaceAll("-", "");
//		}
		return cellphone;
	}
	String sexCd;
	public String getSex(){
		if(sexCd==null)return null;
		else{
			return (String) CommonCode.codeMap.get(sexCd);
		}
	}
	String birthDay;
	public String getBirthDay(){
		if(birthDay==null){
			if(byear!=null&&bmonth!=null&&bday!=null){
				return getByear()+getBmonth()+getBday();
			}else{
				return birthDay;
			}
		}else{
			return birthDay;
		}
	}
	String byear;
	public String getByear(){
		if(byear==null||byear=="")return null;
		return byear;
	}
	String bmonth;
	public String getBmonth(){
		if(bmonth==null||bmonth=="")return null;
		return String.format(".%02d.", Integer.valueOf(bmonth));
	}
	String bday;
	public String getBday(){
		if(bday==null||bday=="")return null;
		return String.format("%02d", Integer.valueOf(bday));
	}
	String birthDayTyCd;
	String zipCd;
	String email;
	String addr;
	String bigo;
	String getSmsYn;
	
	Integer pcstmrId;
	String mrgeTyCd;
	String mrgeTime;
	
	String facebook;
	String twitter;
	String instagram;
	public String getProfile(){
		String name=getCstmrName();
		if(name==null)name="";
		else name=name+"  ";
		String code=getCstmrCd();
		if(code==null)code="";
		else code=" 회원코드:"+code;
		String sex=getSex();
		if(sex==null)sex="";
		else sex=" 성별:"+sex;
		
		String telephone=getTelephone();
		if(telephone==null)telephone="";
		else if(telephone.equals(""))telephone="";
		else telephone=" 전화번호:"+telephone;
		String cell=getCellphone();
		if(cell==null)cell="";
		else if(cell.equals(""))cell="";
		else cell=" 휴대폰:"+cell;
		String birth=getBirthDay();
		if(birth==null)birth="";
		else birth=" 생일:"+birth;
		String addr=getAddr();
		if(addr==null)addr="";
		else addr=" 주소:"+addr;
		
		String email=getEmail();
		if(email==null)email="";
		else email=" 메일:"+email;
		return name+code+sex+birth+telephone+cell+addr+email;
	}
	String searchText1;
	String searchText2;
	String searchTy1;
	String searchTy2;
}
