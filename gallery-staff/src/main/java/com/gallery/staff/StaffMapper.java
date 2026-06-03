package com.gallery.staff;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StaffMapper {
    void addStaff(StaffVo value);
    void updateImgPath(StaffVo value);
    void removeImgPath(StaffVo value);
    void modifyStaff(StaffVo value);
    Integer countStaff(StaffVo value);
    Integer pagedListStaffCount(StaffVo value);
    Integer getCStaffCnt(StaffVo value);
    StaffVo pagedListStaff(StaffVo value);
    StaffVo listStaff(StaffVo value);
    List<StaffVo> listStaffShop(StaffVo value);
    StaffVo getStaff(StaffVo value);
    StaffVo getCStaff(StaffVo value);
}
