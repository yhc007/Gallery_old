package com.gallery.prdct;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.brand.BrandVo;
import com.gallery.shop.ShopVo;

public interface PrdctService {
	String addPrdct(PrdctVo prdctVo) throws Exception;
	String addPrdctColor(PrdctVo prdctVo) throws Exception;
	Integer countPrdctForBrand(BrandVo brandVo) throws Exception;
	void modifyPrdct(PrdctVo prdctVo) throws Exception;
	String modifyPrdctAcpt(PrdctVo prdctVo) throws Exception;
	String modifyPrdctInvn(PrdctVo prdctVo) throws Exception;
	Map pagedListPrdctData(PrdctVo prdctVo) throws Exception;
	Map listPrdctDataForEvent(PrdctVo prdctVo) throws Exception;
	String listPrdctColor(PrdctVo prdctVo) throws Exception;
	Map pagedListPrdctConfirmData(PrdctVo prdctVo) throws Exception;
	Map pagedListPrdctRemainData(PrdctVo prdctVo) throws Exception;
	Map pagedListPrdctInvnHistData(PrdctVo prdctVo) throws Exception;
	PrdctVo selectPrdct(PrdctVo prdctVo) throws Exception;
	PrdctVo selectPrdctInvnHist(PrdctVo prdctVo) throws Exception;
	PrdctVo removePrdct(PrdctVo prdctVo) throws Exception;

