package com.gallery.brand;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BrandServiceImpl implements BrandService {

    private final BrandMapper brandMapper;

    @Override
    public Map listBrandData(BrandVo brandVo) {
        Map resultMap = new HashMap();
        List<BrandVo> brandList = brandMapper.listBrand(brandVo);
        resultMap.put("listBrand", brandList);
        return resultMap;
    }

    @Override
    public BrandVo selectBrand(BrandVo brandVo) {
        return brandMapper.getBrand(brandVo);
    }
}
