package com.gallery.media;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.common.FileUploadForm;


public interface MediaService {
	String addMedia(MediaVo mediaVo,FileUploadForm uploadForm) throws Exception;
	String modifyMediaCode(MediaVo mediaVo) throws Exception;
	void modifyMedia(MediaVo mediaVo) throws Exception;
	Map pagedListMediaData(MediaVo mediaVo) throws Exception;
    @Deprecated
	MediaVo selectMedia(MediaVo mediaVo) throws Exception;
	MediaVo selectVideoCd(MediaVo mediaVo) throws Exception;
	MediaVo removeMedia(MediaVo mediaVo) throws Exception;
    @Deprecated
    void responseMediaData(MediaVo mediaVo, HttpServletResponse response) throws Exception;
    @Deprecated
    List mListMediaData(MediaVo mediaVo) throws Exception;
	String selectRotatePath(MediaVo mediaVo) throws Exception;
}
