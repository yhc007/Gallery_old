package com.gallery.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
    private final AdminMapper adminMapper;

    private Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Transactional
    @Override
    public AdminVo login(AdminVo adminVo) {
        AdminVo pwd = adminMapper.getPwd(adminVo);

        if (pwd != null && adminVo.getPwd().equals(pwd.getPwd())) {
            return adminMapper.getPwd(adminVo);
        }
        return null;
    }

    @Override
    public Map getDscntList(AdminVo adminVo) {
        List<AdminVo> dscntList = adminMapper.getDscntList(adminVo);
        Map map = new HashMap();
        map.put("dscntList", dscntList);
        return map;
    }

    @Override
    public String getDscntListForCSV(AdminVo adminVo) throws Exception {
        Map map = new HashMap();
        ObjectMapper om = new ObjectMapper();

        List<AdminVo> dscntList = adminMapper.getDscntList(adminVo);
        for (int i = 0; i < dscntList.size(); i++) {
            String comName = URLEncoder.encode(dscntList.get(i).getComName(), "UTF-8");
            dscntList.get(i).setComName(comName);
            String shopName = URLEncoder.encode(dscntList.get(i).getShopName(), "UTF-8");
            dscntList.get(i).setShopName(shopName);
        }
        map.put("dscntList", dscntList);

        return om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
    }

    @Override
    public String clientIp(AdminVo adminVo) {
        Integer ipCount = adminMapper.connectIp(adminVo);

        if (ipCount == null || ipCount <= 0) {
            adminMapper.addConnectIp(adminVo);
        } else {
            adminMapper.updateConnectIp(adminVo);
        }
        return "";
    }
}
