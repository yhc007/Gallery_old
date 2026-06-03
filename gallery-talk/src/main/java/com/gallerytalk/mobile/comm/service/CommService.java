package com.gallerytalk.mobile.comm.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.comm.domain.CommVo;

public interface CommService {
	public String addMsgLog(CommVo commVo) throws Exception;
	public Map responseTalkingGroupData(HttpServletResponse response, CommVo commVo) throws Exception;
	public String getRegId(CommVo commVo) throws Exception;
}
