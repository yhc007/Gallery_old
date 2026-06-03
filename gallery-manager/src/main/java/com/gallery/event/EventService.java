package com.gallery.event;

import java.util.Map;


public interface EventService {
	String addEvent(EventVo eventVo) throws Exception;
	String removeEvent(EventVo eventVo) throws Exception;
	String addEventPrdct(EventPrdctVo eventPrdctVo) throws Exception;
	void modifyEvent(EventVo eventVo) throws Exception;
	Map pagedListEventData(EventVo eventVo) throws Exception;
	Map listEventPrdctData(EventVo eventVo) throws Exception;
	EventVo selectEvent(EventVo eventVo) throws Exception;
}
