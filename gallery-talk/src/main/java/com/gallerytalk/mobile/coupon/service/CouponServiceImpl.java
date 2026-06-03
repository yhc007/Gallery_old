package com.gallerytalk.mobile.coupon.service;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.common.domain.PagingVo;
import com.gallerytalk.mobile.coupon.domain.CouponVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

@Service
@Repository
public class CouponServiceImpl extends SqlSessionDaoSupport implements CouponService{

	private final static String namespace= "com.gallerytalk.coupon.";
	private final static String cstmrspace= "com.gallerytalk.gallerystaff.cstmr.";


	@Override
	public CouponVo listBirthCoupon(CouponVo couponVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		couponVo = (CouponVo) sqlSession.selectOne(namespace+"listBirthCoupon", couponVo);
		
		return couponVo;
	}
	
	@Override
	public String checkBirthCoupon(CouponVo couponVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Integer num = (Integer)sqlSession.selectOne(namespace+"checkBirthCoupon", couponVo);
		logger.info("result num is : "+num);
		return num==0?"ok":"duple";
	}
	
	@Override
	@Transactional
	public String modifyBirthCoupon(CouponVo couponVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"modifyBirthCoupon", couponVo);
		
		
		return "success";
	}

	@Override
	public String chkCoupon(CstmrVo cstmrVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String cstmrCd = (String) sql.selectOne(cstmrspace + "getCstmrCd", cstmrVo);
			if(cstmrCd!=null){
				
				String couponCd = (String)sql.selectOne(namespace + "getCoupon", cstmrCd);
				if(couponCd!=null){
					result = "exist|" + couponCd;
				}else{
					result = "noCoupon|null";
				}
			}else{
				result = "noCstmr|null";
			}
		}catch(Exception e){
			e.printStackTrace();
			result = "err|null";
		}
		return result;
	}
	@Override
    public void executeTestService() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        logger.info("DO TestService::executeTestService!!![TIME : " + dateFormat.format(new Date()) + "]");
    }

}
