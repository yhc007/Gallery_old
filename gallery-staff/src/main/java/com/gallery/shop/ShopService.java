package com.gallery.shop;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface ShopService {
//	String addShop(ShopVo shopVo) throws Exception;
//	void modifyShop(ShopVo shopVo) throws Exception;
	Map listShopData(ShopVo shopVo) throws Exception;
//	void mListShopData(HttpServletResponse response,ShopVo shopVo) throws Exception;
	ShopVo selectShop(ShopVo shopVo) throws Exception;
//	ShopVo removeShop(ShopVo shopVo) throws Exception;
//	Integer countShopJoin(ShopVo shopVo) throws Exception;
//	String addShopJoin(ShopVo shopVo) throws Exception;
//	String modifyShopJoin(ShopVo shopVo) throws Exception;
//	ShopVo selectShopJoin(ShopVo shopVo) throws Exception;
	String getShopPwd(ShopVo shopVo)throws Exception;
//	void recIP(String IPaddr)throws Exception;
	void recCstmrHstry(ShopVo shopVo)throws Exception;
	Map listCstmrShopHstry(ShopVo shopVo) throws Exception;
	String rmvCstmrShopHstry(ShopVo shopVo) throws Exception;
	ShopVo getShopInfo(ShopVo shopVo) throws Exception;
//	String connectIp(ShopVo shopVo)throws Exception;
}
