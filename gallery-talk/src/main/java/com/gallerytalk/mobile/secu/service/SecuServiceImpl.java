package com.gallerytalk.mobile.secu.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.secu.domain.SecuVo;

@Service
@Repository
public class SecuServiceImpl extends SqlSessionDaoSupport implements SecuService{

	private final static String namespace= "com.gallerytalk.secu.";
	

	@Override
	public void test(SecuVo secuVo, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		// response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
		PrintWriter writer = response.getWriter();
		String str = secuVo.getSn();

		if(str.equals("abcd")){
			str = "ok";
		}
		writer.write(str);

		writer.flush();
		writer.close();
	}
	
	@Override
	@Transactional
	public String checkSn(SecuVo secuVo) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countReg", secuVo);
		if(1==cnt){
			return "success";
		}else{
			return "fail";
		}
	}
	
	@Override
	@Transactional
	public String regMac(SecuVo secuVo) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		sqlSession.update(namespace+"modifyMac", secuVo);
		return "success";
		
	}
	
	@Override	
	public String checkMac(SecuVo secuVo) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countAuth", secuVo);
		if(1==cnt){
			return "success";
		}else{
			return "fail";
		}
	}
	
	@Override	
	public String checkDvc(SecuVo secuVo) throws Exception {
		// TODO Auto-generated method stub

		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countDvc", secuVo);
		if(1==cnt){
			return "success";
		}else{
			return "fail";
		}
	}
	
}
