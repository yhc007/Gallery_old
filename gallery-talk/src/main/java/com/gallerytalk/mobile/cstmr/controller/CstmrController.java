package com.gallerytalk.mobile.cstmr.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVoSecu;
import com.gallerytalk.mobile.cstmr.service.CstmrService;
import com.gallerytalk.mobile.cstmrHstry.domain.CstmrHstryVo;
import com.gallerytalk.mobile.cstmrHstry.service.CstmrHstryService;
import com.gallerytalk.mobile.sale.domain.SaleVo;
import com.gallerytalk.mobile.shop.domain.ShopVo;
import com.gallerytalk.mobile.shop.service.ShopService;
import com.gallerytalk.mobile.staff.domain.StaffVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/cstmr")
@Controller
public class CstmrController {
	
	private static final Logger logger = LoggerFactory.getLogger(CstmrController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private CstmrService cstmrService;
	
	@Autowired
	private ShopService shopService;
	
	private CstmrHstryService cstmrHstryService;
	
	/*
	 * 모바일 고객 신규 등록 폼
	 */
	@RequestMapping(value = "mNewCstmrForm")
	public String newCstmrForm(HttpServletRequest request,ModelMap model)  throws Exception {
		
		Date date = new Date();
		model.addAttribute("cyear", date.getYear());
		
		return "tiles:cstmr/mNewCstmrForm";
	}
	
	@RequestMapping(value = "mEditCstmrForm")
	public String editCstmrForm(HttpServletRequest request,ModelMap model)  throws Exception {
		
		Date date = new Date();
		model.addAttribute("cyear", date.getYear());
		
		return "tiles:cstmr/mEditCstmrForm";
	}
	
	/*
	 * 모바일 탭 방식 신규 등록 폼
	 */
	
	
	@RequestMapping(value = "getCstmrMemo")
	@ResponseBody
	public String getCstmrMemo(CstmrVo cstmrVo){
		String memo = "";
		try {
			memo = URLEncoder.encode(cstmrService.getCstmrMemo(cstmrVo),"utf-8");
			memo = memo.replaceAll("\\+", "%20");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info("get Memo : "+memo);
		return memo;
	}
	
	
	@RequestMapping(value = "cstmrMemoUpdate")
	@ResponseBody
	public void cstmrMemoUpdate(CstmrVo cstmrVo){
		try {
			cstmrService.CstmrMemoUpdate(cstmrVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "cstmrBigoUpdate")
	@ResponseBody
	public void cstmrBigoUpdate(CstmrVo cstmrVo){
		try {
			cstmrService.CstmrBigoUpdate(cstmrVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	@RequestMapping(value = "mNewCstmrTabForm")
	public String mNewCstmrTabForm(HttpServletRequest request,ModelMap model,CstmrVo cstmrVo, HttpSession session)  throws Exception {
		
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		logger.info("run staffId:"+staffVo.getStaffId());
		logger.info("run staffVo:"+shopVo.getShopId());
		
		SimpleDateFormat sdf;
		Date date = new Date();
		model.addAttribute("cstmrId",cstmrVo.getCstmrId());
		model.addAttribute("cstmrName",cstmrVo.getCstmrName());
		model.addAttribute("cyear", date.getYear());
		model.addAttribute("cstmr", cstmrVo);
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);
		return "cstmr/mNewCstmrTabForm";
	}
	
	@RequestMapping(value = "mEditCstmrTabForm")
	public String mEditCstmrTabForm(HttpServletRequest request,ModelMap model,CstmrVo cstmrVo, HttpSession session)  throws Exception {
		
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		logger.info("run mNewCstmrTabForm staffVo:"+staffVo);
		logger.info("run mNewCstmrTabForm shopVo:"+shopVo);
		
		SimpleDateFormat sdf;
		Date date = new Date();
		model.addAttribute("cyear", date.getYear());
		model.addAttribute("cstmr", cstmrVo);
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);
		return "cstmr/mEditCstmrTabForm";
	}
	
	/*
	 * 고객 머지 폼
	 */
	@RequestMapping(value = "mCstmrMergeForm")
	public String mCstmrMergeForm(HttpServletRequest request,ModelMap model)  throws Exception {
		
		return "tiles:cstmr/mCstmrMergeForm";
	}
	
	
	/*
	 * 고객 머지 액션
	 */
	@RequestMapping(value = "cstmrMergeAction")
	@ResponseBody
	public String cstmrMergeAction(HttpServletRequest request,ModelMap model,String cstmrInfo1,String cstmrInfo2)  throws Exception {
		
		try{
			String result=cstmrService.mergeCstmr(cstmrInfo1,cstmrInfo2);
			return result;
		}catch(Exception e){
			e.printStackTrace();
			return "fail";
		}
	}
	
	
	@RequestMapping(value = "mPopupCstmrForm")
	public String mPopupCstmrForm(HttpServletRequest request,ModelMap model,Integer num)  throws Exception {
		model.addAttribute("num", num);
		
		return "cstmr/mPopupCstmrForm";
	}
	
	@RequestMapping(value = "mAddCstmrAction")
	@ResponseBody
	public String addCstmrAction(HttpServletResponse response,CstmrVo cstmrVo,Model model, HttpSession session) throws Exception {
		logger.info("mAddCstmrAction "+cstmrVo.toString());
		
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		logger.info("mAddCstmrAction shopVo:"+shopVo);
		logger.info(org.springframework.core.SpringVersion.getVersion() );
		/*
		 * make cstmrCd.
		 * m+shopCode(3digit)+yyyyMMdd+count(6digit) = 18 digit.
		 */
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String today=format.format(now);
		String cstmrCd="m"
						+String.format("%03d", shopVo.getShopId())
						+today;
		cstmrVo.setRegShopId(shopVo.getShopId());

		cstmrVo.setRegDate(today);
		shopVo.setJoinDate(today);

		Integer countJoin = shopService.countShopJoin(shopVo);
		if(countJoin.intValue() == 0)
		{
			logger.error("countJoin is 0");
			countJoin++;
			shopVo.setJoinCount(countJoin);
			shopService.addShopJoin(shopVo);
		}else{
			logger.debug("countJoin is not 0");
			shopVo=shopService.selectShopJoin(shopVo);
			countJoin = shopVo.getJoinCount();
			if(countJoin.intValue()==999999)
			{
				return "fail";
			}
			countJoin++;
			shopVo.setJoinCount(countJoin);
			shopService.modifyShopJoin(shopVo);
		}
		String suffix = String.format("%06d", countJoin.intValue()); 
		
		cstmrCd=cstmrCd.concat(suffix);

		cstmrVo.setCstmrCd(cstmrCd);
		try{
			String result=cstmrService.addCstmr(cstmrVo);
			result=result.concat(","+cstmrVo.getCstmrCd()+","+cstmrVo.getCstmrId()+","+cstmrVo.getCstmrName());
			logger.info("result : "+result);
			return result;
			
		}catch(Exception e){
			e.printStackTrace();
			return "fail";
		}
	}
	
	@RequestMapping(value = "idDupleCheck")
	@ResponseBody
	public String idDupleCheck(HttpServletResponse response,CstmrVo cstmrVo) throws Exception {
		System.out.println("idDupleCheck "+cstmrVo.toString());
		logger.info("idDupleCheck "+cstmrVo.toString());
		String result =	null;
		
		try{
			result=cstmrService.idDupleCheck(cstmrVo);
		}catch(Exception e){
			e.printStackTrace();
			return "fail";
		}
		System.out.println("idDupleCheck result="+result);
		return result;
	}
	@RequestMapping("listFmly.do")
	@ResponseBody
	public String listFmlyData(CstmrVo cstmrVo,ModelMap model)throws Exception{
		logger.info("run listCstmrData");
		logger.info("cstmrVo="+cstmrVo.toString());		
		
		try{
			Map map=cstmrService.getListFmly(cstmrVo);
			model.addAllAttributes(map);
			return "success";
		}catch(Exception e){
			return "fail";
		}

	} 

	@RequestMapping("listCstmrData.do") 
	public String listCstmrData(CstmrVo cstmrVo,ModelMap model)throws Exception{
		logger.info("run listCstmrData");
		logger.info("cstmrVo="+cstmrVo.toString());		
		
		List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
		//List<CstmrVoSecu> cstmrs=cstmrService.listCstmrDataSecu(cstmrVo);
		System.out.println(cstmrs.size());
		model.put("listcstmr", cstmrs);

		return "cstmr/popupListCstmrData"; 
	} 
	
		
	
	@RequestMapping(value = "login")
	public String login(HttpServletResponse response,CstmrVo cstmrVo) throws Exception {
		logger.debug("login "+cstmrVo.toString());
		try{
			cstmrService.login(cstmrVo, response);
		}catch(Exception e){
			e.printStackTrace();
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer=response.getWriter();
			writer.write("ERROR 500");
			writer.flush();
			writer.close();
		}
		return "home";
	}
	
	
	
	/*************************************************************************************************/
	@RequestMapping(value = "indexCstmrForm")
	public String indexCstmrForm(HttpServletResponse response,HttpSession session,CstmrVo cstmrVo) throws Exception {
		session.setAttribute(CommonCode.ATTR_SHOP_ID, "1");
		
		return "cstmr/indexCstmrForm";
	}
	@RequestMapping(value = "indexCstmrForm2")
	public String indexCstmrForm2(ModelMap model,HttpServletRequest request,HttpSession session, ShopVo shopVo, StaffVo staffVo) {
		shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		
		logger.info("run staffId:"+staffVo.getStaffId());
		logger.info("run staffVo:"+shopVo.getShopId());
		
		model.addAttribute("saleVo", getSale);
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);
		
		return "cstmr/indexCstmrForm";
	}
	
	@RequestMapping(value = "searchFmlyCd")
	public String searchFmlyCd(ModelMap model,HttpServletRequest request,HttpSession session, ShopVo shopVo, StaffVo staffVo) {
		shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		
		model.addAttribute("saleVo", getSale);
		model.addAttribute("shopVo", shopVo);
		model.addAttribute("staffVo", staffVo);
		
		return "cstmr/searchFmlyCdForm";
	}
	
	@RequestMapping(value = "findInFind")
	public String findInFind(){
		return "cstmr/findInFindForm";
	}
	
	public CstmrVo setSearchKeyword(String keyWord, String keyTy, CstmrVo cstmrVo)
	{
		final int CSTMR_NAME = 0;
		final int CSTMR_ADDR = 1;
		final int CSTMR_PHONE = 2;
		final int CSTMR_MOBILE = 3;
		final int CSTMR_BIRTH = 4;
		final int CSTMR_CD = 5;
		//final int FMLY_CD = 6;
		
		if(!keyWord.equals("")){
			switch (Integer.parseInt(keyTy)){
				case CSTMR_NAME:{
					cstmrVo.setCstmrName(keyWord);
					break;
				}case CSTMR_ADDR:{
					cstmrVo.setAddr(keyWord);
					break;
				}case CSTMR_PHONE:{
					cstmrVo.setTelephone(keyWord);
					break;
				}case CSTMR_MOBILE:{
					cstmrVo.setCellphone(keyWord);
					break;
				}case CSTMR_BIRTH:{
					cstmrVo.setBirthDay(keyWord);
					break;
				}case CSTMR_CD:{
					cstmrVo.setCstmrCd(keyWord);
					break;
				}default:{//case FMLY_CD:{
					cstmrVo.setFmlyCd(keyWord);
					break;
				}
			}
		}
		return cstmrVo;
	}
	
	@RequestMapping(value = "cstmrListFmlyCd")
	public String cstmrListFmlyCd(CstmrVo cstmrVo,HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
		logger.info("run CstmrListFmlyCd");

		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		String searchText1 = cstmrVo.getSearchText1();
		String searchText2 = cstmrVo.getSearchText2();
		String searchTy1 = cstmrVo.getSearchTy1();
		String searchTy2 = cstmrVo.getSearchTy2();
		
		logger.info("run indexShopCstrmForm staffId:"+staffVo.getStaffId());
		logger.info("run indexShopCstrmForm staffVo:"+shopVo.getShopId());

		
		cstmrVo = setSearchKeyword(searchText1,searchTy1,cstmrVo);
		cstmrVo = setSearchKeyword(searchText2,searchTy2,cstmrVo);
		
		String tmpCstmrCd = cstmrVo.getCstmrCd();
		if(tmpCstmrCd!=null)
		{
			tmpCstmrCd = tmpCstmrCd.replace("-", "000000");
			cstmrVo.setCstmrCd(tmpCstmrCd);
		}
		
		String tmpFmlyCd = cstmrVo.getFmlyCd();
		if(tmpFmlyCd!=null)
		{
			tmpFmlyCd=tmpFmlyCd.replace("-", "000000");
			cstmrVo.setFmlyCd(tmpFmlyCd);
		}
		
		//List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
		
		List<CstmrVoSecu> cstmrs=cstmrService.listCstmrDataSecu(cstmrVo);

		
		model.put("listcstmr", cstmrs);
		model.put("srchCstmr", cstmrVo);
		model.put("shopVo", shopVo);
		model.put("staffVo", staffVo);
		return "cstmr/cstmrListFmlyCd";
	}
	
	@RequestMapping(value = "reFindCstmr")
	public String reFindCstmr(CstmrVo cstmrVo,HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
		logger.info("run reFindCstmr");

		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		String searchText1 = cstmrVo.getSearchText1();
		String searchText2 = cstmrVo.getSearchText2();
		String searchTy1 = cstmrVo.getSearchTy1();
		String searchTy2 = cstmrVo.getSearchTy2();
		
		cstmrVo = setSearchKeyword(searchText1,searchTy1,cstmrVo);
		cstmrVo = setSearchKeyword(searchText2,searchTy2,cstmrVo);
		
		List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
		
		model.put("listcstmr", cstmrs);
		model.put("srchCstmr", cstmrVo);
		model.put("shopVo", shopVo);
		model.put("staffVo", staffVo);
		return "cstmr/cstmrListFmlyCd";
	}
	
	@RequestMapping(value = "cstmrListForm")
	public String cstmrListPageForm(CstmrVo cstmrVo,HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {
		
		ShopVo shopVo = (ShopVo)session.getAttribute(CommonCode.ATTR_SHOP);
		StaffVo staffVo = (StaffVo)session.getAttribute(CommonCode.ATTR_STAFF);
		String searchText1 = cstmrVo.getSearchText1();
		String searchText2 = cstmrVo.getSearchText2();
		String searchTy1 = cstmrVo.getSearchTy1();
		String searchTy2 = cstmrVo.getSearchTy2();
		
		logger.info("run staffId:"+staffVo.getStaffId());
		logger.info("run staffVo:"+shopVo.getShopId());
		
		cstmrVo = setSearchKeyword(searchText1,searchTy1,cstmrVo);
		cstmrVo = setSearchKeyword(searchText2,searchTy2,cstmrVo);
		
		String tmpCstmrCd = cstmrVo.getCstmrCd();
		if(tmpCstmrCd!=null)
		{
			tmpCstmrCd = tmpCstmrCd.replace("-", "000000");
			cstmrVo.setCstmrCd(tmpCstmrCd);
		}
		
		String tmpFmlyCd = cstmrVo.getFmlyCd();
		if(tmpFmlyCd!=null)
		{
			tmpFmlyCd=tmpFmlyCd.replace("-", "000000");
			cstmrVo.setFmlyCd(tmpFmlyCd);
		}
		
		
		//List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
		List<CstmrVoSecu> cstmrs=cstmrService.listCstmrDataSecu(cstmrVo);
		
		model.put("listcstmr", cstmrs);
		model.put("srchCstmr", cstmrVo);
		model.put("shopVo", shopVo);
		model.put("staffVo", staffVo);
		return "cstmr/cstmrListForm";
	}
	
	@RequestMapping(value = "cstmrVisit")
	public String cstmrVisit(CstmrVo cstmrVo,ModelMap model) throws Exception {
		System.out.println("cstmrVo="+cstmrVo.toString());		
		List<CstmrVo> cstmrs=cstmrService.listCstmrData(cstmrVo);
		System.out.println(cstmrs.size());
		model.put("listcstmr", cstmrs);
		return "cstmr/cstmrListForm";
	}
	
	@RequestMapping(value = "test")
	public String test(ModelMap model) throws Exception {
		return "home";
	}
	
	@RequestMapping(value = "indexPrdctForm")
	public String indexPrdctForm(ModelMap model,HttpServletRequest request,HttpSession session) {
		logger.info("call indexPrdctForm ");
				
		Integer cstmrId=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId();
		String cstmrName=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName();
		model.addAttribute("cstmrId", cstmrId);
		model.addAttribute("cstmrName", cstmrName);
		
		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		model.addAttribute("saleVo", getSale);
		
		return "tiles:prdct/indexPrdctProcessForm";
	}
	
	@RequestMapping(value = "indexCstmrForm")
	public String indexCstmrForm(ModelMap model,HttpServletRequest request,HttpSession session) {
		logger.info("call indexPrdctForm ");
				
		Integer cstmrId=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrId();
		String cstmrName=((CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR)).getCstmrName();
		model.addAttribute("cstmrId", cstmrId);
		model.addAttribute("cstmrName", cstmrName);
		
		SaleVo getSale=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
		model.addAttribute("saleVo", getSale);
		
		return "tiles:prdct/indexPrdctProcessForm";
	}
	
	
	@RequestMapping(value="modifyCstmrInfo")
	@ResponseBody
	public String modifyCstmrInfo(CstmrVo cstmrVo){
		String result = "";
		try {
			result = cstmrService.modifyCstmrInfo(cstmrVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getCstmrInfo")
	@ResponseBody
	public CstmrVo getCstmrInfo(CstmrVo cstmrVo){
		try {
			cstmrVo = cstmrService.getCstmrInfo(cstmrVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cstmrVo;
	}
	
	
	@RequestMapping(value="getCstmrVIsitInfo")
	@ResponseBody
	public CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo){
		try {
			cstmrVo = cstmrService.getCstmrVIsitInfo(cstmrVo);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cstmrVo;
	}
	
	@RequestMapping(value="getLastData")
	@ResponseBody
	public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo){
		try {
			cstmrHstryVo = cstmrHstryService.getLastData(cstmrHstryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cstmrHstryVo;
	}
}
