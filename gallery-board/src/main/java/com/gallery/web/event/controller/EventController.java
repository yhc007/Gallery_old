package com.gallery.web.event.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.gallery.web.event.domain.EventPrdctVo;
import com.gallery.web.event.domain.EventVo;
import com.gallery.web.event.service.EventService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/event")
@Controller
public class EventController {
	
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private EventService eventService;
	
	@Autowired
	private PrdctService prdctService;
	
	
	@RequestMapping(value = "indexEventForm")
	public String indexEventForm(HttpServletRequest request,ModelMap model, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("이벤트 관리",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 5);
		
		Date date = new Date();
		model.addAttribute("cyear", date.getYear());
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
			rtnPage = "tiles:event/indexEventForm";
		}
		
		return rtnPage;
	}
	
	@RequestMapping(value = "newEventForm")
	public String newEventForm(HttpServletRequest request,ModelMap model) {
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
		return "tiles:event/newEventForm";
	}
	
	
	
	@RequestMapping(value = "eventPrdctForm")
	public String updateEventForm(HttpServletRequest request,ModelMap model,EventVo eventVo) {
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
		
		try{
			model.addAttribute("eventVo",eventService.selectEvent(eventVo));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "tiles:event/eventPrdctForm";
	}
	
	@RequestMapping(value = "addEventAction")
	@ResponseBody
	public String addEventAction(EventVo eventVo) {
		logger.debug("add "+eventVo.toString());
		try{
			String result=eventService.addEvent(eventVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "addEventPrdctAction")
	@ResponseBody
	public String addEventPrdctAction(EventPrdctVo eventPrdctVo) {
		logger.debug("add "+eventPrdctVo.toString());
		try{
			String result=eventService.addEventPrdct(eventPrdctVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "modifyEventAction")
	@ResponseBody
	public String modifyEventAction(EventVo eventVo) {
		logger.debug("modify "+eventVo.toString());
		try{
			eventService.modifyEvent(eventVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "listEventData")
	public String listEventData(EventVo eventVo,ModelMap model) {
		logger.debug("listEventData "+eventVo.toString());
		try{
			Map map=eventService.pagedListEventData(eventVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "event/listEventData";
	}
	
	@RequestMapping(value = "listEventPrdctData")
	public String listEventPrdctData(EventVo eventVo,ModelMap model) {
		logger.debug("listEventData "+eventVo.toString());
		try{
			Map map=eventService.listEventPrdctData(eventVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "event/listEventPrdctData";
	}
	@RequestMapping(value = "listPrdctData")
	public String searchedPrdctData(PrdctVo prdctVo,ModelMap model) {
		logger.debug("listEventData "+prdctVo.toString());
		try{
			Map map=prdctService.listPrdctDataForEvent(prdctVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "event/listPrdctData";
	}
	
	@RequestMapping(value ="getEventData.do")
	@ResponseBody
	public EventVo getEventData(EventVo eventVo)throws Exception{
		EventVo bb=eventService.selectEvent(eventVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	
	
	@RequestMapping(value ="removeEventAction.do")
	@ResponseBody
	public String removeEventAction(EventVo eventVo)throws Exception{
		logger.debug("removeEventAction"+eventVo.toString());
		return eventService.removeEvent(eventVo);
	}
	
	
	@RequestMapping(value = "popupEventPrdctForm")
	public String popupEventPrdctForm(ModelMap model) {
		logger.debug("CALL popupEventPrdctForm");
		
		
		return "event/popupEventPrdctForm";
	}
	
	
}
