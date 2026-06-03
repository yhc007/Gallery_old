package com.gallerytalk.mobile.secu.service;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.gallerytalk.mobile.secu.domain.SecuVo;


public interface SecuService {
	public void test (SecuVo secuVo, HttpServletResponse response)throws Exception;
	public String checkSn(SecuVo secuVo) throws Exception;
	public String regMac(SecuVo secuVo) throws Exception;
	public String checkMac(SecuVo secuVo) throws Exception;
	public String checkDvc(SecuVo secuVo) throws Exception;
}