package com.gallerytalk.mobile.comm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommVo {
	private String mac;
	public String getMac(){
		if(mac==null)return null;
		return mac.replaceAll(":", "");
	}
	private String regId;
	private String ipAddr;
	private String usrId;
	private String staffId;
	
	private String sendGid;
	private String sendName;
	private String rcvGid;
	private String name;
	private String msg;
	private String msgNo;
	private String result;
	
}
