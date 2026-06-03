package com.gallery.cstmrHstry;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gallery.check.CheckVo;
import com.gallery.cstmr.CstmrVo;
import com.gallery.prdct.PrdctVo;

public interface CstmrHstryService {
	Map listVisitData(CstmrHstryVo cstmrHstryVo) throws Exception;

	CstmrHstryVo selectVisitInfo(CstmrHstryVo cstmrHstryVo) throws Exception;
	CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception;

	CheckVo selectVisitInfoForSale(HttpSession session) throws Exception;
//	@Deprecated
//	String addVisit(CheckVo checkVo,HttpSession session) throws Exception;
//    @Deprecated
//	String updateVisit(CheckVo checkVo,HttpSession session) throws Exception;

	Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception;
//    @Deprecated
//	Map listSelectedPrdctDataLens(PrdctVo prdctVo) throws Exception;
//@Deprecated
//	Map listSelectedPrdctDataClens(PrdctVo prdctVo) throws Exception;
//    @Deprecated
//	Map listSelectedPrdctDataAcc(PrdctVo prdctVo) throws Exception;
	Map getNewPrdct(PrdctVo prdctVo) throws Exception;
	CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo)throws Exception;
//    @Deprecated
//	String getCstmrhstryMemo(CstmrHstryVo cstmrHstryVo) throws Exception;
//    @Deprecated
//	void CstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo) throws Exception;
	CstmrHstryVo selectVisitInfoInit(CstmrHstryVo cstmrHstryVo) throws Exception;
}
