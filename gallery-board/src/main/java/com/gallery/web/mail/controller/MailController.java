package com.gallery.web.mail.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/mail")
@Controller
public class MailController {
	
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private MailSender mailSender;


	
	@RequestMapping(value = "sendMail")
	public String indexDlvrForm(HttpServletRequest request,ModelMap model) {
		String title = "test Title";
		String content = "test Content";

		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("max.lee@unomic.com");
		message.setSubject(title);
		message.setText(content);

		message.setTo("jaeokbr@naver.com");
		mailSender.send(message);
		return "home";
	}
	
	
}
