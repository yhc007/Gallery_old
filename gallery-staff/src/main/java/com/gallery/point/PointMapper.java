package com.gallery.point;

import com.gallery.cstmr.CstmrVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface PointMapper {
    void tradePointShop(HashMap value);
    void createCoupon(HashMap value);
    void modifyFmlyCdbyCstmrCd(CstmrVo value);
    void tradePointShop(CstmrVo value);
    void listFamilyCd(PointVo value);
    void calcBalancePoint(PointVo value);
    void addPointHist(PointVo value);
    void removePointHist(PointVo value);
    void removePointCstmrHst(PointVo value);
    void removePointCstmrHstAllStat(PointVo value);
    void removePointAllSale(PointVo value);
    void modifyPointCstmrHst(PointVo value);
    void mergePoint2FmlyCd(PointVo value);
    void addPointCstmrHst(PointVo value);
    Integer checkPoint(PointVo value);
    Integer getPointCstmrHst(PointVo value);
    PointVo selectFmlyCdbyPointCd(PointVo value);
    PointVo pointByFmlyCd(PointVo value);
    List<PointVo> listPointHist(PointVo value);
    PointVo listPointHistMonth(PointVo value);
    PointVo listPointM(PointVo value);
    PointVo listPointUser(PointVo value);
}
