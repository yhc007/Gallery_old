package com.gallery.web.fileserver.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class FileServerVo extends PagingVo{
	String serverId;
	String serverName;
	String serverUrl;
	String isdefault;
	String bigo;
}
