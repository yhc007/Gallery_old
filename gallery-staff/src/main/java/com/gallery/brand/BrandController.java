package com.gallery.brand;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@RequestMapping(value = "/brand")
@Controller
@RequiredArgsConstructor
public class BrandController {

    private static final Logger logger = LoggerFactory.getLogger(BrandController.class);
    private final BrandService brandService;

    @RequestMapping(value = "listBrandData.do")
    public String listBrandData(BrandVo brandVo, ModelMap model) {
        logger.debug("modify " + brandVo.toString());
        try {
            Map map = brandService.listBrandData(brandVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "brand/listBrandData";
    }

    @RequestMapping(value = "getBrandData.do")
    @ResponseBody
    public BrandVo getBrandData(BrandVo brandVo) throws Exception {
        return brandService.selectBrand(brandVo);
    }
}
