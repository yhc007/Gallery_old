package com.gallerytalk.mobile.prdct.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.prdct.domain.PartnerVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;

public interface PrdctService {
	public void addSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	public void addSalePrdctNew(SalePrdctVo salePrdctVo)throws Exception;
	public String checkSalePrdctCount(SalePrdctVo salePrdctVo) throws Exception;
	public String checkSalePrdctCountNew(SalePrdctVo salePrdctVo) throws Exception;
	public String checkNewSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception;
	public String checkSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception;
	public void removeSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	public void removeNewSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	
	public List <PrdctVo> listSalePrdctOff(SaleVo saleVo) throws Exception;
	public Map listPrdctData(PrdctVo prdctVo) throws Exception;
	public Map listPartnerData() throws Exception;
	public Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception;
	public Map listSelectedPrdctDataLens(PrdctVo prdctVo)throws Exception;
	public Map listSelectedPrdctDataClens(PrdctVo prdctVo)throws Exception;
	public Map listSelectedPrdctDataAcc(PrdctVo prdctVo)throws Exception;
	public Map getNewPrdct(PrdctVo prdctVo)throws Exception;

	public PrdctVo selectPrdct(PrdctVo prdctVo) throws Exception;
	public String checkAssemblySaleId(SalePrdctVo salePrdctVo) throws Exception;
	public String checkDeliverySaleId(SalePrdctVo salePrdctVo) throws Exception;
	public String checkDeliverySaleIdEachType(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyAsmblySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyInformPrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyInformPrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyAsmblySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception;		
	public String modifyDlvrySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyDlvrySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	

	public String modifyDscntEarnSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String modifyDscntEarnNewPrdct(SalePrdctVo salePrdctVo) throws Exception;
	
	
	public String incCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception;
	public String incCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	public String decCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception;
	public SalePrdctVo getSalePrdct(SalePrdctVo salePrdctVo) throws Exception;
	public SalePrdctVo getSalePrdctNew(SalePrdctVo salePrdctVo) throws Exception;
	
	public Map getNewPaymentInfo(SaleVo saleVo)throws Exception;
	public Map getFramePaymentInfo(SaleVo saleVo)throws Exception;
	public Map getLensPaymentInfo(SaleVo saleVo)throws Exception;
	public Map getClensPaymentInfo(SaleVo saleVo)throws Exception;
	public Map getAccPaymentInfo(SaleVo saleVo)throws Exception;
	
	public SaleVo getBillInfo(SaleVo saleVo)throws Exception;
}
