package com.gallery.saleJob;

import java.util.Map;


public interface SaleJobService {

	String addSaleJob(SaleJobVo saleJobVo) throws Exception;
	Map listVisitingCstmrData(SaleJobVo saleJobVo) throws Exception;
	String delVisitData(SaleJobVo saleJobVo)throws Exception;
//	String addSaleJob(List<SaleJobVo> listSaleJobVo) throws Exception;
	String addListSaleJob(Map paymentMap) throws Exception ;
	String modifySaleJob(SaleJobVo saleJobVo) throws Exception ;
	String delListSaleJob(Map paymentMap) throws Exception;

}
