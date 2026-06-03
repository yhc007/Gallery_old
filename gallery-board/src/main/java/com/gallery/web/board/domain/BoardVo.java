package com.gallery.web.board.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class BoardVo extends PagingVo{
	Integer no;
	String type;
	Integer id;
	String shopLoginId;
	String fileName;
	String url;
	String pwd;
	String ty;
	String shopName;
	String writerNo;
	String reader;
	Integer shopTy;
	String replyNo;
	String usrTy;
	String cName;
	String writer;
	String writerTy;
	String title;
	String content;
	int page;
	String updTime;
	String reply;
	Integer shopId;
	String usr;
	Integer priority;
	Integer cnt;
	Integer complete;
}
