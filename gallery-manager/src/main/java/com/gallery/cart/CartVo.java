package com.gallery.cart;

import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Deprecated
@Data
@Alias("cartVo")
public class CartVo extends PagingVo{
	Integer cartId;
	Integer cstmrId;
	Integer prdctId;
	Integer regTime;
}
