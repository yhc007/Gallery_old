package com.gallery.tax;

import com.gallery.common.CommonCode;
import com.gallery.prdct.PrdctMapper;
import com.gallery.prdct.PrdctVo;
import com.gallery.sale.SaleMapper;
import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class TaxServiceImpl implements TaxService {

    private final SaleMapper saleMapper;
    private final PrdctMapper prdctMapper;

    @Override
    @Transactional
    public String modifySale(SaleVo saleVo) {
        if (saleVo.getCJSResultCode() == null) {
            return "0002";
        }
        SaleVo getSaleVo = saleMapper.getSaleForResult(saleVo);
        if (getSaleVo == null) {
            return "0001";
        }

        if (!(saleVo.getCJSResultCode().equals("0000") || saleVo.getCJSResultCode().equals("0") || saleVo.getCJSResultCode().equals("sucess"))) {
            List<SalePrdctVo> listSalePrdctVo = saleMapper.listSalePrdct(saleVo);

            for (int i = 0; i < listSalePrdctVo.size(); i++) {
                PrdctVo prdctVo = new PrdctVo();
                prdctVo.setPrdctId(listSalePrdctVo.get(i).getPrdctId());

                prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_IN);
                prdctVo.setCnt(listSalePrdctVo.get(i).getPrdctCnt());

                int rows = prdctMapper.modifyPrdctInvn(prdctVo);
                if (rows != 1) {
                    int a = 1 / 0;
                }
            }
        }
        saleVo.setSaleId(Integer.parseInt(saleVo.getCJSShopOrderNo()));
        saleMapper.modifySale(saleVo);
        return "0000";
    }

    @Override
    public Map findShopName(ShopVo shopVo) {
        List result = saleMapper.findShopName(shopVo);
        Map resultMap = new HashMap();
        resultMap.put("shopList", result);
        return resultMap;
    }
}
