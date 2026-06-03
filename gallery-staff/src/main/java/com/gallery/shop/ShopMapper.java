package com.gallery.shop;

import com.gallery.cstmr.CstmrVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShopMapper {
    List<ShopVo> listShop(ShopVo value);
    List<CstmrVo> listCstmrShopHstry(ShopVo value);
    ShopVo getShop(ShopVo value);
    ShopVo getShopInfo(ShopVo value);
    String shopLogin(ShopVo value);
    Integer countCstmrShopHstry(ShopVo value);
    void addCstmrHstry(ShopVo value);
    void removeCstmrShopHstry(ShopVo value);

}
