package com.gallery.point;

import java.util.Map;


public interface PointService {
//    @Deprecated
//	String addBalancePoint() throws Exception;
//	@Deprecated
//	PointVo selectPointByFmlyCd(PointVo pointVo) throws Exception;
	PointVo selectPointByCstmrCd(PointVo pointVo) throws Exception;
	String addPointHist(PointVo pointVo) throws Exception;
	Map listPointHistory(PointVo pointVo) throws Exception;
	String removePointHist(PointVo pointVo) throws Exception;
//	@Deprecated
//	Map listShopMPointHistMonth(PointVo pointVo) throws Exception;
	String editMPointCstmrHst(PointVo pointVo);
	String editPPointCstmrHst(PointVo pointVo);
	String removePointAllSale(PointVo pointVo) throws Exception;
	String mergePoint2FmlyCd(PointVo pointVo) throws Exception;
}
