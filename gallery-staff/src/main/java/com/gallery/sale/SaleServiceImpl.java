package com.gallery.sale;

import com.gallery.check.CheckMapper;
import com.gallery.check.CheckVo;
import com.gallery.common.CommonCode;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
@Repository
@RequiredArgsConstructor
public class SaleServiceImpl implements SaleService {

    private final SaleMapper saleMapper;
    private final CheckMapper checkMapper;
    private static final Logger logger = LoggerFactory.getLogger(SaleController.class);

    @Override
    @Transactional
    public SaleVo addSaleProcess(SaleVo saleVo) {
        logger.info("before addSale - saleVo:" + saleVo);
        if (saleVo.getDatetime() == null) {
            TimeZone tz;
            Date date = new Date();
            DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
            tz = TimeZone.getTimeZone("Asia/Seoul");
            df.setTimeZone(tz);

            String today = df.format(date);
            saleVo.setDatetime(today);
        }
        saleMapper.addSale(saleVo);
        logger.info("Sale gid=" + saleVo.getShopOrderNo());
        final Integer orderNo = Integer.valueOf(saleVo.getShopOrderNo());
        SaleVo getSale = new SaleVo();
        getSale.setSaleId(orderNo);
        return getSale;
    }

    @Override
    @Transactional
    public Integer addSaleCstmrHstry(SaleVo saleVo) {
        saleMapper.addCstmrHst(saleVo);
        return saleVo.getSaleId();
    }

    @Override
    @Transactional
    public String addInvnHist(SalePrdctVo salePrdctVo) {
        saleMapper.addInvnHist(salePrdctVo);
        return "success";
    }

//	@Override
//	@Transactional
//	public String addFrameInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//
//		sqlSession.insert(namespace+"addFrameInvnHist", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String addLensInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//
//		sqlSession.insert(namespace+"addLensInvnHist", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String addCLensInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//
//		sqlSession.insert(namespace+"addCLensInvnHist", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String addAccInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//
//		sqlSession.insert(namespace+"addAccInvnHist", salePrdctVo);
//
//		return "success";
//	}

    @Override
    @Transactional
    public String modifySaleAndCheckDate(SaleVo saleVo, CheckVo checkVo) {
        logger.info("run modifySaleAndCheckDate");

        String saleDate = saleVo.getDatetime();
        String cardDate = saleVo.getCardDate();
        Integer cardTy = saleVo.getCardTy();
        String checkDate = checkVo.getDatetime();
        logger.info("saleDate:" + saleDate);
        logger.info("cardDate:" + checkDate);
        logger.info("cardTy:" + cardTy);
        logger.info("checkDate:" + checkDate);
        if ((saleDate == null || saleDate.equals(""))
            && (cardDate == null || cardDate.equals(""))
            && (cardTy == null || cardTy.intValue() == 0)
            && (checkDate == null || checkDate.equals(""))) {
            logger.info("end modifySaleAndCheckDate : noDateInfo");
            return "noDateInfo";
        }

        if (!(saleDate == null || saleDate.equals(""))
            || !(cardDate == null || cardDate.equals(""))
            || !(cardTy == null || cardTy.intValue() == 0)
        ) {
            saleMapper.modifySaleDate(saleVo);
            logger.info("run modifySaleDate");
        }

        if (!(checkDate == null || checkDate.equals(""))) {
            checkMapper.modifyCheckDate(checkVo);
            logger.info("run modifyCheckDate");
        }

        logger.info("end modifySaleAndCheckDate : success");
        return "success";
    }

    @Override
    @Transactional
    public String modifyResult(SaleVo saleVo, int saleProcess, int isCOMPLETED) {
        char resultArray[] = saleVo.getResult().toCharArray();

        if (resultArray[saleProcess] != (char) isCOMPLETED) {
            resultArray[saleProcess] = (char) isCOMPLETED;
            saleVo.setResult(new String(resultArray));
            saleMapper.modifyResult(saleVo);
            return saleVo.getResult();
        }
        return saleVo.getResult();
    }

