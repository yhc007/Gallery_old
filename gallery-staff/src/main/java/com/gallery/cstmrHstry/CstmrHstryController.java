package com.gallery.cstmrHstry;

import com.gallery.check.CheckService;
import com.gallery.check.CheckVo;
import com.gallery.common.CommonCode;
import com.gallery.coupon.CouponService;
import com.gallery.coupon.CouponVo;
import com.gallery.cstmr.CstmrService;
import com.gallery.cstmr.CstmrVo;
import com.gallery.payment.PaymentService;
import com.gallery.point.PointService;
import com.gallery.point.PointVo;
import com.gallery.prdct.PrdctService;
import com.gallery.prdct.PrdctVo;
import com.gallery.sale.SaleService;
import com.gallery.sale.SaleVo;
import com.gallery.saleJob.SaleJobService;
import com.gallery.saleJob.SaleJobVo;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffService;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


@RequestMapping(value = "/cstmrHstry")
@Controller
@RequiredArgsConstructor
public class CstmrHstryController {

    private static final Logger logger = LoggerFactory.getLogger(CstmrHstryController.class);

    private final CstmrHstryService cstmrHstryService;
    private final SaleService saleService;
    private final PrdctService prdctService;
    private final StaffService staffService;
    private final PaymentService paymentService;
    private final CheckService checkService;
    private final CstmrService cstmrService;
    private final PointService pointService;
    private final CouponService couponService;
    private final SaleJobService saleJobService;

    @RequestMapping(value = "indexCstmrHstryForm.do")
    public String indexCstmrHstryForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        logger.info("run indexCstmrHstryForm");

        // 세션에 고객/판매 정보가 없을 수 있어(예: indexSaleForm 내부 예외가 삼켜진 경우)
        // null 가드 후 모델에 담는다. 무방비 접근 시 NPE→500→화면 "실패. 재시도 바랍니다" 발생.
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

        model.addAttribute("cstmrId", cstmrVo != null ? cstmrVo.getCstmrId() : -1);
        model.addAttribute("histId", saleVo != null ? saleVo.getHistId() : null);
        model.addAttribute("cstmrName", cstmrVo != null ? cstmrVo.getCstmrName() : "");

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        logger.info("shopVo:" + shopVo);
        logger.info("staffVo:" + staffVo);
        List<StaffVo> listStaff = new ArrayList();
        try {
            listStaff = staffService.listStaff(staffVo);
        } catch (Exception e) {
            logger.error("indexCstmrHstryForm listStaff 실패 staffVo:{}", staffVo, e);
        }
        model.addAttribute("listStaff", listStaff);
        model.addAttribute("shopVo", shopVo);
        model.addAttribute("staffVo", staffVo);

        return "cstmrHstry/indexCstmrHstryForm";
    }

