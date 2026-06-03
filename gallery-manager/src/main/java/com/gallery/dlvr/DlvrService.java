package com.gallery.dlvr;

import java.util.Map;


public interface DlvrService {
    @Deprecated
	String addDlvr(DlvrVo dlvrVo) throws Exception;
    @Deprecated
	String removeDlvr(DlvrVo dlvrVo) throws Exception;
    @Deprecated
	void modifyDlvr(DlvrVo dlvrVo) throws Exception;
	Map listDlvrData(DlvrVo dlvrVo) throws Exception;
    @Deprecated
	DlvrVo selectDlvr(DlvrVo dlvrVo) throws Exception;
}
