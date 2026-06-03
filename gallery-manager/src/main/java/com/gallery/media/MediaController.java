package com.gallery.media;

import com.gallery.brand.BrandService;
import com.gallery.brand.BrandVo;
import com.gallery.common.CommonCode;
import com.gallery.common.FileUploadForm;
import com.gallery.common.MenuTreeVo;
import com.gallery.prdct.PrdctVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;


@RequestMapping(value = "/media")
@Controller
@RequiredArgsConstructor
public class MediaController {

	private static final Logger logger = LoggerFactory.getLogger(MediaController.class);
	private final MediaService mediaService;
	private final BrandService brandService;

	@RequestMapping(value = "rotate.do")
	public String home(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		String path=mediaService.selectRotatePath(mediaVo);
		model.addAttribute("rotatePath", path);
		return "media/rotate";
	}

	@RequestMapping(value = "indexMediaForm.do")
	public String indexMediaForm(ModelMap model,PrdctVo prdctVo,HttpServletRequest request) {
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

	@RequestMapping(value = "addMediaAction.do")
	@ResponseBody
	public String addMediaAction(MediaVo mediaVo,FileUploadForm uploadForm) {
	    // 업로드한 파일이 존재하면
	     try{
	    	 mediaService.addMedia(mediaVo,uploadForm);
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 return "fail";
	     }
		return "success";
	}

	@RequestMapping(value = "modifyMediaAction.do")
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

	@RequestMapping(value = "modifyMediaCodeAction.do")
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

	@RequestMapping(value = "removeMediaAction.do")
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

	@RequestMapping(value = "listMediaData.do")
	public String listMediaData(MediaVo mediaVo,ModelMap model) {
		try{
			Map map=mediaService.pagedListMediaData(mediaVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "media/listMediaData";
	}

    @Deprecated
	@RequestMapping(value ="getMediaData.do")
	@ResponseBody
	public MediaVo getMediaData(MediaVo mediaVo)throws Exception{
		return mediaService.selectMedia(mediaVo);
	}

	@RequestMapping(value ="getVideoCode.do")
	@ResponseBody
	public MediaVo getVodCode(MediaVo mediaVo)throws Exception{
		return mediaService.selectVideoCd(mediaVo);
	}

	@Deprecated
	@RequestMapping(value ="mListMediaData.do")
	@ResponseBody
	public void mListMediaData(MediaVo mediaVo,HttpServletResponse response)throws Exception{
		mediaService.responseMediaData(mediaVo,response);
	}
}
