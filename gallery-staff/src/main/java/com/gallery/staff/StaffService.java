package com.gallery.staff;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;


public interface StaffService {
	String addStaff(StaffVo staffVo) throws Exception;
//	void modifyStaff(StaffVo staffVo) throws Exception;
//	Map pagedListStaffData(StaffVo staffVo) throws Exception;
//	Map listStaffData(StaffVo staffVo) throws Exception;
	List<StaffVo> listStaff(StaffVo staffVo) throws Exception ;
	Map listStaffShop(StaffVo staffVo) throws Exception;
	StaffVo selectStaff(StaffVo staffVo) throws Exception;
//	StaffVo selectCStaff(StaffVo staffVo) throws Exception;
//	Integer getCStaffCnt(StaffVo staffVo) throws Exception;
//	String removeStaff(StaffVo staffVo) throws Exception;
//	String removeStaffPhoto(StaffVo staffVo) throws Exception;
//	void mListStaffData(StaffVo staffVo,HttpServletResponse response) throws Exception;
//	void mListStaffDataForDsply(StaffVo staffVo,HttpServletResponse response) throws Exception;
}
