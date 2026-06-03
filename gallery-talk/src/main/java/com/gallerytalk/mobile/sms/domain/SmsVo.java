package com.gallerytalk.mobile.sms.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SmsVo{
	Integer cardComId;
	String cardComName;
	
	Integer saleId; 
	Integer cancel;
	String cancelMemo;
	String cancelCd;
	
}