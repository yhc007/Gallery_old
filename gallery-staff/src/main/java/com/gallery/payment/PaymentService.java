package com.gallery.payment;

import com.gallery.point.PointVo;
import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import com.gallery.saleJob.SaleJobVo;

import java.util.List;
import java.util.Map;

public interface PaymentService {
	Map listSaleOffHist(SaleVo saleVo) throws Exception;
	Map listSaleOffHistOld(SaleVo saleVo) throws Exception;
	String modifySaleCancel(PaymentVo paymentVo) throws Exception;
	Map selectCardComInfo() throws Exception;
	Map listSalePrdct(PaymentVo paymentVo) throws Exception;
	String addInvnHist(List<SalePrdctVo> listSalePrdctVo) throws Exception;
//	@Deprecated
//	String decCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception;
	String incCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception;
	String cancelPayment(List <SalePrdctVo> listSalePrdctVo, SaleJobVo saleJobVo, PointVo pointVo, PaymentVo paymentVo) throws Exception;
}
