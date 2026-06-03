package com.gallerytalk.mobile.staff.service;

import java.io.File;
import java.io.FileOutputStream;
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
import org.springframework.web.multipart.MultipartFile;

import com.gallerytalk.mobile.common.domain.PagingVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.staff.domain.StaffVo;

@Service
@Repository
public class StaffServiceImpl extends SqlSessionDaoSupport implements StaffService{

	private final static String namespace= "com.gallerytalk.staff.";
	private final static String shopspace= "com.gallerytalk.shop.";
	
	@Override
	@Transactional
	public Map setUserRegId(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String result="";
		Map mapResult=new HashMap();
		int cnt = (Integer) sqlSession.selectOne(namespace+"countStaffPhone", staffVo);
		
		StaffVo getStaff = new StaffVo();
		if(0==cnt){
			result="no";
		}else if (1==cnt){
			getStaff = (StaffVo) sqlSession.selectOne(namespace+"getStaffbyPhone", staffVo);
			sqlSession.update(namespace+"setUserRegId", staffVo);
			result="ok";
			if(0!=getStaff.getShopId())
			{
				mapResult.put("shopId", "S"+getStaff.getShopId());
			}else{
				mapResult.put("shopId", "C"+getStaff.getComId());
			}
			
			mapResult.put("shopName", getStaff.getShopName());
			
		}else{
			result="duple";
		}
		
		mapResult.put("result", result);
		
		
		
		
		return mapResult;
		
	}

}
