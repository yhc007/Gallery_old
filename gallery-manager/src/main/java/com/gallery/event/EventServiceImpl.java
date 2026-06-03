package com.gallery.event;

import com.gallery.common.PagingVo;
import com.gallery.prdct.PrdctService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {

    private final EventMapper eventMapper;

    @Override
    @Transactional
    public String addEvent(EventVo eventVo) {
        Integer cnt = eventMapper.countEvent(eventVo);
        if (cnt == 0) {
            eventMapper.addEvent(eventVo);
            return "addsuccess";
        }
        return "duple";
    }

    @Override
    @Transactional
    public String removeEvent(EventVo eventVo) {
        Integer row = eventMapper.removeEvent(eventVo);
        return (row > 0) ? "success" : "fail";
    }

    @Override
    @Transactional
    public String addEventPrdct(EventPrdctVo eventPrdctVo) {
        eventMapper.addEventPrdct(eventPrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public void modifyEvent(EventVo eventVo) {
        eventMapper.modifyEvent(eventVo);
    }

    @Override
    public Map pagedListEventData(EventVo eventVo) {
        Map resultMap = new HashMap();

        Integer pageCount = eventMapper.pagedListEventCount(eventVo);
        List<EventVo> eventList = eventMapper.pagedListEvent(eventVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(eventVo.getCurrentPage());
        paging.setPageSize(eventVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listEvent", eventList);
        return resultMap;
    }

    @Override
    public Map listEventPrdctData(EventVo eventVo) {
        Map resultMap = new HashMap();
        List<EventPrdctVo> eventModelList = eventMapper.listEventPrdct(eventVo);
        resultMap.put("listEventPrdct", eventModelList);

        return resultMap;
    }

    @Override
    public EventVo selectEvent(EventVo eventVo) {
        return eventMapper.getEvent(eventVo);
    }

}
