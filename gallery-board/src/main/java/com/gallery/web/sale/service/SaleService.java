package com.gallery.web.sale.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.sale.domain.SaleHistSearchVo;
import com.gallery.web.sale.domain.SaleVo;

public interface SaleService {
	public String addSale(SaleVo saleVo,HttpServletResponse response) throws Exception;
	public String modifySale(SaleVo saleVo) throws Exception;
	public Map pagedListSaleData(SaleVo saleVo) throws Exception;
	public Map listSaleData(SaleVo saleVo) throws Exception;
	public Map listSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	public Map listSalesHistData(SaleHistSearchVo saleVo) throws Exception;
	public Map listSalesHistDatatoCsv(SaleHistSearchVo saleVo) throws Exception;
	public Map listPrdctSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	public SaleVo selectSale(SaleVo saleVo) throws Exception;
	public void mListSaleData(HttpServletResponse response) throws Exception;
	public void timeExceed() throws Exception; 
	public Map findShopName(Integer shopId) throws Exception;
	
}
