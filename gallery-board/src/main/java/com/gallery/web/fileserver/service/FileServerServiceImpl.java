package com.gallery.web.fileserver.service;

import java.io.PrintWriter;
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
import com.gallery.web.fileserver.domain.FileServerVo;

@Service
@Repository
public class FileServerServiceImpl extends SqlSessionDaoSupport implements FileServerService{
	private final static String namespace= "com.gallery.fileserver.";
	
	@Override
	@Transactional
	public String addFileServer(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		int cnt=(Integer)sqlSession.selectOne(namespace+"countFileServer", fileServerVo);
		if(cnt==0){
			if(fileServerVo.getIsdefault().equals("1")){
				dropDefault();
			}
			sqlSession.insert(namespace+"addFileServer", fileServerVo);
			return "addsuccess";
		}else{
			return "duple";
		}
	}

	@Override
	@Transactional
	public void modifyFileServer(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		if(fileServerVo.getIsdefault().equals("1")){
			dropDefault();
		}
		sqlSession.insert(namespace+"modifyFileServer", fileServerVo);
		
	}
	
	private void dropDefault() throws Exception {
		SqlSession sqlSession=getSqlSession();
		sqlSession.update(namespace+"dropDefault");
	}

	@Override
	public Map pagedListFileServerData(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		
		int pageCount=(Integer)sqlSession.selectOne(namespace+"pagedListFileServerCount", fileServerVo);
		List fileserverList=sqlSession.selectList(namespace+"pagedListFileServer", fileServerVo);
		PagingVo paging=new PagingVo();
		paging.setCurrentPage(fileServerVo.getCurrentPage());
		paging.setPageSize(fileServerVo.getPageSize());
		paging.setTotalSize(pageCount);
		
		resultMap.put("pv", paging);
		resultMap.put("listFileServer", fileserverList);
		return resultMap;
	}
	@Override
	public Map listFileServerData(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List fileserverList=sqlSession.selectList(namespace+"listFileServer", fileServerVo);
		resultMap.put("listFileServer", fileserverList);
		
		return resultMap;
	}

	@Override
	public FileServerVo selectFileServer(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (FileServerVo)sqlSession.selectOne(namespace+"getFileServer", fileServerVo);
	}

	@Override
	public String removeFileServer(FileServerVo fileServerVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.delete(namespace+"removeFileServer", fileServerVo);
		return "success";
	}

	@Override
	public void mListFileServerData(HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List fileServerList=sqlSession.selectList(namespace+"mlistFileServer");
		resultMap.put("listFileServer", fileServerList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}
}
