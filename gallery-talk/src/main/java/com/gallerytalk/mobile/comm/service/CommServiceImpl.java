package com.gallerytalk.mobile.comm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.comm.domain.CommVo;

@Service
@Repository
public class CommServiceImpl extends SqlSessionDaoSupport implements CommService {
	private static final String NAME_SPACE	="com.gallerytalk.comm.";
	
	
	@Override
	@Transactional
	public String addMsgLog(CommVo commVo) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		sqlSession.update(NAME_SPACE+"addMsgLog",commVo);
		
		return "OK";
	}
	
	@Override
	public Map responseTalkingGroupData(HttpServletResponse response, CommVo commVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map groupMap=new HashMap();
		
		CommVo preObj=null;
		
		List list=new ArrayList();
		
		int cnt = (Integer) sqlSession.selectOne(NAME_SPACE+"cntTalkingGroup",commVo);
		if(cnt>0){
			List <CommVo> groupList=sqlSession.selectList(NAME_SPACE+"listTalkingGroup", commVo);
			logger.info("TalkingList:"+groupList.toString());
			String model="";
			
			List objList=new ArrayList();
			for(int i=0;i<groupList.size();i++){
				CommVo obj=(CommVo)groupList.get(i);
				Map objMap=new HashMap();
				objMap.put("id", groupList.get(i).getRcvGid());
				objMap.put("name", groupList.get(i).getName());
				list.add(objMap);
			}
		}else{
			list=null;
		}
		
		groupMap.put("TalkingList", list);
		
		return groupMap;
	}
	@Override
	public String getRegId(CommVo commVo) throws Exception{
		SqlSession sqlSession = getSqlSession();
		int cnt = (Integer) sqlSession.selectOne(NAME_SPACE+"cntTalkingUser", commVo);
		if(cnt != 1){
			return "false";
		}else{
			commVo = (CommVo) sqlSession.selectOne(NAME_SPACE+"getRegIdByStaff", commVo);
			return commVo.getRegId();
		}
		
	}
	
	

}
