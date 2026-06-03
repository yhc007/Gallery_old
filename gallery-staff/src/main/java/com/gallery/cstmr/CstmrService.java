package com.gallery.cstmr;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface CstmrService {
	String addCstmr(CstmrVo cstmrVo) throws Exception;
	String mergeCstmr(String info1,String info2) throws Exception;
//	void modifyCstmr(CstmrVo cstmrVo) throws Exception;
	String idDupleCheck(CstmrVo cstmrVo) throws Exception;
//	void login(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	List<CstmrVo> listCstmrData(CstmrVo cstmrVo) throws Exception;
	List<CstmrVoSecu> listCstmrDataSecu(CstmrVo cstmrVo) throws Exception;
	String getCstmrMemo(CstmrVo cstmrVo)throws Exception;
	void CstmrMemoUpdate(CstmrVo cstmrVo)throws Exception;
//	void CstmrBigoUpdate(CstmrVo cstmrVo)throws Exception;
	void modifyCstmrFmlyCd(CstmrVo cstmrVo) throws Exception;
	CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception;
//	CstmrVo getCstmrByCd(CstmrVo cstmrVo);
	String modifyCstmrInfo(CstmrVo cstmrVo)throws Exception;
	CstmrVo getCstmrInfo(CstmrVo cstmrVo) throws Exception;
	CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo)throws Exception;
	Map getListFmly(CstmrVo cstmrVo) throws Exception;
	void editCstmrInfo(CstmrVo cstmrVo) throws Exception;
	String joinChk(CstmrVo cstmrVo)throws Exception;
	Map getFmlyList(CstmrVo cstmrVo)throws Exception;
	List<CstmrVo> listCstmr4Fmly(CstmrVo cstmrVo) throws Exception;
	String getCstmrBigo(CstmrVo cstmrVo)throws Exception;
	void editCstmrLastShop(CstmrVo cstmrVo) throws Exception;
	Integer countNewCstmr(CstmrVo cstmrVo) throws Exception;
	String addNewCstmr(CstmrVo cstmrVo) throws Exception;
	CstmrVo getNewCstmr(CstmrVo cstmrVo) throws Exception;
	String modifyNewCstmr(CstmrVo cstmrVo) throws Exception;
}

