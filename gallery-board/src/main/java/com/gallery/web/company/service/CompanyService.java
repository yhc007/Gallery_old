package com.gallery.web.company.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.gallery.web.company.domain.CompanyVo;




public interface CompanyService {
	public String addCompany(CompanyVo companyVo) throws Exception;
	public void modifyCompany(CompanyVo companyVo) throws Exception;
	public Map pagedListCompanyData(CompanyVo companyVo) throws Exception;
	public Map selectCompanyData(CompanyVo company) throws Exception;	
	public Map listCompanyData(CompanyVo companyVo) throws Exception;
	public CompanyVo selectCompany(CompanyVo companyVo) throws Exception;
	public String removeCompany(CompanyVo companyVo) throws Exception;
	public void mListCompanyData(CompanyVo companyVo,HttpServletResponse response) throws Exception;
	public void mListCompanyDataForDsply(CompanyVo companyVo,HttpServletResponse response) throws Exception;
	public Map selectComList(CompanyVo companyVo)throws Exception;
	public Map listAllComData(CompanyVo companyVo)throws Exception;
}
