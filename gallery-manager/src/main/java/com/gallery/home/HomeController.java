package com.gallery.home;

import com.gallery.media.MediaService;
import com.gallery.media.MediaVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;


@RequestMapping(value = "/home")
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final MediaService mediaService;
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Deprecated
    @RequestMapping(value = "abc.do")
    public String home(Locale locale, Model model, MediaVo mediaVo) throws Exception {
        logger.info("Welcome home! The client locale is {}.", locale);

        String path = mediaService.selectRotatePath(mediaVo);
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate);
        model.addAttribute("rotatePath", path);

        return "home";
    }

    @RequestMapping(value = "test.do")
    public String test(Locale locale, Model model, MediaVo mediaVo) throws Exception {
        logger.info("Welcome home! The client locale is {}.", locale);

        String path = mediaService.selectRotatePath(mediaVo);
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate);
        model.addAttribute("rotatePath", path);

        return "test";
    }

    @Deprecated
    @RequestMapping(value = "test2.do")
    public String test2(Locale locale, Model model, MediaVo mediaVo) throws Exception {
        logger.info("Welcome home! The client locale is {}.", locale);

        String path = mediaService.selectRotatePath(mediaVo);
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate);
        model.addAttribute("rotatePath", path);

        return "test2";
    }

    @Deprecated
    @RequestMapping(value = "test3")
    public String test3(Locale locale, Model model, MediaVo mediaVo) throws Exception {
        logger.info("Welcome home! The client locale is {}.", locale);

        String path = mediaService.selectRotatePath(mediaVo);
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate);
        model.addAttribute("rotatePath", path);

        return "sale/testcancel";
    }
}
