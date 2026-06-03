package com.gallery.coupon;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("couponVo")
public class CouponVo{
	Integer cstmrId;
	String cstmrCd;
	String cstmrName;
	String cellphone;
	String telephone;
	Integer shopId;
	String shopName;
	String addr;
	String birthDay;


	String couponCd;
	String cstmrMail;
	Integer shopNum;
	String usingDate;

	Integer saleId;
	String wMemo;
	String couponMemo;

}
