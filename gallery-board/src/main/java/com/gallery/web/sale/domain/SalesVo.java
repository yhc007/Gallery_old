package com.gallery.web.sale.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class SalesVo{
	String shopId;
	String shopName;
	String staffName;
	Integer total;
	Integer payCash;
	Integer payCard;
	Integer framePrc;
	Integer lensPrc;
	String dateTime;
	public SalesVo(){
		
	}
	
	public Integer getTotal(){
		if(total==null){
			total = 0;
		}
		return total;
	}
	public Integer getPayCash(){
		if(payCash==null){
			payCash = 0;
		}
		return payCash;
	}public Integer getPayCard(){
		if(payCard==null){
			payCard = 0;
		}
		return payCard;
	}public Integer getFramePrc(){
		if(framePrc==null){
			framePrc = 0;
		}
		return framePrc;
	}public Integer getLensPrc(){
		if(lensPrc==null){
			lensPrc = 0;
		}
		return lensPrc;
	}
}
