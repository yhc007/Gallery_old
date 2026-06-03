package com.gallerytalk.mobile.check.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;

public interface CheckService {
	public Map listVisitData(CheckVo checkVo) throws Exception;
	public CheckVo selectVisitInfo(CheckVo checkVo) throws Exception;
	public CheckVo selectVisitInfoForSale(HttpSession session) throws Exception;
	public String addVisit(CheckVo checkVo,HttpSession session) throws Exception;
	public String updateVisit(CheckVo checkVo,HttpSession session) throws Exception;
}