    //	@Override
//	@Transactional
//	public String decCntLensInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"decCntLensInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String decCntCLensInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"decCntCLensInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String decCntAccInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"decCntAccInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String decCntFrameInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"decCntFrameInvn", salePrdctVo);
//
//		return "success";
//	}
    @Override
    @Transactional
    public String decCntInvn(SalePrdctVo salePrdctVo) {
        saleMapper.decCntInvn(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String incCntInvn(SalePrdctVo salePrdctVo) {
        saleMapper.incCntInvn(salePrdctVo);
        return "success";
    }

//	@Override
//	@Transactional
//	public String incCntLensInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"incCntLensInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String incCntCLensInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"incCntCLensInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String incCntAccInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"incCntAccInvn", salePrdctVo);
//
//		return "success";
//	}
//	@Override
//	@Transactional
//	public String incCntFrameInvn(SalePrdctVo salePrdctVo)  {
//
//
//
//		sqlSession.update(namespace+"incCntFrameInvn", salePrdctVo);
//
//		return "success";
//	}
//
//	@Override
//	public String checkFrameInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//		Integer num = (Integer)sqlSession.selectOne(namespace+"checkFrameInvnHist", salePrdctVo);
//		logger.info("result num is : "+num);
//		return num==0?"ok":"duple";
//	}
//	public String checkInvnHist(SalePrdctVo salePrdctVo)  {
//
//
//
//		Integer num = (Integer)sqlSession.selectOne(namespace+"checkInvnHist", salePrdctVo);
//		logger.info("result num is : "+num);
//		return num==0?"ok":"duple";
//	}
//	@Override
//	@Transactional
//	public String removeInvnHist(SalePrdctVo salePrdctVo)
//	{
//
//
//		sqlSession.delete(namespace+"removeInvnHist", salePrdctVo);
//
//		return "success";
//	}

    @Override
    @Transactional
    public String modifyResultOgnPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED, int prdctPrc, boolean isAdd) {
        logger.info("run modifyResultOgnPrc saleVo:" + saleVo);

        char resultArray[] = saleVo.getResult().toCharArray();

        if (resultArray[saleProcess] != (char) isCOMPLETED) {
            resultArray[saleProcess] = (char) isCOMPLETED;
        }
        saleVo.setResult(new String(resultArray));
        if (isAdd) {

            saleVo.setOgnPrice(prdctPrc);
        } else {
            prdctPrc = -prdctPrc;
            saleVo.setOgnPrice(prdctPrc);
        }
        logger.info("saleVo:" + saleVo);
        saleMapper.modifyResultOgnPrice(saleVo);

        return saleVo.getResult();
    }


    @Override
    @Transactional
    public String modifyResultPayPrc(SaleVo saleVo, int saleProcess, int isCOMPLETED) {
        logger.info("run modifyResultPayPrc");

        char resultArray[] = saleVo.getResult().toCharArray();

        if (resultArray[saleProcess] != (char) isCOMPLETED) {
            resultArray[saleProcess] = (char) isCOMPLETED;
        }
        saleVo.setResult(new String(resultArray));
        saleMapper.modifyResultPayment(saleVo);

        return saleVo.getResult();
    }

    @Override
    @Transactional
    public String modifyCstmrHst(SaleVo saleVo) {
        logger.info("run modifyCstmrHst");
        saleMapper.modifyCstmrHst(saleVo);
        return "success";
    }

    @Override
    public Integer checkSaleCstrm(SaleVo saleVo) {
        return saleMapper.countSaleCstmr(saleVo);
    }


    //	@Override
//	public Map listSaleData(SaleVo saleVo)  {
//
//
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"listSale", saleVo);
//		resultMap.put("listSale", saleList);
//
//		return resultMap;
//	}
//
//	@Override
//	public Map listSaleHistData(SaleHistSearchVo searchVo)  {
//
//
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"listSaleHist", searchVo);
//		resultMap.put("listsale", saleList);
//
//		return resultMap;
//	}
//	@Override
//	public Map listSaleOffHist(SaleVo saleVo)  {
//
//
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"listSaleOffHist", saleVo);
//		resultMap.put("listSaleOffHist", saleList);
//
//		return resultMap;
//	}
//    @Override
//	public Map listSalesHistData(SaleHistSearchVo searchVo)  {
//
//
//		Map resultMap=new HashMap();
//		List salesList=sqlSession.selectList(namespace+"listSalesHist", searchVo);
//		resultMap.put("listsales", salesList);
//
//		return resultMap;
//	}
//
//	@Override
//	public Map listPrdctSaleHistData(SaleHistSearchVo searchVo)  {
//
//
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"listPrdctSaleHist", searchVo);
//		resultMap.put("listsale", saleList);
//
//		return resultMap;
//	}
    @Override
    public SaleVo selectSale(SaleVo saleVo) {
        return saleMapper.getSale(saleVo);
    }

    @Override
    public SalePrdctVo selectSalePrdctOff(SalePrdctVo salePrdctVo) {
        return saleMapper.getSalePrdctOff(salePrdctVo);
    }

