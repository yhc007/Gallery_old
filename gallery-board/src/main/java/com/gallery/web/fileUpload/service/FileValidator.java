package com.gallery.web.fileUpload.service;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gallery.web.fileUpload.domain.FileVo;
  
public class FileValidator implements Validator {  
  
  
 @Override  
 public void validate(Object uploadedFile, Errors errors) {  
  
  FileVo file = (FileVo) uploadedFile;  
  
  if (file.getFile().getSize() == 0) {  
   errors.rejectValue("file", "uploadForm.salectFile",  
     "Please select a file!");  
  }  
  
 }

@Override
public boolean supports(Class<?> arg0) {
	// TODO Auto-generated method stub
	return false;
}  
  
}  