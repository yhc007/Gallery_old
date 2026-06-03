package com.gallery.web.fileUpload.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gallery.web.fileUpload.domain.FileVo;
import com.gallery.web.fileUpload.service.FileService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/upload")
@Controller
public class FileController {

	private static final Logger logger = LoggerFactory
			.getLogger(FileController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private FileService fileService;

	@Autowired
	private ServletContext servletContext;
	
	@RequestMapping(value="upload")
	// produces="application/json" 생략가능
	@ResponseBody
	public HashMap<String, String> uploadProcess(MultipartHttpServletRequest req, HttpServletRequest request) throws IOException {
	    //servletContext = req.getSession().getServletContext();
	    MultipartFile multipartFile = req.getFile("fileData");
	    String additionalParam = req.getParameter("multiFile");
	    String fileNo = req.getParameter("fileNo");
	    
	    logger.info("is multi : " + additionalParam + "/" + "fileNo : " + fileNo);
	    InputStream in = null;
	    OutputStream out = null;
	    String originalFileName = multipartFile.getOriginalFilename();
	    String targetFileName = String.valueOf(System.currentTimeMillis()) + "." +
	            originalFileName.substring(originalFileName.lastIndexOf(".") + 1, originalFileName.length());   
	   
	    String targetPath = "/usr/local/tomcat7/webapps/media/board_file";
	     
	    File targetPathDir = new File(targetPath);
	    if(!targetPathDir.exists()) targetPathDir.mkdir();
	     
	    String savedFilePath = targetPathDir + File.separator + targetFileName;
	    FileVo fileVo = new FileVo();
	    fileVo.setFileName(targetFileName);
	    fileVo.setMultiFile(additionalParam);
	    fileVo.setFileNo(Integer.parseInt(fileNo));
	    String no = "";
	    
	    try {
			no = fileService.upLoad(fileVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
	    try {
	        in = multipartFile.getInputStream();
	        out = new FileOutputStream(savedFilePath);
	         
	        int readBytes = 0;
	        byte[] buff = new byte[8192];
	         
	        while((readBytes=in.read(buff,0,8192))!=-1){
	            out.write(buff,0,readBytes);
	        }           
	    } finally{
	        if(in!=null) in.close();
	        if(out!=null) out.close();
	    }
	     
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("originalFileName", originalFileName);
	    map.put("renameFileName", targetFileName);
	    map.put("code", "0");
	    map.put("msg", no);
	    map.put("fileName", targetFileName);
	     
	    return map;
	}

	
	@RequestMapping(value="modifyFile")
	// produces="application/json" 생략가능
	@ResponseBody
	public HashMap<String, String> modifyFile(MultipartHttpServletRequest req, HttpServletRequest request) throws IOException {
	    //servletContext = req.getSession().getServletContext();
	    MultipartFile multipartFile = req.getFile("fileData2");
	    String originFileName = req.getParameter("originFileName");
	    
	    logger.info("fileNo : " + originFileName);
	    InputStream in = null;
	    OutputStream out = null;
	    
	    String originalFileName = multipartFile.getOriginalFilename();
	    String targetFileName = String.valueOf(System.currentTimeMillis()) + "." +
	            originalFileName.substring(originalFileName.lastIndexOf(".") + 1, originalFileName.length());   
	   
	    String targetPath = "/usr/local/tomcat7/webapps/media/board_file";
	     
	    File targetPathDir = new File(targetPath);
	    if(!targetPathDir.exists()) targetPathDir.mkdir();
	     
	    String savedFilePath = targetPathDir + File.separator + targetFileName;
	    FileVo fileVo = new FileVo();
	    fileVo.setFileName(targetFileName);
	    fileVo.setOriginFileName(originFileName);
	    String no = "";
	    
	    try {
			no = fileService.modifyFile(fileVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
	    try {
	        in = multipartFile.getInputStream();
	        out = new FileOutputStream(savedFilePath);
	         
	        int readBytes = 0;
	        byte[] buff = new byte[8192];
	         
	        while((readBytes=in.read(buff,0,8192))!=-1){
	            out.write(buff,0,readBytes);
	        }           
	    } finally{
	        if(in!=null) in.close();
	        if(out!=null) out.close();
	    }
	     
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("originalFileName", originalFileName);
	    map.put("renameFileName", targetFileName);
	    map.put("code", "0");
	    map.put("msg", no);
	    map.put("fileName", targetFileName);
	     
	    return map;
	}
	
}
