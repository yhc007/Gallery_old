package com.gallery.comm;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("commVo")
public class CommVo {
	private String mac;
	public String getMac(){
		if(mac==null)return null;
		return mac.replaceAll(":", "");
	}
	private String regId;
	private String ipAddr;
	private String usrId;
	public CommVo(){

	}
}
