package com.gallery.prdct;

import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface PrdctMapper {
    void addListNewPrdct(Map value);
    void addListInvnPrdct(Map value);
    void removeListNewPrdct(Map value);
    void removeListInvnPrdct(Map value);
    void modifyDscntEarnNewPrdct(SalePrdctVo value);
    void modifyDscntNewPrdct(SalePrdctVo value);
    void modifyDscntEarnSalePrdctOff(SalePrdctVo value);
    void addPrdct(SalePrdctVo value);
    void modifyNewPrdct(PrdctVo value);
    void modifyInvnPrdct(PrdctVo value);
    void cntUpInvnPrdct(PrdctVo value);
    void cntDownInvnPrdct(PrdctVo value);
    void regAs(PrdctVo value);
    void completeAs(PrdctVo value);
    void delAs(PrdctVo value);
    List<PrdctVo> listSalePrdctOff(SaleVo value);
    List<SaleVo> getNewPaymentInfo(SaleVo value);
    List<SaleVo> getFramePaymentInfo(SaleVo value);
    List<SaleVo> getLensPaymentInfo(SaleVo value);
    List<SaleVo> getClensPaymentInfo(SaleVo value);
    List<SaleVo> getAccPaymentInfo(SaleVo value);
    List<PrdctVo> listPrdct(PrdctVo value);
    List<PrdctVo> listLens(PrdctVo value);
    List<PrdctVo> listSelectPrdct(PrdctVo value);
    PrdctVo getPrdct(PrdctVo value);
    List<PrdctVo> getAsBoard(PrdctVo value);
    List<SalePrdctVo> listSelectPrdctLens(PrdctVo value);
    List<SalePrdctVo> listSelectPrdctClens(PrdctVo value);
    List<SalePrdctVo> listSelectPrdctAcc(PrdctVo value);
    List<PrdctVo> getNewPrdct(PrdctVo value);
    SalePrdctVo getSalePrdct(SalePrdctVo value);
    SalePrdctVo getSalePrdctNew(SalePrdctVo value);

    List<PartnerVo> listPartner();
}
