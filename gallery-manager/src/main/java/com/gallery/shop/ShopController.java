package com.gallery.shop;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/shop")
@Controller
@RequiredArgsConstructor
public class ShopController {

    private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
    private final ShopService shopService;

    @RequestMapping(value = "indexShopForm.do")
    public String indexShopForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("매장 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("매장 등록/수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 1);

        Integer lv = (Integer) session.getAttribute("lv");

        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:shop/indexShopForm";
    }

    @RequestMapping(value = "findShopName.do")
    public String findShopName(ShopVo shopVo, ModelMap model) {
        try {
            Map map = shopService.findShopName(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "tiles:prdct/shopInfo";
    }

    @RequestMapping(value = "getshopName.do")
    @ResponseBody
    public String getshopName(ShopVo shopVo) {
        String result = "";
        try {
            result = shopService.getshopName(shopVo);
            result = URLEncoder.encode(result, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "addShopAction.do")
    @ResponseBody
    public ShopVo addShopAction(ShopVo shopVo) {
        try {
            return shopService.addShop(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        shopVo.setResult("fail");
        return shopVo;
    }

    @RequestMapping(value = "modifyShopAction.do")
    @ResponseBody
    public ShopVo modifyShopAction(ShopVo shopVo) {
        logger.debug("modify " + shopVo.toString());
        try {
            shopService.modifyShop(shopVo);
            shopVo.setResult("upsuccess");
            return shopVo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        shopVo.setResult("fail");
        return shopVo;
    }

    @RequestMapping(value = "removeShopAction.do")
    @ResponseBody
    public String removeShopAction(ShopVo shopVo) {
        logger.debug("remove " + shopVo.toString());
        try {
            shopService.removeShop(shopVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listShopData.do")
    public String listShopData(ShopVo shopVo, ModelMap model) {
        logger.debug("modify " + shopVo.toString());
        try {
            Map map = shopService.pagedListShopData(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/listShopData";
    }

    @Deprecated
    @RequestMapping(value = "mlistShopData.do")
    public String mlistShopData(HttpServletResponse response, ShopVo shopVo) throws Exception {
        shopService.mListShopData(response, shopVo);
        return "home";
    }

    @RequestMapping(value = "getShopData.do")
    @ResponseBody
    public ShopVo getCstmrData(ShopVo shopVo) throws Exception {
        return shopService.selectShop(shopVo);
    }

    @RequestMapping(value = "shopList.do")
    public String shopList(ShopVo shopVo, ModelMap model) {
        try {
            Map map = shopService.shopList(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/shopList";
    }

    @RequestMapping(value = "taxShopList.do")
    public String taxShopList(ShopVo shopVo, ModelMap model) {
        try {
            Map map = shopService.taxShopList(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/taxShopList";
    }

    @RequestMapping(value = "getComListBySrch.do")
    public String getComListBySrch(ShopVo shopVo, ModelMap model) {
        try {
            Map map = shopService.getComListBySrch(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/listComList";
    }

    @RequestMapping(value = "chkManager.do")
    @ResponseBody
    public String chkManager(ShopVo shopVo) {
        try {
            return shopService.chkManager(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getComList.do")
    public String getComList(ModelMap model) {
        try {
            Map map = shopService.getComList();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/listComList";
    }

    @RequestMapping(value = "getComListForTrade.do")
    public String getComListForTrade(ShopVo shopVo, ModelMap model) {
        try {
            Map map = shopService.getComListForTrade(shopVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "shop/listComListForTrade";
    }

    @RequestMapping(value = "getShopInfo.do")
    @ResponseBody
    public ShopVo getShopInfo(ShopVo shopVo) {
        try {
            return shopService.getShopInfo(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @RequestMapping(value = "addStampPhotoAction.do")
    @ResponseBody
    public String addStampPhotoAction(ShopVo shopVo, MultipartHttpServletRequest request) {
        try {
            return shopService.addStampPhotos(shopVo, request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removeStampAction.do")
    @ResponseBody
    public String removeStampAction(ShopVo shopVo) {
        try {
            return shopService.removeStampPhoto(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "getShopList.do")
    @ResponseBody
    public String getShopList() {
        try {
            return shopService.getShopList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

}
