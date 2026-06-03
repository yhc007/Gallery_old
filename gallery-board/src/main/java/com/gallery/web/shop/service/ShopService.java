package com.gallery.web.shop.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Transactional;

import com.gallery.web.shop.domain.ShopVo;

public interface ShopService {
	public String addShop(ShopVo shopVo) throws Exception;
	public void modifyShop(ShopVo shopVo) throws Exception;
	public Map pagedListShopData(ShopVo shopVo) throws Exception;
	public Map listShopData(ShopVo shopVo) throws Exception;
	public void mListShopData(HttpServletResponse response,ShopVo shopVo) throws Exception;
	public ShopVo selectShop(ShopVo shopVo) throws Exception;
	public ShopVo removeShop(ShopVo shopVo) throws Exception;
	public Map findShopName(ShopVo shopV) throws Exception;
	public Integer countShopJoin(ShopVo shopVo) throws Exception;
	public String addShopJoin(ShopVo shopVo) throws Exception;
	public String modifyShopJoin(ShopVo shopVo) throws Exception;
	public ShopVo selectShopJoin(ShopVo shopVo) throws Exception;	
	public Map shopList(ShopVo shopVo)throws Exception;
	public Map selectAllShop()throws Exception;
	public Map getinum(ShopVo shopVo)throws Exception;
	public Map getShopId(ShopVo shopVo)throws Exception;
}
