package com.gallerytalk.mobile.cstmrHstry.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmrHstry.domain.CstmrHstryVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

@Service
@Repository
public class CstmrHstryServiceImpl extends SqlSessionDaoSupport implements CstmrHstryService {
	private final static String checkspace= "com.gallerytalk.check.";
	private final static String prdctspace= "com.gallerytalk.prdct.";
	private final static String salespace= "com.gallerytalk.sale.";
	private final static String cstmrspace= "com.gallerytalk.gallerystaff.cstmr.";
	private final static String cstmrhstry= "com.gallerytalk.gallerystaff.cstmrHstry.";
	
	
//	@Override
//	public Map listVisitData(CheckVo checkVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		Map resultMap=new HashMap();
//		List visitList=sqlSession.selectList(namespace+"listVisit", checkVo);
//		resultMap.put("listVisit", visitList);
//		return resultMap;
//	}
	@Override
	public Map listVisitData(CstmrHstryVo cstmrHstryVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List <CstmrHstryVo> visitList = sqlSession.selectList(cstmrhstry+"listCstmrHstry", cstmrHstryVo);
		resultMap.put("listVisit", visitList);
		return resultMap;
	}
	
	@Override
	public CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception{
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		cstmrVo=(CstmrVo)sqlSession.selectOne(cstmrspace+"getCstmr",cstmrVo);
		return cstmrVo;
	}
	
//	@Override
//	public CheckVo selectVisitInfo(CheckVo checkVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		return (CheckVo)sqlSession.selectOne(namespace+"getVisitInfo", checkVo);
//	}
	@Override
	public CstmrHstryVo selectVisitInfo(CstmrHstryVo cstmrHstryVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (CstmrHstryVo)sqlSession.selectOne(cstmrhstry+"getVisitInfo", cstmrHstryVo);
	}
	
	
	@Override
	public CheckVo selectVisitInfoForSale(HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		CstmrVo cstmrVo=(CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		return (CheckVo)sqlSession.selectOne(checkspace+"getVisitInfoForSale", cstmrVo);
	}
	
	
	
	@Override
	@Transactional
	public String addVisit(CheckVo checkVo,HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		logger.info("run update:"+checkVo);
		System.out.println("eyeCheck : " + checkVo);
		SqlSession sqlSession=getSqlSession();
		SaleVo saleVo=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo=(StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		//checkVo.setHistId(saleVo.getHistId());
		checkVo.setStaffId(staffVo.getStaffId());
		checkVo.setVisitShopId(staffVo.getShopId());
		
//		Integer count=(Integer) sqlSession.selectOne(namespace+"countVisit", checkVo);
//		if(count>0){
//			sqlSession.update(namespace+"updateVisit", checkVo);
//		}else{
		Date date=new Date();
		String timestr=String.valueOf(date.getYear()+1900)+String.format("%02d",date.getMonth()+1)+String.format("%02d",date.getDate());
		checkVo.setDatetime(timestr);
		sqlSession.insert(checkspace+"addVisit", checkVo);
		
		//saleVo.setHistId(Integer.parseInt(checkVo.getHistId()));
		saleVo.setHistId(checkVo.getHistId());
		sqlSession.update(salespace+"modifyHistId", saleVo);
		
		
		//}
		return "success";
	}
	
	@Override
	@Transactional
	public String updateVisit(CheckVo checkVo,HttpSession session) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		SaleVo saleVo=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		StaffVo staffVo=(StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
		//checkVo.setHistId(saleVo.getHistId().toString());
		checkVo.setHistId(saleVo.getHistId());
		
		checkVo.setStaffId(staffVo.getStaffId());
		Integer count=(Integer) sqlSession.selectOne(checkspace+"countVisit", checkVo);
		if(count>0){
			sqlSession.update(checkspace+"updateVisit", checkVo);
		}else{
			return "fail";}
		return "success";
	}
	
	@Override
	public Map listSelectedPrdctData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdct", prdctVo);
				
		resultMap.put("listPrdctH", prdctList);
		
		return resultMap;
	}
	
	
	
	@Override
	public Map listSelectedPrdctDataLens(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctLens", prdctVo);
				
		resultMap.put("listLensH", prdctList);
		
		return resultMap;
	}
	
	
	@Override
	public Map listSelectedPrdctDataClens(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctClens", prdctVo);
				
		resultMap.put("listClensH", prdctList);
		
		return resultMap;
	}
	
	@Override
	public Map listSelectedPrdctDataAcc(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctAcc", prdctVo);
				
		resultMap.put("listAccH", prdctList);
		
		return resultMap;
	}
	
	@Override
	public Map getNewPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sqlsession =getSqlSession();
		Map resultMap=new HashMap();
		List newPrdct = sqlsession.selectList(prdctspace + "getNewPrdct", prdctVo);
		
		resultMap.put("newPrdctH", newPrdct);
		
		return resultMap;
	}

	@Override
	public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo) throws Exception {
		SqlSession sql = getSqlSession();
		cstmrHstryVo = (CstmrHstryVo) sql.selectOne(cstmrhstry + "cstmrhstry", cstmrHstryVo);
		return cstmrHstryVo;
	}
	
	@Override
	public String getCstmrhstryMemo(CstmrHstryVo cstmrHstryVo) throws Exception {
		SqlSession sql = getSqlSession();
		String memo = (String) sql.selectOne(cstmrhstry + "getCstmrhstryMemo",cstmrHstryVo);
		return memo;
	}

	@Override
	@Transactional
	public void CstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo) throws Exception {
		SqlSession sql = getSqlSession();
		sql.update(cstmrhstry + "cstmrHstryMemoUpdate",cstmrHstryVo);
	}
}
