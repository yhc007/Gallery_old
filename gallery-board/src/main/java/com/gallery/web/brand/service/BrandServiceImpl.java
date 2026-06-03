package com.gallery.web.brand.service;

import java.io.PrintWriter;
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

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

@Service
@Repository
public class BrandServiceImpl extends SqlSessionDaoSupport implements BrandService{

	private final static String namespace= "com.gallery.brand.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public String addBrand(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countBrand", brandVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addBrand", brandVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}

	@Override
	@Transactional
	public void modifyBrand(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyBrand", brandVo);
		
	}

	@Override
	public Map pagedListBrandData(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListBrandCount", brandVo);
		List brandList=sqlSession.selectList(namespace+"pagedListBrand", brandVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(brandVo.getCurrentPage());
		paging.setPageSize(brandVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listBrand", brandList);
		return resultMap;
	}
	
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

	@Override
	public String removeBrand(BrandVo brandVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=prdctService.countPrdctForBrand(brandVo);
		if(cnt>0){
			return "exist";
		}
		sqlSession.delete(namespace+"removeBrand", brandVo);
		return "success";
	}

	@Override
	public void mListBrandData(BrandVo brandVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"mlistBrand",brandVo);
		resultMap.put("listBrand", brandList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	@Override
	public void mListBrandDataForDsply(BrandVo brandVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		
		
		
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"mlistBrandForDsply",brandVo);
		resultMap.put("listBrand", brandList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}

	@Override
	public Map listBrandByTy(BrandVo brandVo) throws Exception {
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"listBrandByTy", brandVo);
		resultMap.put("listBrand", brandList);
		
		return resultMap;
	}

		@Override
		public Map srchBrand(BrandVo brandVo) throws Exception {
			SqlSession sql = getSqlSession();
			Map resultMap = new HashMap();
			List brandList = sql.selectList(namespace + "srchBrand", brandVo);
			resultMap.put("listBrand", brandList);
			return resultMap;
		}

		@Override
		public String addNewBrand(BrandVo brandVo) throws Exception {
			SqlSession sql = getSqlSession();
			String result = "";
			try{
				sql.insert(namespace + "addBrand", brandVo);
				result = "success|" + brandVo.getBrandId();
			}catch(Exception e){
				e.printStackTrace();
				result = "duple|null";
			}
			return result;
		}


}