//    @Deprecated
//    @RequestMapping(value = "listPaymentNew.do")
//    public String listPaymentNew(ModelMap model, HttpServletRequest request, HttpSession session) {
//        logger.info("call listPaymentNew");
//
//        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
//        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
//        CstmrVo cstmrVo = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR));
//        Integer cstmrId = cstmrVo.getCstmrId();
//        String cstmrName = cstmrVo.getCstmrName();
//        model.addAttribute("cstmrVo", cstmrVo);
//        model.addAttribute("cstmrId", cstmrId);
//        model.addAttribute("cstmrName", cstmrName);
//        model.addAttribute("shopVoH", shopVo);
//        model.addAttribute("staffVoH", staffVo);
//
//        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//
//        try {
//            saleVo = saleService.selectSale(saleVo);
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//        logger.info("saleVo:" + saleVo);
//        // model.addAttribute("saleVoH", saleVo);
//        // model.addAttribute("payCardH", saleVo.getPayCard());
//        // model.addAttribute("payCashH", saleVo.getPayCash());
//
//        // model = CommonFunction.setButton(saleVo.getResult(),
//        // model,CommonCode.ARRAY_PAYMENT);
//        return "cstmrHstry/listPaymentNew";
//    }

    @RequestMapping(value = "listVisitData.do")
    public String listVisitData(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        logger.info("call listVisitData");

        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        CstmrHstryVo cstmrHstryVo = new CstmrHstryVo();
        cstmrHstryVo.setCstmrId(checkVo.getCstmrId());
        try {
            Map map = cstmrHstryService.listVisitData(cstmrHstryVo);
            model.addAllAttributes(map);
            model.addAttribute("staffVoH", staffVo);

        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "cstmrHstry/listVisitData";
    }

    @RequestMapping(value = "listVisitDataForFrame.do")
    public String listVisitDataForFrame(ModelMap model, HttpServletRequest request, CheckVo checkVo,
                                        HttpSession session) {
        logger.info("call listVisitData");

        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        CstmrHstryVo cstmrHstryVo = new CstmrHstryVo();
        cstmrHstryVo.setCstmrId(checkVo.getCstmrId());
        try {
            Map map = cstmrHstryService.listVisitData(cstmrHstryVo);
            model.addAllAttributes(map);
            model.addAttribute("staffVoH", staffVo);

        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "cstmrHstry/dateFrame";
    }

    @RequestMapping(value = "listCstmrInfo.do")
    public String listCstmrInfo(ModelMap model, HttpServletRequest request, CstmrHstryVo cstmrHstryVo,
                                HttpSession session) {
        logger.info("call listCstmrInfo");
        CstmrVo cstmrVo = new CstmrVo();

        cstmrVo.setCstmrId(cstmrHstryVo.getCstmrId());

        try {
            cstmrVo = cstmrHstryService.getCstmrById(cstmrVo);
            cstmrVo.setBigo("");
            session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);

            model.addAttribute("cstmrVo", cstmrVo);

            Date today = new Date();
            DateFormat df = new SimpleDateFormat("yyyy");
            TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
            df.setTimeZone(tz);
            String cyear = df.format(today);
            Integer tmp = Integer.parseInt(cyear) - 1900;
            cyear = tmp.toString();
            model.addAttribute("cyear", cyear);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "cstmrHstry/listCstmrInfo";
    }

    @RequestMapping(value = "listPaymentedPrdctData.do")
    public String listPaymentedPrdctData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);

        int saleId = -1;
        if (prdctVo.getSaleId() != null)
            saleId = Integer.parseInt(prdctVo.getSaleId());
        saleVo.setSaleId(saleId);

        try {
            Map map3 = prdctService.listPartnerData();
            Map map2 = cstmrHstryService.getNewPrdct(prdctVo);
            Map map = cstmrHstryService.listSelectedPrdctData(prdctVo);
            saleVo = saleService.selectSale(saleVo);
            Map map7 = paymentService.selectCardComInfo();
            model.addAttribute("saleVoH", saleVo);

            cstmrVo.setBigo("");
            model.addAttribute("cstmrVo", cstmrVo);
            model.addAttribute("shopVo", shopVo);
            model.addAttribute("staffVo", staffVo);

            model.addAllAttributes(map);
            model.addAllAttributes(map2);
            model.addAllAttributes(map3);
            model.addAllAttributes(map7);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmrHstry/listPaymentedPrdctData";
    }

    @RequestMapping(value = "getCheckDataForSale.do")
    @ResponseBody
    public CheckVo getCheckDataForSale(ModelMap model, HttpServletRequest request, HttpSession session) {
        logger.info("call getCheckDataForSale");
        try {
            return cstmrHstryService.selectVisitInfoForSale(session);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return new CheckVo();
    }

    @RequestMapping(value = "getCheckData.do")
    @ResponseBody
    public CstmrHstryVo getCheckData(ModelMap model, HttpServletRequest request, CstmrHstryVo cstmrHstryVo,
                                     HttpSession session) {
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);

        int cstrId = -1;
        if (cstmrVo.getCstmrId() != null)
            cstrId = cstmrVo.getCstmrId();

        cstmrHstryVo.setCstmrId(cstrId);

        if (cstmrHstryVo.getSaleId() == 1) {
            cstmrHstryVo.setCstmrId(null);
        }
        try {
            return cstmrHstryService.selectVisitInfo(cstmrHstryVo);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return new CstmrHstryVo();
    }

    @RequestMapping(value = "getCheckDataInit.do")
    @ResponseBody
    public CstmrHstryVo getCheckDataInit(ModelMap model, HttpServletRequest request, CstmrHstryVo cstmrHstryVo,
                                         HttpSession session) {
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        cstmrHstryVo.setCstmrId(cstmrVo.getCstmrId());
        if (cstmrHstryVo.getSaleId() == 1) {
            cstmrHstryVo.setCstmrId(null);
        }
        try {
            return cstmrHstryService.selectVisitInfoInit(cstmrHstryVo);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return new CstmrHstryVo();
    }

    @RequestMapping(value = "getListFmly.do")
    public String getListFmly(CstmrVo cstmrVo, ModelMap model) {
        List<CstmrVo> listCstmr4Fmly = null;
        try {
            listCstmr4Fmly = cstmrService.listCstmr4Fmly(cstmrVo);
            model.put("listCstmr4Fmly", listCstmr4Fmly);
            return "cstmrHstry/listCstmrFmly";
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        model.put("listCstmr4Fmly", listCstmr4Fmly);
        return "cstmrHstry/listCstmrFmly";
    }

    @RequestMapping(value = "getListCoupon.do")
    public String getListCoupon(CstmrVo cstmrVo, ModelMap model) {
        List<CouponVo> listCoupon = null;
        try {
            listCoupon = couponService.listCstmr4Coupon(cstmrVo);
            model.put("listCoupon", listCoupon);
            return "cstmrHstry/listCstmrCoupon";
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "cstmrHstry/listCstmrCoupon";
    }

    @RequestMapping(value = "getLastData.do")
    @ResponseBody
    public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo) {
        try {
            cstmrHstryVo = cstmrHstryService.getLastData(cstmrHstryVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cstmrHstryVo;
    }

//    @Deprecated
//    @RequestMapping(value = "getCstmrHstryMemo.do")
//    @ResponseBody
//    public String getCstmrHstryMemo(CstmrHstryVo cstmrHstryVo) {
//        String memo = "";
//        try {
//            memo = URLEncoder.encode(cstmrHstryService.getCstmrhstryMemo(cstmrHstryVo), "utf-8");
//            memo = memo.replaceAll("\\+", "%20");
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//        return memo;
//    }

//    @Deprecated
//    @RequestMapping(value = "cstmrHstryMemoUpdate.do")
//    @ResponseBody
//    public void cstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo) {
//        try {
//            cstmrHstryService.CstmrHstryMemoUpdate(cstmrHstryVo);
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//    }

    @RequestMapping(value = "listPrdctData.do")
    public String listPrdctData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        logger.debug("listPrdctData " + prdctVo.toString());
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        try {
            prdctVo.setShopId(shopVo.getShopId());
            Map map = prdctService.listPrdctData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmrHstry/listPrdctData";
    }

    @RequestMapping(value = "listLensData.do")
    public String listLensData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        try {
            prdctVo.setShopId(shopVo.getShopId());
            Map map = prdctService.listLensData(prdctVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmrHstry/listLensData";
    }

    @RequestMapping(value = "listPartnerData.do")
    public String listPartnerData(PrdctVo prdctVo, ModelMap model, HttpSession session) {
        try {
            Map map = prdctService.listPartnerData();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmrHstry/listPartnerData";
    }

    @RequestMapping(value = "addCstmrHstry.do")
    @ResponseBody
    public String addCstmrHstry(CstmrHstryVo cstmrHstryVo, ModelMap model, HttpSession session) {
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        String s = cstmrHstryVo.getJsonString();
        String strReturn = "success";
        String strSuccess = "success";
        logger.info("run addCstmrHstry:" + s);
        Object obj = JSONValue.parse(s);
        JSONObject jsonObject = (JSONObject) obj;

        String inputDate = (String) jsonObject.get("inputDate");
        inputDate = inputDate.replace('-', '.');
        CheckVo checkVo = new CheckVo();
        checkVo = setCheckVo(jsonObject, checkVo);
        Integer histId = 0;
        try {
            histId = checkService.addVisitCstmrHstry(checkVo);
        } catch (Exception e) {

            e.printStackTrace();
            strReturn = "failEyeCheck";
            return strReturn;
        }
        jsonObject.put("histId", histId.toString());
        SaleVo saleVo = new SaleVo();
        setSaleVo(jsonObject, saleVo);

        saleVo.setHistId(histId);
        Integer saleId = 0;
        try {
            saleId = saleService.addSaleCstmrHstry(saleVo);
            CstmrVo tmpCstmrVo = new CstmrVo();
            tmpCstmrVo.setCstmrId(saleVo.getCstmrId());
            tmpCstmrVo.setLastShopId(saleVo.getShopId());
            cstmrService.editCstmrLastShop(tmpCstmrVo);

        } catch (Exception e) {

            e.printStackTrace();
            strReturn = "failSaleOff";
            return strReturn;
        }
        jsonObject.put("saleId", saleId.toString());

        strReturn = setPoint(jsonObject);
        if (strReturn != "success") {
            return strReturn;
        }
        logger.info(strSuccess + "@" + saleId.toString());

        strReturn = setCoupon(jsonObject, cstmrVo);
        if (strReturn != "success") {
            return strReturn;
        }
        strReturn = setPayment(jsonObject);
        if (strReturn != "success") {
            return strReturn;
        }
        strReturn = setPrdct(jsonObject);
        if (strReturn != "success") {
            return strReturn;
        }
        return strSuccess + "@" + saleId.toString();
    }

    @RequestMapping(value = "modifyCstmrHstry.do")
    @ResponseBody
    public String modifyCstmrHstry(CstmrHstryVo cstmrHstryVo, ModelMap model, HttpSession session) {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        String s = cstmrHstryVo.getJsonString();
        String strReturn = "success";

        SaleVo saleVo = new SaleVo();
        CheckVo checkVo = new CheckVo();

        // logger.info("run modifyCstmrHstry:"+s);
        Object obj = JSONValue.parse(s);

        logger.info("json String:" + s);
        JSONObject jsonObject = (JSONObject) obj;

        setSaleVo(jsonObject, saleVo);
        if (strReturn != "success") {
            return strReturn;
        }

        if (saleVo.getSaleId().equals(1)) {
            return "failSaleOff";
        }
        if (saleVo.getSaleId().intValue() == 1) {
            return "failSaleOff";
        }

        try {
            saleService.modifyCstmrHst(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "failSaleOff";
        }

        checkVo = setCheckVo(jsonObject, checkVo);
        if (checkVo.getHistId().equals(1)) {
            return "failSaleOff";
        }

        try {
            checkService.updateCstmrHistVisit(checkVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "failEyeCheck";
        }

        strReturn = setPoint(jsonObject);
        if (setPoint(jsonObject) != "success") {
            return strReturn;
        }

        strReturn = setCoupon(jsonObject, cstmrVo);
        if (setCoupon(jsonObject, cstmrVo) != "success") {
            return strReturn;
        }

        strReturn = setPayment(jsonObject);
        if (setPayment(jsonObject) != "success") {
            return strReturn;
        }

        strReturn = setPrdct(jsonObject);
        if (strReturn != "success") {
            return strReturn;
        }

        return "success";
    }

    private void setListPayment(JSONArray arrPayment, List<SaleJobVo> listPayment, String saleId, String staffId, String fmlyCd) {
        JSONObject jsonObject;
        Iterator iter;
        int size = arrPayment.size();
        for (int i = 0; i < size; i++) {
            jsonObject = (JSONObject) arrPayment.get(i);
            iter = jsonObject.keySet().iterator();
            SaleJobVo tmpPaymentVo = new SaleJobVo();
            while (iter.hasNext()) {
                String key = (String) iter.next();
                if (key.equals("payId")) {
                    tmpPaymentVo.setJobId(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("payCash")) {
                    tmpPaymentVo.setPayCash(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("payCard")) {
                    tmpPaymentVo.setPayCard(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("payPoint")) {
                    tmpPaymentVo.setPayPoint(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("fmlyCd")) {
                    tmpPaymentVo.setFmlyCd((String) jsonObject.get(key));
                } else if (key.equals("datetime")) {
                    String tmp = (String) jsonObject.get(key);
                    tmp = tmp.replace('-', '.');
                    tmpPaymentVo.setDatetime(tmp);
                    tmpPaymentVo.setCardDate(tmp);
                } else if (key.equals("cancel")) {
                    tmpPaymentVo.setCancel(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("cardTy")) {
                    tmpPaymentVo.setCardTy(Integer.parseInt((String) jsonObject.get(key)));
                }
            }
            tmpPaymentVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_PAYMENT);
            tmpPaymentVo.setSaleId(Integer.parseInt(saleId));
            tmpPaymentVo.setStaffId(Integer.parseInt(staffId));
            tmpPaymentVo.setFmlyCd(fmlyCd);
            listPayment.add(tmpPaymentVo);
        }
    }

    private void setListPrdct(String saleId, String shopId, JSONArray arrPrdct, List<PrdctVo> listInvnPrdct, List<PrdctVo> listNewPrdct, List<PrdctVo> listCntUpPrdct, List<PrdctVo> listCntDownPrdct) {
        JSONObject jsonObject;
        Iterator iter;
        int size = arrPrdct.size();
        for (int i = 0; i < size; i++) {
            jsonObject = (JSONObject) arrPrdct.get(i);
            iter = jsonObject.keySet().iterator();
            PrdctVo tmpPrdctVo = new PrdctVo();
            while (iter.hasNext()) {
                String key = (String) iter.next();
                if (key.equals("prdctId")) {
                    tmpPrdctVo.setPrdctId(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("prdctTy")) {
                    tmpPrdctVo.setItemTy(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("prdctName")) {
                    tmpPrdctVo.setPrdctName((String) jsonObject.get(key));
                } else if (key.equals("prdctCnt")) {
                    tmpPrdctVo.setPrdctCnt(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("tradePrc")) {
                    tmpPrdctVo.setTrdePrc(Integer.parseInt((String) jsonObject.get(key)));
                    tmpPrdctVo.setPrc(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("dscntPcnt")) {
                    tmpPrdctVo.setDscntPrcnt(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("isEarn")) {
                    tmpPrdctVo.setEarnPrcnt(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("isAsm")) {
                    tmpPrdctVo.setAsmbly(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("isDlvr")) {
                    tmpPrdctVo.setDlvry(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("isNew")) {
                    tmpPrdctVo.setIsNew(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("addCnt")) {
                    tmpPrdctVo.setAddCnt(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("dtrCnt")) {
                    tmpPrdctVo.setDtrCnt(Integer.parseInt((String) jsonObject.get(key)));
                }
            }
            tmpPrdctVo.setSaleId(saleId);
            tmpPrdctVo.setShopId(Integer.parseInt(shopId));
            if (tmpPrdctVo.getIsNew() == 0) {
                listInvnPrdct.add(tmpPrdctVo);
            } else {
                listNewPrdct.add(tmpPrdctVo);
            }
            if (tmpPrdctVo.getAddCnt() != 0) {
                tmpPrdctVo.setPrdctCnt(tmpPrdctVo.getAddCnt());
                listCntUpPrdct.add(tmpPrdctVo);
            }
            if (tmpPrdctVo.getDtrCnt() != 0) {
                tmpPrdctVo.setPrdctCnt(tmpPrdctVo.getDtrCnt());
                listCntDownPrdct.add(tmpPrdctVo);
            }
        }

    }

    private void setSaleVo(JSONObject jsonObject, SaleVo saleVo) {
        String saleId = (String) jsonObject.get("saleId");
        String cstmrId = (String) jsonObject.get("cstmrId");
        String shopId = (String) jsonObject.get("shopId");
        String datetime = ((String) jsonObject.get("datetime")).replace('-', '.');

        String ognPrice = (String) jsonObject.get("ognPrice");
        String dscntPrice = (String) jsonObject.get("dscntPrice");
        String payCash = (String) jsonObject.get("payCash");
        String payCard = (String) jsonObject.get("payCard");
        String payPoint = (String) jsonObject.get("payPoint");
        String memo = (String) jsonObject.get("memo");
        String result = (String) jsonObject.get("result");
        String birthCoupon = (String) jsonObject.get("birthCoupon");
        String cancelCoupon = (String) jsonObject.get("cancelCoupon");
        JSONObject eyeCheck = (JSONObject) jsonObject.get("eyeCheck");

        String histId = (String) eyeCheck.get("histId");

        String earnPrcnt = (String) jsonObject.get("earnPrcnt");
        JSONObject pDscnt = (JSONObject) jsonObject.get("pDscnt");

        String pId = (String) pDscnt.get("pId");
        String prcnt = (String) pDscnt.get("prcnt");

        JSONObject etcDscnt = (JSONObject) jsonObject.get("etcDscnt");

        String etcDscntMemo = (String) etcDscnt.get("memo");
        String etcDscntMount = (String) etcDscnt.get("mount");

        saleVo.setSaleId(Integer.parseInt(saleId));
        saleVo.setCstmrId(Integer.parseInt(cstmrId));
        saleVo.setShopId(Integer.parseInt(shopId));
        saleVo.setOgnPrice(Integer.parseInt(ognPrice));
        saleVo.setDscntPrice(Integer.parseInt(dscntPrice));
        saleVo.setPayCash(Integer.parseInt(payCash));
        saleVo.setPayCard(Integer.parseInt(payCard));
        saleVo.setPayPoint(Integer.parseInt(payPoint));
        saleVo.setPartnerId(Integer.parseInt(pId));
        saleVo.setPartnerDscnt(Integer.parseInt(prcnt));
        saleVo.setEtcDscnt(Integer.parseInt(etcDscntMount));
        saleVo.setEtcDscntMemo(etcDscntMemo);
        saleVo.setResult(result);
        saleVo.setDatetime(datetime);

        saleVo.setHistId(Integer.parseInt(histId));
        saleVo.setEarnPrcnt(Integer.parseInt(earnPrcnt));

        if (cancelCoupon.isEmpty()) {
            saleVo.setCouponBirth(birthCoupon);
        } else {
            saleVo.setCouponBirth("");
        }
        saleVo.setMemo(memo);

        return;
    }

    private CheckVo setCheckVo(JSONObject jsonObject, CheckVo checkVo) {
        String staffId = (String) jsonObject.get("staffId");
        String cstmrId = (String) jsonObject.get("cstmrId");
        String datetime = ((String) jsonObject.get("datetime")).replace('-', '.');

        String shopId = (String) jsonObject.get("shopId");

        JSONObject eyeCheck = (JSONObject) jsonObject.get("eyeCheck");

        String histId = (String) eyeCheck.get("histId");

        String gsphRight = (String) eyeCheck.get("gsphRight");
        String gcylRight = (String) eyeCheck.get("gcylRight");
        String gaxisRight = (String) eyeCheck.get("gaxisRight");
        String addRight = (String) eyeCheck.get("addRight");
        String pdRight = (String) eyeCheck.get("pdRight");
        String npcRight = (String) eyeCheck.get("npcRight");
        String npaRight = (String) eyeCheck.get("npaRight");
        String prismRight = (String) eyeCheck.get("prismRight");
        String baseRight = (String) eyeCheck.get("baseRight");
        String lsphRight = (String) eyeCheck.get("lsphRight");
        String lcylRight = (String) eyeCheck.get("lcylRight");
        String laxisRight = (String) eyeCheck.get("laxisRight");
        String bcRight = (String) eyeCheck.get("bcRight");
        String diaRight = (String) eyeCheck.get("diaRight");

        String gsphLeft = (String) eyeCheck.get("gsphLeft");
        String gcylLeft = (String) eyeCheck.get("gcylLeft");
        String gaxisLeft = (String) eyeCheck.get("gaxisLeft");
        String addLeft = (String) eyeCheck.get("addLeft");
        String pdLeft = (String) eyeCheck.get("pdLeft");
        String npcLeft = (String) eyeCheck.get("npcLeft");
        String npaLeft = (String) eyeCheck.get("npaLeft");
        String prismLeft = (String) eyeCheck.get("prismLeft");
        String baseLeft = (String) eyeCheck.get("baseLeft");
        String lsphLeft = (String) eyeCheck.get("lsphLeft");
        String lcylLeft = (String) eyeCheck.get("lcylLeft");
        String laxisLeft = (String) eyeCheck.get("laxisLeft");
        String bcLeft = (String) eyeCheck.get("bcLeft");
        String diaLeft = (String) eyeCheck.get("diaLeft");
        String domEye = (String) eyeCheck.get("domEye");

        checkVo.setHistId(Integer.parseInt(histId));
        checkVo.setStaffId(Integer.parseInt(staffId));
        checkVo.setCstmrId(Integer.parseInt(cstmrId));
        checkVo.setVisitShopId(Integer.parseInt(shopId));

        checkVo.setGsphRight(gsphRight);
        checkVo.setGcylRight(gcylRight);
        checkVo.setGaxisRight(gaxisRight);
        checkVo.setAddRight(addRight);
        checkVo.setPdRight(pdRight);
        checkVo.setNpcRight(npcRight);
        checkVo.setNpaRight(npaRight);
        checkVo.setPrismRight(prismRight);
        checkVo.setBaseRight(baseRight);
        checkVo.setLsphRight(lsphRight);
        checkVo.setLcylRight(lcylRight);
        checkVo.setLaxisRight(laxisRight);
        checkVo.setBcRight(bcRight);
        checkVo.setDiaRight(diaRight);

        checkVo.setGsphLeft(gsphLeft);
        checkVo.setGcylLeft(gcylLeft);
        checkVo.setGaxisLeft(gaxisLeft);
        checkVo.setAddLeft(addLeft);
        checkVo.setPdLeft(pdLeft);
        checkVo.setNpcLeft(npcLeft);
        checkVo.setNpaLeft(npaLeft);
        checkVo.setPrismLeft(prismLeft);
        checkVo.setBaseLeft(baseLeft);
        checkVo.setLsphLeft(lsphLeft);
        checkVo.setLcylLeft(lcylLeft);
        checkVo.setLaxisLeft(laxisLeft);
        checkVo.setBcLeft(bcLeft);
        checkVo.setDiaLeft(diaLeft);
        checkVo.setDatetime(datetime);
        checkVo.setDomEye(domEye);

        logger.info("checkVo:" + checkVo);
        return checkVo;
    }

    private String setPoint(JSONObject jsonObject) {
        PointVo pPointVo = new PointVo();
        PointVo mPointVo = new PointVo();
        String saleId = (String) jsonObject.get("saleId");
        String cstmrCd = (String) jsonObject.get("cstmrCd");
        String fmlyCd = (String) jsonObject.get("fmlyCd");
        String point = (String) jsonObject.get("point");
        String shopId = (String) jsonObject.get("shopId");
        String payPoint = (String) jsonObject.get("payPoint");
        String inputDate = (String) jsonObject.get("inputDate");
        inputDate = inputDate.replace('-', '.');
        String result = (String) jsonObject.get("result");

        pPointVo.setSaleId(Integer.parseInt(saleId));
        pPointVo.setCstmrCd(cstmrCd);
        pPointVo.setFmlyCd(fmlyCd);
        pPointVo.setPoint(Integer.parseInt(point) / 100);
        pPointVo.setShopNum(Integer.parseInt(shopId));
        pPointVo.setDateTime(inputDate);
        pPointVo.setPointStatus("P");

        mPointVo.setSaleId(Integer.parseInt(saleId));
        mPointVo.setCstmrCd(cstmrCd);
        mPointVo.setFmlyCd(fmlyCd);
        mPointVo.setPoint(Integer.parseInt(payPoint) / 100);
        mPointVo.setShopNum(Integer.parseInt(shopId));
        mPointVo.setDateTime(inputDate);
        mPointVo.setPointStatus("M");
        try {
            pointService.editMPointCstmrHst(mPointVo);
            logger.info("result:" + result);
            if (result.equals("11111")) {
                pointService.editPPointCstmrHst(pPointVo);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "failPoint";
        }
        return "success";
    }

    private String setCoupon(JSONObject jsonObject, CstmrVo cstmrVo) {
        CouponVo couponVo = new CouponVo();
        String birthCoupon = (String) jsonObject.get("birthCoupon");
        String cancelCoupon = (String) jsonObject.get("cancelCoupon");
        String shopId = (String) jsonObject.get("shopId");
        String inputDate = (String) jsonObject.get("inputDate");
        inputDate = inputDate.replace('-', '.');
        String cstmrCd = (String) jsonObject.get("cstmrCd");
        String saleId = (String) jsonObject.get("saleId");

        if (!cancelCoupon.isEmpty()) {
            try {
                couponVo.setCouponCd(cancelCoupon);
                couponVo.setShopNum(0);
                couponVo.setUsingDate("");
                couponVo.setWMemo("");
                couponService.cancelBirthCoupon(couponVo);
            } catch (Exception e) {
                e.printStackTrace();
                return "failCoupon";
            }
        }
        if (!birthCoupon.isEmpty()) {
            couponVo.setCouponCd(birthCoupon);
            couponVo.setShopNum(Integer.parseInt(shopId));
            couponVo.setUsingDate(inputDate);
            couponVo.setWMemo(cstmrVo.getCstmrName() + cstmrCd);
            couponVo.setSaleId(Integer.parseInt(saleId));
            try {
                couponService.checkNusingCoupon(couponVo);
            } catch (Exception e) {
                e.printStackTrace();
                return "failCoupon";
            }
        }
        return "success";
    }

    private String setPayment(JSONObject jsonObject) {
        String saleId = (String) jsonObject.get("saleId");
        String staffId = (String) jsonObject.get("staffId");
        String fmlyCd = (String) jsonObject.get("fmlyCd");
        JSONArray arrAddPayment = (JSONArray) jsonObject.get("arrAddPayment");
        JSONArray arrRfndPayment = (JSONArray) jsonObject.get("arrRfndPayment");
        JSONArray arrEditPayment = (JSONArray) jsonObject.get("arrEditPayment");
        JSONArray arrDelPayment = (JSONArray) jsonObject.get("arrDelPayment");

        List<SaleJobVo> listAddPayment = new ArrayList<SaleJobVo>();
        List<SaleJobVo> listRfndPayment = new ArrayList<SaleJobVo>();
        List<SaleJobVo> listEditPayment = new ArrayList<SaleJobVo>();
        List<SaleJobVo> listDelPayment = new ArrayList<SaleJobVo>();

        setListPayment(arrAddPayment, listAddPayment, saleId, staffId, fmlyCd);
        setListPayment(arrRfndPayment, listRfndPayment, saleId, staffId, fmlyCd);
        setListPayment(arrEditPayment, listEditPayment, saleId, staffId, fmlyCd);
        setListPayment(arrDelPayment, listDelPayment, saleId, staffId, fmlyCd);

        for (int i = 0, size = listRfndPayment.size(); i < size; i++) {
            listAddPayment.add(listRfndPayment.get(i));
        }

        if (listAddPayment.size() > 0) {
            logger.info(listAddPayment.toString());
            Map addPaymentMap = new HashMap();
            addPaymentMap.put("listPayment", listAddPayment);
            try {
                saleJobService.addListSaleJob(addPaymentMap);
            } catch (Exception e) {
                e.printStackTrace();
                return "failAddPayment";
            }
        }
        if (listDelPayment.size() > 0) {
            logger.info(listDelPayment.toString());
            Map delPaymentMap = new HashMap();
            delPaymentMap.put("listPayment", listDelPayment);
            try {
                saleJobService.delListSaleJob(delPaymentMap);
            } catch (Exception e) {
                e.printStackTrace();
                return "failDelPayment";
            }
        }

        try {
            for (int i = 0, size = listEditPayment.size(); i < size; i++) {
                saleJobService.modifySaleJob(listEditPayment.get(i));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "failModifyPayment";
        }

        return "success";
    }

    private String setPrdct(JSONObject jsonObject) {
        String saleId = (String) jsonObject.get("saleId");
        String shopId = (String) jsonObject.get("shopId");

        List<PrdctVo> listAddInvnPrdct = new ArrayList<PrdctVo>();
        List<PrdctVo> listAddNewPrdct = new ArrayList<PrdctVo>();
        List<PrdctVo> listEditInvnPrdct = new ArrayList<PrdctVo>();
        List<PrdctVo> listEditNewPrdct = new ArrayList<PrdctVo>();
        List<PrdctVo> listDelInvnPrdct = new ArrayList<PrdctVo>();
        List<PrdctVo> listDelNewPrdct = new ArrayList<PrdctVo>();

        // add-Delete
        List<PrdctVo> listCntUpInvnPrdct = new ArrayList<PrdctVo>();

        // Add or dtr-Delete
        List<PrdctVo> listCntDownInvnPrdct = new ArrayList<PrdctVo>();

        JSONArray arrAddPrdct = (JSONArray) jsonObject.get("arrAddPrdct");
        JSONArray arrEditPrdct = (JSONArray) jsonObject.get("arrEditPrdct");
        JSONArray arrDelPrdct = (JSONArray) jsonObject.get("arrDelPrdct");

        setListPrdct(saleId, shopId, arrAddPrdct, listAddInvnPrdct, listAddNewPrdct, listCntUpInvnPrdct,
            listCntDownInvnPrdct);
        setListPrdct(saleId, shopId, arrEditPrdct, listEditInvnPrdct, listEditNewPrdct, listCntUpInvnPrdct,
            listCntDownInvnPrdct);
        setListPrdct(saleId, shopId, arrDelPrdct, listDelInvnPrdct, listDelNewPrdct, listCntUpInvnPrdct,
            listCntDownInvnPrdct);

        if (listAddInvnPrdct.size() > 0) {
            Map prdctMap = new HashMap();
            prdctMap.put("listInvnPrdct", listAddInvnPrdct);
            try {
                prdctService.addInvnPrdct(prdctMap);
            } catch (Exception e) {

                e.printStackTrace();
                return "failAddPrdct";
            }
        }

        if (listAddNewPrdct.size() > 0) {
            Map prdctMap = new HashMap();
            prdctMap.put("listNewPrdct", listAddNewPrdct);
            try {
                prdctService.addNewPrdct(prdctMap);
            } catch (Exception e) {
                e.printStackTrace();
                return "failAddNewPrdct";
            }
        }

        try {
            for (int i = 0, size = listEditInvnPrdct.size(); i < size; i++) {
                prdctService.modifyInvnPrdct(listEditInvnPrdct.get(i));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "failModifyInvnPrdct";
        }

        try {
            for (int i = 0, size = listEditNewPrdct.size(); i < size; i++) {
                prdctService.modifyNewPrdct(listEditNewPrdct.get(i));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "failModifyInvnPrdct";
        }

        if (listDelInvnPrdct.size() > 0) {
            Map prdctMap = new HashMap();
            prdctMap.put("listInvnPrdct", listDelInvnPrdct);
            try {
                prdctService.removeInvnPrdct(prdctMap);
            } catch (Exception e) {
                e.printStackTrace();
                return "failRemoveInvnPrdct";
            }
        }

        if (listDelNewPrdct.size() > 0) {
            Map prdctMap = new HashMap();
            prdctMap.put("listNewPrdct", listDelNewPrdct);
            try {
                prdctService.removeNewPrdct(prdctMap);
            } catch (Exception e) {
                e.printStackTrace();
                return "failRemoveNewPrdct";
            }
        }

        return "success";
    }
}
