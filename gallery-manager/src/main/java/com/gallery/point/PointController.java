package com.gallery.point;

import com.gallery.fileserver.FileServerVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;


@RequestMapping(value = "/point")
@Controller
@RequiredArgsConstructor
public class PointController {

    private final PointService pointService;

    @Deprecated
    @RequestMapping(value = "calcBalancePoint.do")
    @ResponseBody
    public String calcBalancePoint() {
        try {
            return pointService.addBalancePoint();
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Deprecated
    @RequestMapping(value = "listPointHist.do")
    public String listPointHist(PointVo pointVo, ModelMap model) {
        try {
            Map map = pointService.listPointHistory(pointVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointHist";
    }

    @RequestMapping(value = "calcShopPoint.do")
    @ResponseBody
    public String calcShopPoint(PointVo pointVo) {
        try {
            pointService.listShopMPointHistMonth(pointVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    @RequestMapping(value = "listPointEuTable.do")
    public String listPointEuTable(ModelMap model) {
        try {
            Map map = pointService.listPointEuTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointEuData";
    }

    @RequestMapping(value = "listPointEuTableCsv.do")
    public String listPointEuTableCsv(FileServerVo fileVo, ModelMap model) {
        try {
            Map map = pointService.listPointEuTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointEuDataCsv";
    }

    @RequestMapping(value = "listPointUeTable.do")
    public String listPointUeTable(ModelMap model) {
        try {
            Map map = pointService.listPointUeTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointUeData";
    }

    @RequestMapping(value = "listPointUeTableCsv.do")
    public String listPointUeTableCsv(ModelMap model) {
        try {
            Map map = pointService.listPointUeTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointUeDataCsv";
    }

    @RequestMapping(value = "listPointEsumTable.do")
    public String listPointEsumTable(ModelMap model) {
        try {
            Map map = pointService.listPointESumTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointEsumData";
    }

    @RequestMapping(value = "listPointEsumTableCsv.do")
    public String listPointEsumTableCsv(ModelMap model) {
        try {
            Map map = pointService.listPointESumTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointEsumDataCsv";
    }

    @RequestMapping(value = "listPointUsumTable.do")
    public String listPointUsumTable(ModelMap model) {
        try {
            Map map = pointService.listPointUSumTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointUsumData";
    }

    @RequestMapping(value = "listPointUsumTableCsv.do")
    public String listPointUsumTableCsv(ModelMap model) {
        try {
            Map map = pointService.listPointUSumTable();
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "point/listPointUsumDataCsv";
    }

    @RequestMapping(value = "addPointHist.do")
    @ResponseBody
    public String addPointHist(PointVo pointVo) {
        pointVo.setCstmrCd(pointVo.getCstmrCd().replace("ASTERISK", "*"));
        pointVo.setFmlyCd(pointVo.getFmlyCd().replace("ASTERISK", "*"));
        try {
            return pointService.addPointHist(pointVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "expirePoint.do")
    @ResponseBody
    public String expirePoint(PointVo pointVo) {
        try {
            return pointService.expirePoint(pointVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "failed";
    }
}
