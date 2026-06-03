package com.gallery.event;

import lombok.Data;
import org.apache.ibatis.type.Alias;


@Data
@Alias("eventPrdctVo")
public class EventPrdctVo {
    Integer rownum;
    Integer eventId;
    String eventName;
    Integer prdctId;
    String prdctName;
}
