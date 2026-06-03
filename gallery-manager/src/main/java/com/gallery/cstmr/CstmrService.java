package com.gallery.cstmr;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.mail.MailVo;
import com.gallery.sale.SaleVo;


public interface CstmrService {
    @Deprecated
	void addCstmr(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
    @Deprecated
	void idDupleCheck(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	void login(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	CstmrVo selectCstmrForLogin(CstmrVo cstmrVo) throws Exception;
    @Deprecated
	void findCstmrId(CstmrVo cstmrVo,HttpServletResponse response)throws Exception;
//    @Deprecated
//    void findCstmrPw(CstmrVo cstmrVo,HttpServletResponse response)throws Exception;
	String updatePw(CstmrVo cstmrVo)throws Exception;
    @Deprecated
    CstmrVo selectCstmrKey(MailVo mailvo)throws Exception;
	void updateInfo(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	Map buyList(SaleVo saleVo) throws Exception;
	Map myCoupon(CstmrVo cstmrVo) throws Exception;
	CstmrVo mgetCstmrInfo(CstmrVo cstmrVo)throws Exception;
	Map cstmrEyes(CstmrVo cstmrVo)throws Exception;
	Map getCstmrListForChk(CstmrVo cstmrVo)throws Exception;
	Map getCstmrListForChk2(CstmrVo cstmrVo)throws Exception;
	Map getCstmrForMerge(CstmrVo cstmrVo)throws Exception;
	String mergeCstmr(CstmrVo cstmrVo)throws Exception;
	List <CstmrVo> getCstmrCd(CstmrVo cstmrVo) throws Exception;
	String removeCstmr(CstmrVo cstmrVo) throws Exception;
	List <CstmrVo> getListCstmr4Tax(CstmrVo cstmrVo) throws Exception;
	void updateEmail4Tax(CstmrVo cstmrVo) throws Exception;
	Map getCntVisitor(CstmrVo cstmrVo)throws Exception;
	Map getCstmrList(CstmrVo cstmrVo)throws Exception;
	String getCntVisitorForCSV(CstmrVo cstmrVo)throws Exception;
	String getCstmrListForCSV(CstmrVo cstmrVo)throws Exception;
}
