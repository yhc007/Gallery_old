package com.gallery.tax;

import com.gallery.sale.SaleVo;
import com.gallery.shop.ShopVo;

import java.util.Map;

public interface TaxService {
	String modifySale(SaleVo saleVo) throws Exception;
	Map findShopName(ShopVo shopVo) throws Exception;
}
