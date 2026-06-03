package com.gallery.secu;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value = "/secu")
@Controller
@RequiredArgsConstructor
public class SecuController {

    private static final Logger logger = LoggerFactory.getLogger(SecuController.class);
    private final SecuService secuService;

//	@Deprecated
//	@RequestMapping(value = "reg.do")
//	@ResponseBody
//	public String regMac(SecuVo secuVo) {
//		logger.info("run regMac:"+secuVo);
//		String rtn;
//		if(secuVo.getSn() == null || secuVo.getMac() == null){
//			return "fail";
//		}
//		try {
//			if(secuService.checkSn(secuVo).equals("success")){
//				rtn = secuService.regMac(secuVo);
//				logger.info("rtn:"+rtn);
//				return rtn;
//			}else{
//				return "fail";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "fail";
//		}
//	}

//    @Deprecated
//	@RequestMapping(value = "indexSecuTest.do")
//	public String indexSecuTest(SecuVo secuVo, HttpSession session, ModelMap model) {
//		logger.info("run indexSecuTest:"+secuVo);
//		StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
//		ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
//		String DvcSN = secuVo.getSn();
//
//		model.addAttribute("staffVo", staffVo);
//		model.addAttribute("shopVo", shopVo);
//		model.addAttribute("SN",DvcSN);
//
//		return "secu/indexSecuTest";
//	}

    @RequestMapping(value = "dvc.do")
    @ResponseBody
    public String checkDvc(SecuVo secuVo) throws Exception {
        logger.info("run checkMac:" + secuVo);
        return secuService.checkDvc(secuVo);
    }

    @RequestMapping(value = "auth.do")
    @ResponseBody
    public String checkMac(SecuVo secuVo) throws Exception {
        logger.info("run checkMac:" + secuVo);
        return secuService.checkMac(secuVo);
    }

}
