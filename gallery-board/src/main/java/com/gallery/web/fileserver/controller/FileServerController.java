package com.gallery.web.fileserver.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.fileserver.domain.FileServerVo;
import com.gallery.web.fileserver.service.FileServerService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/fileserver")
@Controller
public class FileServerController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileServerController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired 
	private FileServerService fileServerService;
	
	@RequestMapping(value = "indexFileServerForm")
	public String indexFileServerForm(ModelMap model,HttpServletRequest request, HttpSession session) {
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_MFS);
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("시스템",120,"center",0));
		tlist.add(new MenuTreeVo("파일서버 등록/수정",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:fileserver/indexFileServerForm";
		}
		return rtnPage;
		
	}
	
	@RequestMapping(value = "addFileServerAction")
	@ResponseBody
	public String addFileServerAction(FileServerVo fileServerVo) {
		logger.debug("call add "+fileServerVo.toString());

		
	    // 업로드한 파일이 존재하면
	     try{
	    	 String result =fileServerService.addFileServer(fileServerVo);
	    	 return result;
	     }catch(Exception e){
	    	 e.printStackTrace();
	     }
		return "fail";
	}
	
	@RequestMapping(value = "modifyFileServerAction")
	@ResponseBody
	public String modifyFileServerAction(FileServerVo fileServerVo) {
		logger.debug("modify "+fileServerVo.toString());
		try{
			fileServerService.modifyFileServer(fileServerVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeFileServerAction")
	@ResponseBody
	public String removeFileServerAction(FileServerVo fileServerVo) {
		logger.debug("remove "+fileServerVo.toString());
		try{
			fileServerService.removeFileServer(fileServerVo);
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listFileServerData")
	public String listFileServerData(FileServerVo fileServerVo,ModelMap model) {
		logger.debug("modify "+fileServerVo.toString());
		try{
			Map map=fileServerService.pagedListFileServerData(fileServerVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fileserver/listFileServerData";
	}
	
	@RequestMapping(value ="getFileServerData.do")
	@ResponseBody
	public FileServerVo getFileServerData(FileServerVo fileServerVo)throws Exception{
		FileServerVo bb=fileServerService.selectFileServer(fileServerVo);
		logger.debug(bb.toString());
		return bb;
	} 
	
}
