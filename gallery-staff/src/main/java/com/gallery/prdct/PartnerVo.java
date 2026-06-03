package com.gallery.prdct;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("partnerVo")
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
