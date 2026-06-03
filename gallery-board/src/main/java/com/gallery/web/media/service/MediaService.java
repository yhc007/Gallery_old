package com.gallery.web.media.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.media.domain.MediaVo;


public interface MediaService {
	public String addMedia(MediaVo mediaVo,FileUploadForm uploadForm) throws Exception;
	public String ComAddMedia(MediaVo mediaVo,FileUploadForm uploadForm) throws Exception;
	public String modifyMediaCode(MediaVo mediaVo) throws Exception;
	public void modifyMedia(MediaVo mediaVo) throws Exception;
	public Map pagedListMediaData(MediaVo mediaVo) throws Exception;
	public MediaVo selectMedia(MediaVo mediaVo) throws Exception;
	public MediaVo selectVideoCd(MediaVo mediaVo) throws Exception;
	public MediaVo removeMedia(MediaVo mediaVo) throws Exception;
	public void responseMediaData(MediaVo mediaVo, HttpServletResponse response) throws Exception;
	public List mListMediaData(MediaVo mediaVo) throws Exception;
	public String selectRotatePath(MediaVo mediaVo) throws Exception;
}
