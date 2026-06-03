package com.gallery.web.admin.service;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallery.web.admin.domain.AdminVo;
import com.gallery.web.shop.domain.ShopVo;

@Service
@Repository
public class AdminServiceImpl extends SqlSessionDaoSupport implements AdminService{

	private final static String namespace= "com.gallery.admin.";
	
	/*@Override
	
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
	}*/
	
	@Transactional
	@Override
	public AdminVo login(AdminVo adminVo) throws Exception {
		System.out.println("impl : " + adminVo );
		SqlSession sql = getSqlSession();
		AdminVo pwd = (AdminVo)sql.selectOne(namespace + "getPwd",adminVo);
		AdminVo result = null;
		
		
		if(pwd==null){
			result=null;
		}else if(adminVo.getPwd().equals(pwd.getPwd())){
			 result = (AdminVo)sql.selectOne(namespace + "getPwd",adminVo);
		}
		
		
		System.out.println(result);
		return result;
	}

	
	
	@Override
	public AdminVo loginInvn(AdminVo adminVo) throws Exception {
		System.out.println("impl : " + adminVo );
		SqlSession sql = getSqlSession();
		AdminVo pwd = (AdminVo)sql.selectOne(namespace + "getPwd",adminVo);
		AdminVo result = null;
		
		
		if(pwd==null){
			result=null;
		}else if(adminVo.getPwd().equals(pwd.getPwd())){
			 result = (AdminVo)sql.selectOne(namespace + "getPwd",adminVo);
		}
		
		
		System.out.println(result);
		return result;
	}
	@Override
	public String comLogin(AdminVo adminVo, HttpSession session) throws Exception {
		SqlSession sql = getSqlSession();
		String exist = (String)sql.selectOne(namespace + "comLogin", adminVo);
		String result = "";
		if(exist!=null){
			result = "ok";
		}else{
			result = "fail";
		}
		
		return result;
	}



	@Override
	public String getFrameShop(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String frameShop = (String)sql.selectOne(namespace + "frameShop",adminVo);
		return frameShop;
	}



	@Override
	public String getLensShop(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String lensShop = (String)sql.selectOne(namespace + "LensShop",adminVo);
		return lensShop;
	}



	@Override
	public String getClensShop(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String ClensShop = (String)sql.selectOne(namespace + "ClensShop",adminVo);
		return ClensShop;
	}



	@Override
	public String getAccShop(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String AccShop = (String)sql.selectOne(namespace + "AccShop",adminVo);
		return AccShop;
	}
	
	@Override
	public String getetcShop(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String etcShop = (String)sql.selectOne(namespace + "etcShop",adminVo);
		return etcShop;
	}



	@Override
	public String modifyPwdAction(AdminVo adminVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String check = (String)sql.selectOne(namespace + "CheckShopPwd", adminVo);
			if(check!=null){
				sql.update(namespace + "modifyPwdAction", adminVo);
				result = "success";
			}else{
				result = "fail";
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result = "err";
		}
		return result;
	}
	
}
