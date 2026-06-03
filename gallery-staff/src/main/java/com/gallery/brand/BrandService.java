package com.gallery.brand;

import java.util.Map;


public interface BrandService {
	Map listBrandData(BrandVo brandVo) throws Exception;
	BrandVo selectBrand(BrandVo brandVo) throws Exception;
}
