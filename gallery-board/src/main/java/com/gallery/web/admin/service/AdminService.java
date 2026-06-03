package com.gallery.web.admin.service;

import javax.servlet.http.HttpSession;

import com.gallery.web.admin.domain.AdminVo;




public interface AdminService {
	public AdminVo login(AdminVo adminVo) throws Exception;
	public AdminVo loginInvn(AdminVo adminVo) throws Exception;
	public String comLogin(AdminVo adminVo, HttpSession session)throws Exception;
	public String getFrameShop(AdminVo adminVo)throws Exception;
	public String getLensShop(AdminVo adminVo)throws Exception;
	public String getClensShop(AdminVo adminVo)throws Exception;
	public String getAccShop(AdminVo adminVo)throws Exception;
	public String getetcShop(AdminVo adminVo)throws Exception;
	public String modifyPwdAction(AdminVo admonVo)throws Exception;
}
