package com.gallery.staff;

import java.net.URLDecoder;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.common.PagingVo;
import org.apache.ibatis.type.Alias;

@Data
@Alias("staffVo")
public class StaffVo extends PagingVo{
	Integer staffId;
	Integer shopId;
	String staffName;
	String shopName;
	String position;
	String email;
	String iNum;
	String phone;
	String urlStr;
	String shopId2;
	String imgPath;
	String result;

	public String getImgPath(){
		String rtn = null;
		if(imgPath==null){
			return null;
		}
		try {
			rtn = URLDecoder.decode(imgPath, "utf-8");
		} catch (Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
}
