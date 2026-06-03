package com.gallery.prdct;

import com.amazonaws.services.s3.AmazonS3Client;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.brand.BrandVo;
import com.gallery.common.CommonCode;
import com.gallery.common.PagingVo;
import com.gallery.shop.ShopVo;
import com.gallery.staff.StaffVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URL;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
public class PrdctServiceImpl implements PrdctService {

    private final PrdctMapper prdctMapper;
    private final AmazonS3Client s3;
    @Value("${env.BUCKET}")
    private String bucket;

    @Override
    @Transactional
    public String addPrdct(PrdctVo prdctVo) {
        Integer cnt = prdctMapper.countPrdct(prdctVo);
        if (cnt == 0) {
            prdctMapper.addPrdct(prdctVo);
            return "addsuccess";
        } else {
            return "duple";
        }
    }

    @Override
    @Transactional
    public String addPrdctColor(PrdctVo prdctVo) {
        Integer cnt = prdctMapper.countPrdctColor(prdctVo);
        if (cnt == 0) {
            prdctMapper.addPrdctColor(prdctVo);
            return "success";
        } else {
            return "duple";
        }
    }

    public Integer countPrdctForBrand(BrandVo brandVo) {
        return prdctMapper.countPrdctForBrand(brandVo);
    }

    @Override
    @Transactional
    public void modifyPrdct(PrdctVo prdctVo) {
        prdctMapper.modifyPrdct(prdctVo);
    }

    @Override
    @Transactional
    public String modifyPrdctAcpt(PrdctVo prdctVo) {
        int rows = prdctMapper.modifyPrdctAcpt(prdctVo);
        if (rows != 1) {
            int a = 1 / 0;
        }
        return "success";
    }

    @Override
    @Transactional
    public String modifyPrdctInvn(PrdctVo prdctVo) {
        PrdctVo getVo = prdctMapper.getPrdctInvn(prdctVo);
        if (getVo == null) {
            if (prdctVo.getInvnTyCd().equals(CommonCode.CODE_INVN_TY_IN)) {
                prdctMapper.addPrdctInvn(prdctVo);
            } else {
                return "shortage";
            }
        } else {
            if (prdctVo.getInvnTyCd().equals(CommonCode.CODE_INVN_TY_OUT)) {
                if (getVo.getCnt() < prdctVo.getCnt()) {
                    return "shortage";
                }
            }
            int rows = prdctMapper.modifyPrdctInvn(prdctVo);
            if (rows != 1) {
                int a = 1 / 0;
            }
        }
        prdctMapper.addPrdctInvnHist(prdctVo);
        return "success";
    }

    @Override
    public Map pagedListPrdctData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();

