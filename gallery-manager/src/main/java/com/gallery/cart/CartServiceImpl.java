package com.gallery.cart;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Deprecated
@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;

    @Override
    @Transactional
    public String addCart(CartVo cartVo) {
        Integer cnt = cartMapper.countCart(cartVo);
        if (cnt == 0) {
            cartMapper.addCart(cartVo);
            return "success";
        }
        return "duple";
    }

    @Override
    public String removeCart(CartVo cartVo){
        cartMapper.removeCart(cartVo);
        return "success";
    }

    @Override
    @Transactional
    public String removeCartCstmrPrdct(CartVo cartVo) {
        cartMapper.removeCartCstmrPrdct(cartVo);
        return "success";
    }

}
