package com.gallerytalk.mobile.payment.service;

import java.util.List;
import java.util.Map;

import com.gallerytalk.mobile.payment.domain.PaymentVo;
import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;

public interface PaymentService {
	public Map listSaleOffHist(SaleVo saleVo) throws Exception;
	public Map listSaleOffHistOld(SaleVo saleVo) throws Exception;
	public String modifySaleCancel(PaymentVo paymentVo) throws Exception;
	public Map selectCardComInfo() throws Exception;
	public Map listSalePrdct(PaymentVo paymentVo) throws Exception;
	public String addInvnHist(List<SalePrdctVo> listSalePrdctVo) throws Exception;
	public String decCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception;
	public String incCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception;
	public String cancelPayment(List <SalePrdctVo> listSalePrdctVo,SaleJobVo saleJobVo, PointVo pointVo,PaymentVo paymentVo) throws Exception;
}
