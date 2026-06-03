package com.gallery.staff;

import com.gallery.common.CommonCode;
import com.gallery.shop.ShopService;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@RequestMapping(value = "/staff")
@Controller
@RequiredArgsConstructor
public class StaffController {

    private static final Logger logger = LoggerFactory.getLogger(StaffController.class);
    private final StaffService staffService;
    private final ShopService shopService;

    @RequestMapping(value = "indexStaffForm.do")
    public String indexStaffForm(ModelMap model, HttpServletRequest request, ShopVo shopVo) {
        int shopId = -1;

        if (shopVo.getShopId() != null) {
            shopId = shopVo.getShopId();
        }

        StaffVo staffVo = new StaffVo();
        staffVo.setShopId(shopId);

        try {
            Map map = staffService.listStaffShop(staffVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "staff/indexStaffForm";
    }

    @RequestMapping(value = "addStaffAction.do")
    @ResponseBody
    public String addStaffAction(StaffVo staffVo) {
        logger.debug("add " + staffVo.toString());
        try {
            return staffService.addStaff(staffVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

//	@Deprecated
//	@RequestMapping(value = "modifyStaffAction.do")
//	@ResponseBody
//	public String modifyStaffAction(StaffVo staffVo) {
//		logger.debug("modify " + staffVo.toString());
//		try {
//			staffService.modifyStaff(staffVo);
//			return "upsuccess";
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "fail";
//	}
//
//    @Deprecated
//	@RequestMapping(value = "removeStaffAction.do")
//	@ResponseBody
//	public String removeStaffAction(StaffVo staffVo) {
//		logger.debug("remove " + staffVo.toString());
//		try {
//			return staffService.removeStaff(staffVo);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "fail";
//	}
//
//    @Deprecated
//	@RequestMapping(value = "removePhotoAction.do")
//	@ResponseBody
//	public String removeStaffPhotoAction(StaffVo staffVo) {
//		logger.debug("removeStaffPhotoAction " + staffVo.toString());
//		try {
//			return staffService.removeStaffPhoto(staffVo);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "fail";
//	}
//
//    @Deprecated
//	@RequestMapping(value = "listStaffData.do")
//	public String listStaffData(StaffVo staffVo, ModelMap model) {
//		logger.debug("listStaffData " + staffVo.toString());
//		try {
//			Map map = staffService.pagedListStaffData(staffVo);
//			logger.info("staffVo:" + staffVo.toString());
//			model.addAllAttributes(map);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "staff/listStaffData";
//	}

    @RequestMapping(value = "staffLogin.do")
    public ModelAndView StaffLogin(HttpServletRequest request, ModelMap model, HttpSession session, StaffVo staffVo) {
        ShopVo shopVo = new ShopVo();
        try {
            staffVo = staffService.selectStaff(staffVo);
            shopVo.setShopId(staffVo.getShopId());
            shopVo = shopService.selectShop(shopVo);
            session.setAttribute(CommonCode.ATTR_STAFF, staffVo);
            session.setAttribute(CommonCode.ATTR_SHOP, shopVo);
            String ip = request.getRemoteAddr();
            logger.info("staffVo:" + staffVo);
            logger.info("shopVo:" + shopVo);
            logger.info("login_ip:" + ip);

        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }

        return new ModelAndView("redirect:/shop/indexShopCstrmForm.do");
    }

    @RequestMapping(value = "sessionMaintain.do")
    @ResponseBody
    public void sessionMaintain(StaffVo staffVo, HttpSession session, HttpServletRequest request) {
        ShopVo shopVo = new ShopVo();
        try {
            shopVo.setShopId(staffVo.getShopId());

            session.setAttribute(CommonCode.ATTR_STAFF, staffVo);
            session.setAttribute(CommonCode.ATTR_SHOP, shopVo);
            String ip = request.getRemoteAddr();

            logger.info("staffVo:" + staffVo);
            logger.info("shopVo:" + shopVo);
            logger.info("login_ip:" + ip);
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
        }
    }

    @RequestMapping(value = "changeStaff.do")
    @ResponseBody
    public String changeStaff(HttpServletRequest request, ModelMap model, HttpSession session, StaffVo staffVo) {
        ShopVo shopVo = new ShopVo();
        try {
            staffVo = staffService.selectStaff(staffVo);
            shopVo.setShopId(staffVo.getShopId());
            shopVo = shopService.selectShop(shopVo);
            session.setAttribute(CommonCode.ATTR_STAFF, staffVo);
            session.setAttribute(CommonCode.ATTR_SHOP, shopVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
        return "success";
    }

//	@Deprecated
//	@RequestMapping(value = "getStaffData.do")
//	@ResponseBody
//	public StaffVo getStaffData(StaffVo staffVo) throws Exception {
//		StaffVo bb = staffService.selectStaff(staffVo);
//		logger.debug(bb.toString());
//		return bb;
//	}
//    @Deprecated
//	@RequestMapping(value = "mListStaffData.do")
//	public String mListStaffData(HttpServletRequest request, HttpServletResponse response, StaffVo staffVo)
//			throws Exception {
//		staffService.mListStaffData(staffVo, response);
//		return "home";
//	}
//    @Deprecated
//	@RequestMapping(value = "mListStaffDataForDsply.do")
//	public String mListStaffDataForDsply(HttpServletRequest request, HttpServletResponse response, StaffVo staffVo)
//			throws Exception {
//		staffService.mListStaffDataForDsply(staffVo, response);
//		return "home";
//	}
}
