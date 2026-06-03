package com.gallery.web.fileserver.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.fileserver.domain.FileServerVo;


public interface FileServerService {
	public String addFileServer(FileServerVo fileServerVo) throws Exception;
	public void modifyFileServer(FileServerVo fileServerVo) throws Exception;
	public Map pagedListFileServerData(FileServerVo fileServerVo) throws Exception;
	public Map listFileServerData(FileServerVo fileServerVo) throws Exception;
	public FileServerVo selectFileServer(FileServerVo fileServerVo) throws Exception;
	public String removeFileServer(FileServerVo fileServerVo) throws Exception;
	public void mListFileServerData(HttpServletResponse response) throws Exception;
	
}
