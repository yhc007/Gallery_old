package com.gallery.web.staff.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
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
}
