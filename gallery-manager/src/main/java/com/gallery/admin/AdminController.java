package com.gallery.admin;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.prdct.PrdctVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/admin")
@Controller
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

    @Deprecated
    @RequestMapping(value = "loginForm.do")
    public String loginForm() {
        return "tiles:admin/loginForm";
    }

    @RequestMapping(value = "login.do")
    @ResponseBody
    public String login(HttpServletRequest request, HttpSession session, AdminVo adminVo) {
        session.setAttribute("myIP", request.getRemoteAddr());
        String ip = request.getRemoteAddr();
        try {
            AdminVo result = adminService.login(adminVo);
            if (result != null) {
                Integer lv = Integer.parseInt(result.getLv());
                if (result.getShopId() != null) {
                    Integer shopId = Integer.parseInt(result.getShopId());

                    adminVo.setShopId(shopId.toString());
                    adminVo.setIp(ip);
                    adminService.clientIp(adminVo);

                    session.setAttribute("shopId", shopId);
                    session.setAttribute("shopName", result.getShopName());
                }
                session.setAttribute("lv", lv);
                session.setAttribute("i_num", result.getInum());

                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "logOut.do")
    public String logOut(HttpServletRequest request, ModelMap model, HttpSession session, AdminVo adminVo) {
        session.removeAttribute("lv");
        session.removeAttribute("shopId");
        session.removeAttribute("shopName");
        return "tiles:admin/loginForm";
    }

    @RequestMapping(value = "notice1.do")
    public String indexCstmrForm(HttpServletResponse response, HttpSession session) {
        return "admin/notice1";
    }

    @RequestMapping(value = "pointManager.do")
    public String pointManager(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("포인트 관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 3);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:point/pointPage";
    }

    @RequestMapping(value = "chkEyesManager.do")
    public String chkEyesManager(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("검안 대상자", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 4);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/chkEyesManager";
    }

    @RequestMapping(value = "mergeCstmr.do")
    public String mergeCstmr(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("고객관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 5);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/mergeCstmr";
    }

    @RequestMapping(value = "listCstmrInfo.do")
    public String listCstmrInfo(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("고객정보", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 6);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/listCstmrInfo";
    }

    @Deprecated
    @RequestMapping(value = "pointManager2.do")
    public String pointManager2(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("포인트 조정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 6);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/pointManager";
    }

    @RequestMapping(value = "prdctRankingForm.do")
    public String prdctRankingForm(PrdctVo prdctVo, ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("판매 제품 관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 4);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/prdctRanking";
    }

    @RequestMapping(value = "comTradeForm.do")
    public String comTradeForm(PrdctVo prdctVo, ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("거래처별 거래 관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 5);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/comTrade";
    }

    @RequestMapping(value = "modifyDateForm.do")
    public String modifyDateForm(PrdctVo prdctVo, ModelMap model, HttpServletRequest request, HttpSession session) {

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("시스템", 120, "center", 0));
        tlist.add(new MenuTreeVo("거래 날짜 변경", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 6);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:admin/modifyDate";
    }

    @RequestMapping(value = "getDscntList.do")
    public String getDscntList(AdminVo adminVo, ModelMap model) {
        try {
            Map map = adminService.getDscntList(adminVo);
            model.addAllAttributes(map);
        } catch (Exception e) {

            e.printStackTrace();
        }
        return "admin/listComDscnt";
    }

    @RequestMapping(value = "getDscntListForCSV.do")
    @ResponseBody
    public String getDscntListForCSV(AdminVo adminVo) {
        try {
            return adminService.getDscntListForCSV(adminVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
