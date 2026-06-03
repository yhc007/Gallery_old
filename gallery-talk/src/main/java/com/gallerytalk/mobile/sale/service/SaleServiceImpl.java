package com.gallerytalk.mobile.sale.service;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gallerytalk.mobile.check.domain.CheckVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.prdct.service.PrdctService;
import com.gallerytalk.mobile.sale.domain.SaleHistSearchVo;
import com.gallerytalk.mobile.sale.domain.SalePrdctVo;
import com.gallerytalk.mobile.sale.domain.SaleVo;

@Service
@Repository
public class SaleServiceImpl extends SqlSessionDaoSupport implements SaleService{

	private final static String namespace= "com.gallerytalk.sale.";
	private final static String checkspace= "com.gallerytalk.check.";
	private final static String jobspace= "com.gallerytalk.salejob.";
	private final static String prdctspace= "com.gallerytalk.prdct.";
	private final static String eventspace= "com.gallerytalk.event.";
	@Autowired
	PrdctService prdctService;
	
	@Override
	@Transactional
	public SaleVo addSaleProcess(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("before addSale - saleVo:"+saleVo);
		SqlSession sqlSession=getSqlSession();
		
		if(null==saleVo.getDatetime()){
			TimeZone tz;
		    Date date = new Date();
		    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
		    tz = TimeZone.getTimeZone("Asia/Seoul");
		    df.setTimeZone(tz);
			
	    	String today = df.format(date);
	    	saleVo.setDatetime(today);
		}
		
		sqlSession.insert(namespace+"addSale", saleVo);
		logger.info("Sale gid="+saleVo.getShopOrderNo());
		final Integer orderNo=Integer.valueOf(saleVo.getShopOrderNo());
		SaleVo getSale=new SaleVo();
		//getSale.setSaleId(saleId);
		getSale.setSaleId(orderNo);
		return getSale;
	}
	
	
	@Override
	@Transactional
	public String addInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.insert(namespace+"addInvnHist", salePrdctVo);
		
