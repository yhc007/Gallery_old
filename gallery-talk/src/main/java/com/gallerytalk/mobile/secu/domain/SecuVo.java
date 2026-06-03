package com.gallerytalk.mobile.secu.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallerytalk.mobile.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class SecuVo extends PagingVo{
	
	String mac;
	String sn;	
}
