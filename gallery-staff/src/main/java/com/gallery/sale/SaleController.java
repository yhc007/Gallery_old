package com.gallery.sale;

import com.gallery.check.CheckVo;
import com.gallery.common.CommonCode;
import com.gallery.cstmr.CstmrService;
import com.gallery.cstmr.CstmrVo;
import com.gallery.point.PointService;
import com.gallery.point.PointVo;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffVo;
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
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping(value = "/sale")
@Controller
@RequiredArgsConstructor
public class SaleController {

    private static final Logger logger = LoggerFactory.getLogger(SaleController.class);
    private final SaleService saleService;
    private final PointService pointService;
    private final CstmrService cstmrService;

    @RequestMapping(value = "indexSaleForm.do")
    public ModelAndView indexSaleForm(HttpServletRequest request, ModelMap model, HttpSession session, CstmrVo cstmrVo, StaffVo staffVo, ShopVo shopVo) {
        logger.info("Run indexSaleForm cstmrVo:" + cstmrVo);
        shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);

        Integer cstmrId = cstmrVo.getCstmrId();
        try {
            cstmrVo = cstmrService.getCstmrById(cstmrVo);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);

        SaleVo saleVo = new SaleVo();
        saleVo.setCstmrId(cstmrId);
        if (shopVo == null)
            saleVo.setShopId(-1);
        else
            saleVo.setShopId(shopVo.getShopId());

        Integer checkResult;
        SaleVo getSale;

        TimeZone tz;
        Date today = new Date();
        DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
        tz = TimeZone.getTimeZone("Asia/Seoul");
        df.setTimeZone(tz);
        saleVo.setDatetime(df.format(today));

