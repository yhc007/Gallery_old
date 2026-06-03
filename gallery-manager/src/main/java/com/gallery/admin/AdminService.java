package com.gallery.admin;

import java.util.Map;


public interface AdminService {
    AdminVo login(AdminVo adminVo) throws Exception;
    Map getDscntList(AdminVo adminVo)throws Exception;
    String getDscntListForCSV(AdminVo adminVo)throws Exception;
    String clientIp(AdminVo adminVo)throws Exception;
}
