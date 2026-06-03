package com.gallery.web.media.service;

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
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.media.domain.MediaVo;

@Service
@Repository
public class MediaServiceImpl extends SqlSessionDaoSupport implements MediaService {
private final static String namespace= "com.gallery.media.";
	
	@Override
	@Transactional
	public String addMedia(MediaVo mediaVo,FileUploadForm uploadForm) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		MultipartFile ufile=uploadForm.getFiles();
		//String root = "/usr/local/tomcat7/webapps/media";
		String root = "http://s4dm.com:8080/usr/local/tomcat/webapps/media";
	    String dpath =null;
	    
	    if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
	    	dpath = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd();
		}else{
			dpath = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd()+File.separator+mediaVo.getColor();
		}
	    
	    File dir=new File(root+dpath);
	    if(! dir.exists()){
	     dir.mkdirs();
	    }
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
	    mediaVo.setMediaName(ufile.getOriginalFilename());
	    mediaVo.setMediaPath(dpath+fpath);
	    
	    if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
	    	sqlSession.insert(namespace+"addMedia", mediaVo);
		}else{
			Integer count=(Integer) sqlSession.selectOne(namespace+"getStillCount", mediaVo);
			if(count>0){
				sqlSession.insert(namespace+"updateStill", mediaVo);
			}else{
				sqlSession.insert(namespace+"addStill", mediaVo);
			}
		}
	    
		return "addsuccess";
	}
	
	@Override
	@Transactional
	public String ComAddMedia(MediaVo mediaVo,FileUploadForm uploadForm) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		MultipartFile ufile=uploadForm.getFiles();
		String root = "/usr/local/tomcat7/webapps/media";
	    String dpath =null;
	    
	    if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
	    	dpath = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd();
		}else{
			dpath = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd()+File.separator+mediaVo.getColor();
		}
	    
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
	    mediaVo.setMediaName(ufile.getOriginalFilename());
	    mediaVo.setMediaPath(dpath+fpath);
	    
	    if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
	    	sqlSession.insert(namespace+"ComAddMedia", mediaVo);
		}else{
			Integer count=(Integer) sqlSession.selectOne(namespace+"ComGetStillCount", mediaVo);
			if(count>0){
				sqlSession.insert(namespace+"ComUpdateStill", mediaVo);
			}else{
				sqlSession.insert(namespace+"ComAddStill", mediaVo);
			}
		}
	    
		return "addsuccess";
	}


	
	@Override
	@Transactional
	public String modifyMediaCode(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Integer count=(Integer) sqlSession.selectOne(namespace+"ComGetVideoCount", mediaVo);
		if(count==0){
			sqlSession.update(namespace+"ComAddVideoCode", mediaVo);
		}else{
			sqlSession.update(namespace+"ComModifyVideoCode", mediaVo);
		}
		return "success";
		
	}
	
	@Override
	@Transactional
	public void modifyMedia(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		sqlSession.insert(namespace+"ComModifyMedia", mediaVo);
		
	}

	
	
	@Override
	public Map pagedListMediaData(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List mediaList=new ArrayList();
		if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
			mediaList=sqlSession.selectList(namespace+"ComListMedia", mediaVo);
		}else{
			mediaList=sqlSession.selectList(namespace+"ComListStill", mediaVo);
		}
		resultMap.put("listMedia", mediaList);
		
		return resultMap;
	}

	@Override
	public MediaVo selectMedia(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (MediaVo)sqlSession.selectOne(namespace+"ComGetMedia", mediaVo);
	}

	@Override
	public MediaVo selectVideoCd(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		MediaVo media=(MediaVo)sqlSession.selectOne(namespace+"ComGetVideoCd", mediaVo);
		return media;
	}

	@Override
	public String selectRotatePath(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		mediaVo.setMediaTyCd(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE);
		MediaVo getMedia= (MediaVo)sqlSession.selectOne(namespace+"ComGetMediaRotate", mediaVo);
		if(getMedia==null){
			return null;
		}
		String opath=getMedia.getMediaPath();
		String path=getMedia.getUrlStr();
		path+=opath.substring(0,opath.lastIndexOf("-") );
		path+="-#";
		path+=opath.substring(opath.lastIndexOf("."), opath.length());
		return path;
	}
	
	@Override
	@Transactional
	public MediaVo removeMedia(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		 if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
			 sqlSession.delete(namespace+"ComRemoveMedia", mediaVo);
		}else{
			sqlSession.delete(namespace+"ComRemoveStill", mediaVo);
		}

		 
		String root = "/usr/local/tomcat7/webapps/media";
		String path= null;

		if(mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)){
			path = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd()+File.separator+mediaVo.getMediaName();
		}else{
			path = File.separator+mediaVo.getPrdctId()+File.separator+mediaVo.getMediaTyCd()+File.separator+mediaVo.getColor()+File.separator+mediaVo.getMediaName();
		}

		
		logger.info("delete "+path);

		File f=new File(root+path);

		if(f.isFile()){
			f.delete();
		}
		return null;
	}
	
	public void responseMediaData(MediaVo mediaVo, HttpServletResponse response) throws Exception {

		
		Map frameMap=new HashMap();
		
		List list=new ArrayList();
		List mediaList=mListMediaData(mediaVo);
		if(mediaList.size()>0){
			frameMap.put("file_server_url",((MediaVo)mediaList.get(0)).getUrlStr());
		}
		for(int i=0;i<mediaList.size();i++){
			Map map=new HashMap();
			map.put("id", ((MediaVo)mediaList.get(i)).getMediaId());
			map.put("path", ((MediaVo)mediaList.get(i)).getMediaPath());
			list.add(map);
		}
		frameMap.put("images", list);
		
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer=response.getWriter();
		String str="";
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
	
	
	public List mListMediaData(MediaVo mediaVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return sqlSession.selectList(namespace+"ComMListMedia", mediaVo);
	}
}
