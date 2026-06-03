package com.gallery.fileserver;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface FileServerMapper {
    void addFileServer(FileServerVo value);
    void modifyFileServer(FileServerVo value);
    void removeFileServer(FileServerVo value);
    void delCoupon(FileServerVo value);
    Integer countFileServer(FileServerVo value);
    Integer pagedListFileServerCount(FileServerVo value);
    String getLunarDate(FileServerVo value);
    List<FileServerVo> pagedListFileServer(FileServerVo value);
    FileServerVo getFileServer(FileServerVo value);
    List<FileServerVo> getCstmrForCP(FileServerVo value);
    List<FileServerVo> getCouponList(FileServerVo value);
    void dropDefault();
    void createCoupon(HashMap value);
}
