package com.gallery.cstmr;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.net.URLDecoder;


@Data
@Alias("cstmrVo")
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
	Integer visitCnt;
	String couponBigo;
	Integer coupon;
	Integer buyCount;
	Integer point;
	Integer shopId;
	Integer shopNum;
	Integer digit4;
	String monthly;
	String sdate;
	String edate;
	String Sns;
	String SC;
	String jsonSC;
	String DS;
	String SCID;
	String DSID;
	String fmlyCd;
	String srchTy;

	public String getTelephon(){
		if(telephone==null) return null;
		if(telephone.equals("null")) return "";
		String rtn=null;
		try{
			rtn= URLDecoder.decode(telephone,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCellphone(){
		if(cellphone==null) return null;
		if(cellphone.equals("null")) return "";
		String rtn=null;
		try{
			rtn= URLDecoder.decode(cellphone,"utf-8");
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
				return "";
			}
		}else{
			return birthDay;
		}
	}
	String recheck;
	String staffName;
	String shopName;
	String byear;
	String bmonth;
	String bday;
	String birthDayTyCd;
	String zipCd;
	String email;
	String addr;
	String bigo;
	String getSmsYn;
	String getDmYn;
	String getEmailYn;

	//eye Check date
	String datetime;
	String datetime2;
	String gsphLeft;
	String gsphRight;
	String gcylRight;
	String gcylLeft;
	String gaxisRight;
	String gaxisLeft;
	String addRight;
	String addLeft;
	String npcRight;
	String npcLeft;
	String npaRight;
	String npaLeft;
	String pdRight;
	String pdLeft;
	String lsphRight;
	String lsphLeft;
	String lcylRight;
	String lcylLeft;
	String laxisRight;
	String laxisLeft;
	String prismRight;
	String prismLeft;
	String baseRight;
	String baseLeft;
	String bcRight;
	String bcLeft;
	String diaRight;
	String diaLeft;

	String facebook;
	String twitter;
	String instagram;


	public String getFaceBook(){
		if(facebook==null){
			facebook = "";
		}
		return facebook;
	}

	public String getTwitter(){
		if(twitter==null){
			twitter= "";
		}
		return twitter;
	}

	public String getInstagram(){
		if(instagram==null){
			instagram= "";
		}
		return instagram;
	}

	public String getshopName(){
		if(shopName==null){
			shopName= "　";
		}
		return shopName;
	}

	public String getStaffName(){
		if(staffName==null){
			staffName= "　";
		}
		return staffName;
	}

	Integer pointTotal;
	String fmlyName;
	String fmlyTel;
	String fmlyCell;
	String fmlyAddr;
	String fmlyBirth;
	Integer fmlyTotal;
}
