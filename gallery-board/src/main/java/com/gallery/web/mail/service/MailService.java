package com.gallery.web.mail.service;

import com.gallery.web.mail.domain.MailVo;

public interface MailService {
	public void sendMail(MailVo mailVo) throws Exception;
}
