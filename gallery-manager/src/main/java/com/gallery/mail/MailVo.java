package com.gallery.mail;

import com.gallery.common.CommonCode;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Deprecated
@Data
@Alias("mailVo")
public class MailVo {
	String title;
	String content;
	String from;
	public String getFrom(){
		return CommonCode.ADMIN_MAIL_ADDRESS;
	}
	String to;

	Integer cstmrId;
	String pwkey;

}
