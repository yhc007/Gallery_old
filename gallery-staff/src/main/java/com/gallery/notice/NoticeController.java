package com.gallery.notice;

import com.gallery.common.CommonCode;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RequestMapping(value = "/notice")
@Controller
@RequiredArgsConstructor
public class NoticeController {

    @RequestMapping(value = "notice1.do")
    public String indexCstmrForm(Model model, HttpServletResponse response, HttpSession session) {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

        model.addAttribute("shopVo", shopVo);
        model.addAttribute("staffVo", staffVo);

        return "notice/notice1";
    }
}
