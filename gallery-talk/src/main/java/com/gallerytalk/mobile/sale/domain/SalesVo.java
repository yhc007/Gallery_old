package com.gallerytalk.mobile.sale.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SalesVo{
	String shopName;
	Integer total;
	Integer payCash;
	Integer payCard;
	Integer framePrc;
	Integer lensPrc;
	public SalesVo(){
		
	}
}
