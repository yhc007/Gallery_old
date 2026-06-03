package com.gallery.media;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.common.CommonCode;
import com.gallery.common.FileUploadForm;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MediaServiceImpl implements MediaService {
    private final MediaMapper mediaMapper;

    @Override
    @Transactional
    public String addMedia(MediaVo mediaVo, FileUploadForm uploadForm) {
        MultipartFile ufile = uploadForm.getFiles();
        String root = "/usr/local/tomcat7/webapps/media";
        String dpath = null;

        if (mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)) {
            dpath = File.separator + mediaVo.getPrdctId() + File.separator + mediaVo.getMediaTyCd();
        } else {
            dpath = File.separator + mediaVo.getPrdctId() + File.separator + mediaVo.getMediaTyCd() + File.separator + mediaVo.getColor();
        }

        File dir = new File(root + dpath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String fpath = File.separator + ufile.getOriginalFilename();
        if (!ufile.isEmpty()) {
            try {
                byte[] bytes = ufile.getBytes();
                FileOutputStream fos = new FileOutputStream(root + dpath + fpath);
                fos.write(bytes);
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return "fail";
            }
        }
        mediaVo.setMediaName(ufile.getOriginalFilename());
        mediaVo.setMediaPath(dpath + fpath);

        if (mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)) {
            mediaMapper.addMedia(mediaVo);
        } else {
            Integer count = mediaMapper.getStillCount(mediaVo);
            if (count > 0) {
                mediaMapper.updateStill(mediaVo);
            } else {
                mediaMapper.addStill(mediaVo);
            }
        }
        return "addsuccess";
    }

    @Override
    @Transactional
    public String modifyMediaCode(MediaVo mediaVo) {
        Integer count = mediaMapper.getVideoCount(mediaVo);
        if (count == 0) {
            mediaMapper.addVideoCode(mediaVo);
        } else {
            mediaMapper.modifyVideoCode(mediaVo);
        }
        return "success";
    }

    @Override
    @Transactional
    public void modifyMedia(MediaVo mediaVo) {
        mediaMapper.modifyMedia(mediaVo);
    }

    @Override
    public Map pagedListMediaData(MediaVo mediaVo) {
        Map resultMap = new HashMap();
        List<MediaVo> mediaList;
        if (mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)) {
            mediaList = mediaMapper.listMedia(mediaVo);
        } else {
            mediaList = mediaMapper.listStill(mediaVo);
        }
        resultMap.put("listMedia", mediaList);

        return resultMap;
    }

    @Deprecated
    @Override
    public MediaVo selectMedia(MediaVo mediaVo) {
        return mediaMapper.getMedia(mediaVo);
    }

    @Override
    public MediaVo selectVideoCd(MediaVo mediaVo) {
        return mediaMapper.getVideoCd(mediaVo);
    }

    @Override
    public String selectRotatePath(MediaVo mediaVo) {
        mediaVo.setMediaTyCd(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE);
        MediaVo getMedia = mediaMapper.getMediaRotate(mediaVo);
        if (getMedia == null) {
            return null;
        }
        String opath = getMedia.getMediaPath();
        String path = getMedia.getUrlStr();
        path += opath.substring(0, opath.lastIndexOf("-"));
        path += "-#";
        path += opath.substring(opath.lastIndexOf("."), opath.length());
        return path;
    }

    @Override
    @Transactional
    public MediaVo removeMedia(MediaVo mediaVo) {
        if (mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)) {
            mediaMapper.removeMedia(mediaVo);
        } else {
            mediaMapper.removeStill(mediaVo);
        }
        String root = "/usr/local/tomcat7/webapps/media";
        String path = null;

        if (mediaVo.getMediaTyCd().equals(CommonCode.CODE_MEDIA_TY_MULTI_IMAGE)) {
            path = File.separator + mediaVo.getPrdctId() + File.separator + mediaVo.getMediaTyCd() + File.separator + mediaVo.getMediaName();
        } else {
            path = File.separator + mediaVo.getPrdctId() + File.separator + mediaVo.getMediaTyCd() + File.separator + mediaVo.getColor() + File.separator + mediaVo.getMediaName();
        }

        File f = new File(root + path);

        if (f.isFile()) {
            f.delete();
        }
        return null;
    }
    @Deprecated
    public void responseMediaData(MediaVo mediaVo, HttpServletResponse response) throws Exception {
        Map frameMap = new HashMap();

        List list = new ArrayList();
        List mediaList = mListMediaData(mediaVo);
        if (mediaList.size() > 0) {
            frameMap.put("file_server_url", ((MediaVo) mediaList.get(0)).getUrlStr());
        }
        for (int i = 0; i < mediaList.size(); i++) {
            Map map = new HashMap();
            map.put("id", ((MediaVo) mediaList.get(i)).getMediaId());
            map.put("path", ((MediaVo) mediaList.get(i)).getMediaPath());
            list.add(map);
        }
        frameMap.put("images", list);

        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }
    @Deprecated
    public List mListMediaData(MediaVo mediaVo) {
        return mediaMapper.mListMedia(mediaVo);
    }
}
