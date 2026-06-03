package com.gallery.check;

import com.gallery.brand.BrandVo;
import com.gallery.cstmr.CstmrVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CheckMapper {
    List<BrandVo> listBrand(BrandVo value);
    BrandVo getBrand(BrandVo value);
    CheckVo getVisitInfoForSale(CstmrVo value);
    List<CheckVo> listVisit(CheckVo value);
    CheckVo getVisitInfo(CheckVo value);
    Integer countVisit(CheckVo value);
    void modifyCheckDate(CheckVo value);
    void updateVisit(CheckVo value);
    void editCheckInfo(CheckVo value);
    void addVisit(CheckVo value);
}
