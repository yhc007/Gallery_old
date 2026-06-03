package com.gallery.sale;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.shop.ShopVo;

public interface SaleService {
    @Deprecated
	String addSale(SaleVo saleVo,HttpServletResponse response) throws Exception;
	String modifySale(SaleVo saleVo) throws Exception;
    @Deprecated
	Map pagedListSaleData(SaleVo saleVo) throws Exception;
	Map listSaleHistData(SaleHistSearchVo saleVo) throws Exception;
	Map listSalesHistData(SaleHistSearchVo saleVo) throws Exception;
	Map listSalesHistDataTotal(SaleHistSearchVo saleVo) throws Exception;
	Map listSalesHistDatatoCsv(SaleHistSearchVo saleVo) throws Exception;
	Map listSalesHistDataByStaffCsv(SaleHistSearchVo saleVo)throws Exception;
	Map listSalesHistDataTotalCsv(SaleHistSearchVo saleVo)throws Exception;
	Map listPrdctSaleHistData(SaleHistSearchVo saleVo) throws Exception;
    @Deprecated
	SaleVo selectSale(SaleVo saleVo) throws Exception;
	@Deprecated
	void mListSaleData(HttpServletResponse response) throws Exception;
	void timeExceed() throws Exception;
	Map findShopName(ShopVo shopVo) throws Exception;
	Map getCardInfo(SaleHistSearchVo saleVo)throws Exception;
	Map listSalesHistDataByStaff(SaleHistSearchVo saleVo)throws Exception;
	List<SaleVo> listSaleOff4Tax(SaleVo saleVo) throws Exception ;
	String renewalTaxBigo(SaleVo saleVo) throws Exception;
}
