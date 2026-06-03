package com.gallery.check;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gallery.cstmr.CstmrVo;

public interface CheckService {
	Map listVisitData(CheckVo checkVo) throws Exception;
	CheckVo selectVisitInfo(CheckVo checkVo) throws Exception;
	CheckVo selectVisitInfoForSale(HttpSession session) throws Exception;
	String addVisit(CheckVo checkVo,HttpSession session) throws Exception;
	String updateVisit(CheckVo checkVo,HttpSession session) throws Exception;
	String editCheckInfo(CheckVo checkVo,HttpSession session) throws Exception;
	String updateCstmrHistVisit(CheckVo checkVo) throws Exception;
	Integer addVisitCstmrHstry(CheckVo checkVo) throws Exception;
	CheckVo getEyeCheckByCstmrId(CstmrVo cstmrVo) throws Exception;
}
