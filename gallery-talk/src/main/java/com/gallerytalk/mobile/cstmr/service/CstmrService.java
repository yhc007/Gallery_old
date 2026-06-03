package com.gallerytalk.mobile.cstmr.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVoSecu;

public interface CstmrService {
	public String addCstmr(CstmrVo cstmrVo) throws Exception;
	public String mergeCstmr(String info1,String info2) throws Exception;
	public void modifyCstmr(CstmrVo cstmrVo) throws Exception;
	public String idDupleCheck(CstmrVo cstmrVo) throws Exception;
	public void login(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public List<CstmrVo> listCstmrData(CstmrVo cstmrVo) throws Exception;
	public List<CstmrVoSecu> listCstmrDataSecu(CstmrVo cstmrVo) throws Exception;
	public String getCstmrMemo(CstmrVo cstmrVo)throws Exception;
	public void CstmrMemoUpdate(CstmrVo cstmrVo)throws Exception;
	public void CstmrBigoUpdate(CstmrVo cstmrVo)throws Exception;
	public void modifyCstmrFmlyCd(CstmrVo cstmrVo) throws Exception;
	public CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception;
	public String modifyCstmrInfo(CstmrVo cstmrVo)throws Exception;
	public CstmrVo getCstmrInfo(CstmrVo cstmrVo) throws Exception;
	public CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo)throws Exception;
	public Map getListFmly(CstmrVo cstmrVo) throws Exception;
}