//	@Override
//	public SalePrdctVo selectNewSalePrdctOff(SalePrdctVo salePrdctVo)  {
//
//
//		return (SalePrdctVo)sqlSession.selectOne(namespace+"getNewSalePrdctOff", salePrdctVo);
//	}
//
//	@Override
//	public Map listSelectPastPurchased(SaleVo saleVo)  {
//
//
//		Map resultMap = new HashMap();
//		List <SaleVo> purchasedList = sqlSession.selectList(namespace+"listPastPurchasedFrame", saleVo);
//		purchasedList.addAll(sqlSession.selectList(namespace+"listPastPurchasedLens", saleVo));
//		purchasedList.addAll(sqlSession.selectList(namespace+"listPastPurchasedClens", saleVo));
//
//		logger.info("purchasedList:"+purchasedList);
//		Collections.sort(purchasedList);
//		logger.info("purchasedList:"+purchasedList);
//
//
//		resultMap.put("listPurchased",purchasedList);
//
////		resultMap.put("listPurchasedLens",purchasedList2);
////		resultMap.put("listPurchasedClens",purchasedList3);
//
//		return resultMap;
//	}
//
//	@Override
//	public Map listPastPurchasedOld(SaleVo saleVo)  {
//
//
//		Map resultMap = new HashMap();
//		List <SalePrdctVo> purchasedOldList = sqlSession.selectList(namespace+"listPastPurchasedOld", saleVo);
//		resultMap.put("listPurchasedOld",purchasedOldList);
//
//		return resultMap;
//	}
//
//
//	@Override
//	public Map listSelectPastPurchasedNewPrdct(SaleVo saleVo)  {
//
//
//		Map resultMap = new HashMap();
//		List purchasedList = sqlSession.selectList(namespace+"listPastPurchasedNewPrdct", saleVo);
//		resultMap.put("listPurchasedNewPrdct",purchasedList);
//
//		return resultMap;
//	}


    @Override
    public SaleVo selectSaleForCstmrAndResult(SaleVo saleVo) {
        return saleMapper.getSaleForCstmrAndResult(saleVo);
    }


//	@Override
//	public void mListSaleData(HttpServletResponse response)  {
//
//
//		String str="";
//		//response.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
//		PrintWriter writer=response.getWriter();
//
//		Map resultMap=new HashMap();
//		List saleList=sqlSession.selectList(namespace+"mlistSale");
//		resultMap.put("listSale", saleList);
//
//		ObjectMapper om = new ObjectMapper();
//		str=om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//
//		writer.write(str);
//		writer.flush();
//		writer.close();
//	}

    @Override
    public Map getPayCardInfo(SaleVo saleVo) {
        List listCard = saleMapper.getPayCardInfo(saleVo);
        Map resultMap = new HashMap();
        resultMap.put("listCard", listCard);
        return resultMap;
    }

    @Override
    public String getSaleMemo(SaleVo saleVo) {
        return saleMapper.getSaleMemo(saleVo);
    }

    @Override
    @Transactional
    public String SaleMemoUpdate(SaleVo saleVo) {
        saleMapper.saleMemoUpdate(saleVo);
        return "success";
    }

    @Override
    public String modifyCardPayDate(SaleVo saleVo) {
        try {
            saleMapper.modifyCardPayDate(saleVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Override
    public List<SaleVo> getPaymentList(SaleVo saleVo) {
        return saleMapper.getPaymentList(saleVo);
    }

    @Override
    public String delSaleId(SaleVo saleVo) {
        try {
            saleMapper.delSaleId(saleVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Override
	@Transactional
	public String renewalTaxBigo(SaleVo saleVo)  {
        saleMapper.renewalTaxBigo(saleVo);
		return "success";
	}
    @Override
    public String updatepayment(SaleVo saleVo) {
        try {
            saleMapper.salepaymentUpdate(saleVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

	/*@Override
	public String insertpayment(SaleVo saleVo)  {

		String result = null;
		saleVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_PAYMENT);
		saleVo.setActionTy(Character
				.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_FORCE_PAY));
		try {
			sql.insert(namespace + "salepaymentInsert",saleVo);
			result = "success";
		} catch (Exception e) {

			e.printStackTrace();
			return "fail";
		}
		return result;
	}
*/

    @Override
    public String updatejobpayment(SaleVo saleVo) {
        try {
            saleVo.setActionTy(Character.toString(CommonCode.CODE_SALE_JOB_ACTION_TY_FORCE_PAY));
            saleMapper.salejobpaymentUpdate(saleVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

}
