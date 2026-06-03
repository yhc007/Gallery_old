package com.gallery.prdct;

import java.util.List;
import java.util.Map;

import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;

public interface PrdctService {
	void addSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	void addSalePrdctNew(SalePrdctVo salePrdctVo)throws Exception;
	String checkSalePrdctCount(SalePrdctVo salePrdctVo) throws Exception;
//	@Deprecated
//	String checkSalePrdctCountNew(SalePrdctVo salePrdctVo) throws Exception;
	String checkNewSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception;
	String checkSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception;
	void removeSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	void removeNewSalePrdct(SalePrdctVo salePrdctVo) throws Exception;

	List <PrdctVo> listSalePrdctOff(SaleVo saleVo) throws Exception;
	Map listPrdctData(PrdctVo prdctVo) throws Exception;
	Map listLensData(PrdctVo prdctVo) throws Exception;
	@Deprecated
	Map listPartnerData() throws Exception;
	Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception;
	Map listSelectedPrdctDataLens(PrdctVo prdctVo)throws Exception;
	Map listSelectedPrdctDataClens(PrdctVo prdctVo)throws Exception;
	Map listSelectedPrdctDataAcc(PrdctVo prdctVo)throws Exception;
	Map getNewPrdct(PrdctVo prdctVo)throws Exception;

//    @Deprecated
//	PrdctVo selectPrdct(PrdctVo prdctVo) throws Exception;
	String checkAssemblySaleId(SalePrdctVo salePrdctVo) throws Exception;
	String checkDeliverySaleId(SalePrdctVo salePrdctVo) throws Exception;
	String checkDeliverySaleIdEachType(SalePrdctVo salePrdctVo) throws Exception;
	String modifyAsmblySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String modifyInformPrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String modifyInformPrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	String modifyAsmblySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String modifyDlvrySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String modifyDlvrySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception;


	String modifyDscntEarnSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String modifyDscntEarnNewPrdct(SalePrdctVo salePrdctVo) throws Exception;


	String incCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String decCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	String incCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	String decCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	SalePrdctVo getSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
//  @Deprecated
//	SalePrdctVo getSalePrdctNew(SalePrdctVo salePrdctVo) throws Exception;

	Map getNewPaymentInfo(SaleVo saleVo)throws Exception;
	Map getFramePaymentInfo(SaleVo saleVo)throws Exception;
	Map getLensPaymentInfo(SaleVo saleVo)throws Exception;
	Map getClensPaymentInfo(SaleVo saleVo)throws Exception;
	Map getAccPaymentInfo(SaleVo saleVo)throws Exception;

	SaleVo getBillInfo(SaleVo saleVo)throws Exception;

//    @Deprecated
//	Map getPaymentHist(SaleVo saleVo)throws Exception;
	Map getAsBoard(PrdctVo prdctVo)throws Exception;
	String regAs(PrdctVo prdctVo)throws Exception;

	String completeAs(PrdctVo prdctVo)throws Exception;
	String delAs(PrdctVo prdctVo)throws Exception;

	String addNewPrdct(Map prdctMap) throws Exception;
	String addInvnPrdct(Map prdctMap) throws Exception;
	String removeNewPrdct(Map prdctMap) throws Exception;
	String removeInvnPrdct(Map prdctMap) throws Exception;
	String modifyNewPrdct(PrdctVo prdctVo) throws Exception;
	String modifyInvnPrdct(PrdctVo prdctVo) throws Exception;
//    @Deprecated
//    String cntUpInvnPrdct(PrdctVo prdctVo) throws Exception;
//    @Deprecated
//	String cntDownInvnPrdct(PrdctVo prdctVo) throws Exception;
}
