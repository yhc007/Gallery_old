package com.gallery.web.cart.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.cart.domain.CartVo;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.media.domain.MediaVo;




public interface CartService {
	public String addCart(CartVo cartVo) throws Exception;
	public void modifyCart(CartVo cartVo) throws Exception;
	public Map pagedListCartData(CartVo cartVo) throws Exception;
	public void responseCartData(CartVo cartVo,HttpServletResponse response) throws Exception;
	public CartVo selectCart(CartVo cartVo) throws Exception;
	public String removeCart(CartVo cartVo) throws Exception;
	public String removeCartCstmrPrdct(CartVo cartVo) throws Exception;
	/*public void mListCartData(CartVo cartVo,HttpServletResponse response) throws Exception;*/
}
