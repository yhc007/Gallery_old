package com.gallery.shop;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShopMapper {
    void addShop(ShopVo value);
    void addShopJoin(ShopVo value);
    void removeShop(ShopVo value);
    void modifyShopJoin(ShopVo value);
    void modifyShop(ShopVo value);
    void removeImgPath(ShopVo value);
    void updateImgPath(ShopVo value);
    Integer countShop(ShopVo value);
    Integer countShopJoin(ShopVo value);
    Integer pagedListShopCount(ShopVo value);
    Integer getShopNum(ShopVo value);
    String getshopName(ShopVo value);
    String chkManager(ShopVo value);
    List<ShopVo> pagedListShop(ShopVo value);
    List<ShopVo> listShop(ShopVo value);
    List<ShopVo> mlistShop(ShopVo value);
    ShopVo getShop(ShopVo value);
    ShopVo getShopJoin(ShopVo value);
    List<ShopVo> getShopName(ShopVo value);
    List<ShopVo> shopList(ShopVo value);
    List<ShopVo> taxShopList(ShopVo value);
    List<ShopVo> getComListBySrch(ShopVo value);
    ShopVo getShopInfo(ShopVo value);
    List<ShopVo> getComListForTrade(ShopVo value);
    List<ShopVo> getComList();
    List<ShopVo> getPointShopList();
    List<ShopVo> getShopList();

}
