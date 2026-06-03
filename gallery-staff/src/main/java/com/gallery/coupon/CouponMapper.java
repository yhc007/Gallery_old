package com.gallery.coupon;

import com.gallery.cstmr.CstmrVo;
import com.gallery.sale.SaleVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CouponMapper {
    CouponVo listBirthCoupon(CouponVo value);
    CouponVo chkValBrithCoupon(CouponVo value);
    List<CouponVo> getListCstmr4Coupon(CstmrVo value);
    @Deprecated
    void useCoupon(CstmrVo value);
    void modifyBirthCoupon(CouponVo value);
    void cancelBrithCoupon(CouponVo value);
    @Deprecated
    void useOthrPrsnCpn(CouponVo value);
    void updateSaleCoupon(SaleVo value);
    Integer usingCheckBirthCoupon(CouponVo value);
    Integer checkBirthCoupon(CouponVo value);
    Integer existBirthCoupon(CouponVo value);
    @Deprecated
    String chkCoupon(CouponVo value);
    String getCstmrCd(CouponVo value);
    String getCoupon(String value);
}
