package com.gallerytalk.mobile.brand.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.brand.domain.BrandVo;
import com.gallerytalk.mobile.brand.service.BrandService;

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
	
	@RequestMapping(value = "listBrandData")
	public String listBrandData(BrandVo brandVo,ModelMap model) {
		logger.debug("modify "+brandVo.toString());
		try{
			Map map=brandService.listBrandData(brandVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "brand/listBrandData";
	}
	
	@RequestMapping(value ="getBrandData.do")
	@ResponseBody
	public BrandVo getBrandData(BrandVo brandVo)throws Exception{
		BrandVo bb=brandService.selectBrand(brandVo);
		logger.debug(bb.toString());
		return bb;
	}	
}
