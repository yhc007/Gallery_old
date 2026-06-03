package com.gallery.chart;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("chartVo")
public class ChartVo {
	String shopName;
	String yesterDay;
	String toDay;
	Integer month;
	String shopId;
	String prdctTy;
	String prdctName;
	String sdate;
	String edate;
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
