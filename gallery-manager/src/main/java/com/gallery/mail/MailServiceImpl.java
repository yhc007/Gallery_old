//package com.gallery.mail;
//
//import com.gallery.common.CommonCode;
//import lombok.RequiredArgsConstructor;
//import org.springframework.mail.MailSender;
//import org.springframework.mail.SimpleMailMessage;
//import org.springframework.stereotype.Repository;
//import org.springframework.stereotype.Service;
//
//@Deprecated
//@Service
//@RequiredArgsConstructor
//public class MailServiceImpl implements MailService {
//    private final MailSender mailSender;
//
//    public void sendMail(MailVo mailVo) {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom(mailVo.getFrom());
//        message.setSubject(mailVo.getTitle());
//        message.setText(mailVo.getContent().replaceAll(CommonCode.PW_KEY_TAG, mailVo.getPwkey()));
//
//        message.setTo(mailVo.getTo());
//        mailSender.send(message);
//    }
//}
