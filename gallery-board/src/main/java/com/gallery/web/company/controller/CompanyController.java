package com.gallery.web.company.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.company.domain.CompanyVo;
import com.gallery.web.company.service.CompanyService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/company")
@Controller
public class CompanyController {
	
	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private CompanyService companyService;
	private PrdctService prdctService;
	
	@RequestMapping(value = "indexCompanyForm")
	public String indexCompnayForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("거래처 등록/수정",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 0);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<1){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:company/indexCompanyForm";
		}
		return rtnPage;
	}
	
	
	@RequestMapping(value = "addCompanyAction")
	@ResponseBody
	public String addCompanyAction(CompanyVo companyVo) {
		logger.debug("add "+companyVo.toString());
		try{
			String result=companyService.addCompany(companyVo);
			System.out.println("add company : " + result);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "modifyCompanyAction")
	@ResponseBody
	public String modifyCompanyAction(CompanyVo CompanyVo) {
		logger.debug("modify "+CompanyVo.toString());
		try{
			companyService.modifyCompany(CompanyVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeCompanyAction")
	@ResponseBody
	public String removeCompanyAction(CompanyVo CompanyVo) {
		logger.debug("remove "+CompanyVo.toString());
		try{
			return companyService.removeCompany(CompanyVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listCompanyData")
	public String listCompnayData(CompanyVo CompanyVo,ModelMap model) {
		logger.debug("modify "+CompanyVo.toString());
		System.out.println("controller : " + CompanyVo.toString());
		try{
			Map map=companyService.pagedListCompanyData(CompanyVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "company/listCompanyData";
	}
	
	@RequestMapping(value = "selectCompanyData")
	public String selectCompnayData(CompanyVo companyVo,ModelMap model) {
		try{
			Map map=companyService.listAllComData(companyVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "prdct/selectCompanyData";
	}
	
	
	
	@RequestMapping(value ="getCompanyData.do")
	@ResponseBody
	public CompanyVo getCompanyData(CompanyVo CompanyVo)throws Exception{
		CompanyVo bb=companyService.selectCompany(CompanyVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	@RequestMapping(value ="mListCompnayData.do")
	public String mListCompnayData(HttpServletRequest request, HttpServletResponse response,CompanyVo CompanyVo)throws Exception{
		companyService.mListCompanyData(CompanyVo,response);
		return "home";
	}
	@RequestMapping(value ="mListCompnayDataForDsply.do")
	public String mListCompnayDataForDsply(HttpServletRequest request, HttpServletResponse response,CompanyVo CompanyVo)throws Exception{
		companyService.mListCompanyDataForDsply(CompanyVo,response);
		return "home";
	}
	
	@RequestMapping(value="selectComList")
	public String selectComList(CompanyVo companyVo, ModelMap model){
		try {
			Map map = companyService.selectComList(companyVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "company/listComData";
	}
	
}
