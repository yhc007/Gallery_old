package com.gallerytalk.mobile.talkgroup.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.staff.domain.StaffVo;
import com.gallerytalk.mobile.talkgroup.domain.TalkGroupVo;


public interface TalkGroupService {
	public Map responseShopData(HttpServletResponse response) throws Exception;
	public Map responseCompData(HttpServletResponse response) throws Exception;
	public List <TalkGroupVo> getListStaffGid(TalkGroupVo talkGroupVo) throws Exception;
}
