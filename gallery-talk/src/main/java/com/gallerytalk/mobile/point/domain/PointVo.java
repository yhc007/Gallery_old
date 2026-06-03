package com.gallerytalk.mobile.point.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallerytalk.mobile.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class PointVo extends PagingVo{
	Integer poinId;
	Integer rootNum;

	String cstmrCd;
	String cstmrName;
	String fmlyCd;
	String fmlyName;
	String othrPrsnCpn;
	Integer point;
	String pointStatus;
	Integer saleId;
	double totalPoint;
	
	String dateTime;
	
	String demiseDate;
	
	Integer earnOrder;
	double earnPoint;
	
	Integer usingOrder;
	double usingPoint;
	
	Integer shopId;
	Integer shopNum;
	
}
