package com.gallery.saleJob;

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
public class SaleJobServiceImpl implements SaleJobService {
    private final SaleJobMapper saleJobMapper;

    @Override
    @Transactional
    public String addSaleJob(SaleJobVo saleJobVo) {
        Integer jobId = saleJobMapper.addSaleJob(saleJobVo);
        return jobId.toString();
    }

    @Transactional
    @Override
    public String addListSaleJob(Map paymentMap) {
        saleJobMapper.addListSaleJob(paymentMap);
        return "success";
    }

    @Transactional
    @Override
    public String delListSaleJob(Map paymentMap) {
        saleJobMapper.delListSaleJob(paymentMap);
        return "success";
    }

    @Transactional
    @Override
    public String modifySaleJob(SaleJobVo salejobVo) {
        saleJobMapper.modifySaleJob(salejobVo);
        return "success";
    }

//	@Override
//	@Transactional
//	public String addSaleJob(List<SaleJobVo> listSaleJobVo) {
//
//		logger.info("call addSaleJob");
//
//
//		for(int i = 0,size = listSaleJobVo.size();i<size;i++){
//			sqlSession.insert(namespace+"addSaleJob", listSaleJobVo.get(i));
//		}
//		return "success";
//	}

    @Override
    public Map listVisitingCstmrData(SaleJobVo saleJobVo) {
        Map resultMap = new HashMap();
        List<SaleJobVo> cstmrList = saleJobMapper.listVisitingCstmrOffShop(saleJobVo);
        resultMap.put("listCstmr", cstmrList);

        return resultMap;
    }

    @Override
    public String delVisitData(SaleJobVo saleJobVo) {
        try {
            String payment = saleJobMapper.chkPayment(saleJobVo); //sale_id 삭제전 결제 여부
            if (payment != null) {
                saleJobMapper.cancelPayment(saleJobVo); //cancel에 저장 1번
                saleJobMapper.modifyResult(saleJobVo); //result 11111 변경
            } else {
                saleJobMapper.delVisitData(saleJobVo); //기록 삭제
                saleJobMapper.delSalePrdct(saleJobVo); //salePrdct_off 삭제
                saleJobMapper.delNewSalePrdct(saleJobVo); //salePrdct_off 삭제
            }
            saleJobMapper.delPointHist(saleJobVo); //포인트 기록 삭제
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "faile";
    }

}
