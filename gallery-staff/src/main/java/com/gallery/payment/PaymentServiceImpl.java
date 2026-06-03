package com.gallery.payment;

import com.gallery.point.PointMapper;
import com.gallery.point.PointVo;
import com.gallery.sale.SaleMapper;
import com.gallery.sale.SalePrdctVo;
import com.gallery.sale.SaleVo;
import com.gallery.saleJob.SaleJobMapper;
import com.gallery.saleJob.SaleJobVo;
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
public class PaymentServiceImpl implements PaymentService {

    private final SaleMapper saleMapper;
    private final SaleJobMapper saleJobMapper;
    private final PaymentMapper paymentMapper;
    private final PointMapper pointMapper;

    @Override
    public Map listSaleOffHist(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> saleList = saleMapper.listSaleOffHist(saleVo);
        resultMap.put("listSaleOffHist", saleList);

        return resultMap;
    }

    public Map listSaleOffHistOld(SaleVo saleVo) {
        Map resultMap = new HashMap();
        List<SaleVo> saleList = saleMapper.listSaleOffHistOld(saleVo);
        resultMap.put("listSaleOffHistOld", saleList);

        return resultMap;
    }

    @Override
    @Transactional
    public String modifySaleCancel(PaymentVo paymentVo) {
        saleMapper.modifySaleCancel(paymentVo);
        return "success";
    }

    @Override
    public Map selectCardComInfo() {
        Map resultMap = new HashMap();
        List<PaymentVo> listCardCom = paymentMapper.getCardComInfo();
        resultMap.put("listCardCom", listCardCom);

        return resultMap;
    }

    //	@Override
//	public String checkInvn (PaymentVo paymentVo)
//	{
//		logger.info("Run listSalePrdct:"+paymentVo);
//
//
//		Integer chckPrdct = (Integer) sqlSession.selectOne(namespace, "checkInvn");
//		if(chckPrdct.intValue()>0){
//			return "exist";
//		}else{
//			return "nonexist";
//		}
//	}
    @Override
    public Map listSalePrdct(PaymentVo paymentVo) {
        Integer chckPrdct = paymentMapper.checkInvn(paymentVo);
        Map resultMap = new HashMap();
        if (chckPrdct != 0) {
            List<PaymentVo> listPrdct = paymentMapper.listSalePrdct(paymentVo);
            resultMap.put("listPrdct", listPrdct);
        } else {
            return null;
        }
        return resultMap;
    }

    @Override
    @Transactional
    public String addInvnHist(List<SalePrdctVo> listSalePrdctVo) {
        for (int i = 0, size = listSalePrdctVo.size(); i < size; i++) {
            paymentMapper.addInvnHist(listSalePrdctVo.get(i));
        }
        return "success";
    }

//	@Deprecated
//	@Override
//	@Transactional
//	public String decCntInvn(List<SalePrdctVo> listSalePrdctVo) {
//
//
//		int result;
//		for(int i=0,size=listSalePrdctVo.size();i<size;i++){
//			result=sqlSession.update(namespace+"decCntInvn", listSalePrdctVo.get(i));
//			logger.info("update result:"+result);
//		}
//
//		return "success";
//	}


    @Override
    @Transactional
    public String incCntInvn(List<SalePrdctVo> listSalePrdctVo) {
        for (int i = 0, size = listSalePrdctVo.size(); i < size; i++) {
            paymentMapper.incCntInvn(listSalePrdctVo.get(i));
        }
        return "success";
    }

    @Override
    @Transactional
    public String cancelPayment(List<SalePrdctVo> listSalePrdctVo, SaleJobVo saleJobVo,
                                PointVo pointVo, PaymentVo paymentVo) {
        if (!listSalePrdctVo.isEmpty()) {
            incCntInvn(listSalePrdctVo);
            addInvnHist(listSalePrdctVo);
        }

        List<SaleJobVo> listSaleJobVo = saleJobMapper.listJobPayment(saleJobVo);

        for (int i = 0, size = listSaleJobVo.size(); i < size; i++) {
            listSaleJobVo.get(i).setStaffId(saleJobVo.getStaffId());
            listSaleJobVo.get(i).setSaleId(saleJobVo.getSaleId());
            listSaleJobVo.get(i).setCancel(saleJobVo.getCancel());
            listSaleJobVo.get(i).setDatetime(saleJobVo.getDatetime());
            if (null != listSaleJobVo.get(i).getPayCard()) {
                listSaleJobVo.get(i).setPayCard(-listSaleJobVo.get(i).getPayCard());
            } else {
                listSaleJobVo.get(i).setPayCard(0);
            }
            if (null != listSaleJobVo.get(i).getPayCard()) {
                listSaleJobVo.get(i).setPayCash(-listSaleJobVo.get(i).getPayCash());
            } else {
                listSaleJobVo.get(i).setPayCash(0);
            }
            if (null != listSaleJobVo.get(i).getPayPoint()) {
                listSaleJobVo.get(i).setPayPoint(-listSaleJobVo.get(i).getPayPoint());
            } else {
                listSaleJobVo.get(i).setAddPoint(0);
            }

            if (null != listSaleJobVo.get(i).getAddPoint()) {
                listSaleJobVo.get(i).setAddPoint(-listSaleJobVo.get(i).getAddPoint());
            } else {
                listSaleJobVo.get(i).setAddPoint(0);
            }
            saleJobMapper.addSaleJob(listSaleJobVo.get(i));
        }

        pointMapper.removePointHist(pointVo);
        saleMapper.modifySaleCancel(paymentVo);
        return "success";
    }

}
