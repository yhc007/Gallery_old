package com.gallery.cart;

@Deprecated
public interface CartService {
	String addCart(CartVo cartVo) throws Exception;
	String removeCart(CartVo cartVo) throws Exception;
	String removeCartCstmrPrdct(CartVo cartVo) throws Exception;
}
