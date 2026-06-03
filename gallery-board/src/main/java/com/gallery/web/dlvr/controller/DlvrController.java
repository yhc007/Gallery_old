package com.gallery.web.dlvr.controller;

import java.util.ArrayList;
import java.util.Date;
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
import com.gallery.web.dlvr.domain.DlvrVo;
import com.gallery.web.dlvr.service.DlvrService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/dlvr")
@Controller
public class DlvrController {
	
	private static final Logger logger = LoggerFactory.getLogger(DlvrController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private DlvrService dlvrService;
	
	
	@RequestMapping(value = "indexDlvrForm")
	public String indexDlvrForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("배송 관리",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 6);
		
		Date date = new Date();
		model.addAttribute("cyear", date.getYear()+1900);
		model.addAttribute("cmonth", date.getMonth()+1);
		//model.addAttribute("cday", String.format("%02d", date.getDay()) );
		model.addAttribute("cday", date.getDate());
		
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:dlvr/indexDlvrForm";
		}
		return rtnPage;
	}
	
	@RequestMapping(value = "newDlvrForm")
	public String newDlvrForm(HttpServletRequest request,ModelMap model) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("이벤트 관리",120,"center",0));
		tlist.add(new MenuTreeVo("이벤트 등록/수정",500,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 5);
		
		Date date = new Date();
		model.addAttribute("cyear", date.getYear());
		model.addAttribute("cmonth", date.getMonth()+1);
		//model.addAttribute("cday", String.format("%02d", date.getDay()) );
		model.addAttribute("cday", date.getDate());
		return "tiles:dlvr/newDlvrForm";
	}
	
	
	
	@RequestMapping(value = "addDlvrAction")
	@ResponseBody
	public String addDlvrAction(DlvrVo dlvrVo) {
		logger.debug("add "+dlvrVo.toString());
		try{
			String result=dlvrService.addDlvr(dlvrVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "modifyDlvrAction")
	@ResponseBody
	public String modifyDlvrAction(DlvrVo dlvrVo) {
		logger.debug("modify "+dlvrVo.toString());
		try{
			dlvrService.modifyDlvr(dlvrVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "listDlvrData")
	public String listDlvrData(DlvrVo dlvrVo,ModelMap model) {
		logger.debug("listDlvrData "+dlvrVo.toString());
		try{
			Map map=dlvrService.listDlvrData(dlvrVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "dlvr/listDlvrData";
	}
	
	@RequestMapping(value = "listDlvrPrdctData")
	public String listDlvrPrdctData(DlvrVo dlvrVo,ModelMap model) {
		logger.debug("listDlvrData "+dlvrVo.toString());
		try{
			Map map=dlvrService.listDlvrPrdctData(dlvrVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "dlvr/listDlvrPrdctData";
	}
	@RequestMapping(value ="getDlvrData.do")
	@ResponseBody
	public DlvrVo getDlvrData(DlvrVo dlvrVo)throws Exception{
		DlvrVo bb=dlvrService.selectDlvr(dlvrVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	
	
	@RequestMapping(value ="removeDlvrAction.do")
	@ResponseBody
	public String removeDlvrAction(DlvrVo dlvrVo)throws Exception{
		logger.debug("removeDlvrAction"+dlvrVo.toString());
		return dlvrService.removeDlvr(dlvrVo);
	}
	
	
	@RequestMapping(value = "popupDlvrPrdctForm")
	public String popupDlvrPrdctForm(ModelMap model) {
		logger.debug("CALL popupDlvrPrdctForm");
		
		
		return "dlvr/popupDlvrPrdctForm";
	}
	
	
}