		return "success";
	}
	
	@Override
	@Transactional
	public String addFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.insert(namespace+"addFrameInvnHist", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String addLensInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.insert(namespace+"addLensInvnHist", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String addCLensInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.insert(namespace+"addCLensInvnHist", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String addAccInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.insert(namespace+"addAccInvnHist", salePrdctVo);
		
		return "success";
	}
	
	@Override
	@Transactional
	public String modifySaleAndCheckDate(SaleVo saleVo, CheckVo checkVo) throws Exception {
		// TODO Auto-generated method stub
		logger.info("run modifySaleAndCheckDate");
		SqlSession sqlSession=getSqlSession();
		
		String saleDate = saleVo.getDatetime();
		String cardDate = saleVo.getCardDate();
		Integer cardTy = saleVo.getCardTy();
		String checkDate = checkVo.getDatetime(); 
		logger.info("saleDate:"+saleDate);		
		logger.info("cardDate:"+checkDate);
		logger.info("cardTy:"+cardTy);
		logger.info("checkDate:"+checkDate);
		if(	(saleDate==null||saleDate.equals(""))
				&& (cardDate==null||cardDate.equals(""))
				&& (cardTy==null || cardTy.intValue()==0)
				&& (checkDate==null||checkDate.equals(""))	)
		{
			logger.info("end modifySaleAndCheckDate : noDateInfo");
			return "noDateInfo";
		}
		
		if(	!(saleDate==null||saleDate.equals(""))
				|| !(cardDate==null||cardDate.equals(""))
				|| !(cardTy==null || cardTy.intValue()==0)
			)
		{
			sqlSession.update(namespace+"modifySaleDate",saleVo);
			logger.info("run modifySaleDate");
		}
		
		
		if(! (checkDate==null||checkDate.equals(""))	)
		{
			sqlSession.update(checkspace+"modifyCheckDate",checkVo);
			logger.info("run modifyCheckDate");
		}
		
		logger.info("end modifySaleAndCheckDate : success");
		return "success";
	}
	
	@Override
	@Transactional
	public String modifyResult(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		char resultArray[] = saleVo.getResult().toCharArray();
		
		if(resultArray[saleProcess] != (char)isCOMPLETED)
		{
			resultArray[saleProcess] = (char)isCOMPLETED ;
			saleVo.setResult(new String(resultArray));
			
			sqlSession.update(namespace+"modifyResult", saleVo);
			
			
			return saleVo.getResult();
		}
		return saleVo.getResult();
	}
	
	@Override
	@Transactional
	public String decCntLensInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"decCntLensInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String decCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"decCntCLensInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String decCntAccInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"decCntAccInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String decCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"decCntFrameInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String decCntInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"decCntInvn", salePrdctVo);
		
		return "success";
	}
	
	
	@Override
	@Transactional
	public String incCntInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"incCntInvn", salePrdctVo);
		
		return "success";
	}
	
	@Override
	@Transactional
	public String incCntLensInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"incCntLensInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String incCntCLensInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"incCntCLensInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String incCntAccInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"incCntAccInvn", salePrdctVo);
		
		return "success";
	}
	@Override
	@Transactional
	public String incCntFrameInvn(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.update(namespace+"incCntFrameInvn", salePrdctVo);
		
		return "success";
	}
	
	@Override
	public String checkFrameInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Integer num = (Integer)sqlSession.selectOne(namespace+"checkFrameInvnHist", salePrdctVo);
		logger.info("result num is : "+num);
		return num==0?"ok":"duple";
	}
	public String checkInvnHist(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		
		Integer num = (Integer)sqlSession.selectOne(namespace+"checkInvnHist", salePrdctVo);
		logger.info("result num is : "+num);
		return num==0?"ok":"duple";
	}
	
	@Override
	@Transactional
	public String removeInvnHist(SalePrdctVo salePrdctVo) throws Exception
	{
		SqlSession sqlSession=getSqlSession();
		
		sqlSession.delete(namespace+"removeInvnHist", salePrdctVo);
		
		return "success";
	}
	
	@Override
	@Transactional
	public String modifyResultOgnPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED, int prdctPrc,boolean isAdd) throws Exception {
		// TODO Auto-generated method stub
		logger.info("run modifyResultOgnPrc saleVo:"+saleVo);
		SqlSession sqlSession=getSqlSession();
		
		char resultArray[] = saleVo.getResult().toCharArray();
		
		if(resultArray[saleProcess] != (char)isCOMPLETED)
		{
			resultArray[saleProcess] = (char)isCOMPLETED ;
		}
		saleVo.setResult(new String(resultArray));
		if(isAdd){
			
			saleVo.setOgnPrice(prdctPrc);
		}else{
			prdctPrc= -prdctPrc;
			saleVo.setOgnPrice(prdctPrc);
		}
		logger.info("saleVo:"+saleVo);
		sqlSession.update(namespace+"modifyResultOgnPrice", saleVo);
		
		return saleVo.getResult();
	}
	
	
	@Override
	@Transactional
	public String modifyResultPayPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED) throws Exception {
		logger.info("run modifyResultPayPrc");
		SqlSession sqlSession=getSqlSession();
		
		char resultArray[] = saleVo.getResult().toCharArray();
		
		if(resultArray[saleProcess] != (char)isCOMPLETED)
		{
			resultArray[saleProcess] = (char)isCOMPLETED ;
		}
		saleVo.setResult(new String(resultArray));
	
		sqlSession.update(namespace+"modifyResultPayment", saleVo);
		
		return saleVo.getResult();
	}
	
	@Override
	public Integer checkSaleCstrm(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Integer result=(Integer)sqlSession.selectOne(namespace+"countSaleCstmr", saleVo);
		
		return result;
	}

	
	@Override
	public Map listSaleData(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(namespace+"listSale", saleVo);
		resultMap.put("listSale", saleList);
		
		return resultMap;
	}
	
	
	
	@Override
	public Map listSaleHistData(SaleHistSearchVo searchVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(namespace+"listSaleHist", searchVo);
		resultMap.put("listsale", saleList);
		
		return resultMap;
	}
	
