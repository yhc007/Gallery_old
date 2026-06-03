package com.gallery.web.staff.service;

import java.io.File;
import java.io.FileOutputStream;
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
import org.springframework.web.multipart.MultipartFile;

import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.prdct.service.PrdctService;
import com.gallery.web.sale.domain.SalesVo;
import com.gallery.web.staff.domain.StaffVo;

@Service
@Repository
public class StaffServiceImpl extends SqlSessionDaoSupport implements StaffService{

	private final static String namespace= "com.gallery.staff.";
	
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public String addStaffPhotos(StaffVo staffVo,FileUploadForm uploadForm) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		MultipartFile ufile=uploadForm.getFiles();
		String root = "/usr/local/tomcat7.0/webapps/media";
	    String dpath =null;
	    
	    dpath = File.separator+"staff"+File.separator+staffVo.getStaffId();
		
	    
	    File dir=new File(root+dpath);
	    if(! dir.exists())
	     dir.mkdirs();
	    String fpath=File.separator+ufile.getOriginalFilename();
	    if(!ufile.isEmpty()){
		     try{
			     byte[] bytes=ufile.getBytes();
			     FileOutputStream fos = new FileOutputStream(root+dpath+fpath);
			     fos.write(bytes);
			     fos.close();
		     }catch(Exception e){
		    	 e.printStackTrace();
		    	 return "fail";
		     }

	    }
	    
	    staffVo.setImgPath(dpath+fpath);
	    
    	sqlSession.update(namespace+"updateImgPath", staffVo);
	    
		return "addsuccess";
	}
	
	@Override
	@Transactional
	public String addStaff(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"addStaff", staffVo);
		return staffVo.getStaffId().toString();
	}

	@Override
	@Transactional
	public void modifyStaff(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"modifyStaff", staffVo);
		
	}

	
	@Override
	public Map pagedListStaffData(StaffVo staffVo, Integer shopId) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap(); 
		System.out.println(shopId);
		staffVo.setShopId((Integer)sqlSession.selectOne(namespace + "getShopId", shopId));
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListStaffCount", staffVo);
		
		System.out.println(staffVo.getShopId());
		List staffList=sqlSession.selectList(namespace+"pagedListStaff", staffVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(staffVo.getCurrentPage());
		paging.setPageSize(staffVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listStaff", staffList);
		return resultMap;
	}
	@Override
	public Map listStaffData(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List staffList=sqlSession.selectList(namespace+"listStaff", staffVo);
		resultMap.put("listStaff", staffList);
		
		return resultMap;
	}
	

	@Override
	public StaffVo selectStaff(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (StaffVo)sqlSession.selectOne(namespace+"getStaff", staffVo);
	}

	@Override
	public String removeStaff(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.delete(namespace+"removeStaff", staffVo);
		return "success";
	}
	
	@Override
	public String removeStaffPhoto(StaffVo staffVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(namespace+"removeImgPath", staffVo);
		return "success";
	}
	

	@Override
	public void mListStaffData(StaffVo staffVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List staffList=sqlSession.selectList(namespace+"mlistStaff",staffVo);
		resultMap.put("listStaff", staffList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	@Override
	public void mListStaffDataForDsply(StaffVo staffVo,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		
		
		
		Map resultMap=new HashMap();
		List staffList=sqlSession.selectList(namespace+"mlistStaffForDsply",staffVo);
		resultMap.put("listStaff", staffList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}

}
