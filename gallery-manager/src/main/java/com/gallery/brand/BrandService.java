package com.gallery.brand;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;


public interface BrandService {
	String addBrand(BrandVo brandVo) throws Exception;
	void modifyBrand(BrandVo brandVo) throws Exception;
	Map pagedListBrandData(BrandVo brandVo) throws Exception;
	Map listBrandData(BrandVo brandVo) throws Exception;
	BrandVo selectBrand(BrandVo brandVo) throws Exception;
	String removeBrand(BrandVo brandVo) throws Exception;
	Map listBrandByTy(BrandVo brandVo)throws Exception;
	Map srchBrand(BrandVo brandVo)throws Exception;
}
