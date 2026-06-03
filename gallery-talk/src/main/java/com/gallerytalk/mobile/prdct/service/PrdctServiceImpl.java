package com.gallerytalk.mobile.prdct.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.prdct.domain.PartnerVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.sale.service.SaleService;

@Service
@Repository
public class PrdctServiceImpl extends SqlSessionDaoSupport implements PrdctService {
	private final static String namespace= "com.gallerytalk.prdct.";
	private final static String salespace= "com.gallerytalk.sale.";
	private final static String salePrdctspace= "com.gallerytalk.salePrdct.";
	
	@Autowired
	private SaleService saleService;
	
	@Override
	public List <PrdctVo> listSalePrdctOff(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		List <PrdctVo> listSalePrdct=sqlSession.selectList(namespace+"listSalePrdctOff", saleVo);
		
		return listSalePrdct;
	}
	
	@Override
	public Map listPrdctData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listPrdct", prdctVo);
		
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	
	public Map listPartnerData() throws Exception {
		// TODO Auto-generated method stub
		logger.info("run listPartnerData");
		
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List partnerList=sqlSession.selectList(namespace+"listPartner");
		
		resultMap.put("listPartner", partnerList);
		
		return resultMap;
	}
	
	@Override
	public Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listSelectPrdct", prdctVo);
				
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	
	
	@Override
	public Map listSelectedPrdctDataLens(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listSelectPrdctLens", prdctVo);
				
		resultMap.put("listLens", prdctList);
		
		return resultMap;
	}
	
	
	@Override
	public Map listSelectedPrdctDataClens(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listSelectPrdctClens", prdctVo);
				
		resultMap.put("listClens", prdctList);
		
		return resultMap;
	}
	
	@Override
	public Map listSelectedPrdctDataAcc(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listSelectPrdctAcc", prdctVo);
				
		resultMap.put("listAcc", prdctList);
		
		return resultMap;
	}
	@Override
	
	public PrdctVo selectPrdct(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (PrdctVo)sqlSession.selectOne(namespace+"getPrdct", prdctVo);
	}
	
