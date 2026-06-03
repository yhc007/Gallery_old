package com.gallerytalk.mobile.brand.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.brand.domain.BrandVo;




public interface BrandService {
	public Map listBrandData(BrandVo brandVo) throws Exception;
	public BrandVo selectBrand(BrandVo brandVo) throws Exception;
}
