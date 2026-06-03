package com.gallery.web.company.service;

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
import com.gallery.web.company.domain.CompanyVo;
import com.gallery.web.prdct.service.PrdctService;

@Service
@Repository
public class CompanyServiceImpl extends SqlSessionDaoSupport implements CompanyService{

	private final static String namespace= "com.gallery.company.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public String addCompany(CompanyVo companyVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countCompany", companyVo);
		if(cnt==0){
			System.out.println(companyVo.toString());
			sqlSession.insert(namespace+"addCompany", companyVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}

	@Override
	@Transactional
	public void modifyCompany(CompanyVo companyVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyCompany", companyVo);
		
	}

	@Override
	public Map pagedListCompanyData(CompanyVo company) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListCompanyCount", company);
		List companyList=sqlSession.selectList(namespace+"pagedListCompany", company);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(company.getCurrentPage());
		paging.setPageSize(company.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listCompany", companyList);
		return resultMap;
	}
	
	
	@Override
	public Map selectCompanyData(CompanyVo company) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		List companyList=sqlSession.selectList(namespace+"companyList", company);
		
		resultMap.put("listCompany", companyList);
		System.out.println("list : " + companyList);
		return resultMap;
	}
	@Override
	public Map listCompanyData(CompanyVo company) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List companyList=sqlSession.selectList(namespace+"listBrand", company);
		resultMap.put("listBrand", companyList);
		
		return resultMap;
	}
	

	@Override
	public CompanyVo selectCompany(CompanyVo company) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (CompanyVo)sqlSession.selectOne(namespace+"getCompany", company);
	}

	@Override
	public String removeCompany(CompanyVo companyVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=prdctService.countPrdctForCompany(companyVo);
		if(cnt>0){
			return "exist";
		}
		sqlSession.delete(namespace+"removeCompany", companyVo);
		return "success";
	}

	@Override
	public void mListCompanyData(CompanyVo company,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"mlistBrand",company);
		resultMap.put("listBrand", brandList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	@Override
	public void mListCompanyDataForDsply(CompanyVo company,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		
		
		
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"mlistBrandForDsply",company);
		resultMap.put("listBrand", brandList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}

	@Override
	public Map selectComList(CompanyVo companyVo) throws Exception {
		SqlSession sql = getSqlSession();
		List listCom = sql.selectList(namespace + "selectComList", companyVo);
		Map resultMap = new HashMap();
		resultMap.put("listCom", listCom);
		return resultMap;
	}

	@Override
	public Map listAllComData(CompanyVo companyVo) throws Exception {
		SqlSession sql = getSqlSession();
		List listCom = sql.selectList(namespace + "listAllComData", companyVo);
		Map resultMap = new HashMap();
		resultMap.put("listCom", listCom);
		return resultMap;
	}

	

	
	
	
}
