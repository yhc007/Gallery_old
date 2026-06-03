package com.gallery.admin;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    AdminVo getPwd(AdminVo value);
    List<AdminVo> getDscntList(AdminVo value);
    Integer connectIp(AdminVo value);
    void addConnectIp(AdminVo value);
    void updateConnectIp(AdminVo value);
}
