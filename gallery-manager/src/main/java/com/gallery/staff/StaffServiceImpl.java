package com.gallery.staff;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.gallery.common.PagingVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class StaffServiceImpl implements StaffService {

    private final StaffMapper staffMapper;
    private final AmazonS3Client s3;
    @Value("${env.BUCKET}")
    private String bucket;

    @Override
    @Transactional
    public String addStaffPhotos(StaffVo staffVo, MultipartHttpServletRequest request) throws IOException {
        MultipartFile multipartFile = request.getFile("queuedFiles");
        String fileName = multipartFile.getOriginalFilename();
        String key = "/staff/" + staffVo.getStaffId() + "/" + fileName;

        File file = new File(System.getProperty("java.io.tmpdir")+"/"+fileName);
        multipartFile.transferTo(file);

        s3.putObject(new PutObjectRequest(bucket, key, file));

        staffVo.setImgPath(key);
        staffMapper.updateImgPath(staffVo);

        return "addsuccess";
    }

    @Override
    @Transactional
    public String addStaff(StaffVo staffVo) {
        staffMapper.addStaff(staffVo);
        return staffVo.getStaffId().toString();
    }

    @Override
    @Transactional
    public String addComStaff(StaffVo staffVo) {
        staffMapper.addComStaff(staffVo);
        return staffVo.getStaffId().toString();
    }

    @Override
    @Transactional
    public void modifyStaff(StaffVo staffVo) {
        staffMapper.modifyStaff(staffVo);
    }

    @Override
    @Transactional
    public void modifyComStaff(StaffVo staffVo) {
        staffMapper.modifyComStaff(staffVo);
    }

    @Override
    public Map pagedListStaffData(StaffVo staffVo, Integer shopId) {
        Map resultMap = new HashMap();
        staffVo.setShopId(staffMapper.getShopId(shopId));

        int pageCount = staffMapper.pagedListStaffCount(staffVo);
        List<StaffVo> staffList = staffMapper.pagedListStaff(staffVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(staffVo.getCurrentPage());
        paging.setPageSize(staffVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listStaff", staffList);
        return resultMap;
    }

    @Override
    public Map pagedListComStaffData(StaffVo staffVo, Integer shopId) {
        Map resultMap = new HashMap();
        staffVo.setShopId(staffMapper.getShopId(shopId));

        int pageCount = staffMapper.pagedListComStaffCount(staffVo);
        List<StaffVo> staffList = staffMapper.pagedListComStaff(staffVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(staffVo.getCurrentPage());
        paging.setPageSize(staffVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listStaff", staffList);
        return resultMap;
    }

    @Override
    public StaffVo selectStaff(StaffVo staffVo) {
        StaffVo result = staffMapper.getStaff(staffVo);
        String key = result.getImgPath();

        Date expirationDate = Date.from(Instant.now().plus(5L, ChronoUnit.MINUTES)); // 5분동안 다운받을 수 있도록 지정
        URL url = s3.generatePresignedUrl(bucket, key, expirationDate);

        result.setImgPath(url.toString());

        return result;
    }

    @Override
    public StaffVo selectComStaff(StaffVo staffVo) {
        return staffMapper.getComStaff(staffVo);
    }

    @Override
    public String removeStaff(StaffVo staffVo) {
        staffMapper.removeStaff(staffVo);
        return "success";
    }

    @Override
    public String removeStaffPhoto(StaffVo staffVo) {
        staffMapper.removeImgPath(staffVo);
        return "success";
    }

    @Override
    public Map getStaffList(StaffVo staffVo) {
        List<StaffVo> staffList = staffMapper.getStaffList(staffVo);
        Map resultMap = new HashMap();
        resultMap.put("staffList", staffList);
        return resultMap;
    }

}
