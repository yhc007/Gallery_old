package com.gallery.brand;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BrandMapper {
    void addBrand(BrandVo value);
    List<BrandVo> listBrandByTy(BrandVo value);
    List<BrandVo> srchBrand(BrandVo value);
    Integer countBrand(BrandVo value);
    List<BrandVo> pagedListBrand(BrandVo value);
    Integer pagedListBrandCount(BrandVo value);
    List<BrandVo> listBrand();
    void modifyBrand(BrandVo value);
    BrandVo getBrand(BrandVo value);
    void removeBrand(BrandVo value);
}
