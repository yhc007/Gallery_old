package com.gallery.saleJob;

import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SaleJobMapper {
    void mlistSale(SaleVo value);
    void modifyHistId(SaleVo value);
    void removeSalePrdct(SaleVo value);
    void delSalePrdct(SaleJobVo value);
    void removeSale(SaleVo value);
    void delNewSalePrdct(SaleJobVo value);
    void delVisitData(SaleJobVo value);
    Integer addSaleJob(SaleJobVo value);
    void modifySaleJob(SaleJobVo value);
    void cancelPayment(SaleJobVo value);
    void modifyResult(SaleJobVo value);
    void delPointHist(SaleJobVo value);
    List<SaleJobVo> listVisitingCstmrOffShop(SaleJobVo value);
    void addSalePrdct(SaleJobVo value);
    Integer countSale(SaleVo value);
    Integer countSaleCstmr(SaleVo value);
    Integer countSalePrdct(SaleJobVo value);
    String chkPayment(SaleJobVo value);
    void addListSaleJob(Map value);
    void delListSaleJob(Map value);
    SaleVo listSale(SaleVo value);
    SaleVo getSale(SaleVo value);
    SaleVo getSaleForResult(SaleVo value);
    SaleVo getSaleForCstmrAndResult(SaleVo value);
    List<SaleJobVo> listJobPayment(SaleJobVo value);
    SalePrdctVo listSalePrdct(SaleVo value);
}
