package com.gallery.coupon;

import com.gallery.cstmr.CstmrVo;
import com.gallery.point.PointService;
import com.gallery.point.PointVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;


@RequestMapping(value = "/coupon")
@Controller
@RequiredArgsConstructor
public class CouponController {

    private static final Logger logger = LoggerFactory.getLogger(CouponController.class);
    private final PointService pointService;
    private final CouponService couponService;

//	@Deprecated
//	@RequestMapping(value = "calcBalancePoint.do")
//	@ResponseBody
//	public String calcBalancePoint() {
//		logger.debug("run calcBalancePoint");
//		String result;
//		try{
//			result=pointService.addBalancePoint();
//			return result;
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//
//		return "fail";
//	}

    @RequestMapping(value = "getCstmrPoint.do")
    @ResponseBody
    public String getCstmrPoint(PointVo pointVo) {
        logger.info("run getCstmrPoint pointVo:" + pointVo);
        String result = "";
        try {
            pointVo = pointService.selectPointByCstmrCd(pointVo);
            result = String.format("%d", (int) (pointVo.getTotalPoint() * 1000)) + "," + pointVo.getFmlyCd() + "," + pointVo.getFmlyName();
            logger.info(result);
            result = URLEncoder.encode(result, "utf-8");
            result = result.replaceAll("\\+", "%20");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "getBirthCoupon.do")
    @ResponseBody
    public CouponVo getBirthCoupon(CouponVo couponVo, ModelMap model) {
        logger.info("run getBirthCoupon couponVo:" + couponVo);
        logger.info("run getBirthCoupon cstmrCd:" + couponVo.getCstmrCd());
        CouponVo returnVo = new CouponVo();
        String checkBirthCoupon;
        try {
            checkBirthCoupon = couponService.checkBirthCoupon(couponVo);
            //exist
            if (checkBirthCoupon.equals("duple")) {
                returnVo = couponService.listBirthCoupon(couponVo);
                logger.info("birth Coupon is Exist returnVo:" + returnVo);
                return returnVo;
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        returnVo.setCouponCd("NOEXIST");
        return returnVo;
    }

    @RequestMapping(value = "checkValidationBirthCoupon.do")
    @ResponseBody
    public CouponVo checkValidationBirthCoupon(CouponVo couponVo, ModelMap model) {
        logger.info("run checkValidationBirthCoupon couponVo:" + couponVo.getCouponCd());
        CouponVo returnVo = new CouponVo();
        String checkBirthCoupon;
        try {
            checkBirthCoupon = couponService.existBirthCoupon(couponVo);
            //exist
            if (checkBirthCoupon.equals("duple")) {
                returnVo = couponService.checkValidationBirthCoupon(couponVo);
                logger.info("birth Coupon is Exist returnVo:" + returnVo);
                return returnVo;
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        returnVo.setCouponCd("NOEXIST");
        return returnVo;
    }

    @RequestMapping(value = "chkCoupon.do")
    @ResponseBody
    public String chkCoupon(CstmrVo cstmrVo) {
        try {
            return couponService.chkCoupon(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

//	@Deprecated
//	@RequestMapping("useCoupon.do")
//	@ResponseBody
//	public String useCoupon(CstmrVo cstmrVo){
//		String result = "";
//		try {
//			result = couponService.useCoupon(cstmrVo);
//		} catch (Exception e) {
//
//			e.printStackTrace();
//		}
//		return result;
//	}

//	@Deprecated
//	@RequestMapping(value="useOthrPrsnCpn.do")
//	@ResponseBody
//	public String useOthrPrsnCpn(CouponVo couponVo){
//		String result = "";
//		try {
//			result = couponService.useOthrPrsnCpn(couponVo);
//		} catch (Exception e) {
//
//			e.printStackTrace();
//		}
//		return result;
//	}
}
