package com.gallery.secu;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SecuMapper {
    Integer countReg(SecuVo value);
    Integer countAuth(SecuVo value);
    Integer countDvc(SecuVo value);
    void modifyMac(SecuVo value);
}