	@Deprecated
	void responseFrameData(PrdctVo prdctVo,HttpServletResponse response) throws Exception;
    @Deprecated
	void responsePrdctTypeFrameData(PrdctVo prdctVo,HttpServletResponse response) throws Exception;
	@Deprecated
	void responseLensData(PrdctVo prdctVo,HttpServletResponse response) throws Exception;
    @Deprecated
	void responseDsplyLensData(PrdctVo prdctVo,HttpServletResponse response) throws Exception;
    @Deprecated
	List <PrdctVo> selectLensPath(PrdctVo prdctVo) throws Exception;
    @Deprecated
	void modifyPrdctPrc(PrdctVo prdctVo)throws Exception;
	Map getPrdctListByBrand(BrandVo branVo)throws Exception;
	Map getCntryList(PrdctVo prdctVo)throws Exception;
	String addPrdctInvn(PrdctVo prdctVo)throws Exception;
	Map getInvnList(ShopVo shopVo)throws Exception;
	Map getInvnHist(PrdctVo prdctVo)throws Exception;
	Map getColorList()throws Exception;
	Map getMtrlList()throws Exception;
	Integer getPrdctId(PrdctVo prdctVo)throws Exception;
	Map getReqstPrdct(PrdctVo prdctVo)throws Exception;
	PrdctVo getInvnEditForm(PrdctVo prdctVo)throws Exception;
	String modifyInvnPrdct(PrdctVo prdctVo)throws Exception;
	Integer insertDiffClr(PrdctVo ptdctVo)throws Exception;
	Map getMobilePrdct(PrdctVo prdctVo)throws Exception;
	PrdctVo getMobilePrdctInfo(PrdctVo prdctVo)throws Exception;
	Map getComPrdctList(PrdctVo prdctVo)throws Exception;
	PrdctVo getComPrdctEditForm(PrdctVo prdctVo)throws Exception;
	String orderPrdct(PrdctVo prdctVo)throws Exception;
	Map getOrderList(PrdctVo prdctVo)throws Exception;
	Map getOrderNewLensList(PrdctVo prdctVo)throws Exception;
	String receivePrdct(PrdctVo prdctVo)throws Exception;
	String addShopInvn(PrdctVo prdctVo)throws Exception;
	Map srchPrdct(PrdctVo prdctVo)throws Exception;
	Map getReceipt(PrdctVo prdctVo)throws Exception;
	Map getReceiptLens(PrdctVo prdctVo)throws Exception;
	Map getReceiptLens2(PrdctVo prdctVo)throws Exception;
	Map getReceiptClens(PrdctVo prdctVo)throws Exception;
	Map getReceiptAcc(PrdctVo prdctVo)throws Exception;
	Map getReceiptEtc(PrdctVo prdctVo)throws Exception;
	Map getReceiptHeader(PrdctVo prdctVo)throws Exception;
	PrdctVo getPrdctType(PrdctVo prdctVo)throws Exception;
	Map fncListPrdctInvnHistDataOutPut(PrdctVo prdctVo)throws Exception;
	Map getTradeData(PrdctVo prdctVo)throws Exception;
	Map getMtrl(PrdctVo prdctVo)throws Exception;
	Map getFunction(PrdctVo prdctVo)throws Exception;
	Map getLensList(PrdctVo prdctVo)throws Exception;
	Map getRate(PrdctVo prdctVo)throws Exception;
	String newOrder(PrdctVo prdctVo)throws Exception;
	String adNewLensData(PrdctVo prdctVo)throws Exception;
	String cancelOrder(PrdctVo prdctVo)throws Exception;
	Map showAllLensType(PrdctVo prdctVo) throws Exception;
	String addNewLensTy(PrdctVo prdctVo)throws Exception;
	Map getRtnReasonList()throws Exception;
	String ReturnPrdct(PrdctVo prdctVo)throws Exception;
	Map getLensListByType(PrdctVo prdctVo)throws Exception;
	String addNewRtnReason(PrdctVo prdctVo)throws Exception;
	Map getLensComList(PrdctVo prdctVo)throws Exception;
	Map getLensListForOrder(PrdctVo prdctVo)throws Exception;
	String lensOrder(PrdctVo prdctVo)throws Exception;
	String lensComOrder(PrdctVo prdctVo)throws Exception;
	Map getLensOrderList(PrdctVo prdctVo)throws Exception;
	Map getNewLensOrderList(PrdctVo prdctVo)throws Exception;
	PrdctVo getLensBound(PrdctVo prdctVo)throws Exception;
	Map getRtnFrame(PrdctVo prdctVo)throws Exception;
	Map getRtnLens(PrdctVo prdctVo)throws Exception;
	Map getRtnLens2(PrdctVo prdctVo)throws Exception;
	Map getRtnClens(PrdctVo prdctVo)throws Exception;
	Map getRtnAcc(PrdctVo prdctVo)throws Exception;
	Map getRtnEtc(PrdctVo prdctVo)throws Exception;
	String OrderRX(PrdctVo prdctVo)throws Exception;
	PrdctVo editLensRX(PrdctVo prdctVo)throws Exception;
	Map getColorCom(PrdctVo prdctVo)throws Exception;
	Map getColorList(PrdctVo prdctVo)throws Exception;
	String modifyLens(PrdctVo prdctVo)throws Exception;
	String modifySpareLensSpec(PrdctVo prdctVo)throws Exception;
	PrdctVo getOrderPrdctProp(PrdctVo prdctVo)throws Exception;
	PrdctVo getOrderPrdctProp2(PrdctVo prdctVo)throws Exception;
	String allowComOrder(PrdctVo prdctVo)throws Exception;
	String getComOrderCnt(PrdctVo prdctVo)throws Exception;
	Map getComListByCntry(PrdctVo prdctVo)throws Exception;
	Map getComListForOrd(PrdctVo prdctVo)throws Exception;
	Map getLensTyByCom(PrdctVo prdctVo)throws Exception;
	Map getLensSM(PrdctVo prdctVo)throws Exception;
	Map showDetail(PrdctVo prdctVo)throws Exception;
	PrdctVo getShopName(PrdctVo prdctVo)throws Exception;
	String addShopLensInvn(PrdctVo prdctVo)throws Exception;
	Map getComOrderList(PrdctVo prdctVo)throws Exception;
	String chkAdminAllow(PrdctVo prdctVo)throws Exception;
	Map getPrdctOption(PrdctVo prdctVo)throws Exception;
	String modiftOption(PrdctVo prdctVo)throws Exception;
	Map getPrdctRanking(PrdctVo prdctVo)throws Exception;
	Map getTradeListByCom(ShopVo shopVo)throws Exception;
	Map getTradeListForModify(PrdctVo prdctVo)throws Exception;
	String modifyDate(PrdctVo prdctVo)throws Exception;
	String comAllow(PrdctVo prdctVo)throws Exception;
	String getDetail(PrdctVo prdctVo)throws Exception;
	void modDetail(PrdctVo prdctVo)throws Exception;
	String delData(PrdctVo prdctVo)throws Exception;
}

