package com.gallery.point;

import java.util.Map;


public interface PointService {
    @Deprecated
    String addBalancePoint() throws Exception;
    String addPointHist(PointVo pointVo) throws Exception;
    @Deprecated
    Map listPointHistory(PointVo pointVo) throws Exception;
    Map listShopMPointHistMonth(PointVo pointVo) throws Exception;
    Map listPointEuTable() throws Exception;
    Map listPointESumTable() throws Exception;
    Map listPointUeTable() throws Exception;
    Map listPointUSumTable() throws Exception;
    String expirePoint(PointVo inputVo);
}
