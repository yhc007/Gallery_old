package com.gallery.saleJob;

import com.gallery.common.CommonCode;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RequestMapping(value = "/saleJob")
@Controller
@RequiredArgsConstructor
public class SaleJobController {

    private static final Logger logger = LoggerFactory.getLogger(SaleJobController.class);
    private final SaleJobService saleJobService;

    @RequestMapping(value = "listVisitingCstmrData.do")
    public String listVisitingCstmrData(SaleJobVo saleJobVo, ModelMap model, HttpSession session) {
        logger.info("run listVisitingCstmrData");

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        if (shopVo == null)
            saleJobVo.setShopId(-1);
        else
            saleJobVo.setShopId(shopVo.getShopId());
        try {
            Map map = saleJobService.listVisitingCstmrData(saleJobVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "saleJob/listVisitingCstmrData";
    }

    @RequestMapping(value = "delVisitData.do")
    @ResponseBody
    public String delVisitData(SaleJobVo saleJobVo) {
        try {
            return saleJobService.delVisitData(saleJobVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
