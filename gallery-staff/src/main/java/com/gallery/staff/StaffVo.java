package com.gallery.staff;

import com.gallery.common.PagingVo;
import lombok.Data;
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
	String phone;
	String urlStr;
	String imgPath;
	String regId;
	String dvcTk;
}
