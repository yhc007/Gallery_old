package com.gallerytalk.mobile.sale.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.sale.domain.SaleHistSearchVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;

public interface SaleService {
	public SaleVo addSaleProcess(SaleVo saleVo) throws Exception;
	public Map listSaleData(SaleVo saleVo) throws Exception;
	public Map listSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	public Map listSalesHistData(SaleHistSearchVo saleVo) throws Exception;
	public Map listPrdctSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	public SaleVo selectSale(SaleVo saleVo) throws Exception;
	public SalePrdctVo selectSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public SalePrdctVo selectNewSalePrdctOff(SalePrdctVo salePrdctVo)throws Exception;
	public void mListSaleData(HttpServletResponse response) throws Exception;

	public Map listSelectPastPurchased(SaleVo saleVo) throws Exception;
	public Map listSelectPastPurchasedNewPrdct(SaleVo saleVo) throws Exception;
	
//	public Map listSaleOffHist(SaleVo saleVo) throws Exception;
	
	public Map listPastPurchasedOld(SaleVo saleVo) throws Exception;
	
	public String modifyResult(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception;
	public Integer checkSaleCstrm(SaleVo saleVo) throws Exception;
	public SaleVo selectSaleForCstmrAndResult(SaleVo saleVo) throws Exception;
	public String modifyResultOgnPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED, int addPrice, boolean isAdd) throws Exception;
	public String modifyResultPayPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception;

	public String checkInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String checkFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String removeInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	
	public String decCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntLensInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntAccInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntInvn(SalePrdctVo salePrdctVo) throws Exception;
	
	public String incCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String incCntLensInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String incCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String incCntAccInvn(SalePrdctVo salePrdctVo) throws Exception;
	public String incCntInvn(SalePrdctVo salePrdctVo) throws Exception;
	
	public String addInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String addLensInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String addCLensInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String addAccInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	public String addFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception;
	
	public String modifySaleAndCheckDate(SaleVo saleVo, CheckVo checkVo) throws Exception;
	
	public Map getPayCardInfo(SaleVo saleVo) throws Exception;
	
	
	public String getSaleMemo(SaleVo saleVo) throws Exception;
	public String SaleMemoUpdate(SaleVo saleVo) throws Exception;
}
