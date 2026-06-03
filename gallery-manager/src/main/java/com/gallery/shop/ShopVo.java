package com.gallery.shop;

import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.net.URLDecoder;

@Data
@Alias("shopVo")
public class ShopVo extends PagingVo {
	Integer shopId;
	String comName;
	String iNum;
	String shopName;
	Integer shopNum;
	String telephone;
	String shopStatTyCd;
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
	Double lat;
	Double lot;
	String sdate;
	String edate;
	Double dstns;
	String joinDate;
	String eName;
	String pNum;
	String pNum2;
	Integer joinCount;
	String sort;
	String pwd;
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

};
