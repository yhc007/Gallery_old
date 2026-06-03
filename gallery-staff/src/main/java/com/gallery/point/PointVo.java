package com.gallery.point;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("pointVo")
public class PointVo {//extends PagingVo{
	Integer pointId;

	Integer usingShopId;
	Integer earnShopId;
	Integer rootNum;

	String cstmrCd;
	String cstmrName;
	String fmlyCd;
	String bfFmlyCd;
	String afFmlyCd;
	String fmlyName;
	String othrPrsnCpn;
	Integer point;
	String pointStatus;
	Integer saleId;
	double totalPoint;

	String dateTime;
	String saleDate;

	String demiseDate;
	Integer mPoint;
	Integer earnOrder;
	double earnPoint;

	Integer usingOrder;
	double usingPoint;

	Integer shopId;
	Integer shopNum;
	String shopName;

	Integer cstmrPoint;

}
