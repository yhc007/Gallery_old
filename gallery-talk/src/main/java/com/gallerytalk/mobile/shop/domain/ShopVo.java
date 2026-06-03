package com.gallerytalk.mobile.shop.domain;

import java.net.URLDecoder;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.common.domain.PagingVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;



@Getter
@Setter
@ToString
public class ShopVo extends PagingVo {
	Integer shopId;
	String shopName;
	String pwd;
	Integer shopNum;
	String telephone;
	String shopStatTyCd;
	String sn;
	Double lat;
	Double lot;
	Double dstns;
	String joinDate;
	Integer joinCount;

}
