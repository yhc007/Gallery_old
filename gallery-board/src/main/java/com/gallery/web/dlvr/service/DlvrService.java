package com.gallery.web.dlvr.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.dlvr.domain.DlvrVo;


public interface DlvrService {
	public String addDlvr(DlvrVo dlvrVo) throws Exception;
	public String removeDlvr(DlvrVo dlvrVo) throws Exception;
	public void modifyDlvr(DlvrVo dlvrVo) throws Exception;
	public Map listDlvrData(DlvrVo dlvrVo) throws Exception;
	public Map listDlvrPrdctData(DlvrVo dlvrVo) throws Exception;
	public DlvrVo selectDlvr(DlvrVo dlvrVo) throws Exception;
	
	
}
