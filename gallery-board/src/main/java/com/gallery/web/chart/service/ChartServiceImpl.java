package com.gallery.web.chart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.gallery.web.chart.domain.ChartVo;

@Service
@Repository
public class ChartServiceImpl extends SqlSessionDaoSupport implements ChartService {

	private final static String namespace = "com.gallery.chart.";
	
	@Override
	public String getYstdaySales(ChartVo chartVo) throws Exception {
		SqlSession sqlSession = getSqlSession();
		
		System.out.println("sql param : " + chartVo.toString());
		Integer ystdsales = (Integer) sqlSession.selectOne(namespace + "getYstDaySales", chartVo);
		Integer tsales = (Integer) sqlSession.selectOne(namespace + "getTDaySales", chartVo);
		if(ystdsales==null){
			ystdsales = 0;
		}
		if(tsales==null){
			tsales = 0;
		}
		System.out.println(ystdsales + "/" + tsales);
		return ystdsales + "/" + tsales ;
	}

	
	
	@Override
	public Map getShopSales(ChartVo chartvo) throws Exception {
		SqlSession sql = getSqlSession();
		
		Map resultMap=new HashMap();
		List salesInfo = sql.selectList(namespace + "getShopSales",chartvo);
		
		System.out.println("charServiceImpl : " + salesInfo);
		
		resultMap.put("shopSales", salesInfo);
		
		return resultMap;
	}



	@Override
	public Map getPrdctRank(ChartVo chartVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List rankInfo = sql.selectList(namespace + "getPrdctRank",chartVo);
		resultMap.put("prdctRank", rankInfo);
		
		System.out.println("prdct impl : " + rankInfo);
		return resultMap;
	}



	@Override
	public Map getProfit(ChartVo chartVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List rankInfo = sql.selectList(namespace + "getProfit",chartVo);
		resultMap.put("profit", rankInfo);
		
		System.out.println("profit impl : " + rankInfo);
		return resultMap;
	}



	@Override
	public Map getStaffChart(ChartVo chartVo) throws Exception {
		System.out.println("staffChart Impl : " + chartVo.toString());
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List staffList = sql.selectList(namespace + "getStaffChart", chartVo);
		
		resultMap.put("staffChart", staffList);
		return resultMap;
	}



	@Override
	public Map getStaffJob(ChartVo chartVo) throws Exception {
		System.out.println("StaffJobImppl : " + chartVo.toString());
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List staffJobList = sql.selectList(namespace + "getStaffJob", chartVo);
		resultMap.put("staffJob", staffJobList);
		System.out.println("staffJob : " + staffJobList);
		return resultMap;
	}



	@Override
	public Map getStaffList(ChartVo chartVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map result = new HashMap();
		List staffList = sql.selectList(namespace + "getStaffList",chartVo);
		result.put("staffList", staffList);
		return result;
	}

}
