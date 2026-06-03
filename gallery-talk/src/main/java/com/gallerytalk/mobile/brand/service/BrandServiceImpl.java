package com.gallerytalk.mobile.brand.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.gallerytalk.mobile.brand.domain.BrandVo;

@Service
@Repository
public class BrandServiceImpl extends SqlSessionDaoSupport implements BrandService{

	private final static String namespace= "com.gallerytalk.brand.";
		
	
	
	@Override
	public Map listBrandData(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"listBrand", brandVo);
		resultMap.put("listBrand", brandList);
		
		return resultMap;
	}

	@Override
	public BrandVo selectBrand(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (BrandVo)sqlSession.selectOne(namespace+"getBrand", brandVo);
	}
}
