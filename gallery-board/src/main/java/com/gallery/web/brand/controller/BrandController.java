package com.gallery.web.brand.controller;

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.brand.service.BrandService;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/brand")
@Controller
public class BrandController {

    private static final Logger logger = LoggerFactory.getLogger(BrandController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */
    @Autowired
    private BrandService brandService;

    @RequestMapping(value = "indexBrandForm")
    public String indexBrandForm(HttpServletRequest request, ModelMap model) {
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("상품 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("브랜드 등록/수정", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 1);
        return "tiles:brand/indexBrandForm";
    }


    @RequestMapping(value = "addBrandAction")
    @ResponseBody
    public String addBrandAction(BrandVo brandVo) {
        logger.debug("add " + brandVo.toString());
        try {
            String result = brandService.addBrand(brandVo);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "modifyBrandAction")
    @ResponseBody
    public String modifyBrandAction(BrandVo brandVo) {
        logger.debug("modify " + brandVo.toString());
        try {
            brandService.modifyBrand(brandVo);
            return "upsuccess";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removeBrandAction")
    @ResponseBody
    public String removeBrandAction(BrandVo brandVo) {
        logger.debug("remove " + brandVo.toString());
        try {
            return brandService.removeBrand(brandVo);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listBrandData")
    public String listBrandData(BrandVo brandVo, ModelMap model) {
        logger.debug("modify " + brandVo.toString());
        try {
            Map map = brandService.pagedListBrandData(brandVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "brand/listBrandData";
    }


    @RequestMapping(value = "getBrandData.do")
    @ResponseBody
    public BrandVo getBrandData(BrandVo brandVo) throws Exception {
        BrandVo bb = brandService.selectBrand(brandVo);
        logger.debug(bb.toString());
        return bb;
    }

    @RequestMapping(value = "mListBrandData.do")
    public String mListBrandData(HttpServletRequest request, HttpServletResponse response, BrandVo brandVo) throws Exception {
        brandService.mListBrandData(brandVo, response);
        return "home";
    }

    @RequestMapping(value = "mListBrandDataForDsply.do")
    public String mListBrandDataForDsply(HttpServletRequest request, HttpServletResponse response, BrandVo brandVo) throws Exception {
        brandService.mListBrandDataForDsply(brandVo, response);
        return "home";
    }

    @RequestMapping(value = "addNewBrand")
    @ResponseBody
    public String addNewBrand(BrandVo brandVo) {
        String result = "";
        try {
            result = brandService.addNewBrand(brandVo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }

}
