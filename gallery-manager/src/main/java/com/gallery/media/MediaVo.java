package com.gallery.media;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("mediaVo")
public class MediaVo {
	Integer mediaId;
	String mediaName;
	String mediaTyCd;
	String prdctId;
	String mediaPath;
	String prdctType;
	String modelName;
	String videoCd;
	String color;


	String urlStr;

}
