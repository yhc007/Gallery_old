package com.gallery.tax;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Deprecated
@Data
@Alias("tavVo")
public class TaxVo {
	String jsonTax;
	Integer jobId;
	String shopName;
	String dateTime;
	String cstmrName;
}
