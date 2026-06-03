package com.gallerytalk.mobile.point.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.point.domain.PointVo;

@Service
@Repository
public class PointServiceImpl extends SqlSessionDaoSupport implements PointService{

	private final static String namespace= "com.gallerytalk.point.";
	private final static String cstmrspace= "com.gallerytalk.cstmr.";

	@Override
	@Transactional
	public String addBalancePoint() throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		List <PointVo> listPoint = sqlSession.selectList(namespace+"listFamilyCd");

		PointVo inputPoinVo = new PointVo();
		String cstmrCd;
		for(int i=0,size =listPoint.size();i<size;i++)
		{
			logger.info("loop:"+i);
			cstmrCd = listPoint.get(i).toString();
			inputPoinVo.setFmlyCd(cstmrCd);			
			sqlSession.insert(namespace+"calcBalancePoint", inputPoinVo);
		}
		return "success";
		
	}

	@Override
	@Transactional
	public String addPointHist(PointVo pointVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"addPointHist", pointVo);
		
		return "success";
	}

	@Override
	public PointVo selectPointByFmlyCd(PointVo pointVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		pointVo = (PointVo) sqlSession.selectOne(namespace+"pointByFmlyCd", pointVo);
		
		return pointVo;
	}
	@Override
	@Transactional
	public PointVo selectPointByCstmrCd(PointVo pointVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("pointVo :"+pointVo);
		SqlSession sqlSession=getSqlSession();
		if(null == pointVo.getFmlyCd() || pointVo.getFmlyCd().equals(""))
		{
			pointVo = (PointVo) sqlSession.selectOne(namespace+"selectFmlyCdbyPointCd", pointVo);
			CstmrVo cstmrVo = new CstmrVo();
			cstmrVo.setCstmrCd(pointVo.getCstmrCd());
			cstmrVo.setFmlyCd(pointVo.getFmlyCd());
//			sqlSession.update(cstmrspace+"modifyFmlyCdbyCstmrCd", cstmrVo);
			sqlSession.update(namespace+"modifyFmlyCdbyCstmrCd", cstmrVo);
		}
		
		pointVo = (PointVo) sqlSession.selectOne(namespace+"pointByFmlyCd", pointVo);
		logger.info("pointVo2:"+pointVo);
		
		return pointVo;
	}
	
	@Override
	public Map listPointHistory(PointVo pointVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		List listPointHist = sqlSession.selectList(namespace+"listPointHist", pointVo);
		resultMap.put("listPointHist",listPointHist);
		
		return resultMap;
	}
	@Override
	@Transactional
	public String removePointHist(PointVo pointVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.delete(namespace+"removePointHist", pointVo);
		return "success";
	}


}
