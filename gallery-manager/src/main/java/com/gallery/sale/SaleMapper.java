package com.gallery.sale;

import com.gallery.shop.ShopVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SaleMapper {
    Integer addSale(SaleVo value);
    void modifySale(SaleVo value);
    void renewalTaxBigo(SaleVo value);
    void addSalePrdct(SalePrdctVo value);
    List<SaleVo> selectSaleTimeExceed();
    List<SaleVo> mlistSale();
    SalesVo getShopId(Integer value);
    List<SaleVo> pagedListSale(SaleVo value);
    List<SalesVo> findShopName(ShopVo value);
    SaleVo getSaleForResult(SaleVo value);
    SaleVo getSale(SaleVo value);
    List<SalesVo> listSalesHistDataByStaff(SaleHistSearchVo value);
    List<SaleVo> listSaleOff4Tax(SaleVo value);
    List<SaleVo> listSaleHist(SaleHistSearchVo value);
    List<SalesVo> listSalesHist(SaleHistSearchVo value);
    List<SalesVo> getTotalShopSales(SaleHistSearchVo value);
    List<SaleVo> listPrdctSaleHist(SaleHistSearchVo value);
    List<SalesVo> getCardInfo(SaleHistSearchVo value);
    Integer pagedListSaleCount(SaleVo value);
    List<SalePrdctVo> listSalePrdct(SaleVo value);
}
