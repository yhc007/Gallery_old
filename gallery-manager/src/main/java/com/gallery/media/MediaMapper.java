package com.gallery.media;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MediaMapper {
    void addMedia(MediaVo value);
    void addStill(MediaVo value);
    void updateStill(MediaVo value);
    void removeStill(MediaVo value);
    void modifyMediaCode(MediaVo value);
    void modifyMedia(MediaVo value);
    void addVideoCode(MediaVo value);
    void modifyVideoCode(MediaVo value);
    void removeMedia(MediaVo value);
    Integer getStillCount(MediaVo value);
    Integer countMedia(MediaVo value);
    List<MediaVo> listMedia(MediaVo value);
    List<MediaVo> listStill(MediaVo value);
    List<MediaVo> mListMedia(MediaVo value);
    MediaVo getMedia(MediaVo value);
    MediaVo getMediaLensSelectorPath(MediaVo value);
    MediaVo getMediaRotate(MediaVo value);
    MediaVo getMediaCode(MediaVo value);
    MediaVo getVideoCd(MediaVo value);
    Integer getVideoCount(MediaVo value);
}
