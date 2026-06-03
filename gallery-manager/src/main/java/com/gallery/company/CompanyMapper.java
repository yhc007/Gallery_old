package com.gallery.company;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CompanyMapper {
    void addCompany(CompanyVo value);
    void delComTy(CompanyVo value);
    void removeCompany(CompanyVo value);
    void addCompanyTy(CompanyVo value);
    String chkComId(CompanyVo value);
    Integer countCompany(CompanyVo value);
    Integer pagedListCompanyCount(CompanyVo value);
    List<CompanyVo> pagedListCompany(CompanyVo value);
    List<CompanyVo> companyList(CompanyVo value);
    List<CompanyVo> listBrand(CompanyVo value);
    CompanyVo getCompany(CompanyVo value);
    List<CompanyVo> getListCom(CompanyVo value);
    List<CompanyVo> getComTy(CompanyVo value);
    void modifyCompany(CompanyVo value);
    void modifyComTy(CompanyVo value);
}
