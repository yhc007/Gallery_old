package com.gallery.web.media.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.brand.service.BrandService;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.common.fileupload.FileUploadForm;
import com.gallery.web.media.domain.MediaVo;
import com.gallery.web.media.service.MediaService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/media")
@Controller
public class MediaController {
	
	private static final Logger logger = LoggerFactory.getLogger(MediaController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private MediaService mediaService;
	@Autowired
	private BrandService brandService;	
	@Autowired
	private PrdctService prdctService;
	
	
	@RequestMapping(value = "rotate")
	public String home(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String path=mediaService.selectRotatePath(mediaVo);
		model.addAttribute("rotatePath", path);
		return "media/rotate";
	}
		
	@RequestMapping(value = "indexMediaForm")
	public String indexMediaForm(ModelMap model,PrdctVo prdctVo,HttpServletRequest request) {
		logger.info("indexMediaForm : "+prdctVo.toString());
		logger.info("PrdctVo : "+prdctVo.toString());
		/*
		if(prdctVo.getPrdctId()==null)
		{
			try {
				String prdctId = prdctService.addPrdctMediaUpload(prdctVo);
				Integer.parseInt(prdctId);
				prdctVo.setPrdctId(Integer.parseInt(prdctId));
				logger.info("prdctId:"+prdctId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		*/
		try{
			model.addAttribute("prdct", prdctVo);
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("상품 등록/수정",120,"center",0));
		tlist.add(new MenuTreeVo("미디어 관리",120,"center",0));
		tlist.add(new MenuTreeVo(prdctVo.getBrandName(),120,"center",0));
		tlist.add(new MenuTreeVo(prdctVo.getPrdctName(),240,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_MEDIA);
		return "tiles:media/indexMediaForm";
	}
	
	@RequestMapping(value = "addMediaAction")
	@ResponseBody
	public String addMediaAction(MediaVo mediaVo,FileUploadForm uploadForm) {
		logger.info("call add "+mediaVo.toString());

		
	    // 업로드한 파일이 존재하면
	     try{
	    	 mediaService.addMedia(mediaVo,uploadForm);
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 return "fail";
	     }
		return "success";
	}
	
	@RequestMapping(value = "ComindexMediaForm")
	public String ComindexMediaForm(ModelMap model,PrdctVo prdctVo,HttpServletRequest request) {
		logger.info("indexMediaForm : "+prdctVo.toString());
		logger.info("PrdctVo : "+prdctVo.toString());
		try{
			model.addAttribute("prdct", prdctVo);
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("상품 관리",120,"center",0));
		tlist.add(new MenuTreeVo("상품 등록/수정",120,"center",0));
		tlist.add(new MenuTreeVo("미디어 관리",120,"center",0));
		tlist.add(new MenuTreeVo(prdctVo.getBrandName(),120,"center",0));
		tlist.add(new MenuTreeVo(prdctVo.getPrdctName(),240,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 1);
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_MEDIA);
		return "com/ComindexMediaForm";
	}
	
	
	@RequestMapping(value = "ComaddMediaAction")
	@ResponseBody
	public String ComaddMediaAction(MediaVo mediaVo,FileUploadForm uploadForm) {
		logger.info("call add "+mediaVo.toString());

		
	    // 업로드한 파일이 존재하면
	     try{
	    	 mediaService.ComAddMedia(mediaVo,uploadForm);
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 return "fail";
	     }
		return "success";
	}
	
	@RequestMapping(value = "modifyMediaAction")
	@ResponseBody
	public String modifyMediaAction(MediaVo mediaVo) {
		logger.debug("modify "+mediaVo.toString());
		try{
			mediaService.modifyMedia(mediaVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "modifyMediaCodeAction")
	@ResponseBody
	public String modifyMediaCodeAction(MediaVo mediaVo) {
		logger.debug("modify "+mediaVo.toString());
		try{
			return mediaService.modifyMediaCode(mediaVo);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removeMediaAction")
	@ResponseBody
	public String removeMediaAction(MediaVo mediaVo) {
		logger.debug("remove "+mediaVo.toString());
		try{
			mediaService.removeMedia(mediaVo);
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listMediaData")
	public String listMediaData(MediaVo mediaVo,ModelMap model) {
		logger.info("listMediaData "+mediaVo.toString());
		try{
			Map map=mediaService.pagedListMediaData(mediaVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "media/listMediaData";
	}
	
	@RequestMapping(value ="getMediaData.do")
	@ResponseBody
	public MediaVo getMediaData(MediaVo mediaVo)throws Exception{
		MediaVo bb=mediaService.selectMedia(mediaVo);
		logger.debug(bb.toString());
		return bb;
	}
	
	@RequestMapping(value ="getVideoCode.do")
	@ResponseBody
	public MediaVo getVodCode(MediaVo mediaVo)throws Exception{
		System.out.println("getVideoCode"+mediaVo.toString());
		MediaVo media=mediaService.selectVideoCd(mediaVo);
		return media;
	} 
	
	
	@RequestMapping(value ="mListMediaData.do")
	@ResponseBody
	public void mListMediaData(MediaVo mediaVo,HttpServletResponse response)throws Exception{
		mediaService.responseMediaData(mediaVo,response);
	} 
}
