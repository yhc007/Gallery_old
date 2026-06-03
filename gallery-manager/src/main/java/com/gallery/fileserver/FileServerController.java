package com.gallery.fileserver;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/fileserver")
@Controller
@RequiredArgsConstructor
public class FileServerController {

    private static final Logger logger = LoggerFactory.getLogger(FileServerController.class);
    private final FileServerService fileServerService;

    @RequestMapping(value = "indexFileServerForm.do")
    public String indexFileServerForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("파일서버 등록/수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 1);

        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:fileserver/indexFileServerForm";
    }

    @RequestMapping(value = "addFileServerAction.do")
    @ResponseBody
    public String addFileServerAction(FileServerVo fileServerVo) {
        logger.debug("call add " + fileServerVo.toString());
        // 업로드한 파일이 존재하면
        try {
            return fileServerService.addFileServer(fileServerVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "modifyFileServerAction.do")
    @ResponseBody
    public String modifyFileServerAction(FileServerVo fileServerVo) {
        logger.debug("modify " + fileServerVo.toString());
        try {
            fileServerService.modifyFileServer(fileServerVo);
            return "upsuccess";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removeFileServerAction.do")
    @ResponseBody
    public String removeFileServerAction(FileServerVo fileServerVo) {
        logger.debug("remove " + fileServerVo.toString());
        try {
            fileServerService.removeFileServer(fileServerVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listFileServerData.do")
    public String listFileServerData(FileServerVo fileServerVo, ModelMap model) {
        try {
            Map map = fileServerService.pagedListFileServerData(fileServerVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fileserver/listFileServerData";
    }

    @RequestMapping(value = "getFileServerData.do")
    @ResponseBody
    public FileServerVo getFileServerData(FileServerVo fileServerVo) throws Exception {
        return fileServerService.selectFileServer(fileServerVo);
    }

    @RequestMapping(value = "createCouponPage.do")
    public String createCouponPage(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("쿠폰 생성", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:fileserver/createCouponPage";
    }

    @RequestMapping(value = "createCoupon.do")
    @ResponseBody
    public String createCoupon(FileServerVo fileVo) {
        try {
            return fileServerService.createCoupon(fileVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "createCouponForLunar.do")
    @ResponseBody
    public String createCouponForLunar(FileServerVo fileVo) {
        try {
            return fileServerService.createCouponForLunar(fileVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getCouponList.do")
    public String getCouponList(FileServerVo fileVo, ModelMap model) {
        try {
            Map map = fileServerService.getCouponList(fileVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fileserver/listCouponData";
    }

    @RequestMapping(value = "getCouponListCsv.do")
    public String getCouponListCsv(FileServerVo fileVo, ModelMap model) {
        try {
            Map map = fileServerService.getCouponList(fileVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fileserver/listCouponDataCsv";
    }
}
