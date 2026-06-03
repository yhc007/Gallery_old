package com.gallery.event;

import com.gallery.sale.SalePrdctVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EventMapper {
    void addEvent(EventVo value);
    void modifyEvent(EventVo value);
    Integer removeEvent(EventVo value);
    Integer countEvent(EventVo value);
    Integer pagedListEventCount(EventVo value);
    List<EventVo> pagedListEvent(EventVo value);
    EventVo getEvent(EventVo value);
    EventVo getEventForPrdct(SalePrdctVo value);
    List<EventPrdctVo> listEventPrdct(EventVo value);
    void addEventPrdct(EventPrdctVo value);
}
