package com.gallery.staff;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Map;


public interface StaffService {
	String addStaff(StaffVo staffVo) throws Exception;
	String addComStaff(StaffVo staffVo) throws Exception;
	String addStaffPhotos(StaffVo staffVo,MultipartHttpServletRequest request) throws Exception;
	void modifyStaff(StaffVo staffVo) throws Exception;
	void modifyComStaff(StaffVo staffVo) throws Exception;
	Map pagedListStaffData(StaffVo staffVo, Integer session) throws Exception;
	Map pagedListComStaffData(StaffVo staffVo, Integer session)throws Exception;
	StaffVo selectStaff(StaffVo staffVo) throws Exception;
	StaffVo selectComStaff(StaffVo staffVo) throws Exception;
	String removeStaff(StaffVo staffVo) throws Exception;
	String removeStaffPhoto(StaffVo staffVo) throws Exception;
	Map getStaffList(StaffVo staffVo)throws Exception;
}
