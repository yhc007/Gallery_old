package com.gallery.fileserver;

import com.gallery.common.PagingVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FileServerServiceImpl implements FileServerService {
    private final FileServerMapper fileServerMapper;

    @Override
    @Transactional
    public String addFileServer(FileServerVo fileServerVo) {
        Integer cnt = fileServerMapper.countFileServer(fileServerVo);
        if (cnt == 0) {
            if (fileServerVo.getIsdefault().equals("1")) {
                dropDefault();
            }
            fileServerMapper.addFileServer(fileServerVo);
            return "addsuccess";
        } else {
            return "duple";
        }
    }

    @Override
    @Transactional
    public void modifyFileServer(FileServerVo fileServerVo) {
        if (fileServerVo.getIsdefault().equals("1")) {
            dropDefault();
        }
        fileServerMapper.modifyFileServer(fileServerVo);
    }

    private void dropDefault() {
        fileServerMapper.dropDefault();
    }

    @Override
    public Map pagedListFileServerData(FileServerVo fileServerVo) {
        Map resultMap = new HashMap();

        Integer pageCount = fileServerMapper.pagedListFileServerCount(fileServerVo);
        List<FileServerVo> fileserverList = fileServerMapper.pagedListFileServer(fileServerVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(fileServerVo.getCurrentPage());
        paging.setPageSize(fileServerVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listFileServer", fileserverList);
        return resultMap;
    }

    @Override
    public FileServerVo selectFileServer(FileServerVo fileServerVo) {
        return fileServerMapper.getFileServer(fileServerVo);
    }

    @Override
    public String removeFileServer(FileServerVo fileServerVo) {
        fileServerMapper.removeFileServer(fileServerVo);
        return "success";
    }

    @Override
    public String createCoupon(FileServerVo fileVo) {
        List<FileServerVo> cstmrList = fileServerMapper.getCstmrForCP(fileVo);

        fileServerMapper.delCoupon(fileVo);
        Date date = new Date();
        int year = date.getYear() - 100;
        String today = year + fileVo.getBirthDay().replace(".", "");

        int couponCd = 0000;

        for (int i = 0; i < cstmrList.size(); i++) {
            FileServerVo tmpVo = cstmrList.get(i);
            tmpVo.setCouponCd(today + String.format("%04d", couponCd) + "A");
            if (tmpVo.getGetEmailYn() != null && tmpVo.getGetEmailYn().equals("N")) {
                tmpVo.setEmail("sms로 수신");
            } else if (tmpVo.getGetSmsYn() != null && tmpVo.getGetSmsYn().equals("N")) {
                tmpVo.setCellphone("email로 수신");
            }
            cstmrList.set(i, tmpVo);
            couponCd++;
        }

        HashMap<String, Object> couponMap = new HashMap<String, Object>();
        couponMap.put("coupon", cstmrList);

        fileServerMapper.createCoupon(couponMap);

        return "success";
    }

    @Override
    public String createCouponForLunar(FileServerVo fileVo) {
        try {
            String today = fileVo.getBirthDay().replace(".", "").substring(2);
            String birthDay = fileServerMapper.getLunarDate(fileVo);

            fileVo.setBirthDay(birthDay.substring(5));
            fileVo.setBirthDayTyCd("00600002");

            List<FileServerVo> cstmrList = fileServerMapper.getCstmrForCP(fileVo);

            int couponCd = 0000;

            for (int i = 0; i < cstmrList.size(); i++) {
                cstmrList.get(i).setCouponCd(today + String.format("%04d", couponCd) + "B");
                couponCd++;
            }
            HashMap<String, Object> couponMap = new HashMap<String, Object>();
            couponMap.put("coupon", cstmrList);
            fileServerMapper.createCoupon(couponMap);

            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getCouponList(FileServerVo fileVo) {
        Map resultMap = new HashMap();
        List<FileServerVo> couponList = fileServerMapper.getCouponList(fileVo);
        resultMap.put("couponList", couponList);
        return resultMap;
    }
}
