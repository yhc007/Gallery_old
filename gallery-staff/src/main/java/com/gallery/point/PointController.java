package com.gallery.point;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.util.Map;

@RequestMapping(value = "/point")
@Controller
@RequiredArgsConstructor
public class PointController {

    private static final Logger logger = LoggerFactory.getLogger(PointController.class);
    private final PointService pointService;

//    @Deprecated
//	@RequestMapping(value = "calcBalancePoint.do")
//	@ResponseBody
//	public String calcBalancePoint() {
//		logger.debug("run calcBalancePoint");
//		String result;
//		try{
//			result=pointService.addBalancePoint();
//			return result;
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//
//		return "fail";
//	}

    @RequestMapping(value = "getCstmrPoint.do")
    @ResponseBody
    public String getCstmrPoint(PointVo pointVo) {
        logger.info("run getCstmrPoint pointVo:" + pointVo);
        try {
            pointVo = pointService.selectPointByCstmrCd(pointVo);

            String result = String.format("%d", (int) (pointVo.getTotalPoint() * 100)) + "," + pointVo.getFmlyCd() + "," + pointVo.getFmlyName();
            logger.info(result);
            result = URLEncoder.encode(result, "utf-8");
            result = result.replaceAll("\\+", "%20");

            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listPointHist.do")
    public String listPointHist(PointVo pointVo, ModelMap model) {
        logger.info("run listPointHist pointVo:" + pointVo);
        try {
            Map map = pointService.listPointHistory(pointVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointHist";
    }

//    @Deprecated
//	@RequestMapping(value = "calcShopPoint.do")
//	@ResponseBody
//	public String calcShopPoint(PointVo pointVo,ModelMap model) {
//		logger.info("run calcShopPoint pointVo:"+pointVo);
//		try{
//			//pointVo.setDateTime("2014.02.01");
//			Map map = pointService.listShopMPointHistMonth(pointVo);
//			//model.addAllAttributes(map);
//			logger.info(map.toString());
//			List <PointVo> listMonthlyMPoint= (List<PointVo>) map.get("listPointHist");
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return "success";
//	}

}
