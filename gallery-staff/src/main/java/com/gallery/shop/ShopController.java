package com.gallery.shop;

import com.gallery.common.CommonCode;
import com.gallery.sale.SaleService;
import com.gallery.sale.SaleVo;
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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.TimeZone;

@RequestMapping(value = "/shop")
@Controller
@RequiredArgsConstructor
public class ShopController {

    private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
    private final ShopService shopService;
    private final SaleService saleService;

    @RequestMapping(value = "indexShopForm.do")
    public String indexShopForm(HttpServletRequest request, ModelMap model, ShopVo shopVo) {
        logger.info("run indexShopForm shopVo:" + shopVo);
        try {
            Map map = shopService.listShopData(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "shop/indexShopForm";
    }


    @RequestMapping(value = "indexShopCstrmForm.do")
    public String indexShopCstmrForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        session.setAttribute("currentPage", "1");
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

        try {
            logger.info("run staffId:" + staffVo.getStaffId());
            logger.info("run shopVo:" + shopVo.getShopId());
        } catch (NullPointerException e) {
            e.printStackTrace();
            logger.error("staff or Shop session is null.");
            return "error/error";
        }

        TimeZone tz;
        Date today = new Date();
        DateFormat df = new SimpleDateFormat("yyyy");
        tz = TimeZone.getTimeZone("Asia/Seoul");
        df.setTimeZone(tz);
        String cyear = df.format(today);
        Integer tmp = Integer.parseInt(cyear) - 1900;
        cyear = tmp.toString();
        model.addAttribute("cyear", cyear);

        try {
            saleVo = saleService.selectSale(saleVo);
            logger.info("@@@@@@@@@@@@@@@@@@@@ get it 10 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            session.setAttribute(CommonCode.ATTR_SALE, saleVo);
            model.addAttribute("saleVo", saleVo);
            model.addAttribute("staffVo", staffVo);
            model.addAttribute("shopVo", shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "shop/indexShopCstmrForm";
    }

    @RequestMapping(value = "setShopCstmrHstry.do")
    @ResponseBody
    public void setShopCstmrHstry(HttpServletRequest request, ShopVo shopVo, HttpSession session) {
        logger.info("run setShopCstmrHstry shopVo-" + shopVo);

        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        ShopVo getShop = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);

        logger.info("staffId:" + staffVo.getStaffId());
        shopVo.setShopId(getShop.getShopId());
        shopVo.setStaffId(staffVo.getStaffId());

        try {
            shopService.recCstmrHstry(shopVo);
        } catch (Exception e) {
            logger.error("fail recCstmrHstry");
        }
    }

//	@Deprecated
//	@RequestMapping(value = "addShopAction.do")
//	@ResponseBody
//	public String addShopAction(ShopVo shopVo) {
//		logger.debug("add "+shopVo.toString());
//		try{
//			String result=shopService.addShop(shopVo);
//			return result;
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return "fail";
//	}
//
//    @Deprecated
//	@RequestMapping(value = "modifyShopAction.do")
//	@ResponseBody
//	public String modifyShopAction(ShopVo shopVo) {
//		logger.debug("modify "+shopVo.toString());
//		try{
//			shopService.modifyShop(shopVo);
//			return "upsuccess";
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return "fail";
//	}
//
//    @Deprecated
//	@RequestMapping(value = "removeShopAction.do")
//	@ResponseBody
//	public String removeShopAction(ShopVo shopVo) {
//		logger.debug("remove "+shopVo.toString());
//		try{
//			shopService.removeShop(shopVo);
//			return "success";
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return "fail";
//	}

    @RequestMapping(value = "removeCstmrShopHstry.do")
    @ResponseBody
    public String removeCstmrShopHstry(ShopVo shopVo) {
        try {
            shopService.rmvCstmrShopHstry(shopVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listHstryCstmrData.do")
    public String listHstryCstmrData(ShopVo getShopVo, ModelMap model, HttpSession session) {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);

        if (getShopVo.getToday() == null)
            shopVo.setToday(-1);
        else
            shopVo.setToday(getShopVo.getToday());
        try {
            Map map = shopService.listCstmrShopHstry(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saleJob/listHstryCstmrData";
    }

//	@Deprecated
//	@RequestMapping(value = "mlistShopData.do")
//	public String mlistShopData(HttpServletResponse response,ShopVo shopVo) throws Exception{
//		shopService.mListShopData(response, shopVo);
//
//		return "home";
//	}
//
//	@Deprecated
//	@RequestMapping(value ="getShopData.do")
//	@ResponseBody
//	public ShopVo getCstmrData(ShopVo shopVo)throws Exception{
//		ShopVo bb=shopService.selectShop(shopVo);
//		logger.debug(bb.toString());
//		return bb;
//	}

    @RequestMapping(value = "getShopPwd.do")
    @ResponseBody
    public String getShopPwd(ShopVo shopVo) {
        try {
            return shopService.getShopPwd(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getShopInfo.do")
    @ResponseBody
    public ShopVo getShopInfo(ShopVo shopVo) {
        logger.info("run getShopInfo:" + shopVo);
        try {
            return shopService.getShopInfo(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
