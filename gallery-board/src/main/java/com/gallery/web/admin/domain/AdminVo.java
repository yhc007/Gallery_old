package com.gallery.web.admin.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class AdminVo extends PagingVo{
	String id;
	String pwd;
	String lv;
	String shopId;
	String shopName;
	String shopTy;
	String iNum;
	String oldPwd;
	String newPwd;
	String chkPwd;
}
