package com.gallery.staff;

import com.gallery.common.CommonCode;
import com.gallery.common.MenuTreeVo;
import com.gallery.shop.ShopService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequestMapping(value = "/staff")
@Controller
@RequiredArgsConstructor
public class StaffController {

    private static final Logger logger = LoggerFactory.getLogger(StaffController.class);
    private final StaffService staffService;
    private final ShopService shopService;

    @RequestMapping(value = "indexStaffForm.do")
    public String indexStaffForm(HttpServletRequest request, ModelMap model, HttpSession session) {
        try {
            model.addAllAttributes(shopService.listShopData(null));
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("topMenuId", CommonCode.MENU_CODE_SHOP);

        List<MenuTreeVo> tlist = new ArrayList<MenuTreeVo>();
        tlist.add(new MenuTreeVo("매장 관리", 120, "center", 0));
        tlist.add(new MenuTreeVo("점원 관리", 620, "left", 20));

        model.addAttribute("tlist", tlist);
        model.addAttribute("formnum", 2);

        Integer lv = (Integer) session.getAttribute("lv");
        return (lv == null || lv < 3) ? "tiles:access/denied" : "tiles:staff/indexStaffForm";
    }

    @RequestMapping(value = "addStaffAction.do")
    @ResponseBody
    public StaffVo addStaffAction(StaffVo staffVo) {
        logger.debug("add " + staffVo.toString());

        try {
            String staffId = staffService.addStaff(staffVo);
            staffVo.setStaffId(Integer.parseInt(staffId));
            if (staffId != null) {
                staffVo.setResult("upsuccess");
            }
            return staffVo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        staffVo.setResult("fail");
        return staffVo;
    }

    @RequestMapping(value = "addComStaffAction.do")
    @ResponseBody
    public String addComStaffAction(StaffVo staffVo) {
        logger.debug("add " + staffVo.toString());
        try {
            String result = staffService.addComStaff(staffVo);
            if (result != null) {
                result = "upsuccess";
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "addStaffPhotoAction.do")
    @ResponseBody
    public String addStaffPhotoAction(StaffVo staffVo, MultipartHttpServletRequest request) {
        try {
            String result = staffService.addStaffPhotos(staffVo, request);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "modifyStaffAction.do")
    @ResponseBody
    public StaffVo modifyStaffAction(StaffVo staffVo) {
        logger.debug("modify " + staffVo.toString());
        try {
            staffService.modifyStaff(staffVo);
            staffVo.setResult("modified");
            return staffVo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        staffVo.setResult("fail");
        return staffVo;
    }

    @RequestMapping(value = "modifyComStaffAction.do")
    @ResponseBody
    public String modifyComStaffAction(StaffVo staffVo) {
        try {
            staffService.modifyComStaff(staffVo);
            return "modified";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removeStaffAction.do")
    @ResponseBody
    public String removeStaffAction(StaffVo staffVo) {
        logger.debug("remove " + staffVo.toString());
        try {
            return staffService.removeStaff(staffVo);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "removePhotoAction.do")
    @ResponseBody
    public String removeStaffPhotoAction(StaffVo staffVo) {
        logger.debug("removeStaffPhotoAction " + staffVo.toString());
        try {
            return staffService.removeStaffPhoto(staffVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "listStaffData.do")
    public String listStaffData(StaffVo staffVo, ModelMap model, HttpSession session) {
        Integer shopId = (Integer) session.getAttribute("shopId");
        logger.debug("listStaffData " + staffVo.toString());
        try {
            Map map = staffService.pagedListStaffData(staffVo, shopId);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "staff/listStaffData";
    }

    @RequestMapping(value = "listComStaffData.do")
    public String listComStaffData(StaffVo staffVo, ModelMap model, HttpSession session) {
        Integer shopId = (Integer) session.getAttribute("shopId");
        try {
            Map map = staffService.pagedListComStaffData(staffVo, shopId);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "staff/listStaffData";
    }

    @RequestMapping(value = "getStaffData.do")
    @ResponseBody
    public StaffVo getStaffData(StaffVo staffVo) throws Exception {
        return staffService.selectStaff(staffVo);
    }

    @RequestMapping(value = "getComStaffData.do")
    @ResponseBody
    public StaffVo getComStaffData(StaffVo staffVo) throws Exception {
        return staffService.selectComStaff(staffVo);
    }

    @RequestMapping(value = "getStaffList.do")
    public String getStaffList(StaffVo staffVo, ModelMap model) {
        try {
            Map map = staffService.getStaffList(staffVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "staff/listStaffData2";
    }
}
