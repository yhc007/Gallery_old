package com.gallery.web.fileUpload.service;

import com.gallery.web.fileUpload.domain.FileVo;

public interface FileService {
	public String upLoad(FileVo fileNameVo)throws Exception;
	public String modifyFile(FileVo fileVo)throws Exception;
}
