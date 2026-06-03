//package com.gallery.mail;
//
//import com.gallery.common.CommonCode;
//import lombok.RequiredArgsConstructor;
//import org.springframework.mail.MailSender;
//import org.springframework.mail.SimpleMailMessage;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.ModelMap;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import javax.servlet.http.HttpServletRequest;
//
//@Deprecated
//@RequestMapping(value = "/mail")
//@Controller
//@RequiredArgsConstructor
//public class MailController {
//
//	private final MailSender mailSender;
//
//	@RequestMapping(value = "sendMail.do")
//	public String indexDlvrForm(HttpServletRequest request,ModelMap model) {
//		String title = "test Title";
//		String content = "test Content";
//
//		SimpleMailMessage message = new SimpleMailMessage();
//		message.setFrom(CommonCode.ADMIN_MAIL_ADDRESS);
//		message.setSubject(title);
//		message.setText(content);
//
//		message.setTo("jaeokbr@naver.com");
//		mailSender.send(message);
//		return "home";
//	}
//}
