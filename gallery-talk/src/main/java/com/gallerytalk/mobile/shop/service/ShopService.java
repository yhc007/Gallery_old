package com.gallerytalk.mobile.shop.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallerytalk.mobile.shop.domain.ShopVo;

public interface ShopService {
	public String addShop(ShopVo shopVo) throws Exception;
	public void modifyShop(ShopVo shopVo) throws Exception;
	public Map pagedListShopData(ShopVo shopVo) throws Exception;
	public Map listShopData(ShopVo shopVo) throws Exception;
	public void mListShopData(HttpServletResponse response,ShopVo shopVo) throws Exception;
	public ShopVo selectShop(ShopVo shopVo) throws Exception;
	public ShopVo removeShop(ShopVo shopVo) throws Exception;
	public Integer countShopJoin(ShopVo shopVo) throws Exception;
	public String addShopJoin(ShopVo shopVo) throws Exception;
	public String modifyShopJoin(ShopVo shopVo) throws Exception;
	public ShopVo selectShopJoin(ShopVo shopVo) throws Exception;
	public String getShopPwd(ShopVo shopVo)throws Exception;
	public void recIP(String IPaddr)throws Exception;
}
