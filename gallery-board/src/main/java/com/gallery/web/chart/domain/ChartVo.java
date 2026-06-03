package com.gallery.web.chart.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChartVo {
	String shopName;
	Integer yesterDay;
	Integer toDay;
	Integer month;
	String shopId;
	String prdctTy;
	String prdctName;
	Integer prc;
	String img;
	String urlStr;
	Integer puchasPrc;
	Integer trdePrc;
	String staffName;
	String staffId;
	Integer staffSalesAvg;
	Integer prdctCount;
	Integer datetime;
	String selectPrdct;
	String chkeyes;
	String asmbly;
	String payment;
	String dlvl;
	
	public Integer getYesterDay(){
		if(yesterDay==null){
			yesterDay = 0;
		}
		return yesterDay;
	}
	public Integer getPuchasPrc(){
		if(puchasPrc==null){
			puchasPrc = 0;
		}
		return puchasPrc;
	}
	public Integer getTrdePrc(){
		if(trdePrc==null){
			trdePrc = 0;
		}
		return trdePrc;
	}
	public Integer getToDay(){
		if(toDay==null){
			toDay = 0;
		}
		return toDay;
	}
	
	public Integer getPrc(){
		if(prc==null){
			prc = 0;
		}
		return prc;
	}
	
	public String getShopName(){
		if(shopName==null){
			shopName = "";
		}
		return shopName;
	}
}