        Integer pageCount = prdctMapper.pagedListPrdctCount(prdctVo);
        List<PrdctVo> prdctList = prdctMapper.pagedListPrdct(prdctVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(prdctVo.getCurrentPage());
        paging.setPageSize(prdctVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public Map listPrdctDataForEvent(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List<PrdctVo> prdctList = prdctMapper.listPrdctForEvent(prdctVo);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public String listPrdctColor(PrdctVo prdctVo) throws Exception {
        List<PrdctVo> prdctList = prdctMapper.listPrdctColor(prdctVo);

        List list = new ArrayList();
        for (int i = 0; i < prdctList.size(); i++) {
            Map map = new HashMap();
            map.put("color", (prdctList.get(i)).getColor());
            map.put("path", (prdctList.get(i)).getImgPath());
            list.add(map);
        }
        Map resultMap = new HashMap();
        resultMap.put("listColor", list);

        ObjectMapper om = new ObjectMapper();

        return om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
    }

    @Override
    public Map pagedListPrdctConfirmData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        Integer pageCount = prdctMapper.pagedListPrdctConfirmCount(prdctVo);
        List<PrdctVo> prdctList = prdctMapper.pagedListPrdctConfirm(prdctVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(prdctVo.getCurrentPage());
        paging.setPageSize(prdctVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public Map pagedListPrdctRemainData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        Integer pageCount = prdctMapper.pagedListPrdctCount(prdctVo);
        List<PrdctVo> prdctList = prdctMapper.pagedListPrdctRemain(prdctVo);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(prdctVo.getCurrentPage());
        paging.setPageSize(prdctVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public Map pagedListPrdctInvnHistData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        Integer pageCount = prdctMapper.pagedListPrdctInvnHistCount(prdctVo);
        List<PrdctVo> prdctList = prdctMapper.pagedListPrdctInvnHist(prdctVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(prdctVo.getCurrentPage());
        paging.setPageSize(prdctVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listPrdct", prdctList);

        return resultMap;
    }

    @Override
    public PrdctVo selectPrdct(PrdctVo prdctVo) {
        PrdctVo result = prdctMapper.getPrdct(prdctVo);
        String key = result.getImgPath();

        Date expirationDate = Date.from(Instant.now().plus(5L, ChronoUnit.MINUTES)); // 5분동안 다운받을 수 있도록 지정
        URL url = s3.generatePresignedUrl(bucket, key, expirationDate);

        result.setImgPath(url.toString());
        return result;
    }

    @Override
    public PrdctVo selectPrdctInvnHist(PrdctVo prdctVo) {
        return prdctMapper.getPrdctInvnHist(prdctVo);
    }

    @Override
    public PrdctVo removePrdct(PrdctVo prdctVo) {
        prdctMapper.removePrdct(prdctVo);
        return null;
    }

    @Deprecated
    @Override
    public void responseFrameData(PrdctVo prdctVo, HttpServletResponse response) throws Exception {
        Map frameMap = new HashMap();

        List filterList = new ArrayList();
        PrdctVo preObj = null;

        List list = new ArrayList();
        List prdctList = mListFrameData(prdctVo);
        String model = "";

        List objList = new ArrayList();
        for (int i = 0; i < prdctList.size(); i++) {
            Map map = new HashMap();
            PrdctVo obj = (PrdctVo) prdctList.get(i);
            if (!model.equals(obj.getPrdctName())) {
                if (objList.size() != 0) {
                    Map objMap = new HashMap();
                    objMap.put("id", preObj.getPrdctId());
                    objMap.put("name", preObj.getPrdctName());
                    objMap.put("videoCd", preObj.getVideoCd());
                    objMap.put("price", preObj.getTrdePrc());
                    objMap.put("file_server_url", preObj.getUrlStr());
                    objMap.put("multi_img_count", preObj.getMultiImgCnt());
                    objMap.put("event_id", preObj.getEventId());
                    objMap.put("event_name", preObj.getEventName());
                    objMap.put("dscnt", preObj.getDscnt());
                    objMap.put("prdcts", objList);
                    objMap.put("jjim", preObj.getJjim() == 1);

                    list.add(objMap);
                    objList = new ArrayList();
                }
            }

            if (!filterList.contains(obj.getPrdctName() + obj.getColor())) {
                filterList.add(obj.getPrdctName() + obj.getColor());
                preObj = obj;
                model = obj.getPrdctName();

                map.put("still_img_path", obj.getImgPath());
                map.put("color", obj.getColor());
                objList.add(map);
            }
        }

        if (prdctList.size() > 0) {
            PrdctVo obj = preObj;
            Map objMap = new HashMap();
            if (objList.size() != 0) {
                objMap.put("id", obj.getPrdctId());
                objMap.put("name", obj.getPrdctName());
                objMap.put("videoCd", obj.getVideoCd());
                objMap.put("price", obj.getTrdePrc());
                objMap.put("file_server_url", obj.getUrlStr());
                objMap.put("multi_img_count", obj.getMultiImgCnt());
                objMap.put("event_id", obj.getEventId());
                objMap.put("event_name", obj.getEventName());
                objMap.put("dscnt", obj.getDscnt());
                objMap.put("prdcts", objList);
                objMap.put("jjim", obj.getJjim() == 1);
                list.add(objMap);
            }
        }

        frameMap.put("prdctList", list);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Deprecated
    @Override
    public void responsePrdctTypeFrameData(PrdctVo prdctVo, HttpServletResponse response) throws Exception {
        Map frameMap = new HashMap();

        List filterList = new ArrayList();
        PrdctVo preObj = null;

        List list = new ArrayList();
        List prdctList = mListPrdctTypeFrameData(prdctVo);
        String model = "";

        List objList = new ArrayList();
        for (int i = 0; i < prdctList.size(); i++) {
            Map map = new HashMap();
            PrdctVo obj = (PrdctVo) prdctList.get(i);
            if (!model.equals(obj.getPrdctName())) {
                if (objList.size() != 0) {
                    Map objMap = new HashMap();
                    objMap.put("id", preObj.getPrdctId());
                    objMap.put("name", preObj.getPrdctName());
                    objMap.put("videoCd", preObj.getVideoCd());
                    objMap.put("price", preObj.getTrdePrc());
                    objMap.put("file_server_url", preObj.getUrlStr());
                    objMap.put("multi_img_count", preObj.getMultiImgCnt());
                    objMap.put("event_id", preObj.getEventId());
                    objMap.put("event_name", preObj.getEventName());
                    objMap.put("dscnt", preObj.getDscnt());
                    objMap.put("prdcts", objList);
                    objMap.put("jjim", preObj.getJjim() == 1);

                    list.add(objMap);
                    objList = new ArrayList();
                }
            }

            if (!filterList.contains(obj.getPrdctName() + obj.getColor())) {
                filterList.add(obj.getPrdctName() + obj.getColor());
                preObj = obj;
                model = obj.getPrdctName();

                map.put("still_img_path", obj.getImgPath());
                map.put("color", obj.getColor());
                objList.add(map);
            }
        }

        if (prdctList.size() > 0) {
            PrdctVo obj = preObj;
            Map objMap = new HashMap();
            if (objList.size() != 0) {
                objMap.put("id", obj.getPrdctId());
                objMap.put("name", obj.getPrdctName());
                objMap.put("videoCd", obj.getVideoCd());
                objMap.put("price", obj.getTrdePrc());
                objMap.put("file_server_url", obj.getUrlStr());
                objMap.put("multi_img_count", obj.getMultiImgCnt());
                objMap.put("event_id", obj.getEventId());
                objMap.put("event_name", obj.getEventName());
                objMap.put("dscnt", obj.getDscnt());
                objMap.put("prdcts", objList);
                objMap.put("jjim", obj.getJjim() == 1);
                list.add(objMap);
            }
        }
        frameMap.put("prdctList", list);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(frameMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Deprecated
    public List mListFrameData(PrdctVo prdctVo) {
        return prdctMapper.mListFrame(prdctVo);
    }

    @Deprecated
    public List mListPrdctTypeFrameData(PrdctVo prdctVo) {
        return prdctMapper.mListPrdctTypeFrame(prdctVo);
    }

    @Deprecated
    @Override
    public void responseLensData(PrdctVo prdctVo, HttpServletResponse response) throws Exception {
        Map lensMap = new HashMap();
        List list = new ArrayList();
        List prdctList = prdctMapper.mListLens(prdctVo);
        for (int i = 0; i < prdctList.size(); i++) {
            Map map = new HashMap();
            map.put("id", ((PrdctVo) prdctList.get(i)).getPrdctId());
            map.put("name", ((PrdctVo) prdctList.get(i)).getPrdctName());
            map.put("price", ((PrdctVo) prdctList.get(i)).getTrdePrc());
            map.put("file_server_url", ((PrdctVo) prdctList.get(i)).getUrlStr());
            map.put("still_img_path", ((PrdctVo) prdctList.get(i)).getImgPath());
            map.put("multi_img_count", ((PrdctVo) prdctList.get(i)).getMultiImgCnt());
            map.put("videoCd", ((PrdctVo) prdctList.get(i)).getVideoCd());
            map.put("event_id", ((PrdctVo) prdctList.get(i)).getEventId());
            map.put("event_name", ((PrdctVo) prdctList.get(i)).getEventName());
            map.put("dscnt", ((PrdctVo) prdctList.get(i)).getDscnt());
            map.put("jjim", ((PrdctVo) prdctList.get(i)).getJjim() == 1);
            list.add(map);
        }

        lensMap.put("prdctList", list);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(lensMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Deprecated
    @Override
    public List<PrdctVo> selectLensPath(PrdctVo prdctVo) {
        return prdctMapper.getSelectLensDemo(prdctVo);
    }

    @Deprecated
    @Override
    public void responseDsplyLensData(PrdctVo prdctVo, HttpServletResponse response) throws Exception {
        Map lensMap = new HashMap();
        List list = new ArrayList();
        List prdctList = prdctMapper.mListDsplyLens(prdctVo);
        for (int i = 0; i < prdctList.size(); i++) {
            Map map = new HashMap();
            map.put("id", ((PrdctVo) prdctList.get(i)).getPrdctId());
            map.put("name", ((PrdctVo) prdctList.get(i)).getPrdctName());
            map.put("file_server_url", ((PrdctVo) prdctList.get(i)).getUrlStr());
            map.put("still_img_path", ((PrdctVo) prdctList.get(i)).getImgPath());
            map.put("multi_img_count", ((PrdctVo) prdctList.get(i)).getMultiImgCnt());
            map.put("videoCd", ((PrdctVo) prdctList.get(i)).getVideoCd());
            list.add(map);
        }
        lensMap.put("prdctList", list);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer = response.getWriter();

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(lensMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Deprecated
    @Override
    public void modifyPrdctPrc(PrdctVo prdctVo) {
        prdctMapper.modifyPrdctPrc(prdctVo);
    }

    @Override
    public Map getPrdctListByBrand(BrandVo brandVo) {
        Map resultMap = new HashMap();
        List brandList = prdctMapper.getPrdctListByBrand(brandVo);
        resultMap.put("brandList", brandList);
        return resultMap;
    }

    @Override
    public Map getCntryList(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List cntyList = prdctMapper.getCntryList();
        resultMap.put("cntryList", cntyList);
        return resultMap;
    }

    @Override
    public String addPrdctInvn(PrdctVo prdctVo) {
        String result = "";
        String exist = prdctMapper.shopInvn(prdctVo);
        if (exist != null) {
            try {
                prdctMapper.InvnUpdate(prdctVo);
                prdctMapper.updateInvn(prdctVo);
                result = "ok";
            } catch (Exception e) {
                e.printStackTrace();
                result = "fail";
            }
        } else {
            try {
                prdctMapper.addInvn(prdctVo);
                prdctMapper.updateInvn(prdctVo);
                result = "ok";
            } catch (Exception e) {
                e.printStackTrace();
                result = "fail";
            }
        }
        if (!prdctVo.getVideoCd().equals("")) {
            String video = prdctMapper.getVideoCd(prdctVo.getPrdctId());
            if (video != null) {
                prdctMapper.updateVideoCd(prdctVo);
            } else {
                prdctMapper.addVideoCd(prdctVo);
            }
        }
        return result;
    }

    @Override
    public Map getInvnList(ShopVo shopVo) {
        Map resultMap = new HashMap();
        List invnList = prdctMapper.getInvnList(shopVo);
        resultMap.put("invnList", invnList);
        return resultMap;
    }

    @Override
    public Map getInvnHist(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List InvnList = prdctMapper.invnHist(prdctVo);
        resultMap.put("invnHist", InvnList);
        return resultMap;
    }

    @Override
    public Map getColorList() {
        Map resultMap = new HashMap();
        List colorList = prdctMapper.getColorList();
        resultMap.put("colorList", colorList);
        return resultMap;
    }

    @Override
    public Map getMtrlList() {
        Map resultMap = new HashMap();
        List mtrlList = prdctMapper.getMtrlList();
        resultMap.put("mtrlList", mtrlList);
        return resultMap;
    }

    @Override
    public Integer getPrdctId(PrdctVo prdctVo) {
        return prdctMapper.getPrdctId(prdctVo);
    }

    @Override
    public Map getReqstPrdct(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List prdctList = prdctMapper.getReqstPrdct(prdctVo);
        resultMap.put("prdctList", prdctList);
        return resultMap;
    }

    @Override
    public PrdctVo getInvnEditForm(PrdctVo prdctVo) {
        return prdctMapper.getInvnEditForm(prdctVo);
    }

    @Override
    public Integer insertDiffClr(PrdctVo prdctVo) {
        Integer result = 0;
        prdctVo.setOldPrdctId(prdctVo.getPrdctId()); // <==== 이전 prdctId
        Integer exist = prdctMapper.srchMatchClr(prdctVo); //변경하려는 제품의 색상 등록 여부
        if (exist != null) {
            //exist <=== 바뀐 prdctId
            //기존에 있는 색상으로 변경 시
            prdctMapper.delPrdctInvnHist(prdctVo); // 기존 invn_hist prdct 삭제
            prdctMapper.delCntInvn(prdctVo);//기존 invn prdct 삭제
            result = exist;
            prdctVo.setPrdctId(exist);
            prdctMapper.updateInvn(prdctVo); //새 invn_hist 추가
            String invn = prdctMapper.srchPrdctInvn(prdctVo); //변경 prdct invn 유뮤 체크
            if (invn != null) {
                prdctMapper.InvnUpdate(prdctVo); // invn에 있는 경우 update
            } else {
                prdctMapper.addInvn(prdctVo); //invn에 없는 경우 insert
            }

            prdctMapper.delinvn(); //재고 0인 테이블 삭제
        } else {
            //기존에 없는 새로운 색상으로 변경시
            prdctMapper.delPrdctInvnHist(prdctVo); // 기존 invn_hist prdct 삭제
            prdctMapper.delCntInvn(prdctVo);//기존 invn prdct 삭제
            prdctMapper.addPrdct(prdctVo); //newColor prdct 추가
            //LAST SELECT INSERT ID();
            prdctMapper.addInvn(prdctVo); // 새 invn prdct추가
            prdctMapper.updateInvn(prdctVo); // 새 invn_hist prdct추가
            prdctMapper.delinvn(); //재고 0인 테이블 삭제
            result = prdctVo.getPrdctId();
        }
        //still_img에 새로운 prdctId 삽입
        prdctMapper.updatePrdctImg(prdctVo);

        return result;
    }

    @Override
    public String modifyInvnPrdct(PrdctVo prdctVo) {
        try {
            prdctMapper.modifyInvnPrdct(prdctVo);

            String video = prdctMapper.getVideoCd(prdctVo.getPrdctId());
            if (video != null) {
                prdctMapper.updateVideoCd(prdctVo);
            } else {
                prdctMapper.addVideoCd(prdctVo);
            }
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getMobilePrdct(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List listPrdct = prdctMapper.getMobilePrdct(prdctVo);
        resultMap.put("listPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public PrdctVo getMobilePrdctInfo(PrdctVo prdctVo) {
        PrdctVo result = prdctMapper.getMobilePrdctInfo(prdctVo);
        String key = result.getImgPath();

        Date expirationDate = Date.from(Instant.now().plus(5L, ChronoUnit.MINUTES)); // 5분동안 다운받을 수 있도록 지정
        URL url = s3.generatePresignedUrl(bucket, key, expirationDate);

        result.setImgPath(url.toString());

        return result;
    }

    @Override
    public Map getComPrdctList(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List listPrdct = prdctMapper.getComPrdctList(prdctVo);
        resultMap.put("listPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public PrdctVo getComPrdctEditForm(PrdctVo prdctVo) {
        return prdctMapper.getComPrdctEditForm(prdctVo);
    }

    @Override
    public String orderPrdct(PrdctVo prdctVo) {
        try {
            prdctVo.setPuchasPrc(prdctMapper.getPrdctPrice(prdctVo));
            prdctMapper.addOrderList(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getOrderList(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List listPrdct = prdctMapper.getOrderList(prdctVo);
        resultMap.put("listPrdct", listPrdct);
        return resultMap;
    }

    @Override
    public Map getOrderNewLensList(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List listPrdct = prdctMapper.getOrderNewLensList(prdctVo);
        resultMap.put("listNewLens", listPrdct);
        return resultMap;
    }

    @Override
    public String receivePrdct(PrdctVo prdctVo) {
        try {
            prdctMapper.receivePrdct(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String addShopInvn(PrdctVo prdctVo) {
        String result = "";
        Integer cnt = prdctVo.getCnt();
        String shopId = prdctVo.getShopId();
        String comTy = prdctVo.getComTy();
        Integer datetime = prdctVo.getDatetime();
        prdctVo = prdctMapper.getComPrdct(prdctVo); // id로 com_frame 테이블의 prdct속성 출력
        prdctVo.setCnt(cnt);
        prdctVo.setShopId(shopId);
        prdctVo.setComTy(comTy);
        prdctVo.setDatetime(datetime);
        String exist = prdctMapper.srchPrdctTlb(prdctVo); // prdct 테이블에 해당 prdct 유무 체크

        if (exist != null) {
            prdctVo.setPrdctId(Integer.parseInt(exist));
            String invnId = (String) prdctMapper.srchPrdctShopInvn(prdctVo);//invn 테이블에 해당 prdct 등록 유무 체크
            prdctVo.setInvnId(invnId);
            if (invnId != null) {
                prdctMapper.updateShopInvn(prdctVo); //인벤 추가
                prdctMapper.addShopInvnHist(prdctVo); // 인벤 히스토리 추가
            } else {
                prdctMapper.addShopInvn(prdctVo); //인벤 추가
                prdctMapper.addShopInvnHist(prdctVo); // 인벤 히스토리 추가
            }
        } else {
            if (Integer.parseInt(prdctVo.getComTy()) == 1) {
                prdctMapper.addPrdct(prdctVo); //prdct 테이블에 newPrdct 추가
            } else if (Integer.parseInt(prdctVo.getComTy()) == 2) {
                prdctMapper.addNewLens(prdctVo); //prdct 테이블에 newPrdct 추가
            } else if (Integer.parseInt(prdctVo.getComTy()) == 3) {
                prdctMapper.addNewClens(prdctVo); //prdct 테이블에 newPrdct 추가
            } else if (Integer.parseInt(prdctVo.getComTy()) == 4) {
                prdctMapper.addNewClensAcc(prdctVo); //prdct 테이블에 newPrdct 추가
            } else if (Integer.parseInt(prdctVo.getComTy()) == 5) {
                prdctMapper.addNewEtc(prdctVo); //prdct 테이블에 newPrdct 추가
            }

            prdctMapper.addShopInvn(prdctVo); //인벤 추가
            prdctMapper.addShopInvnHist(prdctVo); // 인벤 히스토리 추가
        }
        return result;
    }

    @Override
    public Map srchPrdct(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List brandList = prdctMapper.srchPrdct(prdctVo);
        resultMap.put("brandList", brandList);

        return resultMap;
    }

    @Override
    public Map getReceipt(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceipt(prdctVo);
        resultMap.put("listRecepit", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptLens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceiptLens(prdctVo);
        resultMap.put("listRecepitLens", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptLens2(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceiptLens2(prdctVo);
        resultMap.put("listRecepitLens2", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptClens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceiptClens(prdctVo);
        resultMap.put("listRecepitClens", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptAcc(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceiptAcc(prdctVo);
        resultMap.put("listRecepitAcc", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptEtc(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getReceiptEtc(prdctVo);
        resultMap.put("listRecepitEtc", receitList);
        return resultMap;
    }

    @Override
    public Map getReceiptHeader(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List shopData = prdctMapper.getReceiptHeader(prdctVo);
        resultMap.put("shopData", shopData);
        return resultMap;
    }

    @Override
    public PrdctVo getPrdctType(PrdctVo prdctVo) {
        return prdctMapper.getPrdctType(prdctVo);
    }

    @Override
    public Map fncListPrdctInvnHistDataOutPut(PrdctVo prdctVo) {
        List listInvn = prdctMapper.pagedListPrdctInvnHistOutPut(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listInvn", listInvn);
        return resultMap;
    }

    @Override
    public Map getTradeData(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List ListTrde = prdctMapper.getTradeData(prdctVo);
        resultMap.put("listTrde", ListTrde);
        return resultMap;
    }

    @Override
    public Map getMtrl(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List mtrlList = prdctMapper.getMtrlListLens(prdctVo);
        resultMap.put("mtrlList", mtrlList);
        return resultMap;
    }

    @Override
    public Map getFunction(PrdctVo prdctVo) {
        List listFnct = prdctMapper.getFunction(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("tyList", listFnct);
        return resultMap;
    }

    @Override
    public Map getLensList(PrdctVo prdctVo) {
        List listLens = prdctMapper.getLensList(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listLens", listLens);
        return resultMap;
    }

    @Override
    public Map getRate(PrdctVo prdctVo) {
        List listRate = prdctMapper.getRate(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listRate", listRate);
        return resultMap;
    }

    @Override
    public String newOrder(PrdctVo prdctVo) {
        try {
            prdctMapper.addNewLens(prdctVo);
            prdctMapper.newOrder(prdctVo);
            prdctMapper.newRequestLens(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String adNewLensData(PrdctVo prdctVo) {
        try {
            prdctMapper.addNewLensData(prdctVo);
            return "success|" + prdctVo.getPrdctId();
        } catch (Exception e) {
            e.printStackTrace();
            return "fail|null";
        }
    }

    @Override
    public String cancelOrder(PrdctVo prdctVo) {
        try {
            prdctMapper.candelOrder(prdctVo);
            return "ok";
        } catch (Exception e) {
            return "fail";
        }
    }

    @Override
    public Map showAllLensType(PrdctVo prdctVo) {
        List listTy = prdctMapper.showAllLensType(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("tyList", listTy);

        return resultMap;
    }

    @Override
    public String addNewLensTy(PrdctVo prdctVo) {
        try {
            prdctMapper.addNewLensTyId(prdctVo);
            return "success|" + prdctVo.getTyId1();
        } catch (Exception e) {
            e.printStackTrace();
            return "fail|null";
        }
    }

    @Override
    public Map getRtnReasonList() {
        List listReason = prdctMapper.getRtnReasonList();
        Map resultMap = new HashMap();
        resultMap.put("listReason", listReason);
        return resultMap;
    }

    @Override
    public String ReturnPrdct(PrdctVo prdctVo) {
        try {
            prdctMapper.ReturnPrdct(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getLensListByType(PrdctVo prdctVo) {
        List listLens = prdctMapper.getLensListByType(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listLens", listLens);
        return resultMap;
    }

    @Override
    public String addNewRtnReason(PrdctVo prdctVo) {
        try {
            prdctMapper.addNewRtnReason(prdctVo);
            prdctMapper.ReturnPrdct(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getLensComList(PrdctVo prdctVo) {
        List listCom = prdctMapper.getLensComList(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listCom", listCom);
        return resultMap;
    }

    @Override
    public Map getLensListForOrder(PrdctVo prdctVo) {
        List listLens = prdctMapper.getLensListForOrder(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listLens", listLens);
        return resultMap;
    }

    @Override
    public String lensOrder(PrdctVo prdctVo) {
        try {
            if (!prdctVo.getCYL().substring(0, 1).equals("-")) {
                prdctVo.setCYL("+" + prdctVo.getCYL().trim());
            }
            if (!prdctVo.getSPH().substring(0, 1).equals("-")) {
                prdctVo.setSPH("+" + prdctVo.getSPH().trim());
            }
            prdctMapper.lensOrder(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String lensComOrder(PrdctVo prdctVo) {
        try {
            if (!prdctVo.getCYL().substring(0, 1).equals("-")) {
                prdctVo.setCYL("+" + prdctVo.getCYL().trim());
            }
            if (!prdctVo.getSPH().substring(0, 1).equals("-")) {
                prdctVo.setSPH("+" + prdctVo.getSPH().trim());
            }
            prdctMapper.lensComOrder(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getLensOrderList(PrdctVo prdctVo) {
        List listLens = prdctMapper.getLensOrderList(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listLens", listLens);
        return resultMap;
    }

    @Override
    public Map getNewLensOrderList(PrdctVo prdctVo) {
        List listLens = prdctMapper.getNewLensOrderList(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("listNewLens", listLens);
        return resultMap;
    }

    @Override
    public PrdctVo getLensBound(PrdctVo prdctVo) {
        prdctVo = prdctMapper.getLensBound(prdctVo);
        return prdctVo;
    }

    @Override
    public Map getRtnFrame(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnFrame(prdctVo);
        resultMap.put("getRtnFrame", receitList);
        return resultMap;
    }

    @Override
    public Map getRtnLens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnLens(prdctVo);
        resultMap.put("getRtnLens", receitList);
        return resultMap;
    }

    @Override
    public Map getRtnLens2(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnLens2(prdctVo);
        resultMap.put("getRtnLens2", receitList);
        return resultMap;
    }

    @Override
    public Map getRtnClens(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnClens(prdctVo);
        resultMap.put("getRtnClens", receitList);
        return resultMap;
    }

    @Override
    public Map getRtnAcc(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnAcc(prdctVo);
        resultMap.put("getRtnAcc", receitList);
        return resultMap;
    }

    @Override
    public Map getRtnEtc(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List receitList = prdctMapper.getRtnEtc(prdctVo);
        resultMap.put("getRtnEtc", receitList);
        return resultMap;
    }

    @Override
    public String OrderRX(PrdctVo prdctVo) {
        try {
            if (!prdctVo.getCylL().equals("")) {
                if (!prdctVo.getCylL().substring(0, 1).equals("-")) {
                    prdctVo.setCylL("+" + prdctVo.getCylL().trim());
                }
            }

            if (!prdctVo.getSphL().equals("")) {
                if (!prdctVo.getSphL().substring(0, 1).equals("-")) {
                    prdctVo.setSphL("+" + prdctVo.getSphL().trim());
                }
            }
            if (!prdctVo.getCylR().equals("")) {
                if (!prdctVo.getCylR().substring(0, 1).equals("-")) {
                    prdctVo.setCylR("+" + prdctVo.getCylR().trim());
                }
            }
            if (!prdctVo.getSphR().equals("")) {
                if (!prdctVo.getSphR().substring(0, 1).equals("-")) {
                    prdctVo.setSphR("+" + prdctVo.getSphR().trim());
                }
            }
            prdctMapper.addOrderList(prdctVo);
            prdctMapper.OrderRX(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public PrdctVo editLensRX(PrdctVo prdctVo) {
        return prdctMapper.editLensRX(prdctVo);
    }

    @Override
    public Map getColorCom(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List comList = prdctMapper.getColorCom(prdctVo);
        resultMap.put("comList", comList);
        return resultMap;
    }

    @Override
    public Map getColorList(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List colorList = prdctMapper.getLensColorList(prdctVo);
        resultMap.put("colorList", colorList);
        return resultMap;
    }

    @Override
    public String modifyLens(PrdctVo prdctVo) {
        try {
            if (prdctVo.getCylL() != "") {
                if (!prdctVo.getCylL().substring(0, 1).equals("-")) {
                    prdctVo.setCylL("+" + prdctVo.getCylL().trim());
                }
            }

            if (prdctVo.getSphL() != "") {
                if (!prdctVo.getSphL().substring(0, 1).equals("-")) {
                    prdctVo.setSphL("+" + prdctVo.getSphL().trim());
                }
            }

            if (prdctVo.getCylR() != "") {
                if (!prdctVo.getCylR().substring(0, 1).equals("-")) {
                    prdctVo.setCylR("+" + prdctVo.getCylR().trim());
                }
            }

            if (prdctVo.getSphR() != "") {
                if (!prdctVo.getSphR().substring(0, 1).equals("-")) {
                    prdctVo.setSphR("+" + prdctVo.getSphR().trim());
                }
            }
            prdctMapper.modifyLensM(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String modifySpareLensSpec(PrdctVo prdctVo) {
        try {
            if (!prdctVo.getCYL().substring(0, 1).equals("-")) {
                prdctVo.setCYL("+" + prdctVo.getCYL().trim());
            }
            if (!prdctVo.getSPH().substring(0, 1).equals("-")) {
                prdctVo.setSPH("+" + prdctVo.getSPH().trim());
            }
            prdctMapper.modifySpareLensSpec(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public PrdctVo getOrderPrdctProp(PrdctVo prdctVo) {
        return prdctMapper.getOrderPrdctProp(prdctVo);
    }

    @Override
    public PrdctVo getOrderPrdctProp2(PrdctVo prdctVo) {
        return prdctMapper.getOrderPrdctProp2(prdctVo);
    }

    @Override
    public String allowComOrder(PrdctVo prdctVo) {
        try {
            String allow = prdctMapper.chkAdminAllow(prdctVo);
            if (allow == null) {
                allow = "1";
            }

            if (allow.equals("0")) {
                return "reject";
            } else {
                prdctMapper.allowComOrder(prdctVo);
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String getComOrderCnt(PrdctVo prdctVo) {
        try {
            return prdctMapper.getComOrderCnt(prdctVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getComListByCntry(PrdctVo prdctVo) {
        List comList = prdctMapper.getComListByCntry(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("comList", comList);
        return resultMap;
    }

    @Override
    public Map getComListForOrd(PrdctVo prdctVo) {
        List comList = prdctMapper.getComListForOrd(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("comList", comList);
        return resultMap;
    }

    @Override
    public Map getLensTyByCom(PrdctVo prdctVo) {
        List lensTyList = prdctMapper.getLensTyByCom(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("lensTyList", lensTyList);
        return resultMap;
    }

    @Override
    public Map getLensSM(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List lensSM = prdctMapper.getLensSM(prdctVo);
        resultMap.put("lensSM", lensSM);
        return resultMap;
    }

    @Override
    public Map showDetail(PrdctVo prdctVo) {
        List detailList = prdctMapper.showDetail(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("detailist", detailList);
        return resultMap;
    }

    @Override
    public PrdctVo getShopName(PrdctVo prdctVo) {
        return prdctMapper.getShopName(prdctVo);
    }

    @Override
    public String addShopLensInvn(PrdctVo prdctVo) {
        try {
            String exist = prdctMapper.srchLensInvn(prdctVo);
            if (exist != null) {
                prdctMapper.updateLensInvn(prdctVo);
            } else {
                prdctMapper.addLensInvn(prdctVo);
            }
            prdctMapper.addLensInbnHist(prdctVo);
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getComOrderList(PrdctVo prdctVo) {
        List comOrderList = prdctMapper.getComOrderList(prdctVo);

        Map resultMap = new HashMap();
        resultMap.put("listPrdct", comOrderList);
        return resultMap;
    }

    @Override
    public String chkAdminAllow(PrdctVo prdctVo) {
        try {
            String allow = prdctMapper.chkAdminAllow(prdctVo);
            if (allow.equals("0")) {
                return "reject";
            } else {
                return "allow";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "reject";
        }
    }

    @Override
    public Map getPrdctOption(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List optionList = prdctMapper.getPrdctOption(prdctVo);
        resultMap.put("optionList", optionList);
        return resultMap;
    }

    @Override
    public String modiftOption(PrdctVo prdctVo) {
        try {
            prdctMapper.modifyOption(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public Map getPrdctRanking(PrdctVo prdctVo) {
        Map resultMap = new HashMap();
        List prdctList = prdctMapper.getPrdctRanking(prdctVo);
        resultMap.put("prdctList", prdctList);
        return resultMap;
    }

    @Override
    public Map getTradeListByCom(ShopVo shopVo) {
        List tradeList = prdctMapper.getTradeListByCom(shopVo);
        Map resultMap = new HashMap();
        resultMap.put("tradeList", tradeList);
        return resultMap;
    }

    @Override
    public Map getTradeListForModify(PrdctVo prdctVo) {
        List trdeList = prdctMapper.getTradeListForModify(prdctVo);
        Map resultMap = new HashMap();
        resultMap.put("trdeList", trdeList);
        return resultMap;
    }

    @Override
    public String modifyDate(PrdctVo prdctVo) {
        try {
            prdctMapper.modifyDate(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String comAllow(PrdctVo prdctVo) {
        try {
            prdctMapper.comAllow(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public String getDetail(PrdctVo prdctVo) {
        return prdctMapper.getDetail(prdctVo);
    }

    @Override
    public void modDetail(PrdctVo prdctVo) {
        prdctMapper.modDetail(prdctVo);
    }

    @Override
    public String delData(PrdctVo prdctVo) {
        try {
            prdctMapper.delData(prdctVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}
