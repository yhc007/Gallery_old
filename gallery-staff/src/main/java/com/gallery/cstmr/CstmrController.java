package com.gallery.cstmr;

import com.gallery.common.CommonCode;
import com.gallery.cstmrHstry.CstmrHstryService;
import com.gallery.cstmrHstry.CstmrHstryVo;
import com.gallery.point.PointService;
import com.gallery.point.PointVo;
import com.gallery.sale.SaleVo;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RequestMapping(value = "/cstmr")
@Controller
@RequiredArgsConstructor
public class CstmrController {

    private static final Logger logger = LoggerFactory.getLogger(CstmrController.class);
    private final CstmrService cstmrService;
    private final PointService pointService;
    private final CstmrHstryService cstmrHstryService;

    /*
     * 모바일 고객 신규 등록 폼
     */
    @RequestMapping(value = "mNewCstmrForm.do")
    public String newCstmrForm(HttpServletRequest request, ModelMap model) {
        Date date = new Date();
        model.addAttribute("cyear", date.getYear());

        return "tiles:cstmr/mNewCstmrForm";
    }

//	@Deprecated
//	@RequestMapping(value = "mEditCstmrForm.do")
//	public String editCstmrForm(HttpServletRequest request,ModelMap model){
//
//		Date date = new Date();
//		model.addAttribute("cyear", date.getYear());
//
//		return "tiles:cstmr/mEditCstmrForm";
//	}

