package com.gallery.cstmr;

import com.gallery.common.CommonCode;
import com.gallery.mail.MailVo;
import com.gallery.sale.SaleVo;
import com.gallery.shop.ShopService;
import com.gallery.shop.ShopVo;
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
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;


@RequestMapping(value = "/cstmr")
@Controller
@RequiredArgsConstructor
public class CstmrController {

    private static final Logger logger = LoggerFactory.getLogger(CstmrController.class);
    private final CstmrService cstmrService;
    private final ShopService shopService;

    @Deprecated
    @RequestMapping(value = "newCstmr.do")
    public String newCstmr(HttpServletRequest request,
                           HttpServletResponse response, CstmrVo cstmrVo) throws Exception {
        logger.error("run newCstmr cstmrVo" + cstmrVo);

        TimeZone jst = TimeZone.getTimeZone("JST");
        Calendar cal = Calendar.getInstance(jst);
        String today = "" + cal.get(Calendar.YEAR)
            + (cal.get(Calendar.MONTH) + 1) + cal.get(Calendar.DATE);
        String cstmrCd = "m"
            + CommonCode.SHOP_CODE_MOBILE + today;

        ShopVo shopVo = new ShopVo();
        shopVo.setShopId(Integer.parseInt(CommonCode.SHOP_CODE_MOBILE));
        cstmrVo.setRegShopId(Integer.parseInt(CommonCode.SHOP_CODE_MOBILE));
        shopVo.setJoinDate(today);
        Integer countJoin = shopService.countShopJoin(shopVo);
        if (countJoin.intValue() == 0) {
            logger.error("countJoin is 0");
            countJoin++;
            shopVo.setJoinCount(countJoin);
            shopService.addShopJoin(shopVo);

        } else {
            logger.debug("countJoin is not 0");
            shopVo = shopService.selectShopJoin(shopVo);
            countJoin = shopVo.getJoinCount();
            if (countJoin.intValue() == 999999) // daily join limit
            {
                response.setCharacterEncoding("UTF-8");
                PrintWriter writer = response.getWriter();
                writer.write("ERROR 500");
                writer.flush();
                writer.close();
            }
            countJoin++;
            shopVo.setJoinCount(countJoin);
            shopService.modifyShopJoin(shopVo);
        }
        String suffix = String.format("%06d", countJoin.intValue());

        cstmrCd = cstmrCd.concat(suffix);

        cstmrVo.setCstmrCd(cstmrCd);
        try {
            cstmrService.addCstmr(cstmrVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write("ERROR 500");
            writer.flush();
            writer.close();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "idDupleCheck.do")
    public String idDupleCheck(HttpServletResponse response, CstmrVo cstmrVo)
        throws Exception {
        logger.debug("idDupleCheck " + cstmrVo.toString());
        try {
            cstmrService.idDupleCheck(cstmrVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write("ERROR 500");
            writer.flush();
            writer.close();
        }
        return "home";
    }

    @RequestMapping(value = "login.do")
    public String login(HttpServletResponse response, CstmrVo cstmrVo)
        throws Exception {
        logger.debug("login " + cstmrVo.toString());
        try {
            cstmrService.login(cstmrVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write("ERROR 500");
            writer.flush();
            writer.close();
        }
        return "home";
    }

    @Deprecated
    @RequestMapping(value = "findCstmrId.do")
    public String findCstmrId(HttpServletResponse response, CstmrVo cstmrVo)
        throws Exception {
        logger.debug("findCstmrId " + cstmrVo.toString());
        try {
            cstmrService.findCstmrId(cstmrVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write("ERROR 500");
            writer.flush();
            writer.close();
        }
        return "home";
    }

//    @Deprecated
//    @RequestMapping(value = "findCstmrPw.do")
//    public String findCstmrPw(HttpServletResponse response, CstmrVo cstmrVo)
//        throws Exception {
//        logger.debug("findCstmrId " + cstmrVo.toString());
//        try {
//            cstmrService.findCstmrPw(cstmrVo, response);
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.setCharacterEncoding("UTF-8");
//            PrintWriter writer = response.getWriter();
//            writer.write("fail");
//            writer.flush();
//            writer.close();
//        }
//        return "home";
//    }

    @Deprecated
    @RequestMapping(value = "changePwForm.do")
    public String changePwForm(ModelMap model, MailVo mailVo) throws Exception {
        logger.debug("changePw " + mailVo.toString());

        CstmrVo cstmrVo = cstmrService.selectCstmrKey(mailVo);

        model.addAttribute("cstmrId", cstmrVo.getCstmrId());
        return "cstmr/changePwForm";
    }

    @RequestMapping(value = "updatePwAction.do")
    @ResponseBody
    public String updatePwAction(HttpServletResponse response, CstmrVo cstmrVo) {
        try {
            return cstmrService.updatePw(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Deprecated
    @RequestMapping(value = "mlistCstmrData.do")
    public String istCartData(CstmrVo cstmrVo, ModelMap model) {
        model.addAttribute("cstmrId", cstmrVo.getCstmrId());
        return "cstmr/cstmrInfoForm";
    }

    @RequestMapping(value = "cstmrInfo.do")
    @ResponseBody
    public CstmrVo cstmrInfo(CstmrVo cstmrVo, ModelMap model) {
        try {
            return cstmrService.mgetCstmrInfo(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "cstmrInfoUpdate.do")
    @ResponseBody
    public void cstmrInfoUpdate(HttpServletResponse response, CstmrVo cstmrVo) {
        response.setCharacterEncoding("UTF-8");
        try {
            cstmrService.updateInfo(cstmrVo, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
            PrintWriter writer = null;
            try {
                response.getWriter();
                writer.write("fail");
                writer.flush();
                writer.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    @RequestMapping(value = "cstmrBuyList.do")
    public String cstmrBuyList(HttpServletResponse response, SaleVo saleVo, ModelMap model) {
        Map map;
        try {
            map = cstmrService.buyList(saleVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cstmr/buyList";
    }

    @RequestMapping(value = "myCoupon.do")
    public String getCoupon(HttpServletResponse response, CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map = cstmrService.myCoupon(cstmrVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmr/couponList";
    }

    @RequestMapping(value = "cstmrEyes.do")
    public String cstmrEyes(HttpServletResponse response, CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map = cstmrService.cstmrEyes(cstmrVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmr/eyesCheckData";
    }

    @RequestMapping(value = "modifyPwdForm.do")
    public String modifyPwdForm(CstmrVo cstmrVo, ModelMap model) {
        model.addAttribute("cstmrId", cstmrVo.getCstmrId());
        return "cstmr/modifyPwForm";
    }

    @RequestMapping(value = "getCstmrListForChk.do")
    public String getCstmrListForChk(CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map;
            Map map2;

            if (cstmrVo.getSrchTy().equals("all")) {
                map = cstmrService.getCstmrListForChk(cstmrVo);
                map2 = cstmrService.getCstmrListForChk2(cstmrVo);
                model.addAllAttributes(map);
                model.addAllAttributes(map2);
            } else if (cstmrVo.getSrchTy().equals("a")) {
                map2 = cstmrService.getCstmrListForChk2(cstmrVo);
                model.addAllAttributes(map2);
            } else if (cstmrVo.getSrchTy().equals("c")) {
                map = cstmrService.getCstmrListForChk(cstmrVo);
                model.addAllAttributes(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmr/listCstmrForChk";
    }

    @RequestMapping(value = "getCstmrListForCsv.do")
    public String getCstmrListForCsv(CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map;
            Map map2;

            if (cstmrVo.getSrchTy().equals("all")) {
                map = cstmrService.getCstmrListForChk(cstmrVo);
                map2 = cstmrService.getCstmrListForChk2(cstmrVo);
                model.addAllAttributes(map);
                model.addAllAttributes(map2);
            } else if (cstmrVo.getSrchTy().equals("a")) {
                map2 = cstmrService.getCstmrListForChk2(cstmrVo);
                model.addAllAttributes(map2);
            } else if (cstmrVo.getSrchTy().equals("c")) {
                map = cstmrService.getCstmrListForChk(cstmrVo);
                model.addAllAttributes(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "cstmr/listCstmrForCsv";
    }

    @RequestMapping(value = "getCstmrForMerge.do")
    public String getCstmrForMerge(CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map = cstmrService.getCstmrForMerge(cstmrVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cstmr/listCstmrForMerge";
    }

    @RequestMapping(value = "getCstmrForRemove.do")
    public String getCstmrForRemove(CstmrVo cstmrVo, ModelMap model) {
        try {
            Map map = cstmrService.getCstmrForMerge(cstmrVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "cstmr/listCstmrForRemove";
    }

    @RequestMapping(value = "mergeCstmr.do")
    @ResponseBody
    public String mergeCstmr(CstmrVo cstmrVo) {
        String jsonSC = cstmrVo.getJsonSC();

        Object obj = JSONValue.parse(jsonSC);
        JSONObject tmpJo = (JSONObject) obj;
        JSONArray arrSC = (JSONArray) tmpJo.get("arraySC");

        Iterator ite = arrSC.iterator();
        while (ite.hasNext()) {
            try {
                String scCd = (String) ite.next();
                cstmrVo.setSC(scCd);
                return cstmrService.mergeCstmr(cstmrVo);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @RequestMapping(value = "removeCstmr.do")
    @ResponseBody
    public String removeCstmr(CstmrVo cstmrVo) {
        try {
            return cstmrService.removeCstmr(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getCstmrCd.do")
    public String getCstmrCd(CstmrVo cstmrVo, ModelMap model) {
        try {
            List<CstmrVo> listCstmrPoint = cstmrService.getCstmrCd(cstmrVo);
            for (int i = 0, size = listCstmrPoint.size(); i < size; i++) {
                listCstmrPoint.get(i).setCstmrCd((listCstmrPoint.get(i).getCstmrCd().replace("*", "ASTERISK")));
                listCstmrPoint.get(i).setFmlyCd((listCstmrPoint.get(i).getFmlyCd().replace("*", "ASTERISK")));
            }
            model.put("listCstmrPoint", listCstmrPoint);
            List<ShopVo> listShopPoint = shopService.getPointShopList();
            model.put("listShopPoint", listShopPoint);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/listCstmrFmly";
    }

    @RequestMapping(value = "getCntVisitor.do")
    public String getCntVisitor(CstmrVo cstmrVo, ModelMap model) {
        Map map = null;
        try {
            map = cstmrService.getCntVisitor(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAllAttributes(map);
        return "admin/listCntVisitor";
    }

    @RequestMapping(value = "getCstmrList.do")
    public String getCstmrList(CstmrVo cstmrVo, ModelMap model) {
        Map map = null;
        try {
            map = cstmrService.getCstmrList(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAllAttributes(map);
        return "admin/listCstmr";
    }

    @RequestMapping(value = "getCntVisitorForCSV.do")
    @ResponseBody
    public String getCntVisitorForCSV(CstmrVo cstmrVo) {
        try {
            return cstmrService.getCntVisitorForCSV(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getCstmrVisitListForCSV.do")
    @ResponseBody
    public String getCstmrListForCSV(CstmrVo cstmrVo) {
        try {
            return cstmrService.getCstmrListForCSV(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
