package com.gallerytalk.mobile.check.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.saleJob.domain.SaleJobVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

@Service
@Repository
public class CheckServiceImpl extends SqlSessionDaoSupport implements CheckService {
	
	
	private final static String namespace= "com.gallerytalk.check.";
	private final static String salespace= "com.gallerytalk.sale.";
	private final static String jobspace= "com.gallerytalk.salejob.";
	
	
	@Override
	public Map listVisitData(CheckVo checkVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List visitList=sqlSession.selectList(namespace+"listVisit", checkVo);
		resultMap.put("listVisit", visitList);
		return resultMap;
	}
	
	
	
	@Override
	public CheckVo selectVisitInfo(CheckVo checkVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (CheckVo)sqlSession.selectOne(namespace+"getVisitInfo", checkVo);
	}
	
	
	@Override
	public CheckVo selectVisitInfoForSale(HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		CstmrVo cstmrVo=(CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
		return (CheckVo)sqlSession.selectOne(namespace+"getVisitInfoForSale", cstmrVo);
	}
	
	
	
	@Override
	@Transactional
	public String addVisit(CheckVo checkVo,HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		logger.info("run addVisit checkVo:"+checkVo);
		SqlSession sqlSession=getSqlSession();
		//checkVo.setHistId(saleVo.getHistId());
		SaleJobVo saleJobVo = new SaleJobVo();
		SaleVo saleVo = (SaleVo)session.getAttribute(CommonCode.ATTR_SALE);
		sqlSession.insert(namespace+"addVisit", checkVo);
		saleVo.setHistId(checkVo.getHistId());
		sqlSession.update(salespace+"modifyHistId", saleVo);
		
		saleJobVo.setSaleId(saleVo.getSaleId());
		saleJobVo.setStaffId(checkVo.getStaffId());
		saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_CHECK);
		sqlSession.insert(jobspace+"addSaleJob", saleJobVo);
		
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
		Integer count=(Integer) sqlSession.selectOne(namespace+"countVisit", checkVo);
		if(count>0){
			sqlSession.update(namespace+"updateVisit", checkVo);
		}else{
			return "fail";}
		return "success";
	}
	
}
