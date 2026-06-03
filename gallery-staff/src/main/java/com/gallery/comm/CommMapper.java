package com.gallery.comm;

import org.apache.ibatis.annotations.Mapper;

@Deprecated
@Mapper
public interface CommMapper {
    void addRegist(CommVo value);
    void updateRegist(CommVo value);
    void removeRegistremoveRegist(CommVo value);
    void listRegist(CommVo value);
    Integer countRegist(CommVo value);
    CommVo getRegistByReg(CommVo value);
    CommVo getRegistInfo(CommVo value);
    CommVo getUserListInShop(CommVo value);
}