        try {
            checkResult = saleService.checkSaleCstrm(saleVo);
            logger.info("result:" + checkResult);
            switch (checkResult) {
                case 0:
                    session.setAttribute(CommonCode.ATTR_SALE, saleVo);
                    logger.info("@@@@@@@@@@@@@@@@@@@@ get it 6 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                    break;
                case 1:
                    getSale = saleService.selectSaleForCstmrAndResult(saleVo);
                    getSale.setDatetime(df.format(today));
                    session.setAttribute(CommonCode.ATTR_SALE, getSale);
                    logger.info("@@@@@@@@@@@@@@@@@@@@ get it 7 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                    break;
                default:
                    getSale = saleService.selectSaleForCstmrAndResult(saleVo);
                    getSale.setDatetime(df.format(today));
                    session.setAttribute(CommonCode.ATTR_SALE, getSale);
                    logger.info("@@@@@@@@@@@@@@@@@@@@ get it 7-1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String addr = "redirect:/cstmrHstry/indexCstmrHstryForm.do";

        return new ModelAndView(addr);

    }

    // staffId 있는지 먼제 확인.
    // 있으면 jump로 넘어가고 없으면 없다고 return.
//    @Deprecated
//	@RequestMapping(value = "checkCStaff.do")
//	@ResponseBody
//	public String checkCStaff(CstmrVo cstmrVo) {
//		String rtnStr = "false";
//		StaffVo inputVo = new StaffVo();
//		inputVo.setShopId(Integer.parseInt(cstmrVo.getShopId()));
//
//		int cnt = 0;
//		try {
//			cnt = staffService.getCStaffCnt(inputVo);
//		} catch (Exception e) {
//
//			e.printStackTrace();
//		}
//		if (cnt > 0) {
//			rtnStr = "OK";
//		} else {
//			rtnStr = "false";
//		}
//
//		return rtnStr;
//	}

    // need cstmrCd, shopId
    // 보안상 문제로 기능 개발 취소.
//    @Deprecated
//	@RequestMapping(value = "jumpSaleForm.do")
//	public ModelAndView jumpSaleForm(HttpServletRequest request, ModelMap model, HttpSession session, CstmrVo cstmrVo) {
//		// cstmrId, shopId, StaffId
//		logger.info("Run indexSaleForm cstmrVo:" + cstmrVo);
//		StaffVo staffVo = new StaffVo();
//		ShopVo shopVo = new ShopVo();
//		staffVo.setShopId(Integer.parseInt(cstmrVo.getShopId()));
//
//		try {
//			staffVo = staffService.selectCStaff(staffVo);
//			shopVo.setShopId(staffVo.getShopId());
//			shopVo = shopService.selectShop(shopVo);
//		} catch (Exception e2) {
//
//			e2.printStackTrace();
//		}
//
//		session.setAttribute(CommonCode.ATTR_STAFF, staffVo);
//		session.setAttribute(CommonCode.ATTR_SHOP, shopVo);
//
//		try {
//			cstmrVo = cstmrService.getCstmrByCd(cstmrVo);
//		} catch (Exception e1) {
//
//			e1.printStackTrace();
//		}
//		Integer cstmrId = cstmrVo.getCstmrId();
//		session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);
//
//		SaleVo saleVo = new SaleVo();
//		saleVo.setCstmrId(cstmrId);
//		saleVo.setShopId(shopVo.getShopId());
//
//		Integer checkResult;
//		SaleVo getSaleId = new SaleVo();
//		SaleVo getSale = new SaleVo();
//		String dateTime;
//
//		SaleJobVo saleJobVo = new SaleJobVo();
//		String getJobId;
//
//		TimeZone tz;
//		Date today = new Date();
//		DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
//		tz = TimeZone.getTimeZone("Asia/Seoul");
//		df.setTimeZone(tz);
//		saleVo.setDatetime(df.format(today));
//		saleVo.setShopId(shopVo.getShopId());
//
//		try {
//			checkResult = saleService.checkSaleCstrm(saleVo);
//			switch (checkResult) {
//			case 0:
//				session.setAttribute(CommonCode.ATTR_SALE, saleVo);
//				break;
//			case 1:
//				getSale = saleService.selectSaleForCstmrAndResult(saleVo);
//				getSale.setDatetime(df.format(today));
//				session.setAttribute(CommonCode.ATTR_SALE, getSale);
//				break;
//			default:
//				getSale = saleService.selectSaleForCstmrAndResult(saleVo);
//				getSale.setDatetime(df.format(today));
//				session.setAttribute(CommonCode.ATTR_SALE, getSale);
//				break;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		String addr = "redirect:/cstmrHstry/indexCstmrHstryForm.do";
//
//		return new ModelAndView(addr);
//
//	}

    @RequestMapping(value = "indexSetFmlyCd.do")
    public ModelAndView indexFmlyCd(HttpServletRequest request, ModelMap model, HttpSession session, CstmrVo cstmrVo,
                                    StaffVo staffVo, ShopVo shopVo) {
        logger.info("Run indexSetFmlyCd cstmrVo1:" + cstmrVo);

        CstmrVo fmlyCstmrVo = cstmrVo;
        logger.info("Run indexSetFmlyCd cp to fmlyCstmrVo:" + fmlyCstmrVo);
        cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        logger.info("Run indexSetFmlyCd ogn cstmrVo:" + cstmrVo);
        try {
            cstmrVo = cstmrService.getCstmrById(cstmrVo);
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        cstmrVo.setFmlyCd(fmlyCstmrVo.getCstmrCd());
        try {
            cstmrService.modifyCstmrFmlyCd(cstmrVo);
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        session.setAttribute(CommonCode.ATTR_CSTMR, cstmrVo);
        return new ModelAndView("redirect:/prdct/indexPrdctPaymentForm.do");
    }

//	@Deprecated
//	@RequestMapping(value = "listPurchased.do")
//	public String listPastPurchased(SaleVo saleVo, ModelMap model, String cstmrId) {
//		logger.info("run listPurchased saleVo:" + saleVo);
//		try {
//			Map map = saleService.listSelectPastPurchased(saleVo);
//			Map map2 = saleService.listSelectPastPurchasedNewPrdct(saleVo);
//			Map map3 = saleService.listPastPurchasedOld(saleVo);
//
//			model.addAllAttributes(map);
//			model.addAllAttributes(map2);
//			model.addAllAttributes(map3);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "sale/listPurchased";
//	}

    @RequestMapping(value = "editSaleDate.do")
    @ResponseBody
    public String editSaleDate(SaleVo saleVo, ModelMap model, String cstmrId) {
        logger.info("run editSaleDate - saleVo:" + saleVo);
        CheckVo checkVo = new CheckVo();
        checkVo.setHistId(saleVo.getHistId());
        checkVo.setDatetime(saleVo.getDatetime());
        try {
            return saleService.modifySaleAndCheckDate(saleVo, checkVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @RequestMapping(value = "getPayCardInfo.do")
    public String getPayCardInfo(SaleVo saleVo, ModelMap model) {
        try {
            Map map = saleService.getPayCardInfo(saleVo);
            model.addAllAttributes(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "prdct/listPayCardData";
    }

    @RequestMapping(value = "getSaleMemo.do")
    @ResponseBody
    public String getSaleMemo(SaleVo saleVo) {
        String memo = "";
        try {
            String tmp = saleService.getSaleMemo(saleVo);
            if (tmp != null) {
                memo = URLEncoder.encode(tmp, "utf-8");
            }
            memo = memo.replaceAll("\\+", "%20");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return memo;
    }

    @RequestMapping(value = "saleMemoUpdate.do")
    @ResponseBody
    public String saleMemoUpdate(SaleVo saleVo) {
        String memo = saleVo.getMemo();
        logger.info("run saleMemoUpdate memo1:" + memo);
//		try {
//			memo = URLDecoder.decode(memo,"utf-8");
//		} catch (UnsupportedEncodingException e1) {
//
//			e1.printStackTrace();
//		}
//		logger.info("run saleMemoUpdate memo2:"+memo);
        try {
            saleService.SaleMemoUpdate(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    @RequestMapping(value = "modifyCardPayDate.do")
    @ResponseBody
    public String modifyCardPayDate(SaleVo saleVo) {
        try {
            return saleService.modifyCardPayDate(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getPaymentList.do")
    @ResponseBody
    public Map getPaymentList(SaleVo saleVo) {
        Map map = new HashMap();
        List<SaleVo> listPayment = null;
        try {
            listPayment = saleService.getPaymentList(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        map.put("listPayment", listPayment);
        return map;
    }

    @RequestMapping(value = "delSaleId.do")
    @ResponseBody
    public String delSaleId(SaleVo saleVo) {
        String result1 = "";
        String result2 = "";
        PointVo pointVo = new PointVo();
        pointVo.setSaleId(saleVo.getSaleId());
        try {
            result1 = pointService.removePointAllSale(pointVo);
            result2 = saleService.delSaleId(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result1.equals(result2)) {
            return result1;
        } else {
            return "fail";
        }
    }

    @RequestMapping(value = "modifygoPayment.do")
    @ResponseBody
    public String goPayment(SaleVo saleVo) {
        String result1 = "";
        String result2 = "";
        try {
            result1 = saleService.updatepayment(saleVo);
            result2 = saleService.updatejobpayment(saleVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result1.equals(result2)) {
            return result1;
        } else {
            return "fail";
        }
    }
}
