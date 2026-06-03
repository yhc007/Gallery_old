package com.gallery.common;

import org.springframework.web.multipart.MultipartFile;

public class FileUploadForm {

	private MultipartFile files;
	public MultipartFile getFiles() {
		return files;
	}
	public void setFiles(MultipartFile files) {
		this.files = files;
	}

}
