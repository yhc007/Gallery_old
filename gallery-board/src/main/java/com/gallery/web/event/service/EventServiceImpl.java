package com.gallery.web.event.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.event.domain.EventPrdctVo;
import com.gallery.web.event.domain.EventVo;
import com.gallery.web.prdct.service.PrdctService;

@Service
@Repository
public class EventServiceImpl extends SqlSessionDaoSupport implements EventService{

	private final static String namespace= "com.gallery.event.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public String addEvent(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countEvent", eventVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addEvent", eventVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}
	
	@Override
	@Transactional
	public String removeEvent(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int row=sqlSession.delete(namespace+"removeEvent", eventVo);
		if(row>0){
			return "success";
		}else{
			return "fail";
		}
		
	}
	
	@Override
	@Transactional
	public String addEventPrdct(EventPrdctVo eventPrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"addEventPrdct", eventPrdctVo);
		return "success";
	}

	@Override
	@Transactional
	public void modifyEvent(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyEvent", eventVo);
		
	}

	@Override
	public Map pagedListEventData(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListEventCount", eventVo);
		List eventList=sqlSession.selectList(namespace+"pagedListEvent", eventVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(eventVo.getCurrentPage());
		paging.setPageSize(eventVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listEvent", eventList);
		return resultMap;
	}
	@Override
	public Map listEventData(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List eventList=sqlSession.selectList(namespace+"listEvent", eventVo);
		resultMap.put("listEvent", eventList);
		
		return resultMap;
	}

	@Override
	public Map listEventPrdctData(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List eventModelList=sqlSession.selectList(namespace+"listEventPrdct", eventVo);
		resultMap.put("listEventPrdct", eventModelList);
		
		
		return resultMap;
	}
	
	
	
	@Override
	public EventVo selectEvent(EventVo eventVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (EventVo)sqlSession.selectOne(namespace+"getEvent", eventVo);
	}

}
