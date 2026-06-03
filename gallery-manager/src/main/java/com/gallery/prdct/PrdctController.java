package com.gallery.prdct;

import com.gallery.brand.BrandService;
import com.gallery.brand.BrandVo;
import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;


@RequestMapping(value = "/prdct")
@Controller
@RequiredArgsConstructor
public class PrdctController {

    private final PrdctService prdctService;
    private final BrandService brandService;

    @RequestMapping(value = "indexPrdctForm.do")
    public String indexPrdctForm(ModelMap model, Integer prdctId, HttpServletRequest request) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
            model.addAttribute("prdctId", prdctId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 등록 수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
        return "tiles:prdct/indexPrdctForm";
    }

    @Deprecated
    @RequestMapping(value = "registerPrdct.do")
    public String registerPrdct(ModelMap model, Integer prdctId, HttpServletRequest request) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
            model.addAttribute("prdctId", prdctId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 등록 수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
        return "tiles:prdct/registerPrdct";
    }

    @Deprecated
    @RequestMapping(value = "modifyPrdctPrc.do")
    public void modifyPrdctPrc(PrdctVo prdctVo) {
        try {
            prdctService.modifyPrdctPrc(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "comAllow.do")
    @ResponseBody
    public String comAllow(PrdctVo prdctVo) {
        try {
            return prdctService.comAllow(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    @RequestMapping(value = "indexPrdctConfirmForm.do")
    public String indexPrdctConfirmForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 관리", 620, "left", 20));
        model.addAttribute("formnum", 3);
        model.addAttribute("tlist", tlist);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:prdct/indexPrdctConfirmForm";
    }

    @Deprecated
    @RequestMapping(value = "indexPrdctRemainForm.do")
    public String indexPrdctRemainForm(ModelMap model, HttpServletRequest request) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("재고 관리", 620, "left", 20));
        model.addAttribute("formnum", 4);
        model.addAttribute("tlist", tlist);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
        return "tiles:prdct/indexPrdctRemainForm";
    }

    @RequestMapping(value = "indexPrdctInvnHistForm.do")
    public String indexPrdctInvnHistForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("이력 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("재고 이력", 620, "left", 20));
        model.addAttribute("formnum", 1);
        model.addAttribute("tlist", tlist);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 1) ? "tiles:access/denied" : "tiles:prdct/indexPrdctInvnHistForm";
    }

    @RequestMapping(value = "popupPrdctForm.do")
    public String popupPrdctForm(ModelMap model, PrdctVo prdctVo, HttpSession session) {
        try {
            model.addAttribute("prdctVo", prdctService.selectPrdct(prdctVo));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "prdct/popupPrdctForm";
    }

    @RequestMapping(value = "popupPrdctInvnHistForm.do")
    public String popupPrdctInvnHistForm(ModelMap model, PrdctVo prdctVo) {
        try {
            model.addAttribute("prdctVo", prdctService.selectPrdctInvnHist(prdctVo));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/popupPrdctInvnHistForm";
    }

    @RequestMapping(value = "addPrdctAction.do")
    @ResponseBody
    public String addPrdctAction(PrdctVo prdctVo) {
        try {
            return prdctService.addPrdct(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "addPrdctColor.do")
    @ResponseBody
    public String addPrdctColor(PrdctVo prdctVo) {
        try {
            return prdctService.addPrdctColor(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "modifyPrdctAction.do")
    @ResponseBody
    public String modifyPrdctAction(PrdctVo prdctVo) {
        try {
            prdctService.modifyPrdct(prdctVo);
            return "upsuccess";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removePrdctAction.do")
    @ResponseBody
    public String removePrdctAction(PrdctVo prdctVo) {
        try {
            prdctService.removePrdct(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "updatePrdctAcptAction.do")
    @ResponseBody
    public String updatePrdctAcptAction(PrdctVo prdctVo) {
        try {
            return prdctService.modifyPrdctAcpt(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "updatePrdctInvnAction.do")
    @ResponseBody
    public String updatePrdctInvnAction(PrdctVo prdctVo) {
        try {
            return prdctService.modifyPrdctInvn(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listPrdctData.do")
    public String listPrdctData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.pagedListPrdctData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPrdctData";
    }

    @RequestMapping(value = "listPrdctRemainData.do")
    public String listPrdctRemainData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.pagedListPrdctRemainData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPrdctRemainData";
    }

    @RequestMapping(value = "listPrdctInvnHistData.do")
    public String listPrdctInvnHistData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.pagedListPrdctInvnHistData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPrdctInvnHistData";
    }

    @RequestMapping(value = "listPrdctColor.do")
    @ResponseBody
    public String listPrdctColor(PrdctVo prdctVo) {
        try {
            return prdctService.listPrdctColor(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"listColor\":[{\"a\":\"b\"}]}";
        }
    }

    @RequestMapping(value = "listPrdctConfirmData.do")
    public String listPrdctConfirmData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.pagedListPrdctConfirmData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPrdctConfirmData";
    }

    @RequestMapping(value = "getPrdctData.do")
    @ResponseBody
    public PrdctVo getCstmrData(PrdctVo prdctVo) throws Exception {
        return prdctService.selectPrdct(prdctVo);
    }

    @Deprecated
    @RequestMapping(value = "mListFrameData.do")
    public String mListFrameData(HttpServletResponse response, PrdctVo prdctVo) {
        try {
            prdctService.responseFrameData(prdctVo, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "mListLensData.do")
    public String mListLensData(HttpServletResponse response, PrdctVo prdctVo) {
        try {
            prdctService.responseLensData(prdctVo, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "mListDsplyPrdctData.do")
    public String mListDsplyPrdctData(HttpServletResponse response, PrdctVo prdctVo) {
        try {
            prdctService.responseDsplyLensData(prdctVo, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "mListPrdctTypeFrameData.do")
    public String mListPrdctTypeFrameData(HttpServletResponse response, PrdctVo prdctVo) {
        try {
            prdctService.responsePrdctTypeFrameData(prdctVo, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "lensSelect.do")
    public String lensSelect(Locale locale, Model model, PrdctVo prdctVo) throws Exception {
        List<PrdctVo> lensList = prdctService.selectLensPath(prdctVo);
        model.addAttribute("lensPath", lensList);
        return "prdct/lensSelector";
    }

    @RequestMapping(value = "getPrdctListByBrand.do")
    public String getPrdctListByBrand(BrandVo brandVo, ModelMap model) {
        try {
            Map map = prdctService.getPrdctListByBrand(brandVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/prdctListGroupBrand";
    }

    @Deprecated
    @RequestMapping("responsePrdct.do")
    public String responsePrdct(ModelMap model, HttpServletRequest request) {
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 등록 수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
        return "tiles:prdct/responsePrdct";
    }

    @RequestMapping(value = "getReqstPrdct.do")
    public String getReqstPrdct(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getReqstPrdct(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/reqeustData";
    }

    @RequestMapping(value = "mobilePrdct.do")
    public String mobilePrdct(ModelMap model, HttpServletRequest request, HttpSession session) {
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("온라인 등록 수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 7);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 1) ? "tiles:access/denied" : "tiles:prdct/mobilePrdct";
    }

    @RequestMapping(value = "indexTradeForm.do")
    public String indexTradeForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("거래내역", 120, "center", 0));
        tlist.add(new MenuTreeVo("거래내역", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 8);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 1) ? "tiles:access/denied" : "tiles:prdct/indexTradeForm";
    }

    @RequestMapping(value = "getMobilePrdct.do")
    public String getMobilePrdct(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getMobilePrdct(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listMobilePrdctData";
    }

    @RequestMapping(value = "getMobilePrdctInfo.do")
    @ResponseBody
    public PrdctVo getMobilePrdctInfo(PrdctVo prdctVo) {
        try {
            prdctVo = prdctService.getMobilePrdctInfo(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "getComPrdctList.do")
    public String getComPrdctList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getComPrdctList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listComPrdctData";
    }

    @RequestMapping(value = "orderPrdct.do")
    @ResponseBody
    public String orderPrdct(PrdctVo prdctVo) {
        try {
            return prdctService.orderPrdct(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "orderList.do")
    public String orderList(ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            model.addAllAttributes(brandService.listBrandData(new BrandVo()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("상품 관리", 620, "left", 20));
        model.addAttribute("formnum", 3);
        model.addAttribute("tlist", tlist);

        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:prdct/orderList";
    }

    @RequestMapping(value = "getOrderList.do")
    public String getOrderList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getOrderList(prdctVo);
            Map map2 = prdctService.getOrderNewLensList(prdctVo);
            model.addAllAttributes(map);
            model.addAllAttributes(map2);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listOrderData";
    }

    @RequestMapping(value = "receivePrdct.do")
    @ResponseBody
    public String receivePrdct(PrdctVo prdctVo) {
        try {
            return prdctService.receivePrdct(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "addShopInvn.do")
    @ResponseBody
    public String addShopInvn(PrdctVo prdctVo) {
        try {
            return prdctService.addShopInvn(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getReceipt.do")
    public String getReceipt(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map, map2, map3, map4, map5, map6, map7, map8, map9, map10, map11, map12;
            map = prdctService.getReceipt(prdctVo);
            map2 = prdctService.getReceiptLens(prdctVo);
            map11 = prdctService.getReceiptLens2(prdctVo);
            map3 = prdctService.getReceiptClens(prdctVo);
            map4 = prdctService.getReceiptAcc(prdctVo);
            map5 = prdctService.getReceiptEtc(prdctVo);

            map6 = prdctService.getRtnFrame(prdctVo);
            map7 = prdctService.getRtnLens(prdctVo);
            map12 = prdctService.getRtnLens2(prdctVo);
            map8 = prdctService.getRtnClens(prdctVo);
            map9 = prdctService.getRtnAcc(prdctVo);
            map10 = prdctService.getRtnEtc(prdctVo);

            model.addAllAttributes(map);
            model.addAllAttributes(map2);
            model.addAllAttributes(map3);
            model.addAllAttributes(map4);
            model.addAllAttributes(map5);
            model.addAllAttributes(map6);
            model.addAllAttributes(map7);
            model.addAllAttributes(map8);
            model.addAllAttributes(map9);
            model.addAllAttributes(map10);
            model.addAllAttributes(map11);
            model.addAllAttributes(map12);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "prdct/receiptData";
    }

    @RequestMapping(value = "getReceiptHeader.do")
    public String getReceiptHeader(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getReceiptHeader(prdctVo);
            model.addAllAttributes(map);
            model.addAttribute("iNum", prdctVo.getINum());
            model.addAttribute("shopId", prdctVo.getShopId());
            model.addAttribute("sdate", prdctVo.getSdate());
            model.addAttribute("edate", prdctVo.getEdate());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/receiptHeader";
    }


    @RequestMapping(value = "getPrdctType.do")
    @ResponseBody
    public PrdctVo getPrdctType(PrdctVo prdctVo) {
        try {
            return prdctService.getPrdctType(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "fncListPrdctInvnHistDataOutPut.do")
    public String fncListPrdctInvnHistDataOutPut(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.fncListPrdctInvnHistDataOutPut(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listInvnOutPutData";
    }

    @RequestMapping(value = "getTradeData.do")
    public String getTradeData(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getTradeData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listTrdeData";
    }

    @RequestMapping(value = "getMtrl.do")
    public String getMtrl(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getMtrl(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/mtrlList";
    }

    @RequestMapping(value = "getFunction.do")
    public String getFunction(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getFunction(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listFunctionData";
    }

    @RequestMapping(value = "getLensList.do")
    public String getLensList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensData";
    }

    @RequestMapping(value = "getRate.do")
    public String getRate(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getRate(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listRate";
    }

    @RequestMapping(value = "newOrder.do")
    @ResponseBody
    public String newOrder(PrdctVo prdctVo) {
        try {
            return prdctService.newOrder(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "adNewLensData.do")
    @ResponseBody
    public String adNewLensData(PrdctVo prdctVo) {
        try {
            return prdctService.adNewLensData(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "cancelOrder.do")
    @ResponseBody
    public String cancelOrder(PrdctVo prdctVo) {
        try {
            return prdctService.cancelOrder(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "addNewLensTy.do")
    @ResponseBody
    public String addNewLensTy(PrdctVo prdctVo) {
        try {
            return prdctService.addNewLensTy(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "showAllLensType.do")
    public String showAllLensType(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.showAllLensType(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "invn/listFunctionData";
    }

    @RequestMapping(value = "getRtnReasonList.do")
    public String getRtnReasonList(ModelMap model) {
        try {
            Map map = prdctService.getRtnReasonList();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listRtnReasonData";
    }

    @RequestMapping(value = "ReturnPrdct.do")
    @ResponseBody
    public String ReturnPrdct(PrdctVo prdctVo) {
        try {
            return prdctService.ReturnPrdct(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getLensListByType.do")
    public String getLensListByType(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensListByType(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensByType";
    }

    @RequestMapping(value = "addNewRtnReason.do")
    @ResponseBody
    public String addNewRtnReason(PrdctVo prdctVo) {
        try {
            return prdctService.addNewRtnReason(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "goLensOrderPage.do")
    public String goLensOrderPage() {
        return "prdct/lensOrderPage";
    }

    @RequestMapping(value = "getLensComList.do")
    public String getLensComList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensComList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensComList";
    }

    @RequestMapping(value = "getLensListForOrder.do")
    public String getLensListForOrder(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensListForOrder(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensForOrder";
    }

    @RequestMapping(value = "lensOrder.do")
    @ResponseBody
    public String lensOrder(PrdctVo prdctVo) {
        try {
            return prdctService.lensOrder(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "lensComOrder.do")
    @ResponseBody
    public String lensComOrder(PrdctVo prdctVo) {
        try {
            return prdctService.lensComOrder(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getLensOrderList.do")
    public String getLensOrderList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensOrderList(prdctVo);
            Map map2 = prdctService.getNewLensOrderList(prdctVo);
            model.addAllAttributes(map);
            model.addAllAttributes(map2);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensOrderData";
    }

    @RequestMapping(value = "getLensBound.do")
    @ResponseBody
    public PrdctVo getLensBound(PrdctVo prdctVo, ModelMap model) {
        try {
            prdctVo = prdctService.getLensBound(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "OrderRX.do")
    @ResponseBody
    public String OrderRX(PrdctVo prdctVo) {
        try {
            return prdctService.OrderRX(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "editLensRX.do")
    @ResponseBody
    public PrdctVo editLensRX(PrdctVo prdctVo) {
        try {
            prdctVo = prdctService.editLensRX(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "getColorCom.do")
    public String getColorCom(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getColorCom(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listColorComList";
    }

    @RequestMapping(value = "getColorList.do")
    public String getColorList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getColorList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensColor";
    }

    @RequestMapping(value = "modifyLens.do")
    @ResponseBody
    public String modifyLens(PrdctVo prdctVo) {
        try {
            return prdctService.modifyLens(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "modDetail.do")
    @ResponseBody
    public void modDetail(PrdctVo prdctVo) {
        try {
            prdctService.modDetail(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "modifySpareLensSpec.do")
    @ResponseBody
    public String modifySpareLensSpec(PrdctVo prdctVo) {
        try {
            return prdctService.modifySpareLensSpec(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getOrderPrdctProp.do")
    @ResponseBody
    public PrdctVo getOrderPrdctProp(PrdctVo prdctVo) {
        try {
            prdctVo = prdctService.getOrderPrdctProp(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "getOrderPrdctProp2.do")
    @ResponseBody
    public PrdctVo getOrderPrdctProp2(PrdctVo prdctVo) {
        try {
            prdctVo = prdctService.getOrderPrdctProp2(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "allowComOrder.do")
    @ResponseBody
    public String allowComOrder(PrdctVo prdctVo) {
        try {
            return prdctService.allowComOrder(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getComOrderCnt.do")
    @ResponseBody
    public String getComOrderCnt(PrdctVo prdctVo) {
        try {
            return prdctService.getComOrderCnt(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getComListByCntry.do")
    public String getComListByCntry(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getComListByCntry(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listComPrdctByCntry";
    }

    @RequestMapping(value = "getComListForComOrd.do")
    public String getComListForComOrd(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getComListForOrd(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listComPrdctByCntry";
    }

    @RequestMapping(value = "getLensTyByCom.do")
    public String getLensTyByCom(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensTyByCom(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensTyByCom";
    }

    @RequestMapping(value = "getLensSM.do")
    public String getLensSM(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getLensSM(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "prdct/listLensSM";
    }

    @RequestMapping(value = "showDetail.do")
    public String showDetail(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.showDetail(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listDetailData";
    }

    @RequestMapping(value = "getShopName.do")
    @ResponseBody
    public PrdctVo getShopName(PrdctVo prdctVo) {
        try {
            prdctVo = prdctService.getShopName(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prdctVo;
    }

    @RequestMapping(value = "addShopLensInvn.do")
    @ResponseBody
    public String addShopLensInvn(PrdctVo prdctVo) {
        try {
            return prdctService.addShopLensInvn(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getComOrderList.do")
    public String getComOrderList(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getComOrderList(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listOrderData";
    }

    @RequestMapping(value = "chkAdminAllow.do")
    @ResponseBody
    public String chkAdminAllow(PrdctVo prdctVo) {
        try {
            return prdctService.chkAdminAllow(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getPrdctOption.do")
    public String getPrdctOption(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getPrdctOption(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listLensOptionData";
    }

    @RequestMapping(value = "modiftOption.do")
    @ResponseBody
    public String modiftOption(PrdctVo prdctVo) {
        try {
            return prdctService.modiftOption(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getPrdctRanking.do")
    public String getPrdctRanking(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getPrdctRanking(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPrdctRankingData";
    }

    @RequestMapping(value = "getTradeListByCom.do")
    public String getTradeListByCom(ShopVo shopVo, ModelMap model) {
        try {
            Map map = prdctService.getTradeListByCom(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/listTradeData";
    }

    @RequestMapping(value = "getTradeListForModify.do")
    public String getTradeListForModify(PrdctVo prdctVo, ModelMap model) {
        try {
            Map map = prdctService.getTradeListForModify(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listTradeDataForModify";
    }

    @RequestMapping(value = "modifyDate.do")
    @ResponseBody
    public String modifyDate(PrdctVo prdctVo) {
        try {
            return prdctService.modifyDate(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getDetail.do")
    @ResponseBody
    public String getDetail(PrdctVo prdctVo) {
        try {
            String result = prdctService.getDetail(prdctVo);
            result = URLEncoder.encode(result, "utf-8");
            return result.replaceAll("\\+", "%20");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "delData.do")
    @ResponseBody
    public String delData(PrdctVo prdctVo) {
        try {
            return prdctService.delData(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}

