package com.gallery.secu;


import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("secuVo")
public class SecuVo extends PagingVo{
	String mac;
	String sn;
}
