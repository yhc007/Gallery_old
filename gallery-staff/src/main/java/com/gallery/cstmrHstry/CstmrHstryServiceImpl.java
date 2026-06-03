package com.gallery.cstmrHstry;

import com.gallery.check.CheckMapper;
import com.gallery.check.CheckVo;
import com.gallery.common.CommonCode;
import com.gallery.cstmr.CstmrMapper;
import com.gallery.cstmr.CstmrVo;
import com.gallery.prdct.PrdctMapper;
import com.gallery.prdct.PrdctVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class CstmrHstryServiceImpl implements CstmrHstryService {
    private final CstmrHstryMapper cstmrHstryMapper;
    private final CstmrMapper cstmrMapper;
    private final PrdctMapper prdctMapper;
    private final CheckMapper checkMapper;

    //	@Override
//	public Map listVisitData(CheckVo checkVo) throws Exception {
//
//
//		Map resultMap=new HashMap();
//		List visitList=sqlSession.selectList(namespace+"listVisit", checkVo);
//		resultMap.put("listVisit", visitList);
//		return resultMap;
//	}
    @Override
    public Map listVisitData(CstmrHstryVo cstmrHstryVo) {
        Map resultMap = new HashMap();
        List<CstmrHstryVo> visitList = cstmrHstryMapper.listCstmrHstry(cstmrHstryVo);
        resultMap.put("listVisit", visitList);
        return resultMap;
    }

    @Override
    public CstmrVo getCstmrById(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmr(cstmrVo);
    }

    //	@Override
//	public CheckVo selectVisitInfo(CheckVo checkVo) throws Exception {
//
//
//		return (CheckVo)sqlSession.selectOne(namespace+"getVisitInfo", checkVo);
//	}
    @Override
    public CstmrHstryVo selectVisitInfo(CstmrHstryVo cstmrHstryVo) {
        return cstmrHstryMapper.getVisitInfo(cstmrHstryVo);
    }

    @Override
    public CstmrHstryVo selectVisitInfoInit(CstmrHstryVo cstmrHstryVo) {
        return cstmrHstryMapper.getVisitInfoInit(cstmrHstryVo);
    }

    @Override
    public CheckVo selectVisitInfoForSale(HttpSession session) {
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        return checkMapper.getVisitInfoForSale(cstmrVo);
    }

//    @Deprecated
//	@Override
//	@Transactional
//	public String addVisit(CheckVo checkVo,HttpSession session) throws Exception {
//
//		logger.info("run update:"+checkVo);
//		System.out.println("eyeCheck : " + checkVo);
//
//		SaleVo saleVo=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//		StaffVo staffVo=(StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
//		//checkVo.setHistId(saleVo.getHistId());
//		checkVo.setStaffId(staffVo.getStaffId());
//		checkVo.setVisitShopId(staffVo.getShopId());
//
////		Integer count=(Integer) sqlSession.selectOne(namespace+"countVisit", checkVo);
////		if(count>0){
////			sqlSession.update(namespace+"updateVisit", checkVo);
////		}else{
//		Date date=new Date();
//		String timestr=String.valueOf(date.getYear()+1900)+String.format("%02d",date.getMonth()+1)+String.format("%02d",date.getDate());
//		checkVo.setDatetime(timestr);
//		sqlSession.insert(checkspace+"addVisit", checkVo);
//
//		//saleVo.setHistId(Integer.parseInt(checkVo.getHistId()));
//		saleVo.setHistId(checkVo.getHistId());
//		sqlSession.update(salespace+"modifyHistId", saleVo);
//
//
//		//}
//		return "success";
//	}
//    @Deprecated
//	@Override
//	@Transactional
//	public String updateVisit(CheckVo checkVo,HttpSession session) throws Exception {
//
//
//
//		SaleVo saleVo=(SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
//		StaffVo staffVo=(StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
//		//checkVo.setHistId(saleVo.getHistId().toString());
//		checkVo.setHistId(saleVo.getHistId());
//
//		checkVo.setStaffId(staffVo.getStaffId());
//		Integer count=(Integer) sqlSession.selectOne(checkspace+"countVisit", checkVo);
//		if(count>0){
//			sqlSession.update(checkspace+"updateVisit", checkVo);
//		}else{
//			return "fail";}
//		return "success";
//	}

//    @Deprecated
//	@Override
//	public Map listSelectedPrdctDataLens(PrdctVo prdctVo) throws Exception {
//
//
//		Map resultMap=new HashMap();
//		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctLens", prdctVo);
//
//		resultMap.put("listLensH", prdctList);
//
//		return resultMap;
//	}
//
//    @Deprecated
//	@Override
//	public Map listSelectedPrdctDataClens(PrdctVo prdctVo) throws Exception {
//
//
//		Map resultMap=new HashMap();
//		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctClens", prdctVo);
//
//		resultMap.put("listClensH", prdctList);
//
//		return resultMap;
//	}
//
//    @Deprecated
//	@Override
//	public Map listSelectedPrdctDataAcc(PrdctVo prdctVo) throws Exception {
//
//
//		Map resultMap=new HashMap();
//		List prdctList=sqlSession.selectList(prdctspace+"listSelectPrdctAcc", prdctVo);
//
//		resultMap.put("listAccH", prdctList);
//
//		return resultMap;
//	}

    @Override
    public Map getNewPrdct(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> newPrdct = prdctMapper.getNewPrdct(prdctVo);
        resultMap.put("newPrdctH", newPrdct);
        return resultMap;
    }

    @Override
    public Map listSelectedPrdctData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> prdctList = prdctMapper.listSelectPrdct(prdctVo);
        for (int i = 0, size = prdctList.size(); i < size; i++) {
            prdctList.get(i).setPrdctName(prdctList.get(i).getPrdctName().replace("'", "`"));
        }
        resultMap.put("listPrdctH", prdctList);
        return resultMap;
    }

    @Override
    public CstmrHstryVo getLastData(CstmrHstryVo cstmrHstryVo) {
        return cstmrHstryMapper.cstmrhstry(cstmrHstryVo);
    }

//    @Deprecated
//	@Override
//	public String getCstmrhstryMemo(CstmrHstryVo cstmrHstryVo) throws Exception {
//		SqlSession sql = getSqlSession();
//		String memo = (String) sql.selectOne(cstmrhstry + "getCstmrhstryMemo",cstmrHstryVo);
//		return memo;
//	}
//
//    @Deprecated
//	@Override
//	@Transactional
//	public void CstmrHstryMemoUpdate(CstmrHstryVo cstmrHstryVo) throws Exception {
//		SqlSession sql = getSqlSession();
//		sql.update(cstmrhstry + "cstmrHstryMemoUpdate",cstmrHstryVo);
//	}
}
