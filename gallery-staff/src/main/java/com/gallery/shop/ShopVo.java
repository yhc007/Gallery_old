package com.gallery.shop;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.net.URLDecoder;

@Data
@Alias("shopVo")
public class ShopVo{
	Integer shopId;
	Integer cstmrId;
	Integer staffId;
	String shopName;
	String pwd;
	String id;
	Integer shopNum;
	String telephone;
	String shopStatTyCd;

	String osType;
	String sn;
	Double lat;
	Double lot;
	Double dstns;
	String joinDate;
	Integer joinCount;

	Integer today;

	String comName;
	String iNum;
	String puchasPrc;
	String cName;
	String cNum;
	String taxName;
	String taxNum;
	String addr;
	String fax;
	String shopId2;
	String shopTy;
	Integer rtnPrc;
	String sdate;
	String edate;
	String eName;
	String pNum;
	String pNum2;
	String sort;
	String stampImgPath;
	String result;
	String urlStr;

	public String getStampImgPath(){
		String rtn = null;
		if(stampImgPath==null){
			return null;
		}
		try {
			rtn = URLDecoder.decode(stampImgPath, "utf-8");
		} catch (Exception e){
			e.printStackTrace();
		}
		return rtn;
	}

}
