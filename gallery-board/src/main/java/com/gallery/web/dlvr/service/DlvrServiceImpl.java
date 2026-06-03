package com.gallery.web.dlvr.service;

import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.dlvr.domain.DlvrVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

@Service
@Repository
public class DlvrServiceImpl extends SqlSessionDaoSupport implements DlvrService{

	private final static String namespace= "com.gallery.dlvr.";
	
	@Autowired
	PrdctService prdctService;
	
	
	@Override
	@Transactional
	public String addDlvr(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"addDlvr", dlvrVo);
		
		return "success";
	}
	
	@Override
	@Transactional
	public String removeDlvr(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int row=sqlSession.delete(namespace+"removeDlvr", dlvrVo);
		if(row>0){
			return "success";
		}else{
			return "fail";
		}
		
	}
	

	@Override
	@Transactional
	public void modifyDlvr(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyDlvr", dlvrVo);
		
	}

	
	@Override
	public Map listDlvrData(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		List dlvrList=sqlSession.selectList(namespace+"listDlvr", dlvrVo);
		
		resultMap.put("listdlvr", dlvrList);
		return resultMap;
	}


	@Override
	public Map listDlvrPrdctData(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List dlvrModelList=sqlSession.selectList(namespace+"listDlvrPrdct", dlvrVo);
		resultMap.put("listDlvrPrdct", dlvrModelList);
		
		
		return resultMap;
	}
	
	
	@Override
	public DlvrVo selectDlvr(DlvrVo dlvrVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (DlvrVo)sqlSession.selectOne(namespace+"getDlvr", dlvrVo);
	}

}
