package com.gallery.web.prdct.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.print.attribute.standard.PDLOverrideSupported;
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

import com.gallery.web.brand.domain.BrandVo;
import com.gallery.web.brand.service.BrandService;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.MenuTreeVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;
import com.gallery.web.shop.domain.ShopVo;

/**
 * Handles requests for the application home page.
 */
@RequestMapping(value = "/prdct")
@Controller
public class PrdctController {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdctController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private PrdctService prdctService;
	@Autowired
	private BrandService brandService;
	
	
	@RequestMapping(value = "indexPrdctForm")
	public String indexPrdctForm(ModelMap model,Integer prdctId,HttpServletRequest request) {
		try{
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
			model.addAttribute("prdctId",prdctId);
		}catch(Exception e){
			e.printStackTrace();
		}

		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("������ ������",120,"center",0));
		tlist.add(new MenuTreeVo("������ ������ ������",620,"left",20));
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("formnum", 2);
		
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		return "tiles:prdct/indexPrdctForm";
	}
	
	@RequestMapping(value = "modifyPrdctPrc")
	public void modifyPrdctPrc(PrdctVo prdctVo){
		System.out.println("modifyPrc : " + prdctVo.toString());
		try {
			prdctService.modifyPrdctPrc(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "indexPrdctConfirmForm")
	public String indexPrdctConfirmForm(ModelMap model,HttpServletRequest request, HttpSession session) {
		try{
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("������ ������",120,"center",0));
		tlist.add(new MenuTreeVo("������ ������",620,"left",20));
		model.addAttribute("formnum", 3);
		model.addAttribute("tlist", tlist);
		
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<3){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:prdct/indexPrdctConfirmForm";
		}
		return rtnPage;
	}
	
	@RequestMapping(value = "indexPrdctRemainForm")
	public String indexPrdctRemainForm(ModelMap model,HttpServletRequest request) {
		try{
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("������ ������",120,"center",0));
		tlist.add(new MenuTreeVo("������ ������",620,"left",20));
		model.addAttribute("formnum", 4);
		model.addAttribute("tlist", tlist);
		
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_PRDCT);
		return "tiles:prdct/indexPrdctRemainForm";
	}
	
	
	
	@RequestMapping(value = "indexPrdctInvnHistForm")
	public String indexPrdctInvnHistForm(ModelMap model,HttpServletRequest request, HttpSession session) {
		try{
			model.addAllAttributes(brandService.listBrandData(new BrandVo()));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		List<MenuTreeVo> tlist=new ArrayList<MenuTreeVo>();
		tlist.add(new MenuTreeVo("������ ������",120,"center",0));
		tlist.add(new MenuTreeVo("������ ������",620,"left",20));
		model.addAttribute("formnum", 1);
		model.addAttribute("tlist", tlist);
		
		request.setAttribute("topMenuId", CommonCode.MENU_CODE_HIST);
		
		String rtnPage = "";
		Integer lv = (Integer) session.getAttribute("lv");
		if(lv==null){
			lv = 0;
		}
		if(lv<1){
			rtnPage = "tiles:access/denied";
		}else{
			rtnPage = "tiles:prdct/indexPrdctInvnHistForm";
		}
		return rtnPage;
	}
	
	@RequestMapping(value = "popupPrdctForm")
	public String popupPrdctForm(ModelMap model,PrdctVo prdctVo, HttpSession session) {
		logger.debug("CALL popup ->"+prdctVo);
		Integer shopId = (Integer)session.getAttribute("shopId");
		
		try{
			model.addAttribute("prdctVo",prdctService.selectPrdct(prdctVo));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "prdct/popupPrdctForm";
	}
	
	
	@RequestMapping(value = "popupPrdctInvnHistForm")
	public String popupPrdctInvnHistForm(ModelMap model,PrdctVo prdctVo) {
		logger.debug("CALL popup ->"+prdctVo);
		
		try{
			model.addAttribute("prdctVo",prdctService.selectPrdctInvnHist(prdctVo));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "prdct/popupPrdctInvnHistForm";
	}
	
	
	@RequestMapping(value = "addPrdctAction")
	@ResponseBody
	public String addPrdctAction(PrdctVo prdctVo, HttpSession session) {
		logger.debug("add "+prdctVo.toString());
		System.out.println("prdct : " + prdctVo.toString());
		try{
			String result=prdctService.addPrdct(prdctVo);
			
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "addPrdctColor")
	@ResponseBody
	public String addPrdctColor(PrdctVo prdctVo) {
		try{
			String result=prdctService.addPrdctColor(prdctVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "modifyPrdctAction")
	@ResponseBody
	public String modifyPrdctAction(PrdctVo prdctVo) {
		try{
			prdctService.modifyPrdct(prdctVo);
			return "upsuccess";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "removePrdctAction")
	@ResponseBody
	public String removePrdctAction(PrdctVo prdctVo) {
		logger.debug("remove "+prdctVo.toString());
		try{
			prdctService.removePrdct(prdctVo);
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "updatePrdctAcptAction")
	@ResponseBody
	public String updatePrdctAcptAction(PrdctVo prdctVo) {
		logger.debug("updatePrdctAcptAction "+prdctVo.toString());
		try{
			String result=prdctService.modifyPrdctAcpt(prdctVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	
	@RequestMapping(value = "updatePrdctInvnAction")
	@ResponseBody
	public String updatePrdctInvnAction(PrdctVo prdctVo) {
		logger.debug("updatePrdctInvnAction "+prdctVo.toString());
		try{
			String result=prdctService.modifyPrdctInvn(prdctVo);
			return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
	
	@RequestMapping(value = "listPrdctData")//������
	public String listPrdctData(PrdctVo prdctVo,ModelMap model,HttpSession session) {
		logger.debug("listPrdctData "+prdctVo.toString());
		try{
			Map map=prdctService.pagedListPrdctData(prdctVo);
			System.out.println("������ : " + map);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "prdct/listPrdctData";
	}
	@RequestMapping(value = "listPrdctRemainData")
	public String listPrdctRemainData(PrdctVo prdctVo,ModelMap model) {
		logger.debug("listPrdctData "+prdctVo.toString());
		try{
			Map map=prdctService.pagedListPrdctRemainData(prdctVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "prdct/listPrdctRemainData";
	}
	
	@RequestMapping(value = "listPrdctInvnHistData")
	public String listPrdctInvnHistData(PrdctVo prdctVo,ModelMap model) {
		logger.debug("listPrdctData "+prdctVo.toString());
		try{
			Map map=prdctService.pagedListPrdctInvnHistData(prdctVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "prdct/listPrdctInvnHistData";
	}
	
	@RequestMapping(value = "listPrdctColor")
	@ResponseBody
	public String listPrdctColor(PrdctVo prdctVo,ModelMap model) {
		logger.debug("listPrdctData "+prdctVo.toString());
		try{
			String rtn=prdctService.listPrdctColor(prdctVo);
			System.out.println(rtn);
			return rtn;
			//return "{\"listColor\":[{\"a\":\"b\"},{\"b\":\"c\"}]}";
		}catch(Exception e){
			e.printStackTrace();
			return "{\"listColor\":[{\"a\":\"b\"}]}";
		}
	}
	
	
	
	@RequestMapping(value = "listPrdctConfirmData")
	public String listPrdctConfirmData(PrdctVo prdctVo,ModelMap model) {
		logger.debug("modify "+prdctVo.toString());
		try{
			Map map=prdctService.pagedListPrdctConfirmData(prdctVo);
			model.addAllAttributes(map);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "prdct/listPrdctConfirmData";
	}
	
	@RequestMapping(value ="getPrdctData.do")
	@ResponseBody
	public PrdctVo getCstmrDatgetFunctiona(PrdctVo prdctVo)throws Exception{
		
		PrdctVo bb=prdctService.selectPrdct(prdctVo);
		logger.debug(bb.toString());
		return bb;
	} 
	
	
	
	@RequestMapping(value = "mListFrameData")
	public String mListFrameData(HttpServletResponse response,PrdctVo prdctVo) {
		
		logger.debug("mListFrameData "+prdctVo.toString());
		try{
			prdctService.responseFrameData(prdctVo,response);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "home";
	}
	
	@RequestMapping(value = "mListLensData")
	public String mListLensData(HttpServletResponse response,PrdctVo prdctVo) {
		logger.debug("modify "+prdctVo.toString());
		try{
			prdctService.responseLensData(prdctVo,response);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "home";
	}
	
	
	@RequestMapping(value = "mListDsplyPrdctData")
	public String mListDsplyPrdctData(HttpServletResponse response,PrdctVo prdctVo) {
		logger.debug("modify "+prdctVo.toString());
		try{
			prdctService.responseDsplyLensData(prdctVo,response);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "home";
	}
	
	//	@RequestMapping(value = "rotate")
//	public String home(Locale locale, Model model,MediaVo mediaVo) throws Exception {
//		logger.info("Welcome home! The client locale is {}.", locale);
//		
//		String path=mediaService.selectRotatePath(mediaVo);
//		model.addAttribute("rotatePath", path);
//		return "media/rotate";
//	}
//	
	@RequestMapping(value = "lensSelect")
	public String lensSelect(Locale locale, Model model,PrdctVo prdctVo) throws Exception {
		logger.info("step 1");
		List<PrdctVo> lensList=prdctService.selectLensPath(prdctVo);
		logger.info("step 2");
		model.addAttribute("lensPath", lensList);
		logger.info("step 3");
		logger.info(lensList.toString());
		return "prdct/lensSelector";
	}
	
	@RequestMapping(value="getPrdctListByBrand")
	public String getPrdctListByBrand(BrandVo brandVo, ModelMap model){
		
		Map map;
		try {
			map = prdctService.getPrdctListByBrand(brandVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "prdct/prdctListGroupBrand";
		
	}
	
	
	@RequestMapping(value="delHistData")
	@ResponseBody
	public void delHistData(PrdctVo prdctVo){
		try {
			prdctService.delHistData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@RequestMapping(value="delLensHistData")
	@ResponseBody
	public void delLensHistData(PrdctVo prdctVo){
		try {
			prdctService.delLensHistData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@RequestMapping(value="delClensHistData")
	@ResponseBody
	public void delClensHistData(PrdctVo prdctVo){
		try {
			prdctService.delClensHistData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@RequestMapping(value="delClensAccHistData")
	@ResponseBody
	public void delClensAccHistData(PrdctVo prdctVo){
		try {
			prdctService.delClensAccHistData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value="getMtrl")
	//param :brandId
	public String getMtrl(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getMtrl(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/mtrlList";
	}
	
	@RequestMapping(value="getFunction")
	//param : mtrlId
	public String getFunction(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getFunction(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listFunctionData";
	}
	
	@RequestMapping(value="getPrdctListLens")
	public String getPrdctListLens(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getPrdctListLens(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/prdctListLens";
	}
	
	
	@RequestMapping(value="getPrdctListClens")
	public String getPrdctListClens(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getPrdctListClens(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/prdctListLens";
	}
	
	@RequestMapping(value="getClensList")
	public String getClensList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getClensList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/prdctListLens";
	}
	
	@RequestMapping(value="getEtcList")
	public String getEtcList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getEtcList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/prdctListLens";
	}
	
	@RequestMapping(value="getLensData")
	public String getLensData(PrdctVo prdctVo, ModelMap model){
		System.out.println("prdctParam : " + prdctVo.toString());
		try {
			Map map = prdctService.getLensData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listRateData";
	}
	
	
	@RequestMapping(value="getPrdctPrc")
	@ResponseBody
	public PrdctVo getPrdctRate(PrdctVo prdctVo){
		PrdctVo prdct = new PrdctVo();
		try {
			prdct = (PrdctVo)prdctService.getPrdctPrc(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prdct;
	}
	
	@RequestMapping(value="getClensPrc")
	@ResponseBody
	public PrdctVo getClensPrc(PrdctVo prdctVo){
		PrdctVo prdct = new PrdctVo();
		try {
			prdct = (PrdctVo)prdctService.getClensPrc(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prdct;
	}
	@RequestMapping(value="getClensAccPrc")
	@ResponseBody
	public PrdctVo getClensAccPrc(PrdctVo prdctVo){
		PrdctVo prdct = new PrdctVo();
		try {
			prdct = (PrdctVo)prdctService.getClensAccPrc(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prdct;
	}
	@RequestMapping(value="addLens")
	@ResponseBody
	public String addLens(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addInvnLensData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return  result;
	}
	
	@RequestMapping(value="addClens")
	@ResponseBody
	public String addClens(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addInvnClensData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return  result;
	}
	
	
	@RequestMapping(value="addClensAcc")
	@ResponseBody
	public String addClensAcc(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addInvnClensAccData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return  result;
	}
	@RequestMapping(value="getClensTyList")
	public String getClensTyList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getClensTyList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listClensTyListData";
	}
	
	
	@RequestMapping(value="getPrdctUnit")
	public String getPrdctUnit(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getPrdctUnit(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listUnitdata";
	}
	@RequestMapping(value="getClensTyList2")
	public String getClensTyList2(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getClensTyList2(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listClensTyListData";
	}
	
	@RequestMapping(value="getNewClensTyList2")
	public String getNewClensTyList2(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getNewClensTyList2(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "invn/listClensTyListData";
	}
	@RequestMapping(value="getAccId")
	@ResponseBody
	public String getAccId(PrdctVo prdctVo){
		String prdctId = "";
		try {
			prdctId = prdctService.getAccId(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prdctId;
	}
	
	@RequestMapping(value="modifyComPrdct")
	@ResponseBody
	public String modifyComPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.modifyComPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="changeComPrdctColor")
	@ResponseBody
	public String changeComPrdctColor(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.changeComPrdctColor(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="getComPrdct")
	public String getComPrdct(PrdctVo prdctVo, ModelMap model){
		
		try {
			Map map = prdctService.getComPrdct(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "com/getComPrdct";
	}
	
	@RequestMapping(value="addNewComPrdct")
	@ResponseBody
	public String addNewComPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addNewComPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="allowPrdct")
	@ResponseBody
	public String allowPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.allowPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return result;
	}
	
	@RequestMapping(value="rejectPrdct")
	@ResponseBody
	public String rejectPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.rejectPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return result;
	}
	
	@RequestMapping(value="delRequestPrdct")
	@ResponseBody
	public String delRequestPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.delRequestPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getOrderList")
	public String getOrderList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getOrderList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "com/listOrderData";
	}
	
	@RequestMapping(value="getDeliverList")
	public String getDeliverList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getDeliverList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "com/listDeliverData";
	}
	
	@RequestMapping(value="deliverPrdct")
	@ResponseBody
	public String deliverPrdct(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.deliverPrdct(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getPrdctCnt")
	@ResponseBody
	public String getPrdctCnt(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.getPrdctCnt(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="addNewClensTy1")
	@ResponseBody
	public String addNewClensTy1(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addNewClensTy1(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="addNewClensTy2")
	@ResponseBody
	public String addNewClensTy2(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addNewClensTy2(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	@RequestMapping(value="getNewTyList")
	public String getNewTyList(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getNewTyList(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "invn/listClensTyListData"; 
	}
	
	@RequestMapping(value="deleteDeliverData")
	@ResponseBody
	public String deleteDeliverData(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.deleteDeliverData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="modifyLensRate")
	@ResponseBody
	public String modifyLensRate(PrdctVo prdctVo	){
		String result = "";
		try {
			result = prdctService.modifyLensRate(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="modifyClensData")
	@ResponseBody
	public String modifyClensData(PrdctVo prdctVo	){
		String result = "";
		try {
			result = prdctService.modifyClensData(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="chagneAccUnit")
	@ResponseBody
	public String chagneAccUnit(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.chagneAccUnit(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getReceipt")
	public String getReceipt(PrdctVo prdctVo, ModelMap model){
		try {
			Map map, map2, map3, map4, map5, map6, map7, map8, map9, map10;
			map = prdctService.getReceipt(prdctVo);
			map2 = prdctService.getReceiptLens(prdctVo);
			map3 = prdctService.getReceiptClens(prdctVo);
			map4 = prdctService.getReceiptAcc(prdctVo);
			map5 = prdctService.getReceiptEtc(prdctVo);
			
			map6 = prdctService.getRtnFrame(prdctVo);
			map7 = prdctService.getRtnLens(prdctVo);
			map8 = prdctService.getRtnClens(prdctVo);
			map9 = prdctService.getRtnAcc(prdctVo);
			map10 = prdctService.getRtnEtc(prdctVo);

			model.addAllAttributes(map);
			model.addAllAttributes(map2);
			model.addAllAttributes(map3);
			model.addAllAttributes(map4);
			model.addAllAttributes(map5);
			model.addAllAttributes(map6);
			model.addAllAttributes(map7);
			model.addAllAttributes(map8);
			model.addAllAttributes(map9);
			model.addAllAttributes(map10);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "prdct/receiptData";
	}
	
	@RequestMapping(value="getReceiptHeader")
	public String getReceiptHeader(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getReceiptHeader(prdctVo);
			model.addAllAttributes(map);
			model.addAttribute("iNum",prdctVo.getINum());
			model.addAttribute("shopId",prdctVo.getShopId());
			model.addAttribute("sdate",prdctVo.getSdate());
			model.addAttribute("edate",prdctVo.getEdate());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "prdct/receiptHeader";
	}
	
	@RequestMapping(value="addNewLensTy")
	@ResponseBody
	public String addNewLensTy(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.addNewLensTy(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
		
	}
	
	@RequestMapping(value="showAllLensType")
	public String showAllLensType(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.showAllLensType(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "invn/listFunctionData";
	}
	
	@RequestMapping(value="modifyPrdctCnt")
	@ResponseBody
	public String modifyPrdctCnt(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.modifyPrdctCnt(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="getRtnMsg")
	@ResponseBody
	public PrdctVo getRtnMsg(PrdctVo prdctVo){
		try {
			prdctVo = prdctService.getRtnMsg(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return prdctVo;
	}
	
	@RequestMapping(value="allowRtn")
	@ResponseBody
	public String allowRtn(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.allowRtn(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="modifyShopInvn")
	@ResponseBody
	public String modifyShopInvn(PrdctVo prdctVo){
		String result = "";
		try {
			result = prdctService.modifyShopInvn(prdctVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping(value="selectCom")
	public String selectCom(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.selectCom(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "company/listComData";
	}
	
	@RequestMapping(value="getTradeData")
	public String getTradeData(PrdctVo prdctVo,ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "prdct/listTradeData";	
	}
	
	@RequestMapping(value="getTradeDataS")
	public String getTradeDataS(PrdctVo prdctVo,ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "prdct/listTradeDataS";	
	}
	
	@RequestMapping(value="getTradeGroupData")
	public String getTradeGroupData(PrdctVo prdctVo, ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeGroupData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "prdct/listTradeGroupData";
	}
	
	@RequestMapping(value="getTradeGroupDataS")
	public String getTradeGroupDataS(PrdctVo prdctVo, ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeGroupData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "prdct/listTradeGroupDataS";
	}
	
	@RequestMapping(value="goPrintPage")
	public String goPrintPage(PrdctVo prdctVo, ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "admin/trdePrintPage";
	}
	
	@RequestMapping(value="goPrintPageS")
	public String goPrintPageS(PrdctVo prdctVo, ModelMap model){
		model.addAttribute("thisMonth", prdctVo.getSdate());
		try {
			Map map = prdctService.getTradeData(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "admin/trdePrintPageS";
	}
	
	@RequestMapping(value="getTradeListAll")
	public String getTradeListAll(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getTradeListAll(prdctVo);
			model.addAllAttributes(map);
			System.out.println("@@@@@@@@@@@@@@@@" + map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/trdeListAll";
	}
	
	@RequestMapping(value="getTradeListAllC")
	public String getTradeListAllC(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getTradeListAllC(prdctVo);
			model.addAllAttributes(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/trdeListAllC";
	}
	
	@RequestMapping(value = "csv")
	public String csv(String csv) {
		try{
			logger.debug("run csv");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "admin/csv"; 
	}
	
	@RequestMapping(value="getTradeDataCsv")
	public String getTradeDataCsv(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getTradeDataCsv(prdctVo);
			model.addAllAttributes(map);
			model.addAttribute("sdate",prdctVo.getSdate());
			model.addAttribute("edate",prdctVo.getEdate());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/getTradeDataCsv";
	}
	
	
	@RequestMapping(value="getTradeDataCsvS")
	public String getTradeDataCsvS(PrdctVo prdctVo, ModelMap model){
		try {
			Map map = prdctService.getTradeDataCsvS(prdctVo);
			model.addAllAttributes(map);
			model.addAttribute("sdate",prdctVo.getSdate());
			model.addAttribute("edate",prdctVo.getEdate());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/getTradeDataCsvS";
	}
}
