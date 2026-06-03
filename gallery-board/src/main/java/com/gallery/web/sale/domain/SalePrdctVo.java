package com.gallery.web.sale.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class SalePrdctVo{
	Integer saleId;
	Integer prdctId;
	Integer prdctCnt;
	Integer eventId;
	Integer dscnt;
	Integer prc;
	
	public SalePrdctVo(){
		
	}
	
	public SalePrdctVo(int saleId,int prdctId,int prdctCnt){
		this.saleId=saleId;
		this.prdctId=prdctId;
		this.prdctCnt=prdctCnt;
	}
	public Integer getDscnt(){
		if(dscnt==null){
			return 0;
		}
		return dscnt;
	}
}
