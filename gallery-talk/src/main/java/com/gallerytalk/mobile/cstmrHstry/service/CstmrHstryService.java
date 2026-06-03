package com.gallerytalk.mobile.cstmrHstry.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmrHstry.domain.CstmrHstryVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;

public interface CstmrHstryService {
	//public Map listVisitData(CheckVo checkVo) throws Exception;
	public Map listVisitData(CstmrHstryVo cstmrHstryVo) throws Exception;

	//public CheckVo selectVisitInfo(CheckVo checkVo) throws Exception;
	public CstmrHstryVo selectVisitInfo(CstmrHstryVo cstmrHstryVo) throws Exception;
	public CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception;
	
	public CheckVo selectVisitInfoForSale(HttpSession session) throws Exception;
	public String addVisit(CheckVo checkVo,HttpSession session) throws Exception;
	public String updateVisit(CheckVo checkVo,HttpSession session) throws Exception;
	
	public Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception;
	public Map listSelectedPrdctDataLens(PrdctVo prdctVo) throws Exception;
	public Map listSelectedPrdctDataClens(PrdctVo prdctVo) throws Exception;
	public Map listSelectedPrdctDataAcc(PrdctVo prdctVo) throws Exception;
	public Map getNewPrdct(PrdctVo prdctVo) throws Exception;
	public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo)throws Exception;
	public String getCstmrhstryMemo(CstmrHstryVo cstmrHstryVo) throws Exception;
	public void CstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo) throws Exception;
}
