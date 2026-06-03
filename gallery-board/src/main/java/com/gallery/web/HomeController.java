package com.gallery.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gallery.web.media.domain.MediaVo;
import com.gallery.web.media.service.MediaService;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/home")
@Controller 
public class HomeController {
	
	@Autowired
	private MediaService mediaService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "abc")
	public String home(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String path=mediaService.selectRotatePath(mediaVo);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("rotatePath", path);
		
		
		return "home";
	}
	@RequestMapping(value = "test")
	public String test(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String path=mediaService.selectRotatePath(mediaVo);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("rotatePath", path);
		
		
		return "test";
	}
	@RequestMapping(value = "test2")
	public String test2(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String path=mediaService.selectRotatePath(mediaVo);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("rotatePath", path);
		
		
		return "test2";
	}
	@RequestMapping(value = "test3")
	public String test3(Locale locale, Model model,MediaVo mediaVo) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		String path=mediaService.selectRotatePath(mediaVo);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("rotatePath", path);
		
		
		return "sale/testcancel";
	}
	
}
