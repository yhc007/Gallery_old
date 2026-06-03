package com.gallerytalk.mobile.payment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.payment.domain.PaymentVo;
import com.gallerytalk.mobile.point.domain.PointVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;

@Service
@Repository
public class PaymentServiceImpl extends SqlSessionDaoSupport implements PaymentService{

	private final static String saleSpace= "com.gallerytalk.sale.";
	private final static String namespace= "com.gallerytalk.payment.";
	private final static String jobspace= "com.gallerytalk.salejob.";
	private final static String pointspace="com.gallerytalk.point.";

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
	
//	@Override
//	public String checkInvn (PaymentVo paymentVo) throws Exception
//	{
//		logger.info("Run listSalePrdct:"+paymentVo);
//		SqlSession sqlSession=getSqlSession();
//		
//		Integer chckPrdct = (Integer) sqlSession.selectOne(namespace, "checkInvn");
//		if(chckPrdct.intValue()>0){
//			return "exist";
//		}else{
//			return "nonexist";
//		}
//	}
	@Override
	public Map listSalePrdct(PaymentVo paymentVo) throws Exception
	{
		logger.info("Run listSalePrdct:"+paymentVo);
		SqlSession sqlSession=getSqlSession();
		
		Integer chckPrdct = (Integer) sqlSession.selectOne(namespace+"checkInvn",paymentVo);
		logger.info("chckPrdct:"+chckPrdct);
		
		Map resultMap = new HashMap();
		if(chckPrdct != 0 ){
			List<PaymentVo> listPrdct = sqlSession.selectList(namespace+"listSalePrdct",paymentVo);
			logger.info("listPrdct:"+listPrdct);
			resultMap.put("listPrdct", listPrdct);
		}else{
			return null;
		}
		
		return  resultMap;
	}
	@Override
	@Transactional
	public String addInvnHist(List<SalePrdctVo> listSalePrdctVo) throws Exception{
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		int result;
		for(int i=0,size=listSalePrdctVo.size();i<size;i++){
			result = sqlSession.insert(namespace+"addInvnHist", listSalePrdctVo.get(i));
			logger.info("insert result:"+result);
		}
		return "success";
	}
	
	@Override
	@Transactional
	public String decCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception{
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int result;
		for(int i=0,size=listSalePrdctVo.size();i<size;i++){
			result=sqlSession.update(namespace+"decCntInvn", listSalePrdctVo.get(i));
			logger.info("update result:"+result);
		}
		
		return "success";
	}
	
	
	@Override
	@Transactional
	public String incCntInvn(List<SalePrdctVo> listSalePrdctVo) throws Exception{
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int result;
		for(int i=0,size=listSalePrdctVo.size();i<size;i++){
			result = sqlSession.update(namespace+"incCntInvn", listSalePrdctVo.get(i));
			logger.info("update result:"+result);
		}
		
		return "success";
	}
	@Override
	@Transactional
	public String cancelPayment(List<SalePrdctVo> listSalePrdctVo, SaleJobVo saleJobVo,
								PointVo pointVo, PaymentVo paymentVo)throws Exception {
		SqlSession sqlSession=getSqlSession();
		// TODO Auto-generated method stub
		if(!listSalePrdctVo.isEmpty()){
			incCntInvn(listSalePrdctVo);
			addInvnHist(listSalePrdctVo);
		}
		//saleJobService.addSaleJob(listSaleJobVo);
		
		List<SaleJobVo> listSaleJobVo= sqlSession.selectList(jobspace+"listJobPayment", saleJobVo);
		
		for(int i = 0,size = listSaleJobVo.size();i<size;i++){
			listSaleJobVo.get(i).setStaffId(saleJobVo.getStaffId());
			listSaleJobVo.get(i).setSaleId(saleJobVo.getSaleId());
			listSaleJobVo.get(i).setCancel(saleJobVo.getCancel());
			listSaleJobVo.get(i).setDatetime(saleJobVo.getDatetime());
			if(null != listSaleJobVo.get(i).getPayCard()){
				listSaleJobVo.get(i).setPayCard(-listSaleJobVo.get(i).getPayCard());
			}else{
				listSaleJobVo.get(i).setPayCard(0);
			}
			if(null != listSaleJobVo.get(i).getPayCard()){
				listSaleJobVo.get(i).setPayCash(-listSaleJobVo.get(i).getPayCash());
			}else{
				listSaleJobVo.get(i).setPayCash(0);
			}
			if(null !=listSaleJobVo.get(i).getPayPoint()){
				listSaleJobVo.get(i).setPayPoint(-listSaleJobVo.get(i).getPayPoint());
			}else{
				listSaleJobVo.get(i).setAddPoint(0);
			}
			
			if(null != listSaleJobVo.get(i).getAddPoint()){
				listSaleJobVo.get(i).setAddPoint(-listSaleJobVo.get(i).getAddPoint());
			}else{
				listSaleJobVo.get(i).setAddPoint(0);
			}
			sqlSession.insert(jobspace+"addSaleJob", listSaleJobVo.get(i));
		}

		sqlSession.delete(pointspace+"removePointHist", pointVo);
		sqlSession.update(saleSpace+"modifySaleCancel", paymentVo);
		return "success";
	}
	
}