	@Override
	@Transactional
	public String modifyAsmblySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateAsmblySalePrdctOff", salePrdctVo);
		
		
		return "success";
	}
	
	@Override
	@Transactional
	public String modifyAsmblySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateAsmblyNewSalePrdctOff", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String modifyDlvrySalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateDlvrySalePrdctOff", salePrdctVo);
		return "success";
	}
	
	@Override
	@Transactional
	public String modifyDlvrySaleNewPrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateDlvryNewSalePrdctOff", salePrdctVo);
		return "success";
	}

	
	@Override
	public void addSalePrdct(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(salespace+"addSalePrdct", salePrdctVo);
	}
	
	@Override
	public String checkSalePrdctCount(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countSalePrdct", salePrdctVo);
		return num==0?"ok":"duple";
	}
	
	@Override
	public String checkSalePrdctCountNew(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countSalePrdctNew", salePrdctVo);
		return num==0?"ok":"duple";
	}
	
	@Override
	public String checkSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countSalePrdctSaleId", salePrdctVo);
		return num==0?"ok":"duple";
	}
	
	public String checkNewSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countNewSalePrdctSaleId", salePrdctVo);
		return num==0?"ok":"duple";
	}
	
	
	
	@Override
	public String checkAssemblySaleId(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countAsmbly", salePrdctVo);
		Integer num2=(Integer) sqlSession.selectOne(salespace+"newcountAsmbly", salePrdctVo);
		return num==0 && num2==0?"ok":"duple";
	}
	
	@Override
	public String checkDeliverySaleId(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salespace+"countDlvry", salePrdctVo);
		Integer num2=(Integer) sqlSession.selectOne(salespace+"newcountDlvry", salePrdctVo);
		return num==0 && num2==0?"ok":"duple";
	}
	@Override
	public String checkDeliverySaleIdEachType(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer num=(Integer) sqlSession.selectOne(salePrdctspace+"getDlvryCheck", salePrdctVo);

		return num==0?"no":"yes";
	}
	
	@Override
	public void removeSalePrdct(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(salespace+"removeSalePrdct", salePrdctVo);
	}
	
	@Override
	@Transactional
	public String incCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(salespace+"incCntSalePrdctOff", salePrdctVo);
		return "success";
	}
	@Override
	@Transactional
	public String decCntSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(salespace+"decCntSalePrdctOff", salePrdctVo);
		return "success";
	}
	@Override
	@Transactional
	public String incCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		logger.info("run incCntSalePrdctOffNewImp:"+salePrdctVo);
		sqlSession.update(salespace+"incCntSalePrdctOffNew", salePrdctVo);
		return "success";
	}
	@Override
	@Transactional
	public String decCntSalePrdctOffNew(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(salespace+"decCntSalePrdctOffNew", salePrdctVo);
		return "success";
	}
	
	@Override
	public void removeNewSalePrdct(SalePrdctVo salePrdctVo) throws Exception {
		logger.debug("param : " + salePrdctVo.toString());
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(salespace+"removeNewSalePrdct", salePrdctVo);
	}

	@Override
	public void addSalePrdctNew(SalePrdctVo salePrdctVo) throws Exception {
		SqlSession sqlSession = getSqlSession();
		sqlSession.insert(namespace+"addPrdct",salePrdctVo);
	}

	@Override
	public Map getNewPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sqlsession =getSqlSession();
		Map resultMap=new HashMap();
		List newPrdct = sqlsession.selectList(namespace + "getNewPrdct", prdctVo);
		
		resultMap.put("newPrdct", newPrdct);
		
		return resultMap;
	}
	
	@Override
	@Transactional
	public String modifyDscntEarnSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception{
		SqlSession sqlsession = getSqlSession();
		sqlsession.update(namespace+"modifyDscntEarnSalePrdctOff", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String modifyDscntEarnNewPrdct(SalePrdctVo salePrdctVo) throws Exception{
		SqlSession sqlsession = getSqlSession();
		sqlsession.update(namespace+"modifyDscntEarnNewPrdct", salePrdctVo);
		
		return "success";
	}
	
	
	
	@Override
	public SalePrdctVo getSalePrdct(SalePrdctVo salePrdctVo) throws Exception {
		SqlSession sqlsession =getSqlSession();
		salePrdctVo = (SalePrdctVo) sqlsession.selectOne(namespace + "getSalePrdct", salePrdctVo);
		
		return salePrdctVo;
	}
	@Override
	public SalePrdctVo getSalePrdctNew(SalePrdctVo salePrdctVo) throws Exception {
		SqlSession sqlsession =getSqlSession();
		salePrdctVo = (SalePrdctVo) sqlsession.selectOne(namespace + "getSalePrdctNew", salePrdctVo);
		
		return salePrdctVo;
	}
	
	

	@Override
	@Transactional
	public String modifyInformPrdctOff(SalePrdctVo salePrdctVo){
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateInformSalePrdctOff", salePrdctVo);
	
	return "success";
	}

	@Override
	public String modifyInformPrdctOffNew(SalePrdctVo salePrdctVo)
			throws Exception {
			SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(salespace+"updateInformSalePrdctOffNew", salePrdctVo);
	System.out.println("%%%%%%%%%");
	
	return "success";
	}

	@Override
	public Map getNewPaymentInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getNewPaymentInfo", saleVo);
		resultMap.put("NewPrdct", listPrdct);
		return resultMap;
	}


	@Override
	public Map getLensPaymentInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getFramePaymentInfo", saleVo);
		resultMap.put("FramePrdct", listPrdct);
		return resultMap;
	}

	@Override
	public Map getClensPaymentInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getLensPaymentInfo", saleVo);
		resultMap.put("LensPrdct", listPrdct);
		return resultMap;
	}

	@Override
	public Map getAccPaymentInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getClensPaymentInfo", saleVo);
		resultMap.put("ClensPrdct", listPrdct);
		return resultMap;
	}

	@Override
	public Map getFramePaymentInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getAccPaymentInfo", saleVo);
		resultMap.put("AccPrdct", listPrdct);
		return resultMap;
	}

	@Override
	public SaleVo getBillInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		saleVo = (SaleVo) sql.selectOne(salespace + "getBillInfo", saleVo);
		return saleVo;
	}

}
