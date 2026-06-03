package com.gallery.payment;

import com.gallery.sale.SalePrdctVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PaymentMapper {
    List<PaymentVo> getCardComInfo();
    void incCntInvn(SalePrdctVo value);
    void addInvnHist(SalePrdctVo value);
    void decCntInvn(PaymentVo value);
    Integer checkInvn(PaymentVo value);
    List<PaymentVo> listSalePrdct(PaymentVo value);
}
