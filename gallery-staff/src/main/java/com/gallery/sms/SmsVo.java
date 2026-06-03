package com.gallery.sms;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Deprecated
@Data
@Alias("smsVo")
public class SmsVo{
	Integer cardComId;
	String cardComName;

	Integer saleId;
	Integer cancel;
	String cancelMemo;
	String cancelCd;

}
