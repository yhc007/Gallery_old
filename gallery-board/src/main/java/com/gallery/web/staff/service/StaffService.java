package com.gallery.web.staff.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gallery.web.staff.domain.StaffVo;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.media.domain.MediaVo;


public interface StaffService {
	public String addStaff(StaffVo staffVo) throws Exception;
	public String addStaffPhotos(StaffVo staffVo,FileUploadForm uploadForm) throws Exception;
	public void modifyStaff(StaffVo staffVo) throws Exception;
	public Map pagedListStaffData(StaffVo staffVo, Integer session) throws Exception;
	public Map listStaffData(StaffVo staffVo) throws Exception;
	public StaffVo selectStaff(StaffVo staffVo) throws Exception;
	public String removeStaff(StaffVo staffVo) throws Exception;
	public String removeStaffPhoto(StaffVo staffVo) throws Exception;
	public void mListStaffData(StaffVo staffVo,HttpServletResponse response) throws Exception;
	public void mListStaffDataForDsply(StaffVo staffVo,HttpServletResponse response) throws Exception;
}
