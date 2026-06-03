package com.gallery.staff;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StaffMapper {
    void addStaff(StaffVo value);
    void addComStaff(StaffVo value);
    void updateImgPath(StaffVo value);
    void removeImgPath(StaffVo value);
    void modifyStaff(StaffVo value);
    void modifyComStaff(StaffVo value);
    void removeStaff(StaffVo value);
    Integer getShopId(Integer value);
    Integer pagedListStaffCount(StaffVo value);
    Integer pagedListComStaffCount(StaffVo value);
    List<StaffVo> pagedListStaff(StaffVo value);
    StaffVo getStaff(StaffVo value);
    StaffVo getComStaff(StaffVo value);
    List<StaffVo> pagedListComStaff(StaffVo value);
    List<StaffVo> getStaffList(StaffVo value);
}
