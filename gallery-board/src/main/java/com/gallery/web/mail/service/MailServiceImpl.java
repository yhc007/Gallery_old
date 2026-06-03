package com.gallery.web.mail.service;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.mail.domain.MailVo;


@Service
@Repository
public class MailServiceImpl extends SqlSessionDaoSupport implements MailService {
	private final static String namespace= "com.gallery.media.";
	
	@Autowired
	private MailSender mailSender;
	
	public void sendMail(MailVo mailVo) throws Exception{
		System.out.println("sendMail "+mailVo.toString());
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(mailVo.getFrom());
		message.setSubject(mailVo.getTitle());
		message.setText(mailVo.getContent().replaceAll(CommonCode.PW_KEY_TAG, mailVo.getPwkey()));

		message.setTo(mailVo.getTo());
		mailSender.send(message);
	}
}
