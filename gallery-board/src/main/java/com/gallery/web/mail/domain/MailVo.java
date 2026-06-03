package com.gallery.web.mail.domain;

import java.util.List;

import org.springframework.mail.SimpleMailMessage;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.fileupload.FileUploadForm;

@Getter
@Setter
@ToString
public class MailVo {
	String title;
	String content;
	String from;
	public String getFrom(){
		return "max.lee@unomic.com";
	}
	String to;
	
	Integer cstmrId;
	String pwkey;
	
}