    @RequestMapping(value = "getCstmrMemo.do")
    @ResponseBody
    public String getCstmrMemo(CstmrVo cstmrVo) {
        String memo = "";
        try {
            memo = URLEncoder.encode(cstmrService.getCstmrMemo(cstmrVo), "utf-8");
            memo = memo.replaceAll("\\+", "%20");
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("get Memo : " + memo);
        return memo;
    }


    @RequestMapping(value = "cstmrMemoUpdate.do")
    @ResponseBody
    public void cstmrMemoUpdate(CstmrVo cstmrVo) {
        try {
            cstmrService.CstmrMemoUpdate(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//	@Deprecated
//	@RequestMapping(value = "cstmrBigoUpdate.do")
//	@ResponseBody
//	public void cstmrBigoUpdate(CstmrVo cstmrVo){
//		try {
//			cstmrService.CstmrBigoUpdate(cstmrVo);
//		} catch (Exception e) {
//
//			e.printStackTrace();
//		}
//	}

    @RequestMapping(value = "getCstmrBigo.do")
    @ResponseBody
    public String getCstmrBigo(CstmrVo cstmrVo) {
        String result = "";
        try {
            result = cstmrService.getCstmrBigo(cstmrVo);
            if (result == null) {
                result = "";
            } else {
                result = URLEncoder.encode(result, "utf-8");
                result = result.replaceAll("\\+", "%20");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    @RequestMapping(value = "mNewCstmrTabForm.do")
    public String mNewCstmrTabForm(HttpServletRequest request, ModelMap model, CstmrVo cstmrVo, HttpSession session) {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        logger.info("run staffId:" + staffVo.getStaffId());
        logger.info("run staffVo:" + shopVo.getShopId());

        Date date = new Date();
        model.addAttribute("cstmrId", cstmrVo.getCstmrId());
        model.addAttribute("cstmrName", cstmrVo.getCstmrName());
        model.addAttribute("cyear", date.getYear());
        model.addAttribute("cstmr", cstmrVo);
        model.addAttribute("shopVo", shopVo);
        model.addAttribute("staffVo", staffVo);
        return "cstmr/mNewCstmrTabForm";
    }

//	@Deprecated
//	@RequestMapping(value = "mEditCstmrTabForm.do")
//	public String mEditCstmrTabForm(HttpServletRequest request,ModelMap model,CstmrVo cstmrVo, HttpSession session){
//
//		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
//		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
//		logger.info("run mNewCstmrTabForm staffVo:"+staffVo);
//		logger.info("run mNewCstmrTabForm shopVo:"+shopVo);
//
//		SimpleDateFormat sdf;
//		Date date = new Date();
//		model.addAttribute("cyear", date.getYear());
//		model.addAttribute("cstmr", cstmrVo);
//		model.addAttribute("shopVo", shopVo);
//		model.addAttribute("staffVo", staffVo);
//		return "cstmr/mEditCstmrTabForm";
//	}

    /*
     * 고객 머지 폼
     */
    @RequestMapping(value = "mCstmrMergeForm.do")
    public String mCstmrMergeForm(HttpServletRequest request, ModelMap model) {
        return "tiles:cstmr/mCstmrMergeForm";
    }

    /*
     * 고객 머지 액션
     */
    @RequestMapping(value = "cstmrMergeAction.do")
    @ResponseBody
    public String cstmrMergeAction(HttpServletRequest request, ModelMap model, String cstmrInfo1, String cstmrInfo2) {
        try {
            return cstmrService.mergeCstmr(cstmrInfo1, cstmrInfo2);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "mPopupCstmrForm.do")
    public String mPopupCstmrForm(HttpServletRequest request, ModelMap model, Integer num) {
        model.addAttribute("num", num);
        return "cstmr/mPopupCstmrForm";
    }

    @RequestMapping(value = "mAddCstmrAction.do")
    @ResponseBody
    public String mAddCstmrAction(HttpServletResponse response, CstmrVo cstmrVo, Model model, HttpSession session) throws Exception {
        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        /*
         * make cstmrCd.
         * m+yy+count(6digit) = 9 digit.
         */
        Date now = new Date();
        SimpleDateFormat format2 = new SimpleDateFormat("yyyy.MM.dd");
        SimpleDateFormat fmYear4 = new SimpleDateFormat("yyyy");
        SimpleDateFormat fmYear2 = new SimpleDateFormat("yy");

        String today2 = format2.format(now);
        String year4 = fmYear4.format(now);
        String year2 = fmYear2.format(now);
        String cstmrCd = "m" + year2;

        logger.info("year4:" + year4);
        logger.info("year2:" + year2);

        cstmrVo.setRegShopId(shopVo.getShopId());
        cstmrVo.setJoinYear(year4);
        cstmrVo.setRegDate(today2);

        Integer countJoin = cstmrService.countNewCstmr(cstmrVo);
        if (countJoin.intValue() == 0) {
            logger.error("countJoin is 0");
            countJoin++;
            cstmrVo.setJoinCount(countJoin);
            cstmrService.addNewCstmr(cstmrVo);
        } else {
            logger.debug("countJoin is not 0");
            CstmrVo getCstmrVo = cstmrService.getNewCstmr(cstmrVo);

            countJoin = getCstmrVo.getJoinCount();
            if (countJoin.intValue() == 999999) {
                return "fail";
            }
            countJoin++;
            cstmrVo.setJoinCount(countJoin);
            cstmrService.modifyNewCstmr(cstmrVo);
        }

        String suffix = String.format("%06d", countJoin.intValue());

        cstmrCd = cstmrCd.concat(suffix);

        logger.info("cstmrCd:" + cstmrCd);
        cstmrVo.setCstmrCd(cstmrCd);
        cstmrVo.setFmlyCd(cstmrCd);

        // NOT NULL 컬럼(email 등) 대비: 미입력(null) 값을 빈 문자열로 보정해 가입 실패 방지
        if (cstmrVo.getEmail() == null) cstmrVo.setEmail("");
        if (cstmrVo.getAddr() == null) cstmrVo.setAddr("");
        if (cstmrVo.getZipCd() == null) cstmrVo.setZipCd("");
        if (cstmrVo.getBigo() == null) cstmrVo.setBigo("");
        if (cstmrVo.getFacebook() == null) cstmrVo.setFacebook("");
        if (cstmrVo.getTwitter() == null) cstmrVo.setTwitter("");
        if (cstmrVo.getInstagram() == null) cstmrVo.setInstagram("");
        if (cstmrVo.getBirthDayTyCd() == null) cstmrVo.setBirthDayTyCd("");
        if (cstmrVo.getSexCd() == null) cstmrVo.setSexCd("");
        if (cstmrVo.getCstmrLoginId() == null) cstmrVo.setCstmrLoginId("");
        if (cstmrVo.getCstmrLoginPw() == null) cstmrVo.setCstmrLoginPw("");

        try {
            String result = cstmrService.addCstmr(cstmrVo);
            result = result.concat("," + cstmrVo.getCstmrCd() + "," + cstmrVo.getCstmrId() + "," + cstmrVo.getCstmrName());
            logger.info("result : " + result);
            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "idDupleCheck.do")
    @ResponseBody
    public String idDupleCheck(HttpServletResponse response, CstmrVo cstmrVo) {
        try {
            return cstmrService.idDupleCheck(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

//	@Deprecated
//	@RequestMapping("listFmly.do")
//	@ResponseBody
//	public String listFmlyData(CstmrVo cstmrVo,ModelMap model)throws Exception{
//		logger.info("run listCstmrData");
//		logger.info("cstmrVo="+cstmrVo.toString());
//
//		try{
//			Map map=cstmrService.getListFmly(cstmrVo);
//			model.addAllAttributes(map);
//			return "success";
//		}catch(Exception e){
//			return "fail";
//		}
//
//	}

    @RequestMapping("listCstmrData.do")
    public String listCstmrData(CstmrVo cstmrVo, ModelMap model) throws Exception {
        logger.info("run listCstmrData");
        logger.info("cstmrVo=" + cstmrVo.toString());

        List<CstmrVo> cstmrs = cstmrService.listCstmrData(cstmrVo);
        model.put("listcstmr", cstmrs);
        return "cstmr/popupListCstmrData";
    }

//    @Deprecated
//	@RequestMapping(value = "login.do")
//	public String login(HttpServletResponse response,CstmrVo cstmrVo) throws Exception {
//		logger.debug("login "+cstmrVo.toString());
//		try{
//			cstmrService.login(cstmrVo, response);
//		}catch(Exception e){
//			e.printStackTrace();
//			response.setCharacterEncoding("UTF-8");
//			PrintWriter writer=response.getWriter();
//			writer.write("ERROR 500");
//			writer.flush();
//			writer.close();
//		}
//		return "home";
//	}

    /*************************************************************************************************/
    @RequestMapping(value = "indexCstmrForm.do")
    public String indexCstmrForm(HttpServletResponse response, HttpSession session, CstmrVo cstmrVo) {
        session.setAttribute(CommonCode.ATTR_SHOP_ID, "1");
        return "cstmr/indexCstmrForm";
    }

//	@Deprecated
//	@RequestMapping(value = "indexCstmrForm2.do")
//	public String indexCstmrForm2(ModelMap model,HttpServletRequest request,HttpSession session, ShopVo shopVo, StaffVo staffVo) {
//		shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
//		staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
//		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//
//		logger.info("staffId:"+staffVo.getStaffId());
//		logger.info("staffVo:"+shopVo.getShopId());
//
//		model.addAttribute("saleVo", getSale);
//		model.addAttribute("shopVo", shopVo);
//		model.addAttribute("staffVo", staffVo);
//
//		return "cstmr/indexCstmrForm";
//	}

    @RequestMapping(value = "searchFmlyCd.do")
    public String searchFmlyCd(ModelMap model, HttpServletRequest request, HttpSession session, ShopVo shopVo, StaffVo staffVo) {
        shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        SaleVo getSale = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);

        model.addAttribute("saleVo", getSale);
        model.addAttribute("shopVo", shopVo);
        model.addAttribute("staffVo", staffVo);

        return "cstmr/searchFmlyCdForm";
    }

    @RequestMapping(value = "findInFind.do")
    public String findInFind() {
        return "cstmr/findInFindForm";
    }

    public CstmrVo setSearchKeyword(String keyWord, String keyTy, CstmrVo cstmrVo) {
        final int CSTMR_NAME = 0;
        final int CSTMR_ADDR = 1;
        final int CSTMR_PHONE = 2;
        final int CSTMR_MOBILE = 3;
        final int CSTMR_BIRTH = 4;
        final int CSTMR_CD = 5;
        final int FMLY_CD = 6;
        final int DIGIT4 = 7;

        if (!keyWord.equals("")) {
            switch (Integer.parseInt(keyTy)) {
                case CSTMR_NAME: {
                    cstmrVo.setCstmrName(keyWord);
                    break;
                }
                case CSTMR_ADDR: {
                    cstmrVo.setAddr(keyWord);
                    break;
                }
                case CSTMR_PHONE: {
                    cstmrVo.setTelephone(keyWord);
                    break;
                }
                case CSTMR_MOBILE: {
                    cstmrVo.setCellphone(keyWord);
                    break;
                }
                case CSTMR_BIRTH: {
                    cstmrVo.setBirthDay(keyWord);
                    break;
                }
                case CSTMR_CD: {
                    cstmrVo.setCstmrCd(keyWord);
                    break;
                }
                case FMLY_CD: {
                    cstmrVo.setFmlyCd(keyWord);
                    break;
                }
                case DIGIT4: {
                    cstmrVo.setDigit4(keyWord);
                    break;
                }
                default: {
                    logger.error("unKnown keyWord");
                    break;
                }
            }
        }
        return cstmrVo;
    }

    @RequestMapping(value = "cstmrListFmlyCd.do")
    public String cstmrListFmlyCd(CstmrVo cstmrVo, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
        logger.info("run CstmrListFmlyCd");

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        String searchText1 = cstmrVo.getSearchText1();
        String searchText2 = cstmrVo.getSearchText2();
        String searchTy1 = cstmrVo.getSearchTy1();
        String searchTy2 = cstmrVo.getSearchTy2();

        logger.info("run indexShopCstrmForm staffId:" + staffVo.getStaffId());
        logger.info("run indexShopCstrmForm staffVo:" + shopVo.getShopId());

        setSearchKeyword(searchText1, searchTy1, cstmrVo);
        cstmrVo = setSearchKeyword(searchText2, searchTy2, cstmrVo);

        String tmpCstmrCd = cstmrVo.getCstmrCd();
        if (tmpCstmrCd != null) {
            tmpCstmrCd = tmpCstmrCd.replace("-", "000000");
            cstmrVo.setCstmrCd(tmpCstmrCd);
        }

        String tmpFmlyCd = cstmrVo.getFmlyCd();
        if (tmpFmlyCd != null) {
            tmpFmlyCd = tmpFmlyCd.replace("-", "000000");
            cstmrVo.setFmlyCd(tmpFmlyCd);
        }

        List<CstmrVoSecu> cstmrs;
        if (cstmrVo.getCstmrName() == null && cstmrVo.getCstmrCd() == null
            && cstmrVo.getFmlyCd() == null && cstmrVo.getAddr() == null
            && cstmrVo.getCellphone() == null && cstmrVo.getBirthDay() == null
            && cstmrVo.getTelephone() == null
        ) {
            cstmrs = null;
            logger.info("cstmrs Null");
        } else {
            cstmrs = cstmrService.listCstmrDataSecu(cstmrVo);
        }

        model.put("listcstmr", cstmrs);
        model.put("srchCstmr", cstmrVo);
        model.put("shopVo", shopVo);
        model.put("staffVo", staffVo);

        return "cstmr/cstmrListFmlyCd";
    }

    @RequestMapping(value = "reFindCstmr.do")
    public String reFindCstmr(CstmrVo cstmrVo, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
        logger.info("run reFindCstmr");

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        String searchText1 = cstmrVo.getSearchText1();
        String searchText2 = cstmrVo.getSearchText2();
        String searchTy1 = cstmrVo.getSearchTy1();
        String searchTy2 = cstmrVo.getSearchTy2();

        setSearchKeyword(searchText1, searchTy1, cstmrVo);
        cstmrVo = setSearchKeyword(searchText2, searchTy2, cstmrVo);
        List<CstmrVo> cstmrs = null;
        if (cstmrVo.getCstmrName() == null && cstmrVo.getCstmrCd() == null
            && cstmrVo.getFmlyCd() == null && cstmrVo.getAddr() == null
            && cstmrVo.getCellphone() == null && cstmrVo.getBirthDay() == null
            && cstmrVo.getTelephone() == null) {

            logger.info("cstmrs Null");
        } else {
            cstmrs = cstmrService.listCstmrData(cstmrVo);
        }

        model.put("listcstmr", cstmrs);
        model.put("srchCstmr", cstmrVo);
        model.put("shopVo", shopVo);
        model.put("staffVo", staffVo);
        return "cstmr/cstmrListFmlyCd";
    }

    @RequestMapping(value = "cstmrListForm.do")
    public String cstmrListPageForm(CstmrVo cstmrVo, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        String searchText1 = cstmrVo.getSearchText1();
        String searchText2 = cstmrVo.getSearchText2();
        String searchTy1 = cstmrVo.getSearchTy1();
        String searchTy2 = cstmrVo.getSearchTy2();

        setSearchKeyword(searchText1, searchTy1, cstmrVo);
        cstmrVo = setSearchKeyword(searchText2, searchTy2, cstmrVo);

        String tmpCstmrCd = cstmrVo.getCstmrCd();
        if (tmpCstmrCd != null) {
            tmpCstmrCd = tmpCstmrCd.replace("-", "000000");
            cstmrVo.setCstmrCd(tmpCstmrCd);
        }

        String tmpFmlyCd = cstmrVo.getFmlyCd();
        if (tmpFmlyCd != null) {
            tmpFmlyCd = tmpFmlyCd.replace("-", "000000");
            cstmrVo.setFmlyCd(tmpFmlyCd);
        }

        List<CstmrVoSecu> cstmrs = cstmrService.listCstmrDataSecu(cstmrVo);
        session.setAttribute(CommonCode.ATTR_CSTMRS, cstmrs);

        model.put("listcstmr", cstmrs);
        model.put("srchCstmr", cstmrVo);
        model.put("shopVo", shopVo);
        model.put("staffVo", staffVo);
        return "cstmr/cstmrListForm";
    }

    @RequestMapping(value = "tableCstmrSearch.do")
    public String tableCstmrSearch(CstmrVo cstmrVo, HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

        ShopVo shopVo = (ShopVo) session.getAttribute(CommonCode.ATTR_SHOP);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);

        String tmpCstmrCd = cstmrVo.getCstmrCd();
        if (tmpCstmrCd != null) {
            tmpCstmrCd = tmpCstmrCd.replace("-", "000000");
            cstmrVo.setCstmrCd(tmpCstmrCd);
        }

        String tmpFmlyCd = cstmrVo.getFmlyCd();
        if (tmpFmlyCd != null) {
            tmpFmlyCd = tmpFmlyCd.replace("-", "000000");
            cstmrVo.setFmlyCd(tmpFmlyCd);
        }

        List<CstmrVoSecu> cstmrs = cstmrService.listCstmrDataSecu(cstmrVo);
        session.setAttribute(CommonCode.ATTR_CSTMRS, cstmrs);
        model.put("listcstmr", cstmrs);
        model.put("srchCstmr", cstmrVo);
        model.put("shopVo", shopVo);
        model.put("staffVo", staffVo);

        return "saleJob/listSearchCstmrData";
    }

    @RequestMapping(value = "cstmrListDlg.do")
    public String cstmrListDlg(HttpSession session, ModelMap model) {
        List<CstmrVoSecu> cstmrs = (List<CstmrVoSecu>) session.getAttribute(CommonCode.ATTR_CSTMRS);
        model.put("listcstmr", cstmrs);

        return "cstmr/cstmrListDlg";
    }

//	@Deprecated
//	@RequestMapping(value = "cstmrVisit.do")
//	public String cstmrVisit(CstmrVo cstmrVo,ModelMap model) throws Exception {
//		System.out.println("cstmrVo="+cstmrVo.toString());
//		List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
//		System.out.println(cstmrs.size());
//		model.put("listcstmr", cstmrs);
//		return "cstmr/cstmrListForm";
//	}

    @RequestMapping(value = "test.do")
    public String test(ModelMap model) {
        return "home";
    }

//	@Deprecated
//	@RequestMapping(value = "indexPrdctForm.do")
//	public String indexPrdctForm(ModelMap model,HttpServletRequest request,HttpSession session) {
//		logger.info("call indexPrdctForm ");
//
//		Integer cstmrId=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId();
//		String cstmrName=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName();
//		model.addAttribute("cstmrId", cstmrId);
//		model.addAttribute("cstmrName", cstmrName);
//
//		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//		model.addAttribute("saleVo", getSale);
//
//		return "tiles:prdct/indexPrdctProcessForm";
//	}

//    @RequestMapping(value = "indexCstmrForm.do")
//    public String indexCstmrForm(ModelMap model, HttpServletRequest request, HttpSession session) {
//        logger.info("call indexPrdctForm ");
//
//        Integer cstmrId = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId();
//        String cstmrName = ((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName();
//        model.addAttribute("cstmrId", cstmrId);
//        model.addAttribute("cstmrName", cstmrName);
//
//        SaleVo getSale = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//        model.addAttribute("saleVo", getSale);
//
//        return "tiles:prdct/indexPrdctProcessForm";
//    }


    @RequestMapping(value = "modifyCstmrInfo.do")
    @ResponseBody
    public String modifyCstmrInfo(CstmrVo cstmrVo) {
        try {
            return cstmrService.modifyCstmrInfo(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    @RequestMapping(value = "getCstmrInfo.do")
    @ResponseBody
    public CstmrVo getCstmrInfo(CstmrVo cstmrVo) {
        try {
            return cstmrService.getCstmrInfo(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cstmrVo;
    }

    @RequestMapping(value = "getCstmrVIsitInfo.do")
    @ResponseBody
    public CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo) {
        try {
            return cstmrService.getCstmrVIsitInfo(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cstmrVo;
    }

    @RequestMapping(value = "getLastData.do")
    @ResponseBody
    public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo) {
        try {
            return cstmrHstryService.getLastData(cstmrHstryVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cstmrHstryVo;
    }

    @RequestMapping(value = "editCstmrInfoType.do")
    @ResponseBody
    public String editCstmrInfoType(CstmrVo cstmrVo) {
        logger.info("run editCstmrInfo");
        try {
            CstmrVo editCstmrVo = new CstmrVo();
            if (cstmrVo.getCstmrId() == null) {
                return "fail";
            } else {
                editCstmrVo.setCstmrId(cstmrVo.getCstmrId());
            }

            int typeVal = cstmrVo.getInfoType();
            switch (typeVal) {
                case CommonCode.CSTMR_NAME:
                    logger.info("case name");
                    editCstmrVo.setCstmrName(cstmrVo.getEditVal());
                    break;
                case CommonCode.CSTMR_ADDR:
                    logger.info("case addr");
                    editCstmrVo.setAddr(cstmrVo.getEditVal());
                    break;
                case CommonCode.CSTMR_BIRTH:
                    logger.info("case birth");
                    editCstmrVo.setBirthDay(cstmrVo.getEditVal());
                    editCstmrVo.setBirthDayTyCd(cstmrVo.getEditVal2());
                    break;
                case CommonCode.CSTMR_TELEPHONE:
                    logger.info("case tel");
                    editCstmrVo.setTelephone(cstmrVo.getEditVal());
                    break;
                case CommonCode.CSTMR_CELLPHONE:
                    logger.info("case cell");
                    editCstmrVo.setCellphone(cstmrVo.getEditVal());
                    break;
                case CommonCode.CSTMR_EMAIL:
                    logger.info("case email");
                    editCstmrVo.setEmail(cstmrVo.getEditVal());
                    break;
                case CommonCode.CSTMR_FMLYCD:
                    logger.info("case fmlyCd");
                    editCstmrVo.setFmlyCd(cstmrVo.getEditVal());
                    break;
                default:
                    return "fail";
            }

            cstmrService.editCstmrInfo(editCstmrVo);
            if (typeVal == CommonCode.CSTMR_FMLYCD) {
                PointVo tmpPointVo = new PointVo();
                tmpPointVo.setCstmrCd(cstmrVo.getCstmrCd());
                tmpPointVo.setAfFmlyCd(cstmrVo.getAfFmlyCd());

                pointService.mergePoint2FmlyCd(tmpPointVo);
            }
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "editCstmrInfo.do")
    @ResponseBody
    public String editCstmrInfo(CstmrVo cstmrVo) {
        logger.info("run editCstmrInfo cstmrVo:" + cstmrVo);
        try {
            CstmrVo editCstmrVo = cstmrVo;
            if (cstmrVo.getCstmrId() == null) {
                return "fail";
            } else {
                editCstmrVo.setCstmrId(cstmrVo.getCstmrId());
            }
            editCstmrVo.setBigo(URLDecoder.decode(cstmrVo.getBigo(), "utf-8"));
            cstmrService.editCstmrInfo(editCstmrVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "joinChk.do")
    @ResponseBody
    public String joinChk(CstmrVo cstmrVo) {
        try {
            return cstmrService.joinChk(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "getFmlyList.do")
    public String getFmlyList(CstmrVo cstmrVo, ModelMap model) {
        logger.info("run getFmlyList:" + cstmrVo);
        if (!(cstmrVo.getFmlyCd() == null || cstmrVo.getFmlyCd().isEmpty())) {
            try {
                Map map = cstmrService.getFmlyList(cstmrVo);
                model.addAllAttributes(map);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "cstmr/listFmlyData";
    }

}
