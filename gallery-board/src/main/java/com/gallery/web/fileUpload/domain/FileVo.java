package com.gallery.web.fileUpload.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import org.springframework.web.multipart.MultipartFile;

import com.gallery.web.common.domain.PagingVo;

@Getter
@Setter
@ToString
public class FileVo extends PagingVo{
	 String fileName;
	 MultipartFile file;
	 Integer no;
	 String multiFile;
	 Integer fileNo;
	 String originFileName;
}
