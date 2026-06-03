package com.gallery.sale;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/sale")
@Controller
@RequiredArgsConstructor
public class SaleController {

    private static final Logger logger = LoggerFactory.getLogger(SaleController.class);
    private final SaleService saleService;

    @Deprecated
    @RequestMapping(value = "indexSaleForm.do")
    public String indexSaleForm(HttpServletRequest request, ModelMap model) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("브랜드 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("브랜드 등록/수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 1);
        return "tiles:sale/indexSaleForm";
    }

    @RequestMapping(value = "findShopName.do")
    public String findShopName(HttpServletRequest request, ModelMap model, HttpSession session, ShopVo shopVo) {
        try {
            Map map = saleService.findShopName(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "sale/shopSelectOptionData";
    }

    @RequestMapping(value = "indexSalesHistForm.do")
    public String indexSalesHistForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("이력 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("매출 조회", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 3);

        Date date = new Date();
        model.addAttribute("cyear", 1900 + date.getYear());
        model.addAttribute("cmonth", date.getMonth() + 1);
        model.addAttribute("cday", date.getDate());

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:sale/indexSalesHistForm";
    }

    @RequestMapping(value = "indexSaleHistForm.do")
    public String indexSaleHistForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("이력 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("판매 이력", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        Date date = new Date();
        model.addAttribute("cyear", 1900 + date.getYear());
        model.addAttribute("cmonth", date.getMonth() + 1);
        model.addAttribute("cday", date.getDate());

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:sale/indexSaleHistForm";
    }

    @Deprecated
    @RequestMapping(value = "indexPrdctSaleHistForm.do")
    public String indexPrdctSaleHistForm(HttpServletRequest request, ModelMap model) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("이력 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 판매 이력", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 3);

        Date date = new Date();
        model.addAttribute("cyear", 1900 + date.getYear());
        model.addAttribute("cmonth", date.getMonth() + 1);
        model.addAttribute("cday", date.getDate());
        return "tiles:sale/indexPrdctSaleHistForm";
    }

    @Deprecated
    @RequestMapping(value = "addSaleAction.do")
    @ResponseBody
    public String addSaleAction(SaleVo saleVo, HttpServletResponse response) {
        try {
            return saleService.addSale(saleVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            logger.debug(e.getLocalizedMessage());
        }
        return "{ \"result\":\"fail\"}";
    }

    @Deprecated
    @RequestMapping(value = "modifySaleAction.do")
    @ResponseBody
    public String modifySaleAction(SaleVo saleVo) {
        logger.debug("run modifySaleAction. modify : " + saleVo.toString());
        try {
            saleService.modifySale(saleVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Deprecated
    @RequestMapping(value = "listSaleData.do")
    public String listSaleData(SaleVo saleVo, ModelMap model) {
        try {
            Map map = saleService.pagedListSaleData(saleVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSaleData";
    }

    @RequestMapping(value = "csv.do")
    public String csv(String csv) {
        return "csv/csv1";
    }

    @RequestMapping(value = "csv1.do")
    public String csv1(String csv) {
        return "csv/csv1";
    }

    @RequestMapping(value = "csv2.do")
    public String csv2(String csv) {
        return "csv/csv2";
    }

    @RequestMapping(value = "csv3.do")
    public String csv3(String csv) {
        return "csv/csv3";
    }

    @RequestMapping(value = "csv4.do")
    public String csv4(String csv) {
        return "csv/csv4";
    }

    @Deprecated
    @RequestMapping(value = "getSaleData.do")
    @ResponseBody
    public SaleVo getSaleData(SaleVo saleVo) throws Exception {
        return saleService.selectSale(saleVo);
    }

    @Deprecated
    @RequestMapping(value = "mListSaleData.do")
    public String mListSaleData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        saleService.mListSaleData(response);
        return "home";
    }

    @RequestMapping(value = "listSaleHistData.do")
    public String listSaleHistData(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSaleHistData(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSaleHistData";
    }

    @RequestMapping(value = "listSalesHistData.do")
    public String listSalesHistData(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistData(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistData";
    }

    @RequestMapping(value = "listSalesHistDataTotal.do")
    public String listSalesHistDataTotal(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistDataTotal(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistDataTotal";
    }

    @RequestMapping(value = "listSalesHistDatatoCsv.do")
    public String listSalesHistDatatoCsv(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistDatatoCsv(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistCsvData";
    }

    @RequestMapping(value = "listSalesHistDataByStaffCsv.do")
    public String listSalesHistDataByStaffCsv(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistDataByStaffCsv(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistCsvData";
    }

    @RequestMapping(value = "listSalesHistDataTotalCsv.do")
    public String listSalesHistDataTotalCsv(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistDataTotalCsv(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistCsvDataTotal";
    }

    @RequestMapping(value = "listPrdctSaleHistData.do")
    public String listPrdctSaleHistData(HttpServletRequest request, HttpServletResponse response, SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listPrdctSaleHistData(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listPrdctSaleHistData";
    }

    @Deprecated
    @RequestMapping(value = "mSaleResult.do")
    public String mSaleResult(HttpServletRequest request, HttpServletResponse response, SaleVo saleVo) throws Exception {
        saleService.modifySale(saleVo);
        return "home";
    }

    @RequestMapping(value = "mSaleCallback.do")
    @ResponseBody
    public String mSaleCallBack(HttpServletRequest request, HttpServletResponse response, SaleVo saleVo) {
        String checkSaleId = saleVo.getCJSShopOrderNo();
        checkSaleId = onlyNum(checkSaleId);
        saleVo.setCJSShopOrderNo(checkSaleId);

        try {
            return saleService.modifySale(saleVo);
        } catch (Exception e) {
            logger.info(e.getLocalizedMessage());
            return "0003";
        }
    }

    @Deprecated
    @RequestMapping(value = "mSaleTest.do")
    public String mSaleTest(ModelMap model, HttpServletRequest request, HttpServletResponse response, SaleVo saleVo) {
        return "sale/mSaleRedirectSuccess";
    }

    @RequestMapping(value = "mSaleRedirect.do")
    public String mSaleRedirect(ModelMap model, HttpServletRequest request, HttpServletResponse response, SaleVo saleVo) {
        if (saleVo.getVpresult() != null && saleVo.getVpresult().equals("00")) {
            return "sale/mSaleRedirectCancel";
        }
        try {
            saleService.modifySale(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "sale/mSaleRedirectFail";
        }

        if (saleVo.getCJSResultCode().equals("0") || saleVo.getCJSResultCode().equals("0000") || saleVo.getCJSResultCode().equals("sucess")) {
            if (saleVo.getAmountTotal() == null) {
                saleVo.setAmountTotal("0");
            }
            if (saleVo.getCJSAmountTotal() == null) {
                saleVo.setCJSAmountTotal("0");
            }
            if (!saleVo.getAmountTotal().equals("0")) {
                model.put("price", saleVo.getAmountTotal());
            } else {
                model.put("price", saleVo.getCJSAmountTotal());
            }
            return "sale/mSaleRedirectSuccess";
        } else if (saleVo.getCJSResultCode().equals("2005")) {

            return "sale/mSaleRedirectCancel";
        } else {
            return "sale/mSaleRedirectFail";
        }
    }

    public String onlyNum(String str) {
        if (str == null) return "";

        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < str.length(); i++) {
            if (Character.isDigit(str.charAt(i))) {
                sb.append(str.charAt(i));
            }
        }
        return sb.toString();
    }

    @RequestMapping(value = "getCardInfo.do")
    public String getCardInfo(SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.getCardInfo(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listCardInfoData";
    }

    @RequestMapping(value = "listSalesHistDataByStaff.do")
    public String listSalesHistDataByStaff(SaleHistSearchVo searchVo, ModelMap model) {
        try {
            Map map = saleService.listSalesHistDataByStaff(searchVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "sale/listSalesHistData";
    }

}
