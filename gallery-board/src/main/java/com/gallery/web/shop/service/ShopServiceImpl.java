package com.gallery.web.shop.service;

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

import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.shop.domain.ShopVo;

@Service
@Repository
public class ShopServiceImpl extends SqlSessionDaoSupport implements ShopService{

	private final static String namespace= "com.gallery.shop.";
	
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

	@Override
	public Map findShopName(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultmap = new HashMap();
		List selectList = sql.selectList(namespace + "getShopName", shopVo); 
		resultmap.put("shopName", selectList);
		return resultmap;
	}
	
	@Override
	public Map shopList(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listShop = sql.selectList(namespace + "shopList", shopVo);
		resultMap.put("listShop", listShop);
		return resultMap;
	}

	@Override
	public Map selectAllShop() throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List shopList = sql.selectList(namespace + "selectAllShop");
		resultMap.put("listShop", shopList);
		return resultMap;
	}
	
	

	@Override
	public Map getinum(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		List iNumList = sql.selectList(namespace + "getinum", shopVo);
		Map resultMap = new HashMap();
		resultMap.put("iNumList", iNumList);
		return resultMap;
	}
	
	@Override
	public Map getShopId(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		List iNumList = sql.selectList(namespace + "getShopId", shopVo);
		Map resultMap = new HashMap();
		resultMap.put("iNumList", iNumList);
		return resultMap;
	}
	
}
