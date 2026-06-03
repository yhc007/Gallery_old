package com.gallery.sms;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Deprecated
@Service
@Repository
public class SmsServiceImpl implements SmsService{

//	private final static String saleSpace= "com.gallery.sale.";
//	private final static String namespace= "com.gallery.payment.";
//
//	@Override
//	public Map listSaleOffHist(SaleVo saleVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(saleSpace+"listSaleOffHist", saleVo);
//		logger.info("saleList:"+saleList);
//		resultMap.put("listSaleOffHist", saleList);
//
//		return resultMap;
//	}
//	public Map listSaleOffHistOld(SaleVo saleVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(saleSpace+"listSaleOffHistOld", saleVo);
//		resultMap.put("listSaleOffHistOld", saleList);
//
//		return resultMap;
//	}
//
//
//
//	@Override
//	@Transactional
//	public String modifySaleCancel(PaymentVo paymentVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//
//		sqlSession.update(saleSpace+"modifySaleCancel", paymentVo);
//
//		return "success";
//	}
////	getCardComInfo
//
//	@Override
//	public Map selectCardComInfo() throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		Map resultMap=new HashMap();
//		List<PaymentVo> listCardCom=sqlSession.selectList(namespace+"getCardComInfo");
//		logger.info("listCardCom:"+listCardCom);
//
//		resultMap.put("listCardCom", listCardCom);
//
//		return resultMap;
//	}

}
