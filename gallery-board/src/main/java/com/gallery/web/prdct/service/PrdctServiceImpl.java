package com.gallery.web.prdct.service;

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

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.company.domain.CompanyVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.shop.domain.ShopVo;

@Service
@Repository
public class PrdctServiceImpl extends SqlSessionDaoSupport implements PrdctService {
	private final static String namespace= "com.gallery.prdct.";
	private final static String brandnamespace= "com.gallery.brand.";
	
	@Override
	@Transactional
	public String addPrdct(PrdctVo prdctVo) throws Exception {
		
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		
		int cnt=(Integer)sqlSession.selectOne(namespace+"countPrdct", prdctVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addPrdct", prdctVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}
	
	
	@Override
	@Transactional
	public String addPrdctColor(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		
		int cnt=(Integer)sqlSession.selectOne(namespace+"countPrdctColor", prdctVo);
		if(cnt==0){
			sqlSession.insert(namespace+"addPrdctColor", prdctVo);
			return "success";
		}else{
			return "duple";
		}
	}
	
	public Integer countPrdctForBrand(BrandVo brandVo) throws Exception{
		SqlSession sqlSession=getSqlSession();
		return (Integer)sqlSession.selectOne(namespace+"countPrdctForBrand", brandVo);
	}
	
	
	public Integer countPrdctForCompany(CompanyVo companyVo) throws Exception{
		SqlSession sqlSession=getSqlSession();
		return (Integer)sqlSession.selectOne(namespace+"countPrdctForCompany", companyVo);
	}
	@Override
	@Transactional
	public void modifyPrdct(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(namespace+"modifyPrdct", prdctVo);
		
	}
	@Override
	@Transactional
	public String modifyPrdctAcpt(PrdctVo prdctVo) throws Exception{
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int rows=sqlSession.update(namespace+"modifyPrdctAcpt", prdctVo);
		if(rows!=1){
			int a=1/0;
		}
		return "success";
	}
	
	
	@Override
	@Transactional
	public String modifyPrdctInvn(PrdctVo prdctVo) throws Exception{
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		PrdctVo getVo=(PrdctVo)sqlSession.selectOne(namespace+"getPrdctInvn", prdctVo);
		if(getVo==null){
			if(prdctVo.getInvnTyCd().equals(CommonCode.CODE_INVN_TY_IN)){
				sqlSession.insert(namespace+"addPrdctInvn", prdctVo);
			}else{
				return "shortage";
			}
		}else{
			if(prdctVo.getInvnTyCd().equals(CommonCode.CODE_INVN_TY_OUT)){
				if(getVo.getCnt()<prdctVo.getCnt()){
					return "shortage";
				}
			}
			int rows=sqlSession.update(namespace+"modifyPrdctInvn", prdctVo);
			if(rows!=1){
				int a=1/0;
			}
		}
		
		sqlSession.insert(namespace+"addPrdctInvnHist", prdctVo);
		return "success";
	}
	

	@Override
	public Map pagedListPrdctData(PrdctVo prdctVo) throws Exception {//������
		// TODO Auto-generated method stub
		System.out.println("@@@@ : " + prdctVo);
		
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListPrdctCount", prdctVo);
		List prdctList=sqlSession.selectList(namespace+"pagedListPrdct", prdctVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(prdctVo.getCurrentPage());
		paging.setPageSize(prdctVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	@Override
	public Map listPrdctDataForEvent(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List prdctList=sqlSession.selectList(namespace+"listPrdctForEvent", prdctVo);
		
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	@Override
	public String listPrdctColor(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		List prdctList=sqlSession.selectList(namespace+"listPrdctColor", prdctVo);
		List list=new ArrayList();
		for(int i=0;i<prdctList.size();i++){
			Map map=new HashMap();
			map.put("color", ((PrdctVo)prdctList.get(i)).getColor());
			map.put("path",  ((PrdctVo)prdctList.get(i)).getImgPath());
			list.add(map);
		}
		String str="";
		
		Map resultMap=new HashMap();
		resultMap.put("listColor", list);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		return str;
	}
	
	@Override
	public Map pagedListPrdctConfirmData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListPrdctConfirmCount", prdctVo);
		
		List prdctList=sqlSession.selectList(namespace+"pagedListPrdctConfirm", prdctVo);
		
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(prdctVo.getCurrentPage());
		paging.setPageSize(prdctVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}

	
	@Override
	public Map pagedListPrdctRemainData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListPrdctCount", prdctVo);
		
		System.out.println("page : " + pageCount);
		List prdctList=sqlSession.selectList(namespace+"pagedListPrdctRemain", prdctVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(prdctVo.getCurrentPage());
		paging.setPageSize(prdctVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	@Override
	public Map pagedListPrdctInvnHistData(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListPrdctInvnHistCount", prdctVo);
		List prdctList=sqlSession.selectList(namespace+"pagedListPrdctInvnHist", prdctVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(prdctVo.getCurrentPage());
		paging.setPageSize(prdctVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listPrdct", prdctList);
		
		return resultMap;
	}
	
	@Override
	public PrdctVo selectPrdct(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		return (PrdctVo)sqlSession.selectOne(namespace+"getPrdct", prdctVo);
	}
	
	
	@Override
	public PrdctVo selectPrdctInvnHist(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (PrdctVo)sqlSession.selectOne(namespace+"getPrdctInvnHist", prdctVo);
	}
	
	@Override
	public PrdctVo removePrdct(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.delete(namespace+"removePrdct", prdctVo);
		return null;
	}

	@Override
	public void responseFrameData(PrdctVo prdctVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map frameMap=new HashMap();
		
		
		List filterList=new ArrayList();
		PrdctVo preObj=null;
		
		List list=new ArrayList();
		List prdctList=mListFrameData(prdctVo);
		String model="";
		
		
		List objList=new ArrayList();
		for(int i=0;i<prdctList.size();i++){
			Map map=new HashMap();
			PrdctVo obj=(PrdctVo)prdctList.get(i);
			if(!model.equals(obj.getPrdctName())){
				if(objList.size()!=0){
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
					objMap.put("jjim", preObj.getJjim()==1);
					
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
				objMap.put("jjim", obj.getJjim()==1);
				list.add(objMap);
			}
		}
		objList=new ArrayList();
		
		
		frameMap.put("prdctList", list);
		
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //?������?������������?
		PrintWriter writer=response.getWriter();
		String str="";
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	
	public List mListFrameData(PrdctVo prdctVo)throws Exception {
		SqlSession sqlSession=getSqlSession();
		
		return sqlSession.selectList(namespace+"mListFrame", prdctVo);
	}
	
	@Override
	public void responseLensData(PrdctVo prdctVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Map lensMap=new HashMap();
		List list=new ArrayList();
		List prdctList=sqlSession.selectList(namespace+"mListLens", prdctVo);
		for(int i=0;i<prdctList.size();i++){
			Map map=new HashMap();
			map.put("id", ((PrdctVo)prdctList.get(i)).getPrdctId());
			map.put("name", ((PrdctVo)prdctList.get(i)).getPrdctName());
			map.put("price", ((PrdctVo)prdctList.get(i)).getTrdePrc());
			map.put("file_server_url", ((PrdctVo)prdctList.get(i)).getUrlStr());
			map.put("still_img_path", ((PrdctVo)prdctList.get(i)).getImgPath());
			map.put("multi_img_count", ((PrdctVo)prdctList.get(i)).getMultiImgCnt());
			map.put("videoCd", ((PrdctVo)prdctList.get(i)).getVideoCd());
			map.put("event_id", ((PrdctVo)prdctList.get(i)).getEventId());
			map.put("event_name", ((PrdctVo)prdctList.get(i)).getEventName());
			map.put("dscnt", ((PrdctVo)prdctList.get(i)).getDscnt());
			map.put("jjim", ((PrdctVo)prdctList.get(i)).getJjim()==1);
			list.add(map);
		}
				
		
		lensMap.put("prdctList", list);
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //?������?������������?
		PrintWriter writer=response.getWriter();
		String str="";
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(lensMap);
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	
	@Override
	public List <PrdctVo> selectLensPath(PrdctVo prdctVo) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("step 1");
		SqlSession sqlSession=getSqlSession();
		logger.debug("step 2");
		List <PrdctVo> lensList=sqlSession.selectList(namespace+"getSelectLensDemo", prdctVo);
		logger.debug("step 3");
		logger.debug(lensList.toString());
		logger.debug("step 4");
		return lensList;
	}
	
	@Override
	public void responseDsplyLensData(PrdctVo prdctVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Map lensMap=new HashMap();
		List list=new ArrayList();
		List prdctList=sqlSession.selectList(namespace+"mListDsplyLens", prdctVo);
		for(int i=0;i<prdctList.size();i++){
			Map map=new HashMap();
			map.put("id", ((PrdctVo)prdctList.get(i)).getPrdctId());
			map.put("name", ((PrdctVo)prdctList.get(i)).getPrdctName());
			map.put("file_server_url", ((PrdctVo)prdctList.get(i)).getUrlStr());
			map.put("still_img_path", ((PrdctVo)prdctList.get(i)).getImgPath());
			map.put("multi_img_count", ((PrdctVo)prdctList.get(i)).getMultiImgCnt());
			map.put("videoCd", ((PrdctVo)prdctList.get(i)).getVideoCd());
			list.add(map);
		}
				
		
		lensMap.put("prdctList", list);
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //?������?������������?
		PrintWriter writer=response.getWriter();
		String str="";
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(lensMap);
		
		writer.write(str);
		writer.flush();
		writer.close();
	}


	@Override
	public void modifyPrdctPrc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		sql.update(namespace + "modifyPrdctPrc", prdctVo);
	}


	@Override
	public Map getPrdctListByBrand(BrandVo brandVo) throws Exception {
		System.out.println("brandImpl : " + brandVo);
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List brandList = sql.selectList(namespace + "getPrdctListByBrand", brandVo);
		resultMap.put("brandList", brandList);
		System.out.println("result : " + brandList);
		return resultMap;
	}


	@Override
	public Map getCntryList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List cntyList = sql.selectList(namespace + "getCntryList");
		resultMap.put("cntryList", cntyList);
		return resultMap;
	}


	@Override
	public String addPrdctInvn(PrdctVo prdctVo) throws Exception {
		System.out.print("brandId :" + prdctVo.getBrandId());
		SqlSession sql = getSqlSession();
		String result = "";
		String prdctName = (String)sql.selectOne(namespace + "getPrdctId_",prdctVo.getPrdctId());
		prdctVo.setPrdctName(prdctName);
		String existClr = (String)sql.selectOne(namespace + "prdctClrCk", prdctVo);
		if(existClr==null){
			sql.insert(namespace+"addPrdct", prdctVo);
			sql.insert(namespace + "addInvn", prdctVo);
		}
		String exist = (String)sql.selectOne(namespace + "shopInvn",prdctVo);
		if(exist!=null){
			try{
				sql.update(namespace + "InvnUpdate", prdctVo);
				sql.insert(namespace + "updateInvn", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}else{
			try{
				sql.insert(namespace + "addInvn", prdctVo);
				sql.insert(namespace + "updateInvn", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}
		
		return result;
	}


	@Override
	public Map getInvnList(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List invnList = sql.selectList(namespace + "getInvnList", shopVo);
		resultMap.put("invnList",invnList);
		return resultMap;
	}


	@Override
	public Map getInvnHist(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List InvnList = sql.selectList(namespace + "invnHist",prdctVo);
		resultMap.put("invnHist", InvnList);
		return resultMap;
	}

	@Override
	public Map getLensInvnHist(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List InvnList = sql.selectList(namespace + "lensInvnHist",prdctVo);
		resultMap.put("invnHist", InvnList);
		return resultMap;
	}

	@Override
	public Map getClensnvnHist(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List InvnList = sql.selectList(namespace + "clensInvnHist",prdctVo);
		resultMap.put("invnHist", InvnList);
		return resultMap;
	}
	
	@Override
	public Map getClensAccInvnHist(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List InvnList = sql.selectList(namespace + "clensAccInvnHist",prdctVo);
		resultMap.put("invnHist", InvnList);
		return resultMap;
	}
	@Override
	public Map getColorList() throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List colorList = sql.selectList(namespace + "getColorList");
		resultMap.put("colorList", colorList);
		return resultMap;
	}
	
	@Override
	public Map getMtrlList() throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List mtrlList = sql.selectList(namespace + "getMtrlList");
		resultMap.put("mtrlList", mtrlList);
		return resultMap;
	}


	@Override
	public Integer getPrdctId(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Integer prdctId = (Integer) sql.selectOne(namespace + "getPrdctId", prdctVo);
		System.out.print("new Id : " + prdctId);
		return prdctId;
	}


	@Override
	public Map getPrdctByNFC(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List prdctList = sql.selectList(namespace + "getPrdctByNFC", prdctVo);
		resultMap.put("prdctList", prdctList);
		return resultMap;
	}


	@Override
	public String getImgPath(ShopVo shopVo) throws Exception {
		SqlSession sql = getSqlSession();
		String url = (String)sql.selectOne(namespace + "getURL");
		String imgPath = (String)sql.selectOne(namespace + "getImgPath",shopVo);
		String img = url + imgPath;
		if(imgPath==null){
			img = null;
		}
		return img;
	}


	@Override
	public Map getMorePrdct(ShopVo shpoVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List moreList = sql.selectList(namespace + "getMorePrdct",shpoVo);
		System.out.println("more :" + moreList);
		resultMap.put("moreList", moreList);
		return resultMap;
	}


	@Override
	public PrdctVo getInvnEditForm(PrdctVo prdctVo) throws Exception {
		
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getInvnEditForm", prdctVo);
		logger.debug(prdct.toString());
		return prdct;
	}
	
	@Override
	public PrdctVo getLensInvnEditForm(PrdctVo prdctVo) throws Exception {
		
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getLensInvnEditForm", prdctVo);
		logger.debug(prdct.toString());
		return prdct;
	}
	
	@Override
	public PrdctVo getClensInvnEditForm(PrdctVo prdctVo) throws Exception {
		
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getClensInvnEditForm", prdctVo);
		logger.debug(prdct.toString());
		return prdct;
	}
	
	@Override
	public PrdctVo getClensAccInvnEditForm(PrdctVo prdctVo) throws Exception {
		
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getClensAccInvnEditForm", prdctVo);
		logger.debug(prdct.toString());
		return prdct;
	}
	@Override
	public String modifyInvnPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyInvnPrdct",prdctVo);
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}

	@Override
	public String modifyLensInvnPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyLensInvnPrdct",prdctVo);
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	@Override
	public String modifyClensInvnPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyClensInvnPrdct",prdctVo);
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	
	@Override
	public String modifyClensAccInvnPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyClensAccInvnPrdct",prdctVo);
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	@Override
	public void delHistData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		try{
			PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getInvnCnt", prdctVo);
			sql.update(namespace + "delHistInvn", prdct);
			sql.delete(namespace + "delinvn");
			
			sql.delete(namespace + "delHistData",prdctVo);
			
			
		
			
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}

	@Override
	public void delLensHistData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		try{
			PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getLensInvnCnt", prdctVo);
			sql.update(namespace + "delLensHistInvn", prdct);
			sql.delete(namespace + "delLensinvn");
			sql.delete(namespace + "delLensHistData",prdctVo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	@Override
	public void delClensHistData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		try{
			PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getClensInvnCnt", prdctVo);
			sql.update(namespace + "delClensHistInvn", prdct);
			sql.delete(namespace + "delClensinvn");
			sql.delete(namespace + "delClensHistData",prdctVo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	@Override
	public void delClensAccHistData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		try{
			PrdctVo prdct = (PrdctVo) sql.selectOne(namespace + "getClensAccInvnCnt", prdctVo);
			sql.update(namespace + "delClensAccHistInvn", prdct);
			sql.delete(namespace + "delClensAccinvn");
			sql.delete(namespace + "delClensAccHistData",prdctVo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	@Override
	public Integer insertDiffClr(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Integer result = 0;
		Integer exist = (Integer) sql.selectOne(namespace + "srchMatchClr", prdctVo); //변경하려는 제품의 색상 등록 여부
		if(exist!=null){
			//기존에 있는 색상으로 변경 시
			sql.delete(namespace + "delPrdctInvnHist", prdctVo); // 기존 invn_hist prdct 삭제
			sql.update(namespace + "delCntInvn", prdctVo);//기존 invn prdct 삭제
			result = exist;
			prdctVo.setPrdctId(exist);
			sql.insert(namespace + "updateInvn",prdctVo); //새 invn_hist 추가
			String invn = (String)sql.selectOne(namespace + "srchPrdctInvn",prdctVo); //변경 prdct invn 유뮤 체크
			if(invn!=null){
				sql.update(namespace + "InvnUpdate", prdctVo); // invn에 있는 경우 update 
			}else{
				sql.insert(namespace + "addInvn",prdctVo); //invn에 없는 경우 insert
			}
			
			sql.delete(namespace + "delinvn"); //재고 0인 테이블 삭제
		}else{
			//기존에 없는 새로운 색상으로 변경시
			sql.delete(namespace + "delPrdctInvnHist", prdctVo); // 기존 invn_hist prdct 삭제
			sql.update(namespace + "delCntInvn", prdctVo);//기존 invn prdct 삭제
			sql.insert(namespace+"addPrdct", prdctVo); //newColor prdct 추가
			sql.update(namespace + "addInvn", prdctVo); // 새 invn prdct추가
			sql.update(namespace + "updateInvn", prdctVo); // 새 invn_hist prdct추가
			sql.delete(namespace + "delinvn"); //재고 0인 테이블 삭제
			result = prdctVo.getPrdctId();
	} 
		return result;
}


	@Override
	public Integer insertDiffClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Integer result = 0;
		Integer exist = (Integer) sql.selectOne(namespace + "srchMatchClens", prdctVo); //변경하려는 제품 유무 체크
		if(exist!=null){
			//기존에 있는 색상으로 변경 시
			sql.delete(namespace + "delClensInvnHist", prdctVo); // 기존 invn_hist prdct 삭제
			sql.update(namespace + "delClensCntInvn", prdctVo);//기존 invn prdct 삭제
			result = exist;
			prdctVo.setPrdctId(exist);
			sql.insert(namespace + "updateInvnClens",prdctVo); //새 invn_hist 추가
			String invn = (String)sql.selectOne(namespace + "srchClensInvn",prdctVo); //변경 prdct invn 유뮤 체크
			prdctVo.setInvnId(invn);
			if(invn!=null){
				sql.update(namespace + "updateClensInvn", prdctVo); // invn에 있는 경우 update 
			}else{
				sql.insert(namespace + "addInvnClensData",prdctVo); //invn에 없는 경우 insert
			}
			
			sql.delete(namespace + "delClensinvn"); //재고 0인 테이블 삭제
		}else{
			result = 444;
		}
		return result;
	}

	@Override
	public Integer insertDiffLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Integer result = 0;
		Integer exist = (Integer) sql.selectOne(namespace + "srchMatchRate", prdctVo); //변경하려는 제품의 rate 등록 여부
		if(exist!=null){
			//기존에 있는 색상으로 변경 시
			sql.delete(namespace + "delLensInvnHist", prdctVo); // 기존 invn_hist prdct 삭제
			sql.update(namespace + "delLensCntInvn", prdctVo);//기존 invn prdct 삭제
			result = exist;
			prdctVo.setPrdctId(exist);
			sql.insert(namespace + "updateInvnLens",prdctVo); //새 invn_hist 추가
			String invn = (String)sql.selectOne(namespace + "srchLensInvn",prdctVo); //변경 prdct invn 유뮤 체크
			prdctVo.setInvnId(invn);
			if(invn!=null){
				sql.update(namespace + "updateLensInvn", prdctVo); // invn에 있는 경우 update 
			}else{
				sql.insert(namespace + "addInvnLensData",prdctVo); //invn에 없는 경우 insert
			}
			
			sql.delete(namespace + "delLensinvn"); //재고 0인 테이블 삭제
		}else{
			result = 444;
		}
		return result;
	}

	@Override
	public Integer insertDiffAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Integer result = 0;
		Integer exist = (Integer) sql.selectOne(namespace + "srchMatchUnit", prdctVo); //변경하려는 제품의 Unit등록 여부
		if(exist!=null){
			//기존에 있는 색상으로 변경 시
			sql.delete(namespace + "delAccInvnHist", prdctVo); // 기존 invn_hist prdct 삭제
			sql.update(namespace + "delAccCntInvn", prdctVo);//기존 invn prdct 삭제
			result = exist;
			prdctVo.setPrdctId(exist);
			sql.insert(namespace + "updateAccInvn",prdctVo); //새 invn_hist 추가
			String invn = (String)sql.selectOne(namespace + "srchAccInvn",prdctVo); //변경 prdct invn 유뮤 체크
			prdctVo.setInvnId(invn);
			if(invn!=null){
				sql.update(namespace + "updateClensAccInvn", prdctVo); // invn에 있는 경우 update 
			}else{
				sql.insert(namespace + "addInvnClensAccData",prdctVo); //invn에 없는 경우 insert
			}
			
			sql.delete(namespace + "delClensAccinvn"); //재고 0인 테이블 삭제
		}else{
			result = 444;
		}
		return result;
}
	
	
	@Override
	public Map getMtrl(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List mtrlList = sql.selectList(namespace + "getMtrlListLens", prdctVo);
		resultMap.put("mtrlList", mtrlList);
		return resultMap;
	}

	@Override
	public Map getFunction(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tyList = sql.selectList(namespace +"getFunction", prdctVo);
		resultMap.put("tyList", tyList);
		return resultMap;
	}


	@Override
	public Map getPrdctListLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List PrdctList = sql.selectList(namespace + "getPrdctListLens", prdctVo);
		resultMap.put("brandList", PrdctList);
		return resultMap;
	}
	
	@Override
	public Map getPrdctListClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List PrdctList = sql.selectList(namespace + "getPrdctListClens", prdctVo);
		resultMap.put("brandList", PrdctList);
		return resultMap;
	}

	@Override
	public Map getClensList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List PrdctList = sql.selectList(namespace + "getClensList", prdctVo);
		resultMap.put("brandList", PrdctList);
		return resultMap;
	}
	
	@Override
	public Map getEtcList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List PrdctList = sql.selectList(namespace + "getEtcList", prdctVo);
		resultMap.put("brandList", PrdctList);
		return resultMap;
	}
	
	@Override
	public Map getLensData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List rateList = sql.selectList(namespace +"getLensData", prdctVo);
		resultMap.put("rateList", rateList);
		return resultMap;
	}


	@Override
	public PrdctVo getPrdctPrc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo)sql.selectOne(namespace + "getPrdctPrc", prdctVo);
		return prdct;
	}
	@Override
	public PrdctVo getClensPrc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo)sql.selectOne(namespace + "getClensPrc", prdctVo);
		return prdct;
	}

	
	@Override
	public PrdctVo getClensAccPrc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		PrdctVo prdct = (PrdctVo)sql.selectOne(namespace + "getClensAccPrc", prdctVo);
		return prdct;
	}
	
	@Override
	public String addInvnLensData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String exist = (String)sql.selectOne(namespace + "getInvnLens", prdctVo); //해당 제품 제고 여부 체크
			if(exist!=null){//재고가 있을 경우
				prdctVo.setInvnId(exist);//invn Id  
				sql.update(namespace + "updateLensInvn", prdctVo); //인벤 수정
			}else{//제품이 없을 경우
				sql.selectList(namespace + "addInvnLensData", prdctVo); //인벤 등록
			}
			
			sql.selectList(namespace + "addInvnLensHistData", prdctVo); //인벤히스토리 등록
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		return result;
	}


	@Override
	public String addInvnClensData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String exist = (String)sql.selectOne(namespace + "getInvnClens", prdctVo); //해당 제품 제고 여부 체크
			if(exist!=null){//재고가 있을 경우
				prdctVo.setInvnId(exist);//invn Id  
				sql.update(namespace + "updateClensInvn", prdctVo); //인벤 수정
			}else{//제품이 없을 경우
				sql.selectList(namespace + "addInvnClensData", prdctVo); //인벤 등록
			}
			
			sql.selectList(namespace + "addInvnClensHistData", prdctVo); //인벤히스토리 등록
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		return result;
	}
	
	
	@Override
	public String addInvnClensAccData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			String exist = (String)sql.selectOne(namespace + "getInvnClensAcc", prdctVo); //해당 제품 제고 여부 체크
			if(exist!=null){//재고가 있을 경우
				prdctVo.setInvnId(exist);//invn Id  
				sql.update(namespace + "updateClensAccInvn", prdctVo); //인벤 수정
			}else{//제품이 없을 경우
				sql.selectList(namespace + "addInvnClensAccData", prdctVo); //인벤 등록
			}
			
			sql.selectList(namespace + "addInvnClensAccHistData", prdctVo); //인벤히스토리 등록
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		return result;
	}
	
	@Override
	public Map getInvnLensList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List invnList = sql.selectList(namespace+"getInvnLensList", prdctVo);
		resultMap.put("invnList", invnList);
		return resultMap;
	}
	
