package com.gallery.company;

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


@RequestMapping(value = "/company")
@Controller
@RequiredArgsConstructor
public class CompanyController {

    private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
    private final CompanyService companyService;

    @RequestMapping(value = "indexCompanyForm.do")
    public String indexCompnayForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("매장관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("거래처 등록/수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);

        Integer lv = (Integer) session.getAttribute("lv");

        if (lv == null || lv < 1) {
            return "tiles:access/denied";
        } else if (lv == 3) {
            model.addAttribute("formnum", 3);
            return "tiles:prdct/indexPrdctConfirmForm";
        }

        model.addAttribute("formnum", 0);
        return "tiles:company/indexCompanyForm";
    }

    @RequestMapping(value = "addCompanyAction.do")
    @ResponseBody
    public String addCompanyAction(CompanyVo companyVo) {
        try {
            return companyService.addCompany(companyVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "modifyCompanyAction.do")
    @ResponseBody
    public String modifyCompanyAction(CompanyVo CompanyVo) {
        try {
            companyService.modifyCompany(CompanyVo);
            return "upsuccess";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removeCompanyAction.do")
    @ResponseBody
    public String removeCompanyAction(CompanyVo CompanyVo) {
        try {
            return companyService.removeCompany(CompanyVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listCompanyData.do")
    public String listCompnayData(CompanyVo CompanyVo, ModelMap model) {
        try {
            Map map = companyService.pagedListCompanyData(CompanyVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "company/listCompanyData";
    }

    @RequestMapping(value = "selectCompanyData.do")
    public String selectCompnayData(CompanyVo CompanyVo, ModelMap model) {
        try {
            Map map = companyService.selectCompanyData(CompanyVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/selectCompanyData";
    }

    @RequestMapping(value = "getCompanyData.do")
    @ResponseBody
    public CompanyVo getCompanyData(CompanyVo CompanyVo) throws Exception {
        return companyService.selectCompany(CompanyVo);
    }

    @RequestMapping(value = "getListCom.do")
    public String getListCom(ModelMap model, CompanyVo companyVo) {
        try {
            Map map = companyService.getListCom(companyVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "company/listCompanyDataForManager";
    }

    @RequestMapping(value = "indexComStaff.do")
    public String indexComStaff(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("매장관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("거래처 직원 등록/수정", 620, "left", 20));

        model.addAttribute("formnum", 4);
        model.addAttribute("tlist", tlist);
        return "tiles:shop/comStaffIndex";
    }

    @RequestMapping(value = "getComTy.do")
    @ResponseBody
    public String getComTy(CompanyVo companyVo) {
        try {
            return companyService.getComTy(companyVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "addCompanyTy.do")
    @ResponseBody
    public void addCompanyTy(CompanyVo companyVo) {
        try {
            companyService.addCompanyTy(companyVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
