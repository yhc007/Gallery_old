package com.gallery.tax;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.cstmr.CstmrService;
import com.gallery.cstmr.CstmrVo;
import com.gallery.sale.SaleService;
import com.gallery.sale.SaleVo;
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
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


@RequestMapping(value = "/tax")
@Controller
@RequiredArgsConstructor
public class TaxController {

    private static final Logger logger = LoggerFactory.getLogger(TaxController.class);
    private final SaleService saleService;
    private final CstmrService cstmrService;

    @RequestMapping(value = "indexTaxForm.do")
    public String indexTaxForm(ModelMap model, HttpServletRequest request, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("이력 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("연말정산", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 7);

        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:tax/indexTaxForm";
    }

    @RequestMapping(value = "listSaleOff4Tax.do")
    public String listSaleOff4Tax(SaleVo saleVo, ModelMap model) {
        try {
            List<SaleVo> listSale = saleService.listSaleOff4Tax(saleVo);
            model.put("listSale", listSale);
            return "tax/listCstmr4Tax";
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
        return "tax/listCstmr4Tax";
    }

    @RequestMapping(value = "renewalTax.do")
    @ResponseBody
    public String renewalTax(SaleVo saleVo) {
        String s = saleVo.getJsonTax();
        Object obj = JSONValue.parse(s);
        JSONObject tmpJo = (JSONObject) obj;
        JSONArray arrTax = (JSONArray) tmpJo.get("arrTax");
        String today = (String) tmpJo.get("today");
        String printName = (String) tmpJo.get("printName");

        JSONObject jsonObject;
        Iterator iter;
        List<SaleVo> listSaleVo = new ArrayList<SaleVo>();
        int size = arrTax.size();
        String tmpShopName = "";
        String tmpCstmrName = "";
        for (int i = 0; i < size; i++) {
            jsonObject = (JSONObject) arrTax.get(i);
            iter = jsonObject.keySet().iterator();
            SaleVo tmpSaleVo = new SaleVo();
            while (iter.hasNext()) {
                String key = (String) iter.next();
                if (key.equals("saleId")) {
                    tmpSaleVo.setSaleId(Integer.parseInt((String) jsonObject.get(key)));
                } else if (key.equals("shopName")) {
                    tmpShopName = (String) jsonObject.get(key);
                    tmpSaleVo.setShopName(tmpShopName);
                } else if (key.equals("name")) {
                    tmpCstmrName = (String) jsonObject.get(key);
                    tmpSaleVo.setCstmrName(tmpCstmrName);
                }
            }
            tmpSaleVo.setTaxBigo(today + ":" + tmpShopName + ":" + printName);
            listSaleVo.add(tmpSaleVo);
        }
        try {
            for (int i = 0, size2 = listSaleVo.size(); i < size2; i++) {
                saleService.renewalTaxBigo(listSaleVo.get(i));
            }
            CstmrVo tmpCstmrVo = new CstmrVo();
            tmpCstmrVo.setEmail(saleVo.getEmail());
            tmpCstmrVo.setCstmrId(Integer.parseInt(saleVo.getCstmrId()));
            cstmrService.updateEmail4Tax(tmpCstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    @RequestMapping(value = "getListCstmr.do")
    @ResponseBody
    public String getListCstmr4Tax(CstmrVo cstmrVo, ModelMap model) {
        JSONObject json = new JSONObject();

        JSONArray jsonArray = new JSONArray();
        try {
            List<CstmrVo> listCstmr = cstmrService.getListCstmr4Tax(cstmrVo);

            for (int i = 0, size = listCstmr.size(); i < size; i++) {
                JSONObject jsonCstmrVo = new JSONObject();
                jsonCstmrVo.put("cstmrId", listCstmr.get(i).getCstmrId());
                jsonCstmrVo.put("cstmrCd", listCstmr.get(i).getCstmrCd());
                jsonCstmrVo.put("fmlyCd", listCstmr.get(i).getFmlyCd());
                if (listCstmr.get(i).getCstmrName() == null) {
                    jsonCstmrVo.put("cstmrName", listCstmr.get(i).getCstmrName());
                } else {
                    jsonCstmrVo.put("cstmrName", URLEncoder.encode(listCstmr.get(i).getCstmrName(), "utf-8").replaceAll("\\+", "%20"));
                }
                if (listCstmr.get(i).getTelephone() == null) {
                    jsonCstmrVo.put("telephone", listCstmr.get(i).getTelephone());
                } else {
                    jsonCstmrVo.put("telephone", (listCstmr.get(i).getTelephone().equals("null")) ? "--" : listCstmr.get(i).getTelephone());
                }
                if (listCstmr.get(i).getCellphone() == null) {
                    jsonCstmrVo.put("telephone", listCstmr.get(i).getCellphone());
                } else {
                    jsonCstmrVo.put("cellphone", (listCstmr.get(i).getCellphone().equals("null")) ? "--" : listCstmr.get(i).getCellphone());
                }
                if (listCstmr.get(i).getAddr() == null) {
                    jsonCstmrVo.put("addr", listCstmr.get(i).getAddr());
                } else {
                    jsonCstmrVo.put("addr", URLEncoder.encode(listCstmr.get(i).getAddr(), "utf-8").replaceAll("\\+", "%20"));
                }
                if (listCstmr.get(i).getEmail() == null) {
                    jsonCstmrVo.put("email", listCstmr.get(i).getEmail());
                } else {
                    jsonCstmrVo.put("email", URLEncoder.encode(listCstmr.get(i).getEmail(), "utf-8").replaceAll("\\+", "%20"));
                }

                jsonCstmrVo.put("birthDay", listCstmr.get(i).getBirthDay());
                jsonArray.add(jsonCstmrVo);
            }
            json.put("listCstmr", jsonArray);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json.toJSONString();
    }
}
