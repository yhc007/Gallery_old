package com.gallery.comm;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Deprecated
@Controller
@RequestMapping(value = "/comm/")
@RequiredArgsConstructor
public class CommController {

    private final CommService commService;
    private static final Logger logger = LoggerFactory.getLogger(CommController.class);
    private static final String PARAMETER_REG_ID = "regId";
    private static final String PARAMETER_MAC_ADDR = "mac";

//    @RequestMapping("index.do")
//    public String index(Model model) {
//        logger.info("Welcome home! The client locale is {}.");
//
//        return "regist/indexRegist";
//    }
//
//    @RequestMapping("register.do")
//    public void regester(HttpServletRequest request, HttpServletResponse response, CommVo commVo) throws Exception {
//        commVo.setIpAddr(request.getRemoteAddr());
//        System.out.println("CALL register " + commVo.toString());
//        try {
//            commService.registId(commVo);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    @RequestMapping("unregister.do")
//    public void unregister(HttpServletRequest request, HttpServletResponse response, CommVo commVo) throws Exception {
//        commVo.setIpAddr(request.getRemoteAddr());
//        commService.unregistId(commVo);
//    }
//
//
//    @RequestMapping("visitShop.do")
//    public String visitShop(HttpServletRequest request, Model model, CommVo commVo) {
//        logger.info("Welcome home! The client locale is {}.");
//        //commService.test();
//        commVo.setIpAddr(request.getRemoteAddr());
//        try {
//            commService.visitShop(commVo);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return "home";
//    }
//
//    //String registrationId="APA91bHbbaGduvtyuBnhCrirwk9E1VIdT5c-hJthbj80mGghG20zRwnR0Qzof3AgimlYutGEdPs_7wKW1k9iQCCdvOhvJJp29LJtIJoEhO_4UTd2qrIFIeciYQezOtcfjh5iuIA6oy_VlqUQBDhvAyvpaTg8jvnH3w";
//    String registrationId = "APA91bH1rfd4Y1pQT-MV6X1l04jxLjFf-iKAHhB_XvLwCv-8YdqyqOxgk3aD2H2X270nPpnlC6hlC12TZN1viI-tLFHTp95JKSIaS3cGvz_OgBkxfvyH8vCIaIBbCRnWPIVTBKdR2NGIsxnqKTUwj6UVM_ModRQDsf8_QlHFeSo4gJxvxk_FxoU";
//    String registrationId1 = "APA91bGalDWZ9JCi7XrJBhFgRKqtrAFIfAjNRzb8fHidBWh2q9ccxP6O9YDHl67nqbjTivi9HMTDpml0ePmAIH3vClPa1NjquZiDD9PZWy21Z60OQEJCloFeDCG7r_Zn03yImgdCMr9xqLv4sFG3anRKlf-q79hG_uNGc6q7UrPNLDAtTPk-9gE";
//
//    @RequestMapping("sendTest.do")
//    public String send() {
//        Sender sender = new Sender(CommonCode.myApiKey);
//        int cnt = 0;
//        //System.out.println("target = "+target.toString());
//        //Message message = new Message.Builder().build();
//
//        Message message = new Message.Builder().addData("msg", "hi-newkie").build();
//        Result result = null;
//        try {
//            result = sender.send(message, registrationId, 5);
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//
//        System.out.println("======= Send ======");
//
//        if (result.getMessageId() != null) {
//            logger.debug("result.getMessageId() != null");
//            String canonicalRegId = result.getCanonicalRegistrationId();
//            logger.debug("canonicalRegId : " + canonicalRegId);
//            if (canonicalRegId != null) {
//                // same device has more than on registration ID: update database
//                logger.debug("same device has more than on registration ID: update database");
//            } else {
//                //
//            }
//        } else {
//            String error = result.getErrorCodeName();
//            logger.debug("[ERROR]" + error);
//
//            if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
//                // application has been removed from device - unregister
//                // database
//            }
//        }
//        return "home";
//    }
//
//    @RequestMapping("sendTest1.do")
//    public String send1() {
//        Sender sender = new Sender(CommonCode.myApiKey);
//        int cnt = 0;
//        //System.out.println("target = "+target.toString());
//        //Message message = new Message.Builder().build();
//
//        Message message = new Message.Builder().addData("msg", "hi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkiehi-newkie").build();
//        Result result = null;
//        try {
//            result = sender.send(message, registrationId1, 5);
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//
//        System.out.println("======= Send ======");
//
//        if (result.getMessageId() != null) {
//            logger.debug("result.getMessageId() != null");
//            String canonicalRegId = result.getCanonicalRegistrationId();
//            logger.debug("canonicalRegId : " + canonicalRegId);
//            if (canonicalRegId != null) {
//                // same device has more than on registration ID: update database
//                logger.debug("same device has more than on registration ID: update database");
//            } else {
//                //
//            }
//        } else {
//            String error = result.getErrorCodeName();
//            logger.debug("[ERROR]" + error);
//
//            if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
//                // application has been removed from device - unregister
//                // database
//            }
//        }
//        return "home";
//    }

}
