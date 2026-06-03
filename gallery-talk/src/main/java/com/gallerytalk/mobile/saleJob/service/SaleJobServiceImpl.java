package com.gallerytalk.mobile.saleJob.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;

@Service
@Repository
public class SaleJobServiceImpl extends SqlSessionDaoSupport implements SaleJobService{

	private final static String namespace= "com.gallerytalk.salejob.";

	@Autowired
	PrdctService prdctService;
	

	@Override
	@Transactional
	public String addSaleJob(SaleJobVo saleJobVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("call addSaleJob");
		
		SqlSession sqlSession=getSqlSession();
		Integer jobId=sqlSession.insert(namespace+"addSaleJob", saleJobVo);
		
		return jobId.toString();
	}
	
	@Override
	@Transactional
	public String addSaleJob(List<SaleJobVo> listSaleJobVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("call addSaleJob");
		
		SqlSession sqlSession=getSqlSession();
		for(int i = 0,size = listSaleJobVo.size();i<size;i++){
			sqlSession.insert(namespace+"addSaleJob", listSaleJobVo.get(i));
		}
		return "success";
	}
	
	@Override
	public Map listVisitingCstmrData(SaleJobVo saleJobVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List cstmrList=sqlSession.selectList(namespace+"listVisitingCstmrOffShop", saleJobVo);
		logger.info(cstmrList.toString());
		
		resultMap.put("listCstmr", cstmrList);
		
		return resultMap;
	}

	@Override
	public String delVisitData(SaleJobVo saleJobVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String payment = (String)sql.selectOne(namespace +"chkPayment", saleJobVo); //sale_id 삭제전 결제 여부
			System.out.println("SALEID=" + payment);
			if(payment!=null){
				sql.update(namespace + "cancelPayment", saleJobVo); //cancel에 저장 1번
				sql.update(namespace + "modifyResult", saleJobVo); //result 11111 변경
			}else{
				sql.delete(namespace + "delVisitData",saleJobVo); //기록 삭제
				sql.delete(namespace + "delSalePrdct",saleJobVo); //salePrdct_off 삭제
				sql.delete(namespace + "delNewSalePrdct",saleJobVo); //salePrdct_off 삭제
			}
				sql.delete(namespace + "delPointHist", saleJobVo); //포인트 기록 삭제
			
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	
	

}
