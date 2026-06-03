package com.gallery.prdct;

import com.gallery.sale.SaleMapper;
import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class PrdctServiceImpl implements PrdctService {
    private final PrdctMapper prdctMapper;
    private final SaleMapper saleMapper;

    @Override
    public List<PrdctVo> listSalePrdctOff(SaleVo saleVo) {
        return prdctMapper.listSalePrdctOff(saleVo);
    }

    @Override
    public Map listPrdctData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> prdctList = prdctMapper.listPrdct(prdctVo);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public Map listLensData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> prdctList = prdctMapper.listLens(prdctVo);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

	@Deprecated
	public Map listPartnerData() {
		Map resultMap=new HashMap();
		List partnerList=prdctMapper.listPartner();
		resultMap.put("listPartner", partnerList);
		return resultMap;
	}

    @Override
    public Map listSelectedPrdctData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> prdctList = prdctMapper.listSelectPrdct(prdctVo);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public Map listSelectedPrdctDataLens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<SalePrdctVo> prdctList = prdctMapper.listSelectPrdctLens(prdctVo);
        resultMap.put("listLens", prdctList);

        return resultMap;
    }

    @Override
    public Map listSelectedPrdctDataClens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<SalePrdctVo> prdctList = prdctMapper.listSelectPrdctClens(prdctVo);
        resultMap.put("listClens", prdctList);

        return resultMap;
    }

    @Override
    public Map listSelectedPrdctDataAcc(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<SalePrdctVo> prdctList = prdctMapper.listSelectPrdctAcc(prdctVo);
        resultMap.put("listAcc", prdctList);

        return resultMap;
    }
//	@Deprecated
//	@Override
//	public PrdctVo selectPrdct(PrdctVo prdctVo) {
//		return (PrdctVo)sqlSession.selectOne(namespace+"getPrdct", prdctVo);
//	}

    @Override
    @Transactional
    public String modifyAsmblySalePrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.updateAsmblySalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String modifyAsmblySaleNewPrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.updateAsmblyNewSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String modifyDlvrySalePrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.updateDlvrySalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String modifyDlvrySaleNewPrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.updateDlvryNewSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    public void addSalePrdct(SalePrdctVo salePrdctVo) {
        saleMapper.addSalePrdct(salePrdctVo);
    }

    @Override
    public String checkSalePrdctCount(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.countSalePrdct(salePrdctVo);
        return num == 0 ? "ok" : "duple";
    }

