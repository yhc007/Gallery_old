package com.gallerytalk.mobile.shop.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.common.domain.PagingVo;
import com.gallerytalk.mobile.prdct.domain.PrdctVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;

@Service
@Repository
public class ShopServiceImpl extends SqlSessionDaoSupport implements ShopService{

	private final static String namespace= "com.gallerytalk.shop.";
	
	@Override
	@Transactional
	public String addShop(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countShop", shopVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addShop", shopVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}

	@Override
	@Transactional
	public void modifyShop(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyShop", shopVo);
		
	}

	@Override
	public Map pagedListShopData(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListShopCount", shopVo);
		List shopList=sqlSession.selectList(namespace+"pagedListShop", shopVo);
		
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(shopVo.getCurrentPage());
		paging.setPageSize(shopVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listShop", shopList);
		
		return resultMap;
	}
	@Override
	public Map listShopData(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List shopList=sqlSession.selectList(namespace+"listShop", shopVo);
		resultMap.put("listShop", shopList);
		
		return resultMap;
	}

	@Override
	public ShopVo selectShop(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (ShopVo)sqlSession.selectOne(namespace+"getShop", shopVo);
	}

	@Override
	public ShopVo removeShop(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.delete(namespace+"removeShop", shopVo);
		return null;
	}

	
	@Override
	public void mListShopData(HttpServletResponse response,ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
				
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List shopList=sqlSession.selectList(namespace+"mlistShop",shopVo);
		
		List list=new ArrayList();
		for(int i=0;i<shopList.size();i++){
			Map map=new HashMap();
			map.put("shopId", ((ShopVo)shopList.get(i)).getShopId());
			map.put("shopName", ((ShopVo)shopList.get(i)).getShopName());
			map.put("telephone", ((ShopVo)shopList.get(i)).getTelephone());
			map.put("shopNum", ((ShopVo)shopList.get(i)).getShopNum());
			map.put("shopStatTyCd", ((ShopVo)shopList.get(i)).getShopStatTyCd());
			map.put("lat", ((ShopVo)shopList.get(i)).getLat());
			map.put("lot", ((ShopVo)shopList.get(i)).getLot());
			map.put("dstns", ((ShopVo)shopList.get(i)).getDstns());
			list.add(map);
		}
		
		resultMap.put("listShop", list);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
		
	}
	

	public Integer countShopJoin(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (Integer) sqlSession.selectOne(namespace+"countShopJoin", shopVo);
	}
	@Override
	@Transactional
	public String addShopJoin(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"addShopJoin", shopVo);
		return "success";
	}
	
	@Override
	public ShopVo selectShopJoin(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (ShopVo)sqlSession.selectOne(namespace+"getShopJoin", shopVo);
	}
	

	@Override
	@Transactional
	public String modifyShopJoin(ShopVo shopVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(namespace+"modifyShopJoin", shopVo);
		return "success";
	}

	@Override
	public String getShopPwd(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String shop = (String) sql.selectOne(namespace + "shopLogin", shopVo);
			if(shop!=null){
				result = "success";
			}else{
				result = "fail";
			}
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public void recIP(String IPaddr) throws Exception {
		SqlSession sql = getSqlSession();
		String exist = (String) sql.selectOne(namespace + "getAddr", IPaddr);
		if(exist!=null){
			sql.update(namespace + "addCntIP", IPaddr);
		}else{
			sql.insert(namespace + "recIP", IPaddr);
		}
		
	}
	
	

}
