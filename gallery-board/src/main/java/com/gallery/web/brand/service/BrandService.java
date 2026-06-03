package com.gallery.web.brand.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.media.domain.MediaVo;




public interface BrandService {
	public String addBrand(BrandVo brandVo) throws Exception;
	public void modifyBrand(BrandVo brandVo) throws Exception;
	public Map pagedListBrandData(BrandVo brandVo) throws Exception;
	public Map listBrandData(BrandVo brandVo) throws Exception;
	public BrandVo selectBrand(BrandVo brandVo) throws Exception;
	public String removeBrand(BrandVo brandVo) throws Exception;
	public void mListBrandData(BrandVo brandVo,HttpServletResponse response) throws Exception;
	public void mListBrandDataForDsply(BrandVo brandVo,HttpServletResponse response) throws Exception;
	public Map listBrandByTy(BrandVo brandVo)throws Exception;
	public Map srchBrand(BrandVo brandVo)throws Exception;
	public String addNewBrand(BrandVo brandVo)throws Exception;
}