	@Override
	public Map getInvnClensAccList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List invnList = sql.selectList(namespace+"getInvnClensAccList", prdctVo);
		resultMap.put("invnList", invnList);
		return resultMap;
	}
	
	@Override
	public Map getInvnClensList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List invnList = sql.selectList(namespace+"getInvnClensList", prdctVo);
		resultMap.put("invnList", invnList);
		System.out.println("clensInvn : " + invnList);
		return resultMap;
	}


	@Override
	public String addLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkLensTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewComLens", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			sql.insert(namespace +"addReqeustlens", prdctVo);
			result = "success";
			//sql.selectList(namespace + "addInvnLensData", prdctVo); //인벤 등록
			//sql.selectList(namespace + "addInvnLensHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}
	
	@Override
	public String addClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkClensTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist|null";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewComClens", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			sql.insert(namespace +"addReqeustClens", prdctVo);
			result = "success|" +prdctId;
			
			//sql.selectList(namespace + "addInvnClensData", prdctVo); //인벤 등록
			//sql.selectList(namespace + "addInvnClensHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}

	@Override
	public String addClensAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkClensAccTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist|null";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewComClensAcc", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			sql.insert(namespace +"addReqeustAcc", prdctVo);
			result = "success|" +prdctId;
			//sql.selectList(namespace + "addInvnClensAccData", prdctVo); //인벤 등록
			//sql.selectList(namespace + "addInvnClensAccHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}
	
	
	@Override
	public String addEtc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkEtcTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist|null";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewComEtc", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			sql.insert(namespace +"addReqeustEtc", prdctVo);
			result = "success|" +prdctId;
			//sql.selectList(namespace + "addInvnClensAccData", prdctVo); //인벤 등록
			//sql.selectList(namespace + "addInvnClensAccHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}
	
	
	@Override
	public Map getClensTyList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tyList = sql.selectList(namespace + "getClensTyList", prdctVo);
		resultMap.put("tyList", tyList);
		return resultMap;
	}
	
	@Override
	public Map getClensTyList2(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tyList = sql.selectList(namespace + "getClensTyList2", prdctVo);
		resultMap.put("tyList", tyList);
		return resultMap;
	}

	@Override
	public Map getNewClensTyList2(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tyList = sql.selectList(namespace + "getNewClensTyList2", prdctVo);
		resultMap.put("tyList", tyList);
		return resultMap;
	}
	

	@Override
	public Map getPrdctUnit(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List unitList = sql.selectList(namespace + "getPrdctUnit", prdctVo);
		resultMap.put("unitList", unitList);
		return resultMap;
	}


	@Override
	public String getAccId(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String prdctId = (String)sql.selectOne(namespace + "getAccId", prdctVo);
		System.out.println("newPrdctID: " +prdctId);
		return prdctId;
	}




	@Override
	public String addReqeustFrame(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String) sql.selectOne(namespace + "chkRequestFrame", prdctVo);
		if(exist!=null){
			result = "exist|null";
		}else{
			try{
				sql.insert(namespace +"addReqeustFrame", prdctVo);
				result = "ok|" +prdctVo.getPrdctId();
			}catch(Exception e){
				e.printStackTrace();
				result = "fail|null";
			}
		}
		return result;
	}

	@Override
	public String addReqeustlens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String) sql.selectOne(namespace + "chkRequestLens", prdctVo);
		if(exist!=null){
			result = "exist";
		}else{
			try{
				sql.insert(namespace +"addReqeustlens", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}
		return result;
	}
	@Override
	public String addReqeustClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String) sql.selectOne(namespace + "chkRequestClens", prdctVo);
		if(exist!=null){
			result = "exist";
		}else{
			try{
				sql.insert(namespace +"addReqeustClens", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}
		return result;
	}
	@Override
	public String addReqeustAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String) sql.selectOne(namespace + "chkRequestAcc", prdctVo);
		if(exist!=null){
			result = "exist";
		}else{
			try{
				sql.insert(namespace +"addReqeustAcc", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}
		return result;
	}

	@Override
	public String addReqeustEtc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		String exist = (String) sql.selectOne(namespace + "chkRequestEtc", prdctVo);
		if(exist!=null){
			result = "exist";
		}else{
			try{
				sql.insert(namespace +"addReqeustEtc", prdctVo);
				result = "ok";
			}catch(Exception e){
				e.printStackTrace();
				result = "fail";
			}
		}
		return result;
	}
	@Override
	public Map getFrame(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List frameList = sql.selectList(namespace + "getFrame", prdctVo);
		resultMap.put("listFrame", frameList);
		return resultMap;
	}


	@Override
	public PrdctVo getComPrdctEditForm(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		prdctVo = (PrdctVo)sql.selectOne(namespace + "getComPrdctEditForm",prdctVo);
		return prdctVo;
	}


	@Override
	public String modifyComPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		
		try{
			sql.update(namespace + "modifyComPrdct", prdctVo);
			result = "success";
		}catch (Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public Map getComPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getComPrdct", prdctVo);
		resultMap.put("listPrdct", listPrdct);
		return resultMap;
	}


	@Override
	public String addNewComPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		
		String exist = (String)sql.selectOne(namespace + "getComFrame", prdctVo);
		if(exist!=null){
			result = "duple|null";
		}else{
			sql.insert(namespace + "addNewComPrdct", prdctVo); //새 제품 등록
			sql.insert(namespace + "addReqeustFrame", prdctVo); //requestTable에 등록
			result = "ok|" + prdctVo.getPrdctId();
		}
		return result;
	}


	@Override
	public String allowPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "allowPrdct", prdctVo);
			sql.update(namespace + "modifyTrdePrc", prdctVo);
			prdctVo.setOldPrdctId(prdctVo.getId());
			Integer comTy = prdctVo.getComTy();
			Integer prdctId = (Integer) sql.selectOne(namespace + "getPrdctIdByClr", prdctVo);
			if(prdctId!=null){
				prdctVo.setPrdctId(prdctId);
				sql.update(namespace + "updatePrdctPrc", prdctVo);
				result = "success";
			}else{
				PrdctVo comPrdctVo = (PrdctVo) sql.selectOne(namespace + "getComPrdctIdByClr", prdctVo);
				if(comTy==1){
					sql.insert(namespace + "addPrdct", comPrdctVo);
					prdctVo.setPrdctId(comPrdctVo.getPrdctId());
					sql.update(namespace + "updatePrdctPrc", prdctVo);
					sql.update(namespace + "insertPrdctId", prdctVo);
				}else if(comTy==2){
					sql.insert(namespace + "addNewLens", comPrdctVo);
					prdctVo.setPrdctId(comPrdctVo.getPrdctId());
					sql.update(namespace + "updatePrdctPrc", prdctVo);
					sql.update(namespace + "insertPrdctId", prdctVo);
				}else if(comTy==3){
					sql.insert(namespace + "addNewClens", comPrdctVo);
					prdctVo.setPrdctId(comPrdctVo.getPrdctId());
					sql.update(namespace + "updatePrdctPrc", prdctVo);
					sql.update(namespace + "insertPrdctId", prdctVo);
				}else if(comTy==4){
					sql.insert(namespace + "addNewClensAcc", comPrdctVo);
					prdctVo.setPrdctId(comPrdctVo.getPrdctId());
					sql.update(namespace + "updatePrdctPrc", prdctVo);
					sql.update(namespace + "insertPrdctId", prdctVo);
				}else if(comTy==5){
					sql.insert(namespace + "addNewComEtc", comPrdctVo);
					prdctVo.setPrdctId(comPrdctVo.getPrdctId());
					sql.update(namespace + "updatePrdctPrc", prdctVo);
					sql.update(namespace + "insertPrdctId", prdctVo);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return null;
	}
	
	@Override
	public String rejectPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "rejectPrdct", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return null;
	}


	@Override
	public String changeComPrdctColor(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		prdctVo.setOldPrdctId(prdctVo.getPrdctId().toString()); 
		String exist = (String) sql.selectOne(namespace + "getPrdctColors", prdctVo);//동일 제품 색상 검색
		
		if(exist!=null){ //존재 
			prdctVo.setPrdctId(Integer.parseInt(exist));
			
			sql.update(namespace + "updateComPrdctColor", prdctVo); //제품 id, 색상 변경
			sql.update(namespace + "updatePrdctImg", prdctVo); //still img prdctId 변경
		}else{ //x경
			sql.insert(namespace + "addComFrame", prdctVo);
			sql.update(namespace + "updateComPrdctColor", prdctVo); //제품 id, 색상 변경
			sql.update(namespace + "updatePrdctImg", prdctVo); //still img prdctId 변경
		}
		return null;
	}


	@Override
	public String changeBrandName(BrandVo brandVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		
		try{
			sql.update(brandnamespace + "changeBrandName", brandVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		
		return result;
	}


	@Override
	public String changePrdctName(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		
		try{
			sql.update(namespace + "changePrdctName", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		
		
		return result;
	}


	@Override
	public String delRequestPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.delete(namespace + "delRequestPrdct", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}
	
	@Override
	public Map getOrderList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getOrderList", prdctVo);
		resultMap.put("listPrdct", listPrdct);
		return resultMap;
	}

	@Override
	public Map getDeliverList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List listPrdct = sql.selectList(namespace + "getDeliverList", prdctVo);
		resultMap.put("listPrdct", listPrdct);
		return resultMap;
	}

	@Override
	public String deliverPrdct(PrdctVo prdctVo) {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "deliverPrdct", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public String getPrdctCnt(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = (String) sql.selectOne(namespace + "getPrdctCnt", prdctVo); 
		return result;
	}


	@Override
	public String addNewClensTy1(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.insert(namespace + "addNewClensTy1", prdctVo);
			String ty1Id = prdctVo.getTyId1();
			result = "success|" + ty1Id;
		}catch(Exception e){
			e.printStackTrace();
			result = "fail|null";
		}
		return result;
	}

	@Override
	public String addNewClensTy2(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.insert(namespace + "addNewClensTy2", prdctVo);
			String ty1Id = prdctVo.getTyId1();
			result = "success|" + ty1Id;
		}catch(Exception e){
			e.printStackTrace();
			result = "fail|null";
		}
		return result;
	}
	@Override
	public Map getNewTyList(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tyList = sql.selectList(namespace + "getNewTyList", prdctVo);
		resultMap.put("tyList", tyList);
		return resultMap;
	}


	@Override
	public String deleteDeliverData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.delete(namespace + "deleteDeliverData", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public String modifyLensRate(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			prdctVo.setOldPrdctId(prdctVo.getPrdctId().toString());
			prdctVo.setPrdctId((Integer)sql.selectOne(namespace + "getLensRate", prdctVo));
			sql.update(namespace + "modifyLensRate", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public String modifyClensData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyClensData", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public String chagneAccUnit(PrdctVo prdctVo) {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			prdctVo.setOldPrdctId(prdctVo.getPrdctId().toString());
			prdctVo.setPrdctId((Integer)sql.selectOne(namespace + "getAccUnitId", prdctVo));
			sql.update(namespace + "changeAccUnit", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public Map srchPrdct(PrdctVo prdctVo) throws Exception {
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List brandList=sqlSession.selectList(namespace+"srchPrdct", prdctVo);
		resultMap.put("brandList", brandList);
		
		return resultMap;
	}
	
	@Override
	public String addShopLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkLensShopTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewLens", prdctVo);
			sql.selectList(namespace + "addInvnLensData", prdctVo); //인벤 등록
			sql.selectList(namespace + "addInvnLensHistData", prdctVo); //인벤히스토리 등록
			result = "success";
		}
		return result;
	}
	
	@Override
	public String addShopClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkClensShopTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist|null";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewClens", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			result = "success|" +prdctId;
			
			sql.selectList(namespace + "addInvnClensData", prdctVo); //인벤 등록
			sql.selectList(namespace + "addInvnClensHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}
	@Override
	public String addShopClensAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		System.out.println("new Lens :" +prdctVo.toString());
		String result = "";
		String exist = (String)sql.selectOne(namespace + "ChkClensAccShopTbl", prdctVo);//동일한 이름의 제품 유뮤 체크
		if(exist!=null){//제품이 있으면
			result = "exist|null";
		}else{ //없으면 등록
			sql.insert(namespace + "addNewClensAcc", prdctVo);
			Integer prdctId = prdctVo.getPrdctId();
			result = "success|" +prdctId;
			sql.selectList(namespace + "addInvnClensAccData", prdctVo); //인벤 등록
			sql.selectList(namespace + "addInvnClensAccHistData", prdctVo); //인벤히스토리 등록
		}
		return result;
	}
	
	
	@Override
	public Map getReceipt(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getReceipt", prdctVo);
		resultMap.put("listRecepit", receitList);
		return resultMap;
	}
	
	
	@Override
	public Map getReceiptLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getReceiptLens", prdctVo);
		resultMap.put("listRecepitLens", receitList);
		return resultMap;
	}
	
	@Override
	public Map getReceiptClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getReceiptClens", prdctVo);
		resultMap.put("listRecepitClens", receitList);
		return resultMap;
	}
	
	@Override
	public Map getReceiptAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getReceiptAcc", prdctVo);
		resultMap.put("listRecepitAcc", receitList);
		return resultMap;
	}
	
	@Override
	public Map getReceiptEtc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getReceiptEtc", prdctVo);
		resultMap.put("listRecepitEtc", receitList);
		return resultMap;
	}
	
	@Override
	public Map getRtnFrame(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getRtnFrame", prdctVo);
		resultMap.put("getRtnFrame", receitList);
		return resultMap;
	}
	
	@Override
	public Map getRtnLens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getRtnLens", prdctVo);
		resultMap.put("getRtnLens", receitList);
		return resultMap;
	}
	
	@Override
	public Map getRtnClens(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getRtnClens", prdctVo);
		resultMap.put("getRtnClens", receitList);
		return resultMap;
	}
	
	@Override
	public Map getRtnAcc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getRtnAcc", prdctVo);
		resultMap.put("getRtnAcc", receitList);
		return resultMap;
	}
	
	@Override
	public Map getRtnEtc(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List receitList = sql.selectList(namespace + "getRtnEtc", prdctVo);
		resultMap.put("getRtnEtc", receitList);
		return resultMap;
	}
	
	
	@Override
	public Map getReceiptHeader(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List shopData = sql.selectList(namespace + "getReceiptHeader", prdctVo);
		resultMap.put("shopData", shopData);
		return resultMap;
	}


	@Override
	public String addNewLensTy(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.insert(namespace + "addNewLensTyId", prdctVo);
			result = "success|" + prdctVo.getTyId1();
		}catch(Exception e){
			e.printStackTrace();
			result = "fail|null";
		}
		return result;
	}


	@Override
	public Map showAllLensType(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		List listTy = sql.selectList(namespace + "showAllLensType", prdctVo);
		Map resultMap = new HashMap();
		resultMap.put("tyList", listTy);
		
		return resultMap;
	}


	@Override
	public String modifyPrdctCnt(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "modifyPrdctCnt", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public PrdctVo getRtnMsg(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		prdctVo = (PrdctVo)sql.selectOne(namespace + "getRtnMsg", prdctVo);
		return prdctVo;
	}


	@Override
	public String allowRtn(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		try{
			sql.update(namespace + "allowRtn", prdctVo);
			result = "success";
		}catch(Exception e){
			e.printStackTrace();
			result = "fail";
		}
		return result;
	}


	@Override
	public String modifyShopInvn(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		String result = "";
		
		Integer cnt = prdctVo.getCnt();
		String shopId = prdctVo.getShopId();
		Integer comTy = prdctVo.getComTy();
		Integer datetime = prdctVo.getDatetime();
		Integer prdctId = prdctVo.getPrdctId();
		
		prdctVo = (PrdctVo) sql.selectOne(namespace + "getComPrdctForRtn", prdctVo); // id로 com 테이블의 prdct속성 출력
		prdctVo.setPrdctId(prdctId);
		prdctVo.setCnt(cnt);
		prdctVo.setShopId(shopId);
		prdctVo.setComTy(comTy);
		prdctVo.setDatetime(datetime);
		String exist = (String) sql.selectOne(namespace + "srchPrdctTlb", prdctVo); // prdct 테이블에 해당 prdct 유무 체크
		
		if(exist!=null){ 
			prdctVo.setPrdctId(Integer.parseInt(exist));
			String invnId = (String) sql.selectOne(namespace + "srchPrdctShopInvn", prdctVo);//invn 테이블에 해당 prdct 등록 유무 체크
			prdctVo.setInvnId(invnId);
			sql.update(namespace + "modifyInvn", prdctVo); //invn 수량 변경
			prdctVo.setInvnTyCd("00900003");
			sql.insert(namespace + "addInvnHist", prdctVo); // invn_hist추가
		}
		
		return result;
	}
	
	@Override
	public Map selectCom(PrdctVo prdctVo) throws Exception {
		
		SqlSession sql = getSqlSession();
		List <PrdctVo> listCom = sql.selectList(namespace + "selectCom", prdctVo);
		Map resultMap = new HashMap();
		resultMap.put("listCom", listCom);
		return resultMap;
	}


	@Override
	public Map getTradeData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tradeList = sql.selectList(namespace + "getTradeData", prdctVo);
		resultMap.put("trdeList", tradeList);
		return resultMap;
	}
	
	@Override
	public Map getTradeGroupData(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tradeList = sql.selectList(namespace + "getTradeGroupData", prdctVo);
		resultMap.put("trdeList", tradeList);
		return resultMap;
	}


	@Override
	public Map getTradeListAll(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tradeList = sql.selectList(namespace + "getTradeListAll", prdctVo);
		resultMap.put("trdeList", tradeList);
		return resultMap;
	}


	@Override
	public Map getTradeListAllC(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		Map resultMap = new HashMap();
		List tradeList = sql.selectList(namespace + "getTradeListAllC", prdctVo);
		resultMap.put("trdeList", tradeList);
		return resultMap;
	}


	@Override
	public Map getTradeDataCsv(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		List trdeList =sql.selectList(namespace +"getTradeDataCsv", prdctVo	);
		Map resultMap = new HashMap();
		resultMap.put("trdeList", trdeList);
		return resultMap;
	}
	
	@Override
	public Map getTradeDataCsvS(PrdctVo prdctVo) throws Exception {
		SqlSession sql = getSqlSession();
		List trdeList =sql.selectList(namespace +"getTradeDataCsvS", prdctVo	);
		Map resultMap = new HashMap();
		resultMap.put("trdeList", trdeList);
		return resultMap;
	}
}