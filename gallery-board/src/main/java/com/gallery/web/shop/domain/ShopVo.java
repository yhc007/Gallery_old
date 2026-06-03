package com.gallery.web.shop.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class ShopVo extends PagingVo {
	Integer shopId;
	String shopName;
	Integer shopNum;
	String telephone;
	String shopStatTyCd;
	String iNum;
	Double lat;
	Double lot;
	String lv;
	Double dstns;
	String joinDate;
	Integer joinCount;
	String sort;
	String PrdctName;
	String prdctId;
}
