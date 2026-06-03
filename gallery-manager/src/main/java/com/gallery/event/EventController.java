package com.gallery.event;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.prdct.PrdctService;
import com.gallery.prdct.PrdctVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/event")
@Controller
@RequiredArgsConstructor
public class EventController {

	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	private final EventService eventService;
	private final PrdctService prdctService;

	@RequestMapping(value = "indexEventForm.do")
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

		model.addAttribute("cday", date.getDate());

		Integer lv = (Integer) session.getAttribute("lv");

		return (lv == null || lv < 3) ? "tiles:access/denied" :"tiles:event/indexEventForm";
	}

	@RequestMapping(value = "newEventForm.do")
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
		model.addAttribute("cday", date.getDate());

		return "tiles:event/newEventForm";
	}

	@RequestMapping(value = "eventPrdctForm.do")
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

	@RequestMapping(value = "addEventAction.do")
	@ResponseBody
	public String addEventAction(EventVo eventVo) {
		logger.debug("add "+eventVo.toString());
		try{
			return eventService.addEvent(eventVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "addEventPrdctAction.do")
	@ResponseBody
	public String addEventPrdctAction(EventPrdctVo eventPrdctVo) {
		logger.debug("add "+eventPrdctVo.toString());
		try{
			return eventService.addEventPrdct(eventPrdctVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "modifyEventAction.do")
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

	@RequestMapping(value = "listEventData.do")
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

	@RequestMapping(value = "listEventPrdctData.do")
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

	@RequestMapping(value = "listPrdctData.do")
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
		return eventService.selectEvent(eventVo);
	}

	@RequestMapping(value ="removeEventAction.do")
	@ResponseBody
	public String removeEventAction(EventVo eventVo)throws Exception{
		logger.debug("removeEventAction"+eventVo.toString());
		return eventService.removeEvent(eventVo);
	}

	@RequestMapping(value = "popupEventPrdctForm.do")
	public String popupEventPrdctForm(ModelMap model) {
		logger.debug("CALL popupEventPrdctForm");
		return "event/popupEventPrdctForm";
	}
}
