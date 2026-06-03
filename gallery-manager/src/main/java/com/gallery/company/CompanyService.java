package com.gallery.company;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;


public interface CompanyService {
	public String addCompany(CompanyVo companyVo) throws Exception;
	public void modifyCompany(CompanyVo companyVo) throws Exception;
	public Map pagedListCompanyData(CompanyVo companyVo) throws Exception;
	public Map selectCompanyData(CompanyVo company) throws Exception;
	public CompanyVo selectCompany(CompanyVo companyVo) throws Exception;
	public String removeCompany(CompanyVo companyVo) throws Exception;
	public Map getListCom(CompanyVo companyVo)throws Exception;
	public String getComTy(CompanyVo companyVo)throws Exception;
	public void addCompanyTy(CompanyVo companyVo)throws Exception;
}
