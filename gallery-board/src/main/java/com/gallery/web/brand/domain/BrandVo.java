package com.gallery.web.brand.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class BrandVo extends PagingVo{
	Integer brandId;
	String brandName;
	String bigo;
	String shopTy;
	String prdctTyCd;
}
