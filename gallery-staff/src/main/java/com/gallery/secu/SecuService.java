package com.gallery.secu;

public interface SecuService {
//	void test (SecuVo secuVo, HttpServletResponse response) throws Exception;
//	String checkSn(SecuVo secuVo) throws Exception;
//	String regMac(SecuVo secuVo) throws Exception;
	String checkMac(SecuVo secuVo) throws Exception;
	String checkDvc(SecuVo secuVo) throws Exception;
}
