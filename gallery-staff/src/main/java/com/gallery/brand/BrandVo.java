package com.gallery.brand;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("brandVo")
public class BrandVo {
    Integer brandId;
    String brandName;
    String bigo;
    String prdctTyCd;
}
