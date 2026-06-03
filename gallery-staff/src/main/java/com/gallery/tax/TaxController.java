package com.gallery.tax;

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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


@RequestMapping(value = "/tax")
@Controller
@RequiredArgsConstructor
public class TaxController {

    private static final Logger logger = LoggerFactory.getLogger(TaxController.class);
    private final SaleService saleService;

    @RequestMapping(value = "renewalTax.do")
    @ResponseBody
    public String renewalTax(SaleVo saleVo) {
        String s = saleVo.getJsonTax();
        logger.info("run renewalTax:" + s);
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
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

    @RequestMapping(value = "printTax.do")
    public String printTax(String taxHtml, ModelMap model, HttpServletRequest request) {
        model.addAttribute("taxHtml", taxHtml);
        return "print/taxPrint";
    }

}
