package com.gallery.web.prdctType.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.PagingVo;


@Getter
@Setter
@ToString
public class PrdctTypeVo{
	Integer typeId;
	String typeName;
	Integer prdctId;
	String prdctName;
}
