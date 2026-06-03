package com.gallerytalk.mobile.saleJob.service;

import java.util.List;
import java.util.Map;

import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;



public interface SaleJobService {
	
	public String addSaleJob(SaleJobVo saleJobVo) throws Exception;
	public Map listVisitingCstmrData(SaleJobVo saleJobVo) throws Exception;
	public String delVisitData(SaleJobVo saleJobVo)throws Exception;
	public String addSaleJob(List<SaleJobVo> listSaleJobVo) throws Exception;
}
