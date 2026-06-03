package com.gallery.mail;

import com.gallery.cstmr.CstmrVo;
import org.apache.ibatis.annotations.Mapper;

@Deprecated
@Mapper
public interface MailMapper {
    void addKey(MailVo value);
    void destroyKey(MailVo value);
    Integer getPwKeyCnt(String value);
    CstmrVo getCstmrForKey(MailVo value);
}
