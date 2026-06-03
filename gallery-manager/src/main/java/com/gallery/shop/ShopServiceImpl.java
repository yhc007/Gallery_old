package com.gallery.shop;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.common.PagingVo;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ShopServiceImpl implements ShopService {

    private final ShopMapper shopMapper;
    private final AmazonS3Client s3;
    @Value("${env.BUCKET}")
    private String bucket;

    @Override
    @Transactional
    public ShopVo addShop(ShopVo shopVo) {
        int cnt = shopMapper.countShop(shopVo);
        shopVo.setShopNum(shopMapper.getShopNum(shopVo) + 1);
        if (cnt == 0) {
            shopMapper.addShop(shopVo);
            shopVo.setResult("addsuccess");
            return shopVo;
        } else {
            shopVo.setResult("duple");
            return shopVo;
        }
    }

    @Override
    @Transactional
    public void modifyShop(ShopVo shopVo) {
        shopMapper.modifyShop(shopVo);
    }

    @Override
    public Map pagedListShopData(ShopVo shopVo) {
        Map resultMap = new HashMap();

        int pageCount = shopMapper.pagedListShopCount(shopVo);
        List shopList = shopMapper.pagedListShop(shopVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(shopVo.getCurrentPage());
        paging.setPageSize(shopVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listShop", shopList);

        return resultMap;
    }

    @Override
    public Map listShopData(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List shopList = shopMapper.listShop(shopVo);
        resultMap.put("listShop", shopList);
        return resultMap;
    }

    @Override
    public ShopVo selectShop(ShopVo shopVo) {
        ShopVo result = shopMapper.getShop(shopVo);
        String key = result.getStampImgPath();

        Date expirationDate = Date.from(Instant.now().plus(5L, ChronoUnit.MINUTES)); // 5분동안 다운받을 수 있도록 지정
        URL url = s3.generatePresignedUrl(bucket, key, expirationDate);

        result.setStampImgPath(url.toString());

        return result;
    }

    @Override
    public Integer countShopJoin(ShopVo shopVo) {
        return shopMapper.countShopJoin(shopVo);
    }

    @Override
    @Transactional
    public String addShopJoin(ShopVo shopVo) {
        shopMapper.addShopJoin(shopVo);
        return "success";
    }

    @Override
    public ShopVo selectShopJoin(ShopVo shopVo) {
        return shopMapper.getShopJoin(shopVo);
    }

    @Override
    @Transactional
    public String modifyShopJoin(ShopVo shopVo) {
        shopMapper.modifyShopJoin(shopVo);
        return "success";
    }

    @Override
    public ShopVo removeShop(ShopVo shopVo) {
        shopMapper.removeShop(shopVo);
        return null;
    }

    @Deprecated
    @Override
    public void mListShopData(HttpServletResponse response, ShopVo shopVo) throws Exception {
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();

        Map resultMap = new HashMap();
        List shopList = shopMapper.mlistShop(shopVo);

        List list = new ArrayList();
        for (int i = 0; i < shopList.size(); i++) {
            Map map = new HashMap();
            map.put("shopId", ((ShopVo) shopList.get(i)).getShopId());
            map.put("shopName", ((ShopVo) shopList.get(i)).getShopName());
            map.put("telephone", ((ShopVo) shopList.get(i)).getTelephone());
            map.put("shopNum", ((ShopVo) shopList.get(i)).getShopNum());
            map.put("shopStatTyCd", ((ShopVo) shopList.get(i)).getShopStatTyCd());
            map.put("lat", ((ShopVo) shopList.get(i)).getLat());
            map.put("lot", ((ShopVo) shopList.get(i)).getLot());
            map.put("dstns", ((ShopVo) shopList.get(i)).getDstns());
            list.add(map);
        }
        resultMap.put("listShop", list);

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);

        writer.write(str);
        writer.flush();
        writer.close();

    }

    @Override
    public Map findShopName(ShopVo shopVo) {
        Map resultmap = new HashMap();
        List selectlist = shopMapper.getShopName(shopVo);
        resultmap.put("shopName", selectlist);
        return resultmap;
    }

    @Override
    public Map shopList(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List listShop = shopMapper.shopList(shopVo);
        resultMap.put("listShop", listShop);
        return resultMap;
    }

    @Override
    public Map taxShopList(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List listShop = shopMapper.taxShopList(shopVo);
        resultMap.put("listShop", listShop);
        return resultMap;
    }

    @Override
    public Map getComListBySrch(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List comList = shopMapper.getComListBySrch(shopVo);
        resultMap.put("listCom", comList);
        return resultMap;
    }

    @Override
    public String chkManager(ShopVo shopVo) {
        try {
            String shopId = shopMapper.chkManager(shopVo);
            if (shopId != null) {
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Override
    public Map getComList() {
        Map resultMap = new HashMap();
        List comList = shopMapper.getComList();
        resultMap.put("listCom", comList);
        return resultMap;
    }

    @Override
    public Map getComListForTrade(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List comList = shopMapper.getComListForTrade(shopVo);
        resultMap.put("comList", comList);
        return resultMap;
    }

    @Override
    public ShopVo getShopInfo(ShopVo shopVo) {
        return shopMapper.getShopInfo(shopVo);
    }

    @Override
    @Transactional
    public String addStampPhotos(ShopVo shopVo, MultipartHttpServletRequest request) throws IOException {
        MultipartFile multipartFile = request.getFile("queuedFiles");
        String fileName = multipartFile.getOriginalFilename();
        String key = "/shop/" + shopVo.getShopId() + "/" + fileName;

        File file = new File(System.getProperty("java.io.tmpdir")+"/"+fileName);
        multipartFile.transferTo(file);

        s3.putObject(new PutObjectRequest(bucket, key, file));

        shopVo.setStampImgPath(key);
        shopMapper.updateImgPath(shopVo);

        return "addsuccess";
    }

    @Override
    public String removeStampPhoto(ShopVo shopVo) {
        shopMapper.removeImgPath(shopVo);
        return "success";
    }

    @Override
    public String getshopName(ShopVo shopVo) {
        try {
            return shopMapper.getshopName(shopVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Override
    public List<ShopVo> getPointShopList() {
        List<ShopVo> listShop = new ArrayList<ShopVo>();
        try {
            listShop = shopMapper.getPointShopList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listShop;
    }

    @Override
    public String getShopList() throws Exception {
        Map map = new HashMap();
        ObjectMapper om = new ObjectMapper();
        List<ShopVo> shoplist = shopMapper.getShopList();
        for (int i = 0; i < shoplist.size(); i++) {
            String shopName = URLEncoder.encode(shoplist.get(i).getShopName(), "utf-8");
            shoplist.get(i).setShopName(shopName);
        }
        map.put("shopList", shoplist);
        return om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
    }
}
