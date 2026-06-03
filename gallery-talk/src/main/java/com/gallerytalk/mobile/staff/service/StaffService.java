package com.gallerytalk.mobile.staff.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.staff.domain.StaffVo;


public interface StaffService {
	public Map setUserRegId(StaffVo staffVo) throws Exception;
}
