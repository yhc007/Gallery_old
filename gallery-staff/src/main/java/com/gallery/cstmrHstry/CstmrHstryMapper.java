package com.gallery.cstmrHstry;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CstmrHstryMapper {
    List<CstmrHstryVo> listCstmrHstry(CstmrHstryVo value);
    CstmrHstryVo getVisitInfo(CstmrHstryVo value);
    CstmrHstryVo getVisitInfoInit(CstmrHstryVo value);
    CstmrHstryVo cstmrhstry(CstmrHstryVo value);
    String getCstmrhstryMemo(CstmrHstryVo value);
    void cstmrHstryMemoUpdate(CstmrHstryVo value);
}
