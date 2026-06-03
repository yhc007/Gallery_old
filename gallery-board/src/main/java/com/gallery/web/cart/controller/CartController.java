package com.gallery.web.cart.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.cart.domain.CartVo;
import com.gallery.web.cart.service.CartService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/cart")
@Controller
public class CartController {
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value = "addCartAction")
	@ResponseBody
	public String addCartAction(CartVo cartVo) {
		logger.debug("add "+cartVo.toString());
		try{
			String result=cartService.addCart(cartVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeCartAction")
	@ResponseBody
	public String removeCartAction(CartVo cartVo) {
		logger.debug("remove "+cartVo.toString());
		try{
			return cartService.removeCart(cartVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeCartCstmrPrdctAction")
	@ResponseBody
	public String removeCartCstmrPrdctAction(CartVo cartVo) {
		logger.debug("remove "+cartVo.toString());
		logger.info(cartVo.toString());
		try{
			return cartService.removeCartCstmrPrdct(cartVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listCartData")
	public void listCartData(CartVo cartVo,ModelMap model,HttpServletResponse response) {
		
		logger.debug("modify "+cartVo.toString());
		try{
			cartService.responseCartData(cartVo,response);
		}catch(Exception e){
			e.printStackTrace();
			
			response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
			PrintWriter writer=null;
			try{
				response.getWriter();
				writer.write("fail");
				writer.flush();
				writer.close();
			}catch(Exception e2){
				
			}
		}
	}
	
}
