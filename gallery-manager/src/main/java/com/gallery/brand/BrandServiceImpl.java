package com.gallery.brand;

import com.gallery.common.PagingVo;
import com.gallery.prdct.PrdctService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
public class BrandServiceImpl implements BrandService {
    private final BrandMapper brandMapper;
    private final PrdctService prdctService;

    @Override
    @Transactional
    public String addBrand(BrandVo brandVo) {
        Integer cnt = brandMapper.countBrand(brandVo);
        if (cnt == 0) {
            brandMapper.addBrand(brandVo);
            return "addsuccess";
        } else {
            return "duple";
        }
    }

    @Override
    @Transactional
    public void modifyBrand(BrandVo brandVo) {
        brandMapper.modifyBrand(brandVo);
    }

    @Override
    public Map pagedListBrandData(BrandVo brandVo) {
        Map resultMap = new HashMap();

        Integer pageCount = brandMapper.pagedListBrandCount(brandVo);
        List<BrandVo> brandList = brandMapper.pagedListBrand(brandVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(brandVo.getCurrentPage());
        paging.setPageSize(brandVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listBrand", brandList);

        return resultMap;
    }

    @Override
    public Map listBrandData(BrandVo brandVo) {
        Map resultMap = new HashMap();
        resultMap.put("listBrand", brandMapper.listBrand());
        return resultMap;
    }

    @Override
    public BrandVo selectBrand(BrandVo brandVo) {
        return brandMapper.getBrand(brandVo);
    }

    @Override
    public String removeBrand(BrandVo brandVo) throws Exception {
        Integer cnt = prdctService.countPrdctForBrand(brandVo);
        if (cnt > 0) {
            return "exist";
        }
        brandMapper.removeBrand(brandVo);
        return "success";
    }

    @Override
    public Map listBrandByTy(BrandVo brandVo) {
        Map resultMap = new HashMap();
        List<BrandVo> brandList = brandMapper.listBrandByTy(brandVo);
        resultMap.put("listBrand", brandList);

        return resultMap;
    }

    @Override
    public Map srchBrand(BrandVo brandVo) {
        Map resultMap = new HashMap();
        List<BrandVo> brandList = brandMapper.srchBrand(brandVo);
        resultMap.put("listBrand", brandList);

        return resultMap;
    }
}
