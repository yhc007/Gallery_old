package com.gallery.coupon;

import com.gallery.cstmr.CstmrMapper;
import com.gallery.cstmr.CstmrVo;
import com.gallery.sale.SaleVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Repository
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {

    private final CouponMapper couponMapper;
    private final CstmrMapper cstmrMapper;

    @Override
    public CouponVo listBirthCoupon(CouponVo couponVo) {
        return couponMapper.listBirthCoupon(couponVo);
    }

    @Override
    public String checkBirthCoupon(CouponVo couponVo) {
        Integer num = couponMapper.checkBirthCoupon(couponVo);
        return num == 0 ? "ok" : "duple";
    }

    @Override
    public String existBirthCoupon(CouponVo couponVo) {
        Integer num = couponMapper.existBirthCoupon(couponVo);
        return num == 0 ? "ok" : "duple";
    }

    @Override
    public CouponVo checkValidationBirthCoupon(CouponVo couponVo) {
        return couponMapper.chkValBrithCoupon(couponVo);
    }

    @Override
    @Transactional
    public String modifyBirthCoupon(CouponVo couponVo) {
        SaleVo saleVo = new SaleVo();
        saleVo.setCouponBirth(couponVo.getCouponCd());
        saleVo.setSaleId(couponVo.getSaleId());
        couponMapper.modifyBirthCoupon(couponVo);
        couponMapper.updateSaleCoupon(saleVo);
        return "success";
    }

    @Override
    @Transactional
    public String cancelBirthCoupon(CouponVo couponVo) {
        couponMapper.modifyBirthCoupon(couponVo);
        couponMapper.cancelBrithCoupon(couponVo);
        return "success";
    }

    @Override
    @Transactional
    public String checkNusingCoupon(CouponVo couponVo) {
        int cnt = couponMapper.usingCheckBirthCoupon(couponVo);
        if (cnt > 0) {
            SaleVo saleVo = new SaleVo();
            saleVo.setCouponBirth(couponVo.getCouponCd());
            saleVo.setSaleId(couponVo.getSaleId());
            couponMapper.modifyBirthCoupon(couponVo);
            couponMapper.updateSaleCoupon(saleVo);
            return "success";
        }
        return "notUse";
    }

    @Override
    public String chkCoupon(CstmrVo cstmrVo) {
        try {
            String cstmrCd = cstmrMapper.getCstmrCd(cstmrVo);
            if (cstmrCd != null) {
                String couponCd = couponMapper.getCoupon(cstmrCd);
                return (couponCd != null) ? "exist|" + couponCd : "noCoupon|null";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "err|null";
        }
        return "noCstmr|null";
    }

//    @Deprecated
//	@Override
//    public void executeTestService() {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//        logger.info("DO TestService::executeTestService!!![TIME : " + dateFormat.format(new Date()) + "]");
//    }
//
//    @Deprecated
//	@Override
//	@Transactional
//	public String useCoupon(CstmrVo cstmrVo) throws Exception {
//		SqlSession sql = getSqlSession();
//		String result = "";
//		try{
//			sql.update(namespace + "useCoupon", cstmrVo);
//			result = "success";
//		}catch(Exception e){
//			e.printStackTrace();
//			result = "fail";
//		}
//
//		return result;
//	}
//
//    @Deprecated
//	@Override
//	public String useOthrPrsnCpn(CouponVo couponVo) throws Exception {
//		SqlSession sql = getSqlSession();
//		String result = "";
//		try{
//			couponVo.setCstmrCd((String)sql.selectOne(namespace + "getCstmrCd", couponVo));
//			sql.update(namespace + "useOthrPrsnCpn", couponVo);
//			result = "success";
//		}catch(Exception e){
//			e.printStackTrace();
//			result = "fail";
//		}
//
//		return result;
//	}

    @Override
    public List<CouponVo> listCstmr4Coupon(CstmrVo cstmrVo) {
        return couponMapper.getListCstmr4Coupon(cstmrVo);
    }

}
