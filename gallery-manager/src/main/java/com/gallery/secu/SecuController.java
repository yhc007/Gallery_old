package com.gallery.secu;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


@RequestMapping(value = "/secu")
@RestController
@RequiredArgsConstructor
public class SecuController {

	private static final Logger logger = LoggerFactory.getLogger(SecuController.class);
	private final SecuService secuService;

	@Deprecated
	@RequestMapping(value = "reg.do")
	@ResponseBody
	public String regMac(SecuVo secuVo) {
		logger.info("run regMac:"+secuVo);
		if(secuVo.getSn() == null || secuVo.getMac() == null){
			return "fail";
		}
		try {
			if(secuService.checkSn(secuVo).equals("success")){
				return secuService.regMac(secuVo);
			}else{
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping(value = "dvc.do")
	@ResponseBody
	public String checkDvc(SecuVo secuVo) throws Exception {
		logger.info("run checkMac:"+secuVo);
		return secuService.checkDvc(secuVo);
	}

	@RequestMapping(value = "auth.do")
	@ResponseBody
	public String checkMac(SecuVo secuVo) throws Exception {
		logger.info("run checkMac:"+secuVo);
		return secuService.checkMac(secuVo);
	}

}
