package com.gallery.web.cart.service;

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

import com.gallery.web.cart.domain.CartVo;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

@Service
@Repository
public class CartServiceImpl extends SqlSessionDaoSupport implements CartService{

	private final static String namespace= "com.gallery.cart.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public String addCart(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countCart", cartVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addCart", cartVo);
			return "success";
		}else{
			return "duple";
		}
	}

	@Override
	@Transactional
	public void modifyCart(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyCart", cartVo);
		
	}
	

	@Override
	public Map pagedListCartData(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListCartCount", cartVo);
		List cartList=sqlSession.selectList(namespace+"pagedListCart", cartVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(cartVo.getCurrentPage());
		paging.setPageSize(cartVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listCart", cartList);
		return resultMap;
	}
	
	@Override
	public void responseCartData(CartVo cartVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map frameMap=new HashMap();
		
		List filterList=new ArrayList();
		PrdctVo preObj=null;
		
		List list=new ArrayList();
		List prdctList=mListCartData(cartVo);
		logger.info("prdctList:"+prdctList.toString());
		String model="";
		
		
		List objList=new ArrayList();
		for(int i=0;i<prdctList.size();i++){
			Map map=new HashMap();
			PrdctVo obj=(PrdctVo)prdctList.get(i);
			if(!model.equals(obj.getPrdctName())){
				if(objList.size()!=0){
					logger.info("preObj"+preObj.toString());
					Map objMap=new HashMap();
					objMap.put("id", preObj.getPrdctId());
					objMap.put("name", preObj.getPrdctName());
					objMap.put("videoCd", preObj.getVideoCd());
					objMap.put("price", preObj.getTrdePrc());
					objMap.put("file_server_url", preObj.getUrlStr());
					objMap.put("multi_img_count", preObj.getMultiImgCnt());
					objMap.put("event_id", preObj.getEventId());
					objMap.put("event_name", preObj.getEventName());
					objMap.put("dscnt", preObj.getDscnt());
					objMap.put("prdcts", objList);
					objMap.put("jjim", true);
					objMap.put("brand_name", preObj.getBrandName());
					
					list.add(objMap);
					objList=new ArrayList();
				}
			}
			
			
			if(!filterList.contains(obj.getPrdctName()+obj.getColor())){
				filterList.add( obj.getPrdctName()+obj.getColor() );
				preObj=obj;
				model=obj.getPrdctName();
				
				map.put("still_img_path", obj.getImgPath());
				map.put("color", obj.getColor());
				objList.add(map);
			}
		}
		
		
		if(prdctList.size()>0){
			PrdctVo obj=preObj;
			Map objMap=new HashMap();
			if(objList.size()!=0){
				objMap.put("id", obj.getPrdctId());
				objMap.put("name", obj.getPrdctName());
				objMap.put("videoCd", obj.getVideoCd());
				objMap.put("price", obj.getTrdePrc());
				objMap.put("file_server_url", obj.getUrlStr());
				objMap.put("multi_img_count", obj.getMultiImgCnt());
				objMap.put("event_id", obj.getEventId());
				objMap.put("event_name", obj.getEventName());
				objMap.put("dscnt", obj.getDscnt());
				objMap.put("prdcts", objList);
				objMap.put("jjim", true);
				objMap.put("brand_name", obj.getBrandName());
				list.add(objMap);
			}
		}
		objList=new ArrayList();
		
		
		frameMap.put("prdctList", list);
		
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		String str="";
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);
		
		
		writer.write(str);
		
		writer.flush();
		writer.close();
		
	}
	
	public List mListCartData(CartVo cartVo)throws Exception {
		SqlSession sqlSession=getSqlSession();
		
		return sqlSession.selectList(namespace+"mListCart", cartVo);
	}

	@Override
	public CartVo selectCart(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (CartVo)sqlSession.selectOne(namespace+"getCart", cartVo);
	}

	@Override
	public String removeCart(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.delete(namespace+"removeCart", cartVo);
		return "success";
	}
	
	@Override
	@Transactional
	public String removeCartCstmrPrdct(CartVo cartVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info(cartVo.toString());
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"removeCartCstmrPrdct", cartVo);
		return "success";
	}


	/*@Override
	public void mListCartData(CartVo cartVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
	
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List cartList=sqlSession.selectList(namespace+"mlistCart",cartVo);
		resultMap.put("listCart", cartList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}*/

}
