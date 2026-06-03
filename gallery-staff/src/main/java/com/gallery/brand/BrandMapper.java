package com.gallery.brand;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BrandMapper {
    List<BrandVo> listBrand(BrandVo value);
    BrandVo getBrand(BrandVo value);
}
