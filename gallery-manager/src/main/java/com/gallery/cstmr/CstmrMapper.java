package com.gallery.cstmr;

import com.gallery.sale.SaleVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CstmrMapper {
    void addCstmr(CstmrVo value);
    void modifyCsmtrPw(CstmrVo value);
    void updateInfo(CstmrVo value);
    void updatePw(CstmrVo value);
    void setSaleOff(CstmrVo value);
    void visit_history1(CstmrVo value);
    void visit_history2(CstmrVo value);
    void point_hist1(CstmrVo value);
    void point_hist2(CstmrVo value);
    Integer getPoint(CstmrVo value);
    void cstmrSet1(CstmrVo value);
    void cstmrSet2(CstmrVo value);
    void delCstmr(CstmrVo value);
    List<CstmrVo> getCstmrLoginId(CstmrVo value);
    CstmrVo getCstmrLoginPw(CstmrVo value);
    CstmrVo getCstmrForLogin(CstmrVo value);
    CstmrVo mgetCstmr(CstmrVo value);
    List<CstmrVo> eyesCheckResult(CstmrVo value);
    List<CstmrVo> myCoupon(CstmrVo value);
    List<CstmrVo> getCstmrListForChk(CstmrVo value);
    List<CstmrVo> getCstmrListForChk2(CstmrVo value);
    List<CstmrVo> getListCstmr4Tax(CstmrVo value);
    List<CstmrVo> getCstmrId4Digit(CstmrVo value);
    List<CstmrVo> listCntVisitor(CstmrVo value);
    List<CstmrVo> getCstmrList(CstmrVo value);
    List<CstmrVo>  getListCstmr4Fmly(CstmrVo value);
    Integer login(CstmrVo value);
    Integer cntCstmr(CstmrVo value);
    Integer countCstmrById(CstmrVo value);
    String checkId(CstmrVo value);
    String getSCID(CstmrVo value);
    String getDSID(CstmrVo value);
    SaleVo buyList(SaleVo value);
}
