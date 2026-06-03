package com.gallerytalk.mobile.comm.controller;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallerytalk.mobile.comm.domain.CommVo;
import com.gallerytalk.mobile.comm.service.CommService;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.staff.domain.StaffVo;
import com.gallerytalk.mobile.staff.service.StaffService;
import com.gallerytalk.mobile.talkgroup.domain.TalkGroupVo;
import com.gallerytalk.mobile.talkgroup.service.TalkGroupService;
import com.google.android.gcm.server.Constants;
import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/comm/")
public class CommController {
    @Autowired
    private CommService commService;

    @Autowired
    private TalkGroupService talkGroupService;

    @Autowired
    private StaffService staffGroupService;
    private static final Logger logger = LoggerFactory.getLogger(CommController.class);
    private static final String PARAMETER_REG_ID = "regId";
    private static final String PARAMETER_MAC_ADDR = "mac";

    /**
     * Simply selects the home view to render by returning its name.
     */

    @RequestMapping("index")
    public String index(Model model) {
        logger.info("Welcome home! The client locale is {}.");
        //commService.test();

        return "regist/indexRegist";
    }

    @RequestMapping("sendMsg")
    @ResponseBody
    public String sendMsg(CommVo commVo) {

        int cnt = 0;
        String msg = "";
        ObjectMapper om = new ObjectMapper();
        TimeZone tz;
        Date today = new Date();
        //DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss (z Z)");
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        tz = TimeZone.getTimeZone("Asia/Seoul");
        df.setTimeZone(tz);
        String thisTime = df.format(today);

        logger.info("msg:" + commVo.getMsg());
        logger.info("decoded msg:" + URLDecoder.decode(commVo.getMsg()), "utf-8");

        Map map = new HashMap();

        map.put("type", "chat");
        map.put("msg", commVo.getMsg());
        map.put("from", commVo.getSendGid());
        map.put("fromName", commVo.getSendName());
        map.put("to", commVo.getRcvGid());
        map.put("time", thisTime);

        try {
            msg = om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
        } catch (JsonGenerationException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        } catch (JsonMappingException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        } catch (IOException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        }
        logger.info("json4gcm:" + msg);

        //return "test";

        Message message = new Message.Builder().addData("msg", msg).build();

        TalkGroupVo rcvGroupVo = new TalkGroupVo();
        TalkGroupVo sndGroupVo = new TalkGroupVo();
        List<TalkGroupVo> listRecvStaff = new ArrayList<TalkGroupVo>();
        List<TalkGroupVo> listSendStaff = new ArrayList<TalkGroupVo>();
        rcvGroupVo.setGroupId(commVo.getRcvGid());
        sndGroupVo.setGroupId(commVo.getSendGid());

        logger.info("step1");
        try {
            listRecvStaff = talkGroupService.getListStaffGid(rcvGroupVo);
            listSendStaff = talkGroupService.getListStaffGid(sndGroupVo);
            logger.info("step2");
        } catch (Exception e1) {
            // TODO Auto-generated catch block
            try {
                logger.info("step3");
                commVo.setResult(CommonCode.CODE_GCM_FAIL);
                commService.addMsgLog(commVo);
            } catch (Exception e) {
                logger.info("step4");
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            e1.printStackTrace();
            logger.info("step5");
            return "no";
        }
        String gcmResult;
        boolean checker;
        logger.info("step6");
        if (!commVo.getSendGid().equals(commVo.getRcvGid())) {
            logger.info("step7");
            logger.info("run send and rcv is not equal");
            checker = ("ok" == sendGCM(commVo, listRecvStaff, rcvGroupVo, message)
                    && "ok" == sendGCM(commVo, listSendStaff, sndGroupVo, message));
        } else {
            logger.info("step8");
            logger.info("run send and rcv is equal");
            checker = ("ok" == sendGCM(commVo, listRecvStaff, rcvGroupVo, message));
        }
        logger.info("step9");
        if (checker) {
            logger.info("step10");
            try {
                logger.info("add msg success");
                commVo.setResult(CommonCode.CODE_GCM_SUCCESS);
                commService.addMsgLog(commVo);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                logger.info("step11");
            }
            logger.info("step12");
            return "ok";
        } else {
            logger.info("step13");
            try {
                logger.info("add msg fail");
                commVo.setResult(CommonCode.CODE_GCM_FAIL);
                commService.addMsgLog(commVo);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            logger.info("step14");
            return "fail";
        }

    }

    private String sendGCM(CommVo commVo, List<TalkGroupVo> listStaff, TalkGroupVo talkGroupVo, Message message) {
        Sender sender = new Sender(CommonCode.myApiKey);

        logger.info("listTalkGrouopVo" + listStaff);
        Iterator<TalkGroupVo> itr = listStaff.iterator();
        TalkGroupVo rcvGroupVo;
        Result result = null;

        while (itr.hasNext()) {
            rcvGroupVo = itr.next();
            logger.info("@@@@@ talkGroupVo:" + rcvGroupVo);

            try {
                result = sender.send(message, rcvGroupVo.getRegId(), 5);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            logger.info("======= Send ======");
            StaffVo staffVo = new StaffVo();
            staffVo.setPhone(rcvGroupVo.getPhone());
            if (result.getMessageId() != null) {
                logger.debug("result.getMessageId() != null");
                String canonicalRegId = result.getCanonicalRegistrationId();
                logger.debug("canonicalRegId : " + canonicalRegId);
                if (canonicalRegId != null) {
                    staffVo.setRegId(canonicalRegId);
                    // same device has more than on registration ID: update database
                    logger.debug("same device has more than on registration ID: update database");
                } else {
                    //
                }
            } else {
                String error = result.getErrorCodeName();
                logger.debug("[ERROR]" + error);
                if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
                    // application has been removed from device - unregister
                    // database
                    logger.info("ERROR_NOT_REGISTERED");
                    staffVo.setRegId(null);
                }

                try {
                    logger.info("add msg fail");
                    commVo.setResult(CommonCode.CODE_GCM_FAIL);
                    commService.addMsgLog(commVo);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                //return "error";
            }
            try {
                //
                //staffGroupService.setUserRegId(staffVo);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        return "ok";

    }

    @RequestMapping(value = "listTalkGroup.do")
    public void listTalkGroup(CommVo commVo, HttpServletResponse response) throws Exception {
        logger.info("run getCompList");
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        Map map = new HashMap();
        try {
            map = commService.responseTalkingGroupData(response, commVo);
            map.put("result", "ok");
            str = om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
            logger.info("str:" + str);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            logger.error("");
            map.put("result", "error");
        }
        writer.write(str);

        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "unRegUser.do")
    public void unRegUser(CommVo commVo, HttpServletResponse response) throws Exception {
        logger.info("run getCompList");
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        String regId = commService.getRegId(commVo);
        if (regId.equals("fail")) {
            logger.error("Staff does not exist.");
        }

        Map map = new HashMap();

        map.put("type", "regno");
        map.put("msg", null);
        map.put("from", null);
        map.put("fromName", null);
        map.put("to", null);
        map.put("time", null);

        String msg = "";
        ObjectMapper om = new ObjectMapper();
        try {
            msg = om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
        } catch (JsonGenerationException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        } catch (JsonMappingException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        } catch (IOException e2) {
            // TODO Auto-generated catch block
            e2.printStackTrace();
        }
        logger.info("json4gcm:" + msg);

        //return "test";
        Message message = new Message.Builder().addData("msg", msg).build();
        Sender sender = new Sender(CommonCode.myApiKey);

        Result result = sender.send(message, regId, 5);

    }
}
