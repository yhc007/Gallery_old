package com.gallery.cart;

import org.apache.ibatis.annotations.Mapper;

@Deprecated
@Mapper
public interface CartMapper {
    CartVo addCart(CartVo value);
    Integer countCart(CartVo value);
    void removeCart(CartVo value);
    void removeCartCstmrPrdct(CartVo value);
}
