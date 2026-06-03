package com.gallery.fileserver;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;


public interface FileServerService {
	String addFileServer(FileServerVo fileServerVo) throws Exception;
	void modifyFileServer(FileServerVo fileServerVo) throws Exception;
	Map pagedListFileServerData(FileServerVo fileServerVo) throws Exception;
	FileServerVo selectFileServer(FileServerVo fileServerVo) throws Exception;
	String removeFileServer(FileServerVo fileServerVo) throws Exception;
	String createCoupon(FileServerVo fileVo)throws Exception;
	String createCouponForLunar(FileServerVo fileVo)throws Exception;
	Map getCouponList(FileServerVo fileVo)throws Exception;
}
