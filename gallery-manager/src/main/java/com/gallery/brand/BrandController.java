package com.gallery.brand;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/brand")
@Controller
@RequiredArgsConstructor
public class BrandController {

	private final BrandService brandService;

	@RequestMapping(value = "indexBrandForm.do")
	public String indexBrandForm(HttpServletRequest request,ModelMap model) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);

		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("브랜드 등록/수정",620,"left",20));

		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		return "tiles:brand/indexBrandForm";
	}

	@RequestMapping(value = "addBrandAction.do")
	@ResponseBody
	public String addBrandAction(BrandVo brandVo) {
		try{
			return brandService.addBrand(brandVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "modifyBrandAction.do")
	@ResponseBody
	public String modifyBrandAction(BrandVo brandVo) {
		try{
			brandService.modifyBrand(brandVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "removeBrandAction.do")
	@ResponseBody
	public String removeBrandAction(BrandVo brandVo) {
		try{
			return brandService.removeBrand(brandVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "listBrandData.do")
	public String listBrandData(BrandVo brandVo,ModelMap model) {
		try{
			Map map=brandService.pagedListBrandData(brandVo);
            model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "brand/listBrandData";
	}

	@RequestMapping(value ="getBrandData.do")
	@ResponseBody
	public BrandVo getBrandData(BrandVo brandVo) throws Exception{
		return brandService.selectBrand(brandVo);
	}

}
