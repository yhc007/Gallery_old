package com.gallery.app.cstmr.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.app.cstmr.domain.CstmrVo;
import com.gallery.web.mail.domain.MailVo;
import com.gallery.web.sale.domain.SaleVo;


public interface CstmrService {
	public void addCstmr(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public void modifyCstmr(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public void idDupleCheck(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public void login(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public CstmrVo selectCstmrForLogin(CstmrVo cstmrVo) throws Exception;
	public void findCstmrId(CstmrVo cstmrVo,HttpServletResponse response)throws Exception;
	public void findCstmrPw(CstmrVo cstmrVo,HttpServletResponse response)throws Exception;
	public String updatePw(CstmrVo cstmrVo)throws Exception;
	public CstmrVo selectCstmrKey(MailVo mailvo)throws Exception;
	public void responseCstmrData(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public void updateInfo(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public void buyList(SaleVo saleVo,HttpServletResponse response) throws Exception;
	public void myCoupon(CstmrVo cstmrVo,HttpServletResponse response) throws Exception;
	public Map cstmrEmail() throws Exception;
}
