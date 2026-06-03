package com.gallery.web.company.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class CompanyVo extends PagingVo{
	String iNum;
	String cType;
	String cName;
	String eName;
	String pNum1;
	String pNum2;
	String cMemo;
	String comTy;
	String cId;
	String cPwd;
	String cState;
}
