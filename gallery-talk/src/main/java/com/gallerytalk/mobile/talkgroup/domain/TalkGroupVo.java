package com.gallerytalk.mobile.talkgroup.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallerytalk.mobile.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class TalkGroupVo extends PagingVo{
	Integer staffId;
	Integer shopId;
	String staffName;
	String shopName;
	String position;
	String email;
	String phone;
	String urlStr;
	String imgPath;
	String regId;
	String dvcTk;
	String reqType;
	Integer iNum;
	Integer comId;
	String cName;
	String groupId;
	Integer result;
}
