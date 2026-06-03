package com.gallery.sale;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("salesVo")
public class SalesVo{
	String shopName;
	Integer total;
	Integer payCash;
	Integer payCard;
	Integer framePrc;
	Integer lensPrc;
	public SalesVo(){

	}
}
