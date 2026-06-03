package com.gallerytalk.mobile.talkgroup.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallerytalk.mobile.shop.service.ShopService;
import com.gallerytalk.mobile.staff.service.StaffService;
import com.gallerytalk.mobile.talkgroup.domain.TalkGroupVo;
import com.gallerytalk.mobile.talkgroup.service.TalkGroupService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/talkGroup")
@Controller
public class TalkGruopController {

    private static final Logger logger = LoggerFactory.getLogger(TalkGruopController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */
    @Autowired
    private StaffService staffService;

    @Autowired
    private ShopService shopService;

    @Autowired
    private TalkGroupService talkGroupService;

    //@RequestMapping(value="/fox", produces="text/html;charset=UTF-8")
    @RequestMapping(value = "getShopList.do")
    public void getShopList(TalkGroupVo talkGroupVo, HttpServletResponse response, ModelMap model) throws Exception {
        logger.info("run getShopList");
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        Map map = new HashMap();
        try {
            map = talkGroupService.responseShopData(response);
            map.put("result", "ok");
            str = om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
            logger.info("str:" + str);
        } catch (Exception e) {
            // TODO: handle exception
            //e.printStackTrace();
            logger.error("");
            map.put("result", "error");
        }
        writer.write(str);

        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "getCompList.do")
    public void getCompList(TalkGroupVo talkGroupVo, HttpServletResponse response) throws Exception {
        logger.info("run getCompList");
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        Map map = new HashMap();
        try {
            map = talkGroupService.responseCompData(response);
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

}
