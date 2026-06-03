package com.gallery.check;

import com.gallery.common.CommonCode;
import com.gallery.cstmr.CstmrVo;
import com.gallery.sale.SaleMapper;
import com.gallery.sale.SaleVo;
import com.gallery.saleJob.SaleJobMapper;
import com.gallery.saleJob.SaleJobVo;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class CheckServiceImpl implements CheckService {

    private final CheckMapper checkMapper;
    private final SaleMapper saleMapper;
    private final SaleJobMapper saleJobMapper;

    @Override
    public Map listVisitData(CheckVo checkVo) {
        Map resultMap = new HashMap();
        List visitList = checkMapper.listVisit(checkVo);
        resultMap.put("listVisit", visitList);
        return resultMap;
    }

    @Override
    public CheckVo selectVisitInfo(CheckVo checkVo) {
        return checkMapper.getVisitInfo(checkVo);
    }

    @Override
    public CheckVo selectVisitInfoForSale(HttpSession session) {
        CstmrVo cstmrVo = (CstmrVo) session.getAttribute(CommonCode.ATTR_CSTMR);
        return checkMapper.getVisitInfoForSale(cstmrVo);
    }

    @Override
    public CheckVo getEyeCheckByCstmrId(CstmrVo cstmrVo) {
        return checkMapper.getVisitInfoForSale(cstmrVo);
    }

    @Override
    @Transactional
    public String addVisit(CheckVo checkVo, HttpSession session) {
        SaleJobVo saleJobVo = new SaleJobVo();
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
        checkMapper.addVisit(checkVo);
        saleVo.setHistId(checkVo.getHistId());
        saleMapper.modifyHistId(saleVo);

        saleJobVo.setSaleId(saleVo.getSaleId());
        saleJobVo.setStaffId(checkVo.getStaffId());
        saleJobVo.setTyCd(CommonCode.CODE_STAFF_PROCESS_TY_CHECK);
        saleJobMapper.addSaleJob(saleJobVo);

        return "success";
    }

    @Override
    @Transactional
    public Integer addVisitCstmrHstry(CheckVo checkVo) {
        checkMapper.addVisit(checkVo);
        return checkVo.getHistId();
    }

    @Override
    @Transactional
    public String updateVisit(CheckVo checkVo, HttpSession session) {
        SaleVo saleVo = (SaleVo) session.getAttribute(CommonCode.ATTR_SALE);
        StaffVo staffVo = (StaffVo) session.getAttribute(CommonCode.ATTR_STAFF);
        checkVo.setHistId(saleVo.getHistId());

        checkVo.setStaffId(staffVo.getStaffId());
        Integer count = checkMapper.countVisit(checkVo);
        if (count > 0) {
            checkMapper.updateVisit(checkVo);
        } else {
            return "fail";
        }
        return "success";
    }

    @Override
    @Transactional
    public String updateCstmrHistVisit(CheckVo checkVo) {
        Integer count = checkMapper.countVisit(checkVo);
        if (count > 0) {
            checkMapper.updateVisit(checkVo);
        } else {
            return "fail";
        }
        return "success";
    }

    @Override
    @Transactional
    public String editCheckInfo(CheckVo checkVo, HttpSession session) {
        Integer count = checkMapper.countVisit(checkVo);
        if (count == 1) {
            checkMapper.editCheckInfo(checkVo);
        } else {
            return "fail";
        }
        return "success";
    }

}
