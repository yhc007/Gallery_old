package com.gallery.shop;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public interface ShopService {
	ShopVo addShop(ShopVo shopVo) throws Exception;
	void modifyShop(ShopVo shopVo) throws Exception;
	Map pagedListShopData(ShopVo shopVo) throws Exception;
	Map listShopData(ShopVo shopVo) throws Exception;
	@Deprecated
	void mListShopData(HttpServletResponse response,ShopVo shopVo) throws Exception;
	ShopVo selectShop(ShopVo shopVo) throws Exception;
	ShopVo removeShop(ShopVo shopVo) throws Exception;
	Map findShopName(ShopVo shopV) throws Exception;
	Integer countShopJoin(ShopVo shopVo) throws Exception;
	String addShopJoin(ShopVo shopVo) throws Exception;
	String modifyShopJoin(ShopVo shopVo) throws Exception;
	ShopVo selectShopJoin(ShopVo shopVo) throws Exception;
	Map shopList(ShopVo shopVo)throws Exception;
	Map taxShopList(ShopVo shopVo) throws Exception;
	Map getComListBySrch(ShopVo shopVo)throws Exception;
	String chkManager(ShopVo shopVo)throws Exception;
	Map getComList()throws Exception;
	Map getComListForTrade(ShopVo shopVo)throws Exception;
	ShopVo getShopInfo(ShopVo shopVo) throws Exception;
	String addStampPhotos(ShopVo shopVo,MultipartHttpServletRequest request) throws Exception;
	String removeStampPhoto(ShopVo shopVo) throws Exception;
	String getshopName(ShopVo shopVo)throws Exception;
	List<ShopVo> getPointShopList() throws Exception;
	String getShopList() throws Exception;
}
