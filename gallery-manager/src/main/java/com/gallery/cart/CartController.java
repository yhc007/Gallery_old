package com.gallery.cart;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@Deprecated
@RequestMapping(value = "/cart")
@RestController
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;

	@RequestMapping(value = "addCartAction.do")
	@ResponseBody
	public String addCartAction(CartVo cartVo) {
		try{
			return cartService.addCart(cartVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "removeCartAction.do")
	@ResponseBody
	public String removeCartAction(CartVo cartVo) {
		try{
			return cartService.removeCart(cartVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}

	@RequestMapping(value = "removeCartCstmrPrdctAction.do")
	@ResponseBody
	public String removeCartCstmrPrdctAction(CartVo cartVo) {
		try{
			return cartService.removeCartCstmrPrdct(cartVo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
}
