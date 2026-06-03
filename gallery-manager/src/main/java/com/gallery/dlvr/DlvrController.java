package com.gallery.dlvr;

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
import java.util.Date;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/dlvr")
@Controller
@RequiredArgsConstructor
public class DlvrController {

    private static final Logger logger = LoggerFactory.getLogger(DlvrController.class);
    private final DlvrService dlvrService;

    @RequestMapping(value = "indexDlvrForm.do")
    public String indexDlvrForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("배송 관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 6);

        Date date = new Date();
        model.addAttribute("cyear", date.getYear() + 1900);
        model.addAttribute("cmonth", date.getMonth() + 1);
        model.addAttribute("cday", date.getDate());

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:dlvr/indexDlvrForm";
    }

    @Deprecated
    @RequestMapping(value = "newDlvrForm.do")
    public String newDlvrForm(HttpServletRequest request, ModelMap model) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("이벤트 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("이벤트 등록/수정", 500, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 5);

        Date date = new Date();
        model.addAttribute("cyear", date.getYear());
        model.addAttribute("cmonth", date.getMonth() + 1);
        model.addAttribute("cday", date.getDate());
        return "tiles:dlvr/newDlvrForm";
    }

    @Deprecated
    @RequestMapping(value = "addDlvrAction.do")
    @ResponseBody
    public String addDlvrAction(DlvrVo dlvrVo) {
        try {
            return dlvrService.addDlvr(dlvrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Deprecated
    @RequestMapping(value = "modifyDlvrAction.do")
    @ResponseBody
    public String modifyDlvrAction(DlvrVo dlvrVo) {
        logger.debug("modify " + dlvrVo.toString());
        try {
            dlvrService.modifyDlvr(dlvrVo);
            return "upsuccess";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listDlvrData.do")
    public String listDlvrData(DlvrVo dlvrVo, ModelMap model) {
        logger.debug("listDlvrData " + dlvrVo.toString());
        try {
            Map map = dlvrService.listDlvrData(dlvrVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "dlvr/listDlvrData";
    }

    @Deprecated
    @RequestMapping(value = "getDlvrData.do")
    @ResponseBody
    public DlvrVo getDlvrData(DlvrVo dlvrVo) throws Exception {
        return dlvrService.selectDlvr(dlvrVo);
    }

    @Deprecated
    @RequestMapping(value = "removeDlvrAction.do")
    @ResponseBody
    public String removeDlvrAction(DlvrVo dlvrVo) throws Exception {
        logger.debug("removeDlvrAction" + dlvrVo.toString());
        return dlvrService.removeDlvr(dlvrVo);
    }

    @Deprecated
    @RequestMapping(value = "popupDlvrPrdctForm.do")
    public String popupDlvrPrdctForm(ModelMap model) {
        logger.debug("CALL popupDlvrPrdctForm");
        return "dlvr/popupDlvrPrdctForm";
    }
}
