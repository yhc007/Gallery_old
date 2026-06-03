package com.gallery.invn;

import com.gallery.admin.AdminService;
import com.gallery.admin.AdminVo;
import com.gallery.brand.BrandService;
import com.gallery.brand.BrandVo;
import com.gallery.prdct.PrdctService;
import com.gallery.prdct.PrdctVo;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;


@RequestMapping(value = "/invn")
@Controller
@RequiredArgsConstructor
public class InvnController {

    private final AdminService adminService;
    private final PrdctService prdctService;
    private final BrandService brandService;

    @RequestMapping(value = "index.do")
    public String index(HttpServletRequest request, ModelMap model, HttpSession session) {
        return "invn/login";
    }

    @RequestMapping(value = "indexM.do")
    public String indexM(HttpServletRequest request, ModelMap model, HttpSession session) {
        return "invn/loginM";
    }

    @RequestMapping(value = "login.do")
    @ResponseBody
    public String login(HttpServletRequest request, ModelMap model, HttpSession session, AdminVo adminVo) {
        try {
            AdminVo result = adminService.login(adminVo);
            if (result == null) {
                return "fail";
            } else {
                if (result.getShopId() != null) {
                    Integer shopId = Integer.parseInt(result.getShopId());
                    session.setAttribute("shopId", shopId);
                    session.setAttribute("shopName", result.getShopName());
                }
                Integer lv = Integer.parseInt(result.getLv());
                session.setAttribute("lv", lv);
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "srchPrdct.do")
    public String srchPrdct(PrdctVo prdctVo, HttpSession session) {
        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 1) ? "invn/denied" : "invn/srchPrdct";
    }

    @RequestMapping(value = "srchPrdctM.do")
    public String srchPrdctM(PrdctVo prdctVo, HttpSession session) {
        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 1) ? "invn/deniedM" : "invn/srchPrdctM";
    }

    @RequestMapping(value = "logOut.do")
    public String logOut(HttpServletRequest request, ModelMap model, HttpSession session, AdminVo adminVo) {
        session.removeAttribute("lv");
        session.removeAttribute("shopId");
        session.removeAttribute("shopName");

        return "invn/login";
    }

    @RequestMapping(value = "logOutM.do")
    public String logOutM(HttpServletRequest request, ModelMap model, HttpSession session, AdminVo adminVo) {
        session.removeAttribute("lv");
        session.removeAttribute("shopId");
        session.removeAttribute("shopName");

        return "invn/loginM";
    }

    @RequestMapping(value = "addPrdct.do")
    public String addPrdct(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 1) ? "invn/denied" : "invn/addPrdct";
    }

    @RequestMapping(value = "addPrdctM.do")
    public String addPrdctM(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 1) ? "invn/deniedM" : "invn/addPrdctM";
    }

    @RequestMapping(value = "getBrandList.do")
    public String getBrandList(BrandVo brandVo, ModelMap model) {
        try {
            Map map = brandService.listBrandByTy(brandVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listBrandData";
    }

    @RequestMapping(value = "srchBrand.do")
    public String srchBrand(BrandVo brandVo, ModelMap model) {
        try {
            Map map = brandService.srchBrand(brandVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listBrandData";
    }

    @RequestMapping(value = "getCountryList.do")
    public String listCntryData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getCntryList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listCntryData";
    }

    @RequestMapping(value = "addInvn.do")
    @ResponseBody
    public String addInvn(PrdctVo prdctVo) {
        try {
            return prdctService.addPrdctInvn(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getInvnList.do")
    public String getInvnList(ShopVo shopVo, ModelMap model) {
        try {
            Map map = prdctService.getInvnList(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listInvnData";
    }

    @RequestMapping(value = "getInvnHist.do")
    public String getInvnHist(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getInvnHist(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listInvnHistData";
    }

    @RequestMapping(value = "getMtrlList.do")
    public String getMtrlList(ModelMap model) {
        try {
            Map map = prdctService.getMtrlList();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listPrdctMtrlData";
    }

    @RequestMapping(value = "getPrdctId.do")
    @ResponseBody
    public Integer getPrdctId(PrdctVo prdctVo) {
        try {
            return prdctService.getPrdctId(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @RequestMapping(value = "editInvn.do")
    @ResponseBody
    public PrdctVo editInvn(PrdctVo prdctVo, ModelMap model) {
        try {
            return prdctService.getInvnEditForm(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "modifyInvn.do")
    @ResponseBody
    public String modifyInvn(PrdctVo prdctVo) {
        try {
            return prdctService.modifyInvnPrdct(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "insertDiffClr.do")
    @ResponseBody
    public Integer insertDiffClr(PrdctVo prdctVo) {
        try {
            return prdctService.insertDiffClr(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @RequestMapping(value = "getColorList.do")
    public String getColorList(ModelMap model) {
        try {
            Map map = prdctService.getColorList();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listPrdctColorData";
    }

    @RequestMapping(value = "getComPrdctEditForm.do")
    @ResponseBody
    public PrdctVo getComPrdctEditForm(PrdctVo prdctVo, ModelMap model) {
        try {
            prdctVo = prdctService.getComPrdctEditForm(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "srchingPrdct.do")
    public String srchPrdct(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.srchPrdct(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/prdctListGroupBrand";
    }
}
