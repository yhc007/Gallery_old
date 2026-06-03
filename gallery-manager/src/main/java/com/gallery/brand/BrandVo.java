package com.gallery.brand;

import lombok.Data;

import com.gallery.common.PagingVo;
import org.apache.ibatis.type.Alias;

@Data
@Alias("brandVo")
public class BrandVo extends PagingVo {
    Integer brandId;
    String brandName;
    Integer comTy;
    String bigo;
    String prdctTyCd;
}
