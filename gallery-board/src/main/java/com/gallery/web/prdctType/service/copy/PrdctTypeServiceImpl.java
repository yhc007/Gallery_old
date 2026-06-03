package com.gallery.web.prdctType.service.copy;

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

import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;
import com.gallery.web.prdctType.domain.PrdctTypeVo;

@Service
@Repository
public class PrdctTypeServiceImpl extends SqlSessionDaoSupport implements PrdctTypeService{

	private final static String namespace= "com.gallery.prdctType.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	public void mListPrdctTypeData(HttpServletResponse response) throws Exception {
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List <PrdctTypeVo> prdctTypeList=sqlSession.selectList(namespace+"getListPrdctType");
		resultMap.put("listPrdctType", prdctTypeList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
}
