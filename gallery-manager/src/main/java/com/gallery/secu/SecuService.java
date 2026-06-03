package com.gallery.secu;

public interface SecuService {
    @Deprecated
	String checkSn(SecuVo secuVo) throws Exception;
    @Deprecated
	String regMac(SecuVo secuVo) throws Exception;
	String checkMac(SecuVo secuVo) throws Exception;
	String checkDvc(SecuVo secuVo) throws Exception;
}
