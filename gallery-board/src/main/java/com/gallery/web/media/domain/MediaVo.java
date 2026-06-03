package com.gallery.web.media.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.gallery.web.common.fileupload.FileUploadForm;

@Getter
@Setter
@ToString
public class MediaVo {
	Integer mediaId;
	String mediaName;
	String mediaTyCd;
	String prdctId;
	String mediaPath;
	
	String modelName;
	String videoCd;
	String color;
	
	
	String urlStr;
	
}
