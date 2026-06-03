package com.gallery.web.event.service;

import java.util.Map;

import com.gallery.web.event.domain.EventPrdctVo;
import com.gallery.web.event.domain.EventVo;


public interface EventService {
	public String addEvent(EventVo eventVo) throws Exception;
	public String removeEvent(EventVo eventVo) throws Exception;
	public String addEventPrdct(EventPrdctVo eventPrdctVo) throws Exception;
	public void modifyEvent(EventVo eventVo) throws Exception;
	public Map pagedListEventData(EventVo eventVo) throws Exception;
	public Map listEventData(EventVo eventVo) throws Exception;
	public Map listEventPrdctData(EventVo eventVo) throws Exception;
	public EventVo selectEvent(EventVo eventVo) throws Exception;
	
}
