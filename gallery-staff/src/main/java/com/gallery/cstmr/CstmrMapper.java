package com.gallery.cstmr;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CstmrMapper {
    void cstmrMemoUpdate(CstmrVo value);
    void editCstmrLastShop(CstmrVo value);
    void cstmrBigoUpdate(CstmrVo value);
    void modifyCstmrFmlyCd(CstmrVo value);
    void modifyFmlyCdbyCstmrCd(CstmrVo value);
    void addCstmr(CstmrVo value);
    void addCstmrMrgeHist(CstmrVo value);
    void modifyCstmr(CstmrVo value);
    void removeCstmr(CstmrVo value);
    void modifyCstmrInfo(CstmrVo value);
    void editCstmrInfo(CstmrVo value);
    void addNewCstmr(CstmrVo value);
    void modifyNewCstmr(CstmrVo value);
    Integer countCstmrById(CstmrVo value);
    Integer login(CstmrVo value);
    Integer listCstmrHstry(CstmrVo value);
    Integer countNewCstmr(CstmrVo value);
    String getCoupon(String value);
    String getCstmrBigo(CstmrVo value);
    String getCstmrMemo(CstmrVo value);
    String getCstmrCd(CstmrVo value);
    String joinChk(CstmrVo value);
    List<CstmrVo> listCstmr(CstmrVo value);
    CstmrVo getCstmrByLoginId(CstmrVo value);
    CstmrVo getCstmr(CstmrVo value);
    CstmrVo getCstmrByCd(CstmrVo value);
    List<CstmrVo> getListCstmr4Fmly(CstmrVo value);
    CstmrVo getCstmrInfo(CstmrVo value);
    CstmrVo getCstmrVIsitInfo(CstmrVo value);
    List<CstmrVo> listFmly(CstmrVo value);
    List<CstmrVo> getFmlyList(CstmrVo value);
    CstmrVo getNewCstmr(CstmrVo value);
    List<CstmrVoSecu> listCstmrSecu(CstmrVo value);
}
