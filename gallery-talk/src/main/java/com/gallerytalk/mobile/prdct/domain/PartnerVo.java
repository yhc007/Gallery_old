package com.gallerytalk.mobile.prdct.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PartnerVo{
	Integer partnerId;
	String partnerName;
	String prdctTyCd;
	Integer dscntPrcnt;
	String partnerCert;
	String partnerMemo;
	
	public Integer getDscntPrcnt(){
		if(dscntPrcnt==null)return 0;
		return dscntPrcnt;
	}
}
