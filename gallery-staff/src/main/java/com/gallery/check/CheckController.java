package com.gallery.check;

import com.gallery.common.CommonCode;
import com.gallery.common.CommonFunction;
import com.gallery.cstmr.CstmrService;
import com.gallery.cstmr.CstmrVo;
import com.gallery.sale.SaleService;
import com.gallery.sale.SaleVo;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffService;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@RequestMapping(value = "/check")
@Controller
@RequiredArgsConstructor
public class CheckController {

    private static final Logger logger = LoggerFactory.getLogger(CheckController.class);
    private final CheckService checkService;
    private final SaleService saleService;
    private final CstmrService cstmrService;
    private final StaffService staffService;

    @RequestMapping(value = "indexCheckEyesForm.do")
    public String indexPrdctForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        logger.info("run indexCheckEyesForm");
        session.setAttribute("currentPage", "2");
        model.addAttribute("cstmrId", ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId());
        model.addAttribute("histId", ((SaleVo) session.getAttribute(CommonCode.ATTR_SALE)).getHistId());
        model.addAttribute("cstmrName", ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName());

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        CstmrVo cstmrVo = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR));

        logger.info("run indexCheckEyesForm staffId:" + staffVo.getStaffId());
        logger.info("run indexCheckEyesForm staffVo:" + shopVo.getShopId());

        model.addAttribute("shopVo", shopVo);
        model.addAttribute("staffVo", staffVo);

        SaleVo getSale = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
        try {
            if (getSale.getSaleId() != null) {

                getSale = saleService.selectSale(getSale);

                model.addAttribute("saleVo", getSale);
                model = CommonFunction.setButton(getSale.getResult(), model, CommonCode.ARRAY_CHECK);
            } else {
                model = CommonFunction.setButton("00000", model, CommonCode.ARRAY_CHECK);
            }
            Map map6 = cstmrService.getListFmly(cstmrVo);
            Map map7 = staffService.listStaffShop(staffVo);

            model.addAllAttributes(map6);
            model.addAllAttributes(map7);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "tiles:check/indexCheckEyesForm";
    }


    @RequestMapping(value = "listVisitData.do")
    public String listVisitData(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        try {
            Map map = checkService.listVisitData(checkVo);
            model.addAllAttributes(map);
            model.addAttribute("staffVo", staffVo);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "check/listVisitData";
    }

    @RequestMapping(value = "insertVisitAction.do")
    @ResponseBody
    public String insertVisitAction(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        logger.info("run insertVisitAction:" + checkVo.toString());
        String msgReturn;
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        saleVo.setShopId(shopVo.getShopId());
        saleVo.setCstmrId(cstmrVo.getCstmrId());
        String dateTile = checkVo.getDateTile();
        checkVo.setStaffId(staffVo.getStaffId());
        checkVo.setVisitShopId(staffVo.getShopId());

        //make new sale
        if (saleVo.getSaleId() == null) {
            saleVo.setResult(CommonCode.RESULT_INIT);
            saleVo.setDatetime(dateTile);
            try {
                if (0 == saleService.checkSaleCstrm(saleVo)) {
                    saleVo = saleService.addSaleProcess(saleVo);
                    saleVo.setResult(CommonCode.RESULT_INIT);
                    saleVo.setDatetime(dateTile);
                    session.setAttribute(CommonCode.ATTR_SALE, saleVo);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            checkVo.setDatetime(checkVo.getDateTile());
            msgReturn = checkService.addVisit(checkVo, session);
            saleVo.setResult(saleService.modifyResult(saleVo, CommonCode.ARRAY_CHECK, CommonCode.COMPLETED));
            logger.info("@@@@@@@@@@@@@@@@@@@@ get it1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            session.setAttribute(CommonCode.ATTR_SALE, saleVo);
            return msgReturn;
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "fail";
    }

    @RequestMapping(value = "updateVisitAction.do")
    @ResponseBody
    public String updateVisitAction(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        logger.info("run updateVisitAciton");
        logger.info(checkVo.toString());
        try {
            return checkService.updateVisit(checkVo, session);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "fail";
    }

    @RequestMapping(value = "editCheckInfo.do")
    @ResponseBody
    public String editCheckInfo(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        logger.info("run editCheckInfo");
        logger.info(checkVo.toString());
        CheckVo setterCheckVo = new CheckVo();
        logger.info("init setCheckVo:" + setterCheckVo);
        if (checkVo.getHistId() == null) {
            return "fail";
        } else {
            setterCheckVo.setHistId(checkVo.getHistId());
        }

        if (checkVo.getHistName().equals("gsphRight")) {
            setterCheckVo.setGsphRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("gsphLeft")) {
            setterCheckVo.setGsphLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("gcylRight")) {
            setterCheckVo.setGcylRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("gcylLeft")) {
            setterCheckVo.setGcylLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("gaxisRight")) {
            setterCheckVo.setGaxisRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("gaxisLeft")) {
            setterCheckVo.setGaxisLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("pdRight")) {
            setterCheckVo.setPdRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("pdLeft")) {
            setterCheckVo.setPdLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("addRight")) {
            setterCheckVo.setAddRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("addLeft")) {
            setterCheckVo.setAddLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("prismRight")) {
            setterCheckVo.setPrismRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("prismLeft")) {
            setterCheckVo.setPrismLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("baseRight")) {
            setterCheckVo.setBaseRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("baseLeft")) {
            setterCheckVo.setBaseLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("npcRight")) {
            setterCheckVo.setNpcRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("npcLeft")) {
            setterCheckVo.setNpcLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("npaRight")) {
            setterCheckVo.setNpaRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("npaLeft")) {
            setterCheckVo.setNpaLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("domEye")) {
            setterCheckVo.setDomEye(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("lsphRight")) {
            setterCheckVo.setLsphRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("lsphLeft")) {
            setterCheckVo.setLsphLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("lcylRight")) {
            setterCheckVo.setLcylRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("lcylLeft")) {
            setterCheckVo.setLcylLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("laxisRight")) {
            setterCheckVo.setLaxisRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("laxisLeft")) {
            setterCheckVo.setLaxisLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("bcRight")) {
            setterCheckVo.setBcRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("bcLeft")) {
            setterCheckVo.setBcLeft(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("diaRight")) {
            setterCheckVo.setDiaRight(checkVo.getEditHstVal());
        } else if (checkVo.getHistName().equals("diaLeft")) {
            setterCheckVo.setDiaLeft(checkVo.getEditHstVal());
        }
        try {
            return checkService.editCheckInfo(setterCheckVo, session);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "fail";
    }

    @RequestMapping(value = "getCheckDataForSale.do")
    @ResponseBody
    public CheckVo getCheckDataForSale(ModelMap model, HttpServletRequest request, HttpSession session) {
        try {
            return checkService.selectVisitInfoForSale(session);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return new CheckVo();
    }

    @RequestMapping(value = "getEyeCheckByCstmrId.do")
    @ResponseBody
    public CheckVo getEyeCheckByCstmrId(ModelMap model, HttpServletRequest request, CstmrVo cstmrVo) {
        logger.info("run GetEyeCheckByCstmrId :" + cstmrVo);
        try {
            logger.info("step1");
            return checkService.getEyeCheckByCstmrId(cstmrVo);
        } catch (Exception e) {
            logger.info("step2");
            logger.error(e.getLocalizedMessage());
        }
        logger.info("step3");
        return new CheckVo();
    }


    @RequestMapping(value = "getCheckData.do")
    @ResponseBody
    public CheckVo getCheckData(ModelMap model, HttpServletRequest request, CheckVo checkVo, HttpSession session) {
        logger.info("run getCheckData");
        try {
            checkVo = checkService.selectVisitInfo(checkVo);
            return checkVo;
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return new CheckVo();
    }
}
