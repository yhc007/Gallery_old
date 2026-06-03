package com.gallerytalk.mobile.point.service;

import java.util.Map;

import com.gallerytalk.mobile.point.domain.PointVo;


public interface PointService {
	
	public String addBalancePoint() throws Exception;
	public PointVo selectPointByFmlyCd(PointVo pointVo) throws Exception;
	public PointVo selectPointByCstmrCd(PointVo pointVo) throws Exception;
	public String addPointHist(PointVo pointVo) throws Exception;
	public Map listPointHistory(PointVo pointVo) throws Exception;
	public String removePointHist(PointVo pointVo) throws Exception;
}