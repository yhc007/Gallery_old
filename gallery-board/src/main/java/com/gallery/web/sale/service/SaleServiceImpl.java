package com.gallery.web.sale.service;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.CommonURI;
import com.gallery.web.common.domain.PagingVo;
import com.gallery.web.event.domain.EventVo;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.prdct.service.PrdctService;
import com.gallery.web.sale.domain.SaleHistSearchVo;
import com.gallery.web.sale.domain.SalePrdctVo;
import com.gallery.web.sale.domain.SaleVo;
import com.gallery.web.sale.domain.SalesVo;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;

@Service
@Repository
public class SaleServiceImpl extends SqlSessionDaoSupport implements SaleService {

    private final static String namespace = "com.gallery.sale.";
    private final static String prdctspace = "com.gallery.prdct.";
    private final static String eventspace = "com.gallery.event.";
    @Autowired
    PrdctService prdctService;


    @Transactional
    public void timeExceed() throws Exception {
        SqlSession sqlSession = getSqlSession();
        List<SaleVo> sales = sqlSession.selectList(namespace + "selectSaleTimeExceed");

        if (sales != null) {
            for (int i = 0; i < sales.size(); i++) {
                checkJob(sales.get(i).getSaleId());
            }
        }
    }

    @Override
    @Transactional
    public String addSale(SaleVo saleVo, HttpServletResponse response) throws Exception {
        // TODO Auto-generated method stub

        SqlSession sqlSession = getSqlSession();

        saleVo.setShopNumber(-1000);

        Integer gid = sqlSession.insert(namespace + "addSale", saleVo);
        logger.debug("Sale gid=" + saleVo.getShopOrderNo());
        final Integer orderNo = Integer.valueOf(saleVo.getShopOrderNo());

        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지

        ObjectMapper mapper = new ObjectMapper();

        Integer ognPrc = 0;
        Integer salePrc = 0;

        JsonNode actualObj = mapper.readTree(saleVo.getPrdct());
        JsonNode lens = actualObj.get("lens");
        if (lens != null) {
            JsonFactory f = new JsonFactory();
            JsonParser jp = f.createJsonParser(lens.toString());
            // advance stream to START_ARRAY first:
            jp.nextToken();

            // and then each time, advance to opening START_OBJECT


            while (jp.nextToken() == JsonToken.START_OBJECT) {

                try {
                    SalePrdctVo salePrdctVo = mapper.readValue(jp, SalePrdctVo.class);
                    //PrdctVo prdctVo = mapper.readValue(jp, PrdctVo.class);

                    PrdctVo prdctVo = new PrdctVo();
                    prdctVo.setPrdctId(salePrdctVo.getPrdctId());
                    prdctVo.setCnt(salePrdctVo.getPrdctCnt());
                    prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                    logger.info(">>>>>>>>>>>>>>>>" + salePrdctVo.toString());
                    logger.info(">>>>>>>>>>>>>>>>" + prdctVo.toString());
                    salePrdctVo.setSaleId(orderNo);

                    PrdctVo getVo = (PrdctVo) sqlSession.selectOne(prdctspace + "getPrdctInvn", prdctVo);


                    if (getVo == null) {
                        PrintWriter writer = response.getWriter();
                        writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                        writer.flush();
                        writer.close();

                        int a = 1 / 0;
                    } else {
                        salePrdctVo.setPrc(getVo.getTrdePrc());
                        prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                        sqlSession.insert(namespace + "addSalePrdct", salePrdctVo);

                        if (getVo.getCnt() < prdctVo.getCnt()) {
                            PrintWriter writer = response.getWriter();
                            writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                            writer.flush();
                            writer.close();

                            int a = 1 / 0;
                        }

                        int rows = sqlSession.update(prdctspace + "modifyPrdctInvn", prdctVo);
                        if (rows != 1) {
                            int a = 1 / 0;
                        }


                        logger.debug("getVo" + getVo.toString());
                        logger.debug("salePrdctVo" + salePrdctVo.toString());
                        ognPrc += (getVo.getTrdePrc() * salePrdctVo.getPrdctCnt());
                        if (salePrdctVo.getEventId() != null) {
                            EventVo eventVo = (EventVo) sqlSession.selectOne(eventspace + "getEventForPrdct", salePrdctVo);
                            if (eventVo == null) {
                                PrintWriter writer = response.getWriter();
                                writer.write("{\"result\":\"NoMatchEvent\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                                writer.flush();
                                writer.close();

                                int a = 1 / 0;
                            }

                            if (eventVo.getDscnt() != salePrdctVo.getDscnt()) {
                                PrintWriter writer = response.getWriter();
                                writer.write("{\"result\":\"NoMatchEvent\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                                writer.flush();
                                writer.close();

                                int a = 1 / 0;
                            }
                        }
                        System.out.println(">>> salePrc" + ((getVo.getTrdePrc() * salePrdctVo.getPrdctCnt()) * (100 - salePrdctVo.getDscnt())) / 100);
                        salePrc += ((getVo.getTrdePrc() * salePrdctVo.getPrdctCnt()) * (100 - salePrdctVo.getDscnt())) / 100;

                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    int a = 1 / 0;
                }
                // process
                // after binding, stream points to closing END_OBJECT
            }
        }
        JsonNode frame = actualObj.get("frame");

        if (frame != null) {
            JsonFactory f = new JsonFactory();

            JsonParser jp = f.createJsonParser(frame.toString());
            // advance stream to START_ARRAY first:
            jp.nextToken();
            // and then each time, advance to opening START_OBJECT
            while (jp.nextToken() == JsonToken.START_OBJECT) {
                try {
                    SalePrdctVo salePrdctVo = mapper.readValue(jp, SalePrdctVo.class);
                    //PrdctVo prdctVo = mapper.readValue(jp, PrdctVo.class);

                    PrdctVo prdctVo = new PrdctVo();
                    prdctVo.setPrdctId(salePrdctVo.getPrdctId());
                    prdctVo.setCnt(salePrdctVo.getPrdctCnt());

                    logger.debug(">>>>>>>>>>>>>>>>" + salePrdctVo.toString());
                    logger.debug(">>>>>>>>>>>>>>>>" + prdctVo.toString());
                    salePrdctVo.setSaleId(orderNo);

                    PrdctVo getVo = (PrdctVo) sqlSession.selectOne(prdctspace + "getPrdctInvn", prdctVo);

                    if (getVo == null) {
                        PrintWriter writer = response.getWriter();
                        writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                        writer.flush();
                        writer.close();

                        int a = 1 / 0;
                    } else {
                        salePrdctVo.setPrc(getVo.getTrdePrc());
                        prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                        sqlSession.insert(namespace + "addSalePrdct", salePrdctVo);
                        if (getVo.getCnt() < prdctVo.getCnt()) {
                            PrintWriter writer = response.getWriter();
                            writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                            writer.flush();
                            writer.close();

                            int a = 1 / 0;
                        }

                        int rows = sqlSession.update(prdctspace + "modifyPrdctInvn", prdctVo);
                        if (rows != 1) {
                            int a = 1 / 0;
                        }

                        ognPrc += (getVo.getTrdePrc() * salePrdctVo.getPrdctCnt());
                        if (salePrdctVo.getEventId() != null) {
                            EventVo eventVo = (EventVo) sqlSession.selectOne(eventspace + "getEventForPrdct", salePrdctVo);
                            if (eventVo == null) {
                                PrintWriter writer = response.getWriter();
                                writer.write("{\"result\":\"NoMatchEvent\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                                writer.flush();
                                writer.close();

                                int a = 1 / 0;
                            }

                            if (eventVo.getDscnt() != salePrdctVo.getDscnt()) {
                                PrintWriter writer = response.getWriter();
                                writer.write("{\"result\":\"NoMatchEvent\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                                writer.flush();
                                writer.close();

                                int a = 1 / 0;
                            }


                        }
                        salePrc += (getVo.getTrdePrc() * salePrdctVo.getPrdctCnt() * ((100 - salePrdctVo.getDscnt()) / 100));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    int a = 1 / 0;
                }
                // process
                // after binding, stream points to closing END_OBJECT
            }
        }
        logger.debug("ognPrc:" + ognPrc + ", saleVo.getOgnPrice():" + saleVo.getOgnPrice());
        if (ognPrc.intValue() != saleVo.getOgnPrice().intValue()) {
            PrintWriter writer = response.getWriter();
            writer.write("{\"result\":\"NoMatchOgnPrc\"}");
            writer.flush();
            writer.close();

            int a = 1 / 0;
        }
        logger.debug("saleVo = " + saleVo.toString());
        logger.debug("salePrc" + salePrc + ", saleVo." + (saleVo.getPayCard() + saleVo.getPayCash()));
        if (salePrc != (saleVo.getPayCard() + saleVo.getPayCash())) {
            PrintWriter writer = response.getWriter();
            writer.write("{\"result\":\"NoMatchSalePrc\"}");
            writer.flush();
            writer.close();

            int a = 1 / 0;
        }

        Timer timer = new Timer();
        timer.schedule(new TimerTask() {

            public void run() {
                try {
                    checkJob(orderNo);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 1000 * 60 * 30);

        Map resultMap = new HashMap();
        resultMap.put("result", "SUCCESS");
        resultMap.put("saleId", orderNo);
        resultMap.put("callback", CommonURI.CALLBACK_URI);
        resultMap.put("redirect", CommonURI.REDIRECT_URI);

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);

        return str;
    }

    @Transactional
    public void checkJob(Integer saleId) throws Exception {
        SaleVo saleVo = new SaleVo();
        saleVo.setSaleId(saleId);
        SqlSession sqlSession = getSqlSession();
        SaleVo getSaleVo = (SaleVo) sqlSession.selectOne(namespace + "getSaleForResult", saleVo);
        if (getSaleVo != null) {
            saleVo.setCJSResultCode("0001");
            modifySale(saleVo);
        }
    }

    @Override
    @Transactional
    public String modifySale(SaleVo saleVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();

        if (saleVo.getCJSResultCode() == null) {
            return "0002";
        }
        SaleVo getSaleVo = (SaleVo) sqlSession.selectOne(namespace + "getSaleForResult", saleVo);
        if (getSaleVo == null) {
            return "0001";
        }

        if (!(saleVo.getCJSResultCode().equals("0000") || saleVo.getCJSResultCode().equals("0") || saleVo.getCJSResultCode().equals("sucess"))) {
            List<SalePrdctVo> salePrdctVo = sqlSession.selectList(namespace + "listSalePrdct", saleVo);

            for (int i = 0; i < salePrdctVo.size(); i++) {
                PrdctVo prdctVo = new PrdctVo();
                prdctVo.setPrdctId(salePrdctVo.get(i).getPrdctId());

                prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_IN);
                PrdctVo getVo = (PrdctVo) sqlSession.selectOne(prdctspace + "getPrdctInvn", prdctVo);
                prdctVo.setCnt(salePrdctVo.get(i).getPrdctCnt());

                int rows = sqlSession.update(prdctspace + "modifyPrdctInvn", prdctVo);
                if (rows != 1) {
                    int a = 1 / 0;
                }
            }
        }
        sqlSession.update(namespace + "modifySale", saleVo);
        return "0000";
    }


    @Override
    public Map pagedListSaleData(SaleVo saleVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();

        int pageCount = (Integer) sqlSession.selectOne(namespace + "pagedListSaleCount", saleVo);
        List saleList = sqlSession.selectList(namespace + "pagedListSale", saleVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(saleVo.getCurrentPage());
        paging.setPageSize(saleVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listSale", saleList);
        return resultMap;
    }

    @Override
    public Map listSaleData(SaleVo saleVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();
        List saleList = sqlSession.selectList(namespace + "listSale", saleVo);
        resultMap.put("listSale", saleList);

        return resultMap;
    }

    @Override
    public Map listSaleHistData(SaleHistSearchVo searchVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();
        List saleList = sqlSession.selectList(namespace + "listSaleHist", searchVo);
        System.out.println(saleList);
        resultMap.put("listsale", saleList);

        return resultMap;
    }

    @Override
    public Map listSalesHistData(SaleHistSearchVo searchVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();
        List salesList = sqlSession.selectList(namespace + "listSalesHist", searchVo);
        resultMap.put("listsales", salesList);

        return resultMap;
    }

    @Override
    public Map listPrdctSaleHistData(SaleHistSearchVo searchVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();
        List saleList = sqlSession.selectList(namespace + "listPrdctSaleHist", searchVo);
        resultMap.put("listsale", saleList);

        return resultMap;
    }


    @Override
    public SaleVo selectSale(SaleVo saleVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        return (SaleVo) sqlSession.selectOne(namespace + "getSale", saleVo);
    }


    @Override
    public void mListSaleData(HttpServletResponse response) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        String str = "";
        //response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();

        Map resultMap = new HashMap();
        List saleList = sqlSession.selectList(namespace + "mlistSale");
        resultMap.put("listSale", saleList);

        ObjectMapper om = new ObjectMapper();
        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);


        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Override
    public Map findShopName(Integer shopId) throws Exception {

        SqlSession sql = getSqlSession();
        SalesVo shop_id = (SalesVo) sql.selectOne(namespace + "getShopId", shopId);
        List result = sql.selectList(namespace + "findShopName", shop_id);
        Map resultMap = new HashMap();
        resultMap.put("shopList", result);
        return resultMap;

    }

    @Override
    public Map listSalesHistDatatoCsv(SaleHistSearchVo searchVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();
        List salesList = sqlSession.selectList(namespace + "listSalesHist", searchVo);
        resultMap.put("listsales", salesList);

        return resultMap;
    }


}
