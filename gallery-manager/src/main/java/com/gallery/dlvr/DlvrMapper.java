package com.gallery.dlvr;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DlvrMapper {
    void addDlvr(DlvrVo value);
    void modifyDlvr(DlvrVo value);
    Integer removeDlvr(DlvrVo value);
    List<DlvrVo> listDlvr(DlvrVo value);
    DlvrVo getDlvr(DlvrVo value);
}