//	@Deprecated
//	@Override
//	public String checkSalePrdctCountNew(SalePrdctVo salePrdctVo) {
//		Integer num=(Integer) sqlSession.selectOne(salespace+"countSalePrdctNew", salePrdctVo);
//		return num==0?"ok":"duple";
//	}

    @Override
    public String checkSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.countSalePrdctSaleId(salePrdctVo);
        return num == 0 ? "ok" : "duple";
    }

    @Override
    public String checkNewSalePrdctSaleIdCount(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.countNewSalePrdctSaleId(salePrdctVo);
        return num == 0 ? "ok" : "duple";
    }

    @Override
    public String checkAssemblySaleId(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.countAsmbly(salePrdctVo);
        Integer num2 = saleMapper.newcountAsmbly(salePrdctVo);
        return (num == 0 && num2 == 0) ? "ok" : "duple";
    }

    @Override
    public String checkDeliverySaleId(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.countDlvry(salePrdctVo);
        Integer num2 = saleMapper.newcountDlvry(salePrdctVo);
        return (num == 0 && num2 == 0) ? "ok" : "duple";
    }

    @Override
    public String checkDeliverySaleIdEachType(SalePrdctVo salePrdctVo) {
        Integer num = saleMapper.getDlvryCheck(salePrdctVo);
        return num == 0 ? "no" : "yes";
    }

    @Override
    public void removeSalePrdct(SalePrdctVo salePrdctVo) {
        saleMapper.removeSalePrdct(salePrdctVo);
    }

    @Override
    @Transactional
    public String incCntSalePrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.incCntSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String decCntSalePrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.decCntSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String incCntSalePrdctOffNew(SalePrdctVo salePrdctVo) {
        saleMapper.incCntSalePrdctOffNew(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String decCntSalePrdctOffNew(SalePrdctVo salePrdctVo) {
        saleMapper.decCntSalePrdctOffNew(salePrdctVo);
        return "success";
    }

    @Override
    public void removeNewSalePrdct(SalePrdctVo salePrdctVo) {
        saleMapper.removeNewSalePrdct(salePrdctVo);
    }

    @Override
    public void addSalePrdctNew(SalePrdctVo salePrdctVo) {
        prdctMapper.addPrdct(salePrdctVo);
    }

    @Override
    public Map getNewPrdct(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> newPrdct = prdctMapper.getNewPrdct(prdctVo);
        resultMap.put("newPrdct", newPrdct);

        return resultMap;
    }

    @Override
    @Transactional
    public String modifyDscntEarnSalePrdctOff(SalePrdctVo salePrdctVo) {
        prdctMapper.modifyDscntEarnSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String modifyDscntEarnNewPrdct(SalePrdctVo salePrdctVo) {
        prdctMapper.modifyDscntEarnNewPrdct(salePrdctVo);
        return "success";
    }

    @Override
    public SalePrdctVo getSalePrdct(SalePrdctVo salePrdctVo) {
        return prdctMapper.getSalePrdct(salePrdctVo);
    }
//	@Deprecated
//	@Override
//	public SalePrdctVo getSalePrdctNew(SalePrdctVo salePrdctVo) {
//
//		salePrdctVo = (SalePrdctVo) sqlsession.selectOne(namespace + "getSalePrdctNew", salePrdctVo);
//
//		return salePrdctVo;
//	}

    @Override
    @Transactional
    public String modifyInformPrdctOff(SalePrdctVo salePrdctVo) {
        saleMapper.updateInformSalePrdctOff(salePrdctVo);
        return "success";
    }

    @Override
    public String modifyInformPrdctOffNew(SalePrdctVo salePrdctVo) {
        saleMapper.updateInformSalePrdctOffNew(salePrdctVo);
        return "success";
    }

    @Override
    public Map getNewPaymentInfo(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> listPrdct = prdctMapper.getNewPaymentInfo(saleVo);
        resultMap.put("NewPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public Map getLensPaymentInfo(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> listPrdct = prdctMapper.getFramePaymentInfo(saleVo);
        resultMap.put("FramePrdct", listPrdct);
        return resultMap;
    }

    @Override
    public Map getClensPaymentInfo(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> listPrdct = prdctMapper.getLensPaymentInfo(saleVo);
        resultMap.put("LensPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public Map getAccPaymentInfo(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> listPrdct = prdctMapper.getClensPaymentInfo(saleVo);
        resultMap.put("ClensPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public Map getFramePaymentInfo(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> listPrdct = prdctMapper.getAccPaymentInfo(saleVo);
        resultMap.put("AccPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public SaleVo getBillInfo(SaleVo saleVo) {
        return saleMapper.getBillInfo(saleVo);
    }

//	@Deprecated
//	@Override
//	public Map getPaymentHist(SaleVo saleVo) {
//
//		Map resultMap = new HashMap();
//		List cardPayList = sql.selectList(salespace + "getPaymentHist", saleVo);
//		resultMap.put("cardPayList", cardPayList);
//		return resultMap;
//	}

    @Override
    public Map getAsBoard(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> boardList = prdctMapper.getAsBoard(prdctVo);
        resultMap.put("boardList", boardList);
        return resultMap;
    }

    @Override
    public String regAs(PrdctVo prdctVo) {
        try {
            prdctMapper.regAs(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String completeAs(PrdctVo prdctVo) {
        try {
            prdctMapper.completeAs(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String delAs(PrdctVo prdctVo) {
        try {
            prdctMapper.delAs(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    @Transactional
    public String addNewPrdct(Map prdctMap) {
        prdctMapper.addListNewPrdct(prdctMap);
        return "success";
    }

    @Override
    @Transactional
    public String addInvnPrdct(Map prdctMap) {
        prdctMapper.addListInvnPrdct(prdctMap);
        return "success";
    }

    @Override
    @Transactional
    public String removeNewPrdct(Map prdctMap) {
        prdctMapper.removeListNewPrdct(prdctMap);
        return "success";
    }

    @Override
    @Transactional
    public String removeInvnPrdct(Map prdctMap) {
        prdctMapper.removeListInvnPrdct(prdctMap);
        return "success";
    }

    @Override
    @Transactional
    public String modifyNewPrdct(PrdctVo prdctVo) {
        prdctMapper.modifyNewPrdct(prdctVo);
        return "success";
    }

    @Override
    @Transactional
    public String modifyInvnPrdct(PrdctVo prdctVo) {
        prdctMapper.modifyInvnPrdct(prdctVo);
        return "success";
    }

//	@Deprecated
//	@Override
//	@Transactional
//	public String cntUpInvnPrdct(PrdctVo prdctVo) {
//
//
//		sqlSession.update(namespace+"cntUpInvnPrdct", prdctVo);
//		return "success";
//	}

//    @Deprecated
//	@Override
//	@Transactional
//	public String cntDownInvnPrdct(PrdctVo prdctVo) {
//
//
//		sqlSession.update(namespace+"cntDownInvnPrdct", prdctVo);
//		return "success";
//	}


}