//	@Override
//	public Map listSaleOffHist(SaleVo saleVo) throws Exception {
//		// TODO Auto-generated method stub
//		SqlSession sqlSession=getSqlSession();
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"listSaleOffHist", saleVo);
//		resultMap.put("listSaleOffHist", saleList);
//		
//		return resultMap;
//	}
	
	
		
	
	@Override
	public Map listSalesHistData(SaleHistSearchVo searchVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List salesList=sqlSession.selectList(namespace+"listSalesHist", searchVo);
		resultMap.put("listsales", salesList);
		
		return resultMap;
	}
	
	@Override
	public Map listPrdctSaleHistData(SaleHistSearchVo searchVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(namespace+"listPrdctSaleHist", searchVo);
		resultMap.put("listsale", saleList);
		
		return resultMap;
	}	
	@Override
	public SaleVo selectSale(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (SaleVo)sqlSession.selectOne(namespace+"getSale", saleVo);
	}
	
	@Override
	public SalePrdctVo selectSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (SalePrdctVo)sqlSession.selectOne(namespace+"getSalePrdctOff", salePrdctVo);
	}
	
	@Override
	public SalePrdctVo selectNewSalePrdctOff(SalePrdctVo salePrdctVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (SalePrdctVo)sqlSession.selectOne(namespace+"getNewSalePrdctOff", salePrdctVo);
	}
	
	@Override
	public Map listSelectPastPurchased(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		List <SaleVo> purchasedList = sqlSession.selectList(namespace+"listPastPurchasedFrame", saleVo);
		purchasedList.addAll(sqlSession.selectList(namespace+"listPastPurchasedLens", saleVo));
		purchasedList.addAll(sqlSession.selectList(namespace+"listPastPurchasedClens", saleVo));

		logger.info("purchasedList:"+purchasedList);
		Collections.sort(purchasedList);
		logger.info("purchasedList:"+purchasedList);

		
		resultMap.put("listPurchased",purchasedList);
		
//		resultMap.put("listPurchasedLens",purchasedList2);
//		resultMap.put("listPurchasedClens",purchasedList3);
		
		return resultMap;
	}
	
	@Override
	public Map listPastPurchasedOld(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		List <SalePrdctVo> purchasedOldList = sqlSession.selectList(namespace+"listPastPurchasedOld", saleVo);
		resultMap.put("listPurchasedOld",purchasedOldList);
		
		return resultMap;
	}
	
	
	@Override
	public Map listSelectPastPurchasedNewPrdct(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		Map resultMap = new HashMap();
		List purchasedList = sqlSession.selectList(namespace+"listPastPurchasedNewPrdct", saleVo);
		resultMap.put("listPurchasedNewPrdct",purchasedList);
		
		return resultMap;
	}
	
	
	@Override
	public SaleVo selectSaleForCstmrAndResult(SaleVo saleVo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		return (SaleVo)sqlSession.selectOne(namespace+"getSaleForCstmrAndResult", saleVo);
	}


	@Override
	public void mListSaleData(HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		SqlSession sqlSession=getSqlSession();
		String str="";
		//response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
		PrintWriter writer=response.getWriter();
		
		Map resultMap=new HashMap();
		List saleList=sqlSession.selectList(namespace+"mlistSale");
		resultMap.put("listSale", saleList);
		
		ObjectMapper om = new ObjectMapper();
		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		
		
		writer.write(str);
		writer.flush();
		writer.close();
	}

	@Override
	public Map getPayCardInfo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		List listCard = sql.selectList(namespace + "getPayCardInfo", saleVo);
		Map resultMap = new HashMap();
		resultMap.put("listCard", listCard);
		return resultMap;
	}
	
	@Override
	public String getSaleMemo(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		String memo = (String) sql.selectOne(namespace + "getSaleMemo",saleVo);
		return memo;
	}

	@Override
	@Transactional
	public String SaleMemoUpdate(SaleVo saleVo) throws Exception {
		SqlSession sql = getSqlSession();
		sql.update(namespace + "saleMemoUpdate",saleVo);
		return "success";
	}


}
