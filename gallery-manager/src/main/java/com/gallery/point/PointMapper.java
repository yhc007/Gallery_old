package com.gallery.point;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface PointMapper {
    List<PointVo> listFamilyCd();
    List<PointVo> listPointHistMonthly();
    List<PointVo> getEuTable();
    List<PointVo> getUeTable();
    List<PointVo> getESumTable();
    List<PointVo> getUSumTable();
    void modifyUShopId();
    void removePointYear();
    void modifyEShopId();
    void cleanPointTrade();
    void calcBalancePoint(PointVo value);
    void expirePoint(PointVo value);
    void calcExpirePoint(PointVo value);
    void createPointMonthly(PointVo value);
    void removePointMonthly();
    void addPointHist(PointVo value);
    void removePointTrade();
    void tradePointShop(HashMap value);
    List<PointVo> listPointHist(PointVo value);
    List<PointVo> listPointM(PointVo value);
}
