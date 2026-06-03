package com.gallery.web.cart.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class CartVo extends PagingVo{
	Integer cartId;
	Integer cstmrId;
	Integer prdctId;
	Integer regTime;
}
