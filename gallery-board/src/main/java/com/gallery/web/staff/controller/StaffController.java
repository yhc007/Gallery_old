package com.gallery.web.staff.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.shop.service.ShopService;
import com.gallery.web.staff.domain.StaffVo;
import com.gallery.web.staff.service.StaffService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/staff")
@Controller
public class StaffController {
	
	private static final Logger logger = LoggerFactory.getLogger(StaffController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private StaffService staffService;
	
	@Autowired
	private ShopService shopService;
	
	@RequestMapping(value = "indexStaffForm")
	public String indexStaffForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		
		try{
			model.addAllAttributes(shopService.listShopData(null));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("매장 관리",120,"center",0));
		tlist.add(new MenuTreeVo("점원 관리",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 2);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:staff/indexStaffForm";
		}
		return rtnPage;
	}
	
	
	@RequestMapping(value = "addStaffAction")
	@ResponseBody
	public String addStaffAction(StaffVo staffVo) {
		logger.debug("add "+staffVo.toString());
		

		try{
			String result=staffService.addStaff(staffVo);
			if(result!=null){
				result = "upsuccess";
			}
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "fail";
	}
	
	@RequestMapping(value = "addStaffPhotoAction")
	@ResponseBody
	public String addStaffPhotoAction(StaffVo staffVo,FileUploadForm uploadForm) {
		logger.info("addStaffPhotoAction "+staffVo.toString());
		
		try{
			String result=staffService.addStaffPhotos(staffVo, uploadForm);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "modifyStaffAction")
	@ResponseBody
	public String modifyStaffAction(StaffVo staffVo) {
		logger.debug("modify "+staffVo.toString());
		try{
			staffService.modifyStaff(staffVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeStaffAction")
	@ResponseBody
	public String removeStaffAction(StaffVo staffVo) {
		logger.debug("remove "+staffVo.toString());
		try{
			return staffService.removeStaff(staffVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removePhotoAction")
	@ResponseBody
	public String removeStaffPhotoAction(StaffVo staffVo) {
		logger.debug("removeStaffPhotoAction "+staffVo.toString());
		try{
			return staffService.removeStaffPhoto(staffVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listStaffData")
	public String listStaffData(StaffVo staffVo,ModelMap model, HttpSession session) {
		Integer shopId = (Integer) session.getAttribute("shopId");
		logger.debug("listStaffData "+staffVo.toString());
		try{
			Map map=staffService.pagedListStaffData(staffVo,shopId);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "staff/listStaffData";
	}
	
	
	
	
	@RequestMapping(value ="getStaffData.do")
	@ResponseBody
	public StaffVo getStaffData(StaffVo staffVo)throws Exception{
		StaffVo bb=staffService.selectStaff(staffVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	@RequestMapping(value ="mListStaffData.do")
	public String mListStaffData(HttpServletRequest request, HttpServletResponse response,StaffVo staffVo)throws Exception{
		 staffService.mListStaffData(staffVo,response);
		return "home";
	}
	
	@RequestMapping(value ="mListStaffDataForDsply.do")
	public String mListStaffDataForDsply(HttpServletRequest request, HttpServletResponse response,StaffVo staffVo)throws Exception{
		 staffService.mListStaffDataForDsply(staffVo,response);
		return "home";
	}
	
}
