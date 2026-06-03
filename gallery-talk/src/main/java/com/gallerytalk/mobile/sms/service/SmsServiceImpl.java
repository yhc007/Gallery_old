package com.gallerytalk.mobile.sms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.payment.domain.PaymentVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;

@Service
@Repository
public class SmsServiceImpl extends SqlSessionDaoSupport implements SmsService{

	private final static String saleSpace= "com.gallerytalk.sale.";
	private final static String namespace= "com.gallerytalk.payment.";
	
	@Override
	public Map listSaleOffHist(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(saleSpace+"listSaleOffHist", saleVo);
		logger.info("saleList:"+saleList);
		resultMap.put("listSaleOffHist", saleList);
		
		return resultMap;
	}
	public Map listSaleOffHistOld(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(saleSpace+"listSaleOffHistOld", saleVo);
		resultMap.put("listSaleOffHistOld", saleList);
		
		return resultMap;
	}
	
	
	
	@Override
	@Transactional
	public String modifySaleCancel(PaymentVo paymentVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(saleSpace+"modifySaleCancel", paymentVo);
		
		return "success";
	}
//	getCardComInfo
	
	@Override
	public Map selectCardComInfo() throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List<PaymentVo> listCardCom=sqlSession.selectList(namespace+"getCardComInfo");
		logger.info("listCardCom:"+listCardCom);
		
		resultMap.put("listCardCom", listCardCom);
		
		return resultMap;
	}
	
}
