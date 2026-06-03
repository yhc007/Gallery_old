package com.gallerytalk.mobile.sms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gallerytalk.mobile.payment.domain.PaymentVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;

public interface SmsService {
	public Map listSaleOffHist(SaleVo saleVo) throws Exception;
	public Map listSaleOffHistOld(SaleVo saleVo) throws Exception;
	public String modifySaleCancel(PaymentVo paymentVo) throws Exception;
	public Map selectCardComInfo() throws Exception;
}
