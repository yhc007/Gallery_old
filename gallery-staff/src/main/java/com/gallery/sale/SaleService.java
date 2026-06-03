package com.gallery.sale;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.check.CheckVo;

public interface SaleService {
	SaleVo addSaleProcess(SaleVo saleVo) throws Exception;
//	Map listSaleData(SaleVo saleVo) throws Exception;
//	Map listSaleHistData(SaleHistSearchVo saleVo) throws Exception;
//	Map listSalesHistData(SaleHistSearchVo saleVo) throws Exception;
//	Map listPrdctSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	SaleVo selectSale(SaleVo saleVo) throws Exception;
	SalePrdctVo selectSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
//	SalePrdctVo selectNewSalePrdctOff(SalePrdctVo salePrdctVo)throws Exception;
//	void mListSaleData(HttpServletResponse response) throws Exception;

//	Map listSelectPastPurchased(SaleVo saleVo) throws Exception;
//	Map listSelectPastPurchasedNewPrdct(SaleVo saleVo) throws Exception;

//	Map listSaleOffHist(SaleVo saleVo) throws Exception;

//	Map listPastPurchasedOld(SaleVo saleVo) throws Exception;

	String modifyResult(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception;
	Integer checkSaleCstrm(SaleVo saleVo) throws Exception;
	SaleVo selectSaleForCstmrAndResult(SaleVo saleVo) throws Exception;
	String modifyResultOgnPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED, int addPrice, boolean isAdd) throws Exception;
	String modifyResultPayPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception;

//	String checkInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String checkFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String removeInvnHist(SalePrdctVo salePrdctVo) throws Exception;

//	String decCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String decCntLensInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String decCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String decCntAccInvn(SalePrdctVo salePrdctVo) throws Exception;
	String decCntInvn(SalePrdctVo salePrdctVo) throws Exception;

//	String incCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String incCntLensInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String incCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception;
//	String incCntAccInvn(SalePrdctVo salePrdctVo) throws Exception;
	String incCntInvn(SalePrdctVo salePrdctVo) throws Exception;

	String addInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String addLensInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String addCLensInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String addAccInvnHist(SalePrdctVo salePrdctVo) throws Exception;
//	String addFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception;

	String modifySaleAndCheckDate(SaleVo saleVo, CheckVo checkVo) throws Exception;

	Map getPayCardInfo(SaleVo saleVo) throws Exception;


	String getSaleMemo(SaleVo saleVo) throws Exception;
	String SaleMemoUpdate(SaleVo saleVo) throws Exception;

	String modifyCardPayDate(SaleVo saleVo)throws Exception;
	List <SaleVo> getPaymentList(SaleVo saleVo) throws Exception;
	String modifyCstmrHst(SaleVo saleVo) throws Exception;
	String delSaleId(SaleVo saleVo)throws Exception;
	Integer addSaleCstmrHstry(SaleVo saleVo) throws Exception;
	String renewalTaxBigo(SaleVo saleVo) throws Exception;
	String updatepayment(SaleVo saleVo) throws Exception;
	String updatejobpayment(SaleVo saleVo) throws Exception;;
}
