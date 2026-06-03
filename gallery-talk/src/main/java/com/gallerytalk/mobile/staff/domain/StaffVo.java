package com.gallerytalk.mobile.staff.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallerytalk.mobile.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class StaffVo extends PagingVo{
	Integer staffId;
	Integer shopId;
	Integer comId;
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
