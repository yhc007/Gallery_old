package com.gallerytalk.mobile.sms.controller;

import com.gallerytalk.mobile.payment.service.PaymentService;
import com.gallerytalk.mobile.point.service.PointService;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;
import com.gallerytalk.mobile.saleJob.service.SaleJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.InetAddress;
import java.net.Socket;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Random;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/sms")
@Controller

public class SmsController {

    private static final Logger logger = LoggerFactory.getLogger(SmsController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private SaleJobService saleJobService;

    @Autowired
    private PointService pointService;

    @Autowired
    private SaleService saleService;

    @Autowired
    private PrdctService prdctService;

    @RequestMapping(value = "smsTest")
    public String smsTest(SaleVo saleVo, ModelMap model, String cstmrId) {
        logger.info("run smsTest");

        return "sms/smsTest";
    }
//	<%@ page language="java" import="java.util.*, java.security.*, java.io.*, java.net.*" %>
//	<%!
    /**====================================================================================
     Description        :  사용 함수 선언
     ====================================================================================**/
    /**
     * nullcheck
     *
     * @param str, Defaultvalue
     * @return
     */

    public static String nullcheck(String str, String Defaultvalue) throws Exception {
        String ReturnDefault = "";
        if (str == null) {
            ReturnDefault = Defaultvalue;
        } else if (str == "") {
            ReturnDefault = Defaultvalue;
        } else {
            ReturnDefault = str;
        }
        return ReturnDefault;
    }

    /**
     * BASE64 Encoder
     *
     * @param str
     * @return
     */
    public static String base64Encode(String str) throws java.io.IOException {
        byte[] strByte = str.getBytes();
        String result = Base64.getEncoder().encodeToString(strByte);
        return result;
    }

    /**
     * BASE64 Decoder
     *
     * @param str
     * @return
     */
    public static String base64Decode(String str) throws java.io.IOException {
        byte[] strByte = Base64.getDecoder().decode(str);
        String result = new String(strByte);
        return result;
    }
//	%>
//	<%
    /**====================================================================================
     Description        : 캐릭터셋 정의
     EUC-KR: @ page contentType="text/html;charset=EUC-KR
     UTF-8: @ page contentType="text/html;charset=UTF-8
     ====================================================================================**/
//	%>
//	<%@ page contentType="text/html;charset=EUC-KR"%>
//	<%

    /**
     * ====================================================================================
     * Description        :  사용자 샘플코드
     * ====================================================================================
     **/
    //String charsetType = "EUC-KR"; //EUC-KR 또는 UTF-8
    @RequestMapping(value = "sendSms")
    public String smsTest(SaleVo saleVo, ModelMap model, String cstmrId, HttpServletResponse response) throws UnsupportedEncodingException {
        logger.info("run listSaleOffHist saleVo:" + saleVo);
        String charsetType = "UTF-8";


        //request.setCharacterEncoding(charsetType);
        response.setCharacterEncoding(charsetType);
        String action;
        try {
            //action = nullcheck(request.getParameter("action"), "");
            //if(action.equals("go")) {

            String sms_url = "";
            sms_url = "http://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
            String user_id = base64Encode("unomic3"); // SMS아이디
            String secure = base64Encode("6726f6e66a388c35c88793ac2e1233be");//인증키
            //String msg = base64Encode(nullcheck(request.getParameter("msg"), "테스트 메세지 입니다."));
            String msg = base64Encode("테스트 메세지 입니다.");
            //String rphone = base64Encode(nullcheck(request.getParameter("rphone"), "010-8576-5646"));
            String rphone = base64Encode("010-8576-5646");
            //String sphone1 = base64Encode(nullcheck(request.getParameter("sphone1"), "010"));
            String sphone1 = base64Encode("010");
            //String sphone2 = base64Encode(nullcheck(request.getParameter("sphone2"), "1234"));
            String sphone2 = base64Encode("1234");
            //String sphone3 = base64Encode(nullcheck(request.getParameter("sphone3"), "5678"));
            String sphone3 = base64Encode("5678");

            //String rdate = base64Encode(nullcheck(request.getParameter("rdate"), ""));
            String rdate = base64Encode("");

            //String rtime = base64Encode(nullcheck(request.getParameter("rtime"), ""));
            String rtime = base64Encode("");

            String mode = base64Encode("1");
            //String testflag = base64Encode(nullcheck(request.getParameter("testflag"), ""));
            String testflag = base64Encode("");
            //String destination = base64Encode(nullcheck(request.getParameter("destination"), ""));
            String destination = base64Encode("");
            //String repeatFlag = base64Encode(nullcheck(request.getParameter("repeatFlag"), ""));
            String repeatFlag = base64Encode("");
//			    String repeatNum = base64Encode(nullcheck(request.getParameter("repeatNum"), ""));
            String repeatNum = base64Encode("");
//			    String repeatTime = base64Encode(nullcheck(request.getParameter("repeatTime"), ""));
            String repeatTime = base64Encode("");
//			    String returnurl = nullcheck(request.getParameter("returnurl"), "jaguar.s4g.kr/sms/smsTest.do");
            String returnurl = "jaguar.s4g.kr/sms/smsTest.do";
//			    String nointeractive = nullcheck(request.getParameter("nointeractive"), "");
            String nointeractive = base64Encode("");

            String[] host_info = sms_url.split("/");
            String host = host_info[2];
            String path = "/" + host_info[3];
            int port = 80;

            // 데이터 맵핑 변수 정의
            String arrKey[]
                    = new String[]{"user_id", "secure", "msg", "rphone", "sphone1", "sphone2", "sphone3", "rdate", "rtime"
                    , "mode", "testflag", "destination", "repeatFlag", "repeatNum", "repeatTime"};
            String valKey[] = new String[arrKey.length];
            valKey[0] = user_id;
            valKey[1] = secure;
            valKey[2] = msg;
            valKey[3] = rphone;
            valKey[4] = sphone1;
            valKey[5] = sphone2;
            valKey[6] = sphone3;
            valKey[7] = rdate;
            valKey[8] = rtime;
            valKey[9] = mode;
            valKey[10] = testflag;
            valKey[11] = destination;
            valKey[12] = repeatFlag;
            valKey[13] = repeatNum;
            valKey[14] = repeatTime;

            String boundary = "";
            Random rnd = new Random();
            String rndKey = Integer.toString(rnd.nextInt(32000));
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytData = rndKey.getBytes();
            md.update(bytData);
            byte[] digest = md.digest();
            for (int i = 0; i < digest.length; i++) {
                boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
            }
            boundary = "---------------------" + boundary.substring(0, 10);

            // 본문 생성
            String data = "";
            String index = "";
            String value = "";
            for (int i = 0; i < arrKey.length; i++) {
                index = arrKey[i];
                value = valKey[i];
                data += "--" + boundary + "\r\n";
                data += "Content-Disposition: form-data; name=\"" + index + "\"\r\n";
                data += "\r\n" + value + "\r\n";
                data += "--" + boundary + "\r\n";
            }

            //out.println(data);

            InetAddress addr = InetAddress.getByName(host);
            Socket socket = new Socket(host, port);
            // 헤더 전송
            BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
            wr.write("POST " + path + " HTTP/1.0\r\n");
            wr.write("Content-Length: " + data.length() + "\r\n");
            wr.write("Content-type: multipart/form-data, boundary=" + boundary + "\r\n");
            wr.write("\r\n");

            // 데이터 전송
            wr.write(data);
            wr.flush();

            // 결과값 얻기
            BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(), charsetType));
            String line;
            String alert = "";
            ArrayList tmpArr = new ArrayList();
            while ((line = rd.readLine()) != null) {
                tmpArr.add(line);
            }
            wr.close();
            rd.close();

            String tmpMsg = (String) tmpArr.get(tmpArr.size() - 1);
            String[] rMsg = tmpMsg.split(",");
            String Result = rMsg[0]; //발송결과
            String Count = ""; //잔여건수
            if (rMsg.length > 1) {
                Count = rMsg[1];
            }

            //발송결과 알림
            if (Result.equals("success")) {
                alert = "성공적으로 발송하였습니다.";
                alert += " 잔여건수는 " + Count + "건 입니다.";
            } else if (Result.equals("reserved")) {
                alert = "성공적으로 예약되었습니다";
                alert += " 잔여건수는 " + Count + "건 입니다.";
            } else if (Result.equals("3205")) {
                alert = "잘못된 번호형식입니다.";
            } else {
                alert = "[Error]" + Result;
            }

            //out.println(nointeractive);
            logger.info("nointeractive" + nointeractive);

            if (nointeractive.equals("1") && !(Result.equals("Test Success!")) && !(Result.equals("success")) && !(Result.equals("reserved"))) {
                //out.println("<script>alert('" + alert + "')</script>");
                logger.info("<script>alert('" + alert + "')</script>");
            } else if (!(nointeractive.equals("1"))) {
                //out.println("<script>alert('" + alert + "')</script>");
                logger.info("<script>alert('" + alert + "')</script>");
            }

            //out.println("<script>location.href='"+returnurl+"';</script>");
            logger.info("<script>alert('" + alert + "')</script>");
            //}
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String testReturn = "success";
        return testReturn;

    }

}