package com.gallery.sale;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.common.CommonCode;
import com.gallery.common.CommonURI;
import com.gallery.common.PagingVo;
import com.gallery.event.EventMapper;
import com.gallery.event.EventVo;
import com.gallery.prdct.PrdctMapper;
import com.gallery.prdct.PrdctVo;
import com.gallery.shop.ShopVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;

@Service
@RequiredArgsConstructor
public class SaleServiceImpl implements SaleService {

    private final SaleMapper saleMapper;
    private final PrdctMapper prdctMapper;
    private final EventMapper eventMapper;

    @Deprecated
    @Transactional
    public void timeExceed() {
        List<SaleVo> sales = saleMapper.selectSaleTimeExceed();
        if (sales != null) {
            for (int i = 0; i < sales.size(); i++) {
                checkJob(sales.get(i).getSaleId());
            }
        }
    }

    @Deprecated
    @Override
    @Transactional
    public String addSale(SaleVo saleVo, HttpServletResponse response) throws Exception {
        saleVo.setShopNumber(Integer.parseInt(CommonCode.SHOP_CODE_MOBILE));
        saleMapper.addSale(saleVo);

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

                    PrdctVo prdctVo = new PrdctVo();
                    prdctVo.setPrdctId(salePrdctVo.getPrdctId());
                    prdctVo.setCnt(salePrdctVo.getPrdctCnt());
                    prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                    salePrdctVo.setSaleId(orderNo);

                    PrdctVo getVo = prdctMapper.getPrdctInvn(prdctVo);

                    if (getVo == null) {
                        PrintWriter writer = response.getWriter();
                        writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                        writer.flush();
                        writer.close();

                        int a = 1 / 0;
                    } else {
                        salePrdctVo.setPrc(getVo.getTrdePrc());
                        prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                        saleMapper.addSalePrdct(salePrdctVo);

                        if (getVo.getCnt() < prdctVo.getCnt()) {
                            PrintWriter writer = response.getWriter();
                            writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                            writer.flush();
                            writer.close();
                            int a = 1 / 0;
                        }

                        int rows = prdctMapper.modifyPrdctInvn(prdctVo);
                        if (rows != 1) {
                            int a = 1 / 0;
                        }

                        ognPrc += (getVo.getTrdePrc() * salePrdctVo.getPrdctCnt());
                        if (salePrdctVo.getEventId() != null) {
                            EventVo eventVo = eventMapper.getEventForPrdct(salePrdctVo);
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

                    salePrdctVo.setSaleId(orderNo);

                    PrdctVo getVo = prdctMapper.getPrdctInvn(prdctVo);

                    if (getVo == null) {
                        PrintWriter writer = response.getWriter();
                        writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                        writer.flush();
                        writer.close();

                        int a = 1 / 0;
                    } else {
                        salePrdctVo.setPrc(getVo.getTrdePrc());
                        prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_OUT);
                        saleMapper.addSalePrdct(salePrdctVo);
                        if (getVo.getCnt() < prdctVo.getCnt()) {
                            PrintWriter writer = response.getWriter();
                            writer.write("{\"result\":\"shortage\",\"prdctId\":\"" + prdctVo.getPrdctId() + "\"}");
                            writer.flush();
                            writer.close();

                            int a = 1 / 0;
                        }

                        int rows = prdctMapper.modifyPrdctInvn(prdctVo);
                        if (rows != 1) {
                            int a = 1 / 0;
                        }

                        ognPrc += (getVo.getTrdePrc() * salePrdctVo.getPrdctCnt());
                        if (salePrdctVo.getEventId() != null) {
                            EventVo eventVo = eventMapper.getEventForPrdct(salePrdctVo);
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
        if (ognPrc.intValue() != saleVo.getOgnPrice().intValue()) {
            PrintWriter writer = response.getWriter();
            writer.write("{\"result\":\"NoMatchOgnPrc\"}");
            writer.flush();
            writer.close();

            int a = 1 / 0;
        }
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
    public void checkJob(Integer saleId) {
        SaleVo saleVo = new SaleVo();
        saleVo.setSaleId(saleId);

        SaleVo getSaleVo = saleMapper.getSaleForResult(saleVo);

        if (getSaleVo != null) {
            saleVo.setCJSResultCode("0001");
            modifySale(saleVo);
        }
    }

    @Override
    @Transactional
    public String modifySale(SaleVo saleVo) {
        if (saleVo.getCJSResultCode() == null) {
            return "0002";
        }
        SaleVo getSaleVo = saleMapper.getSaleForResult(saleVo);
        if (getSaleVo == null) {
            return "0001";
        }

        if (!(saleVo.getCJSResultCode().equals("0000") || saleVo.getCJSResultCode().equals("0") || saleVo.getCJSResultCode().equals("sucess"))) {
            List<SalePrdctVo> listSalePrdctVo = saleMapper.listSalePrdct(saleVo);

            for (int i = 0; i < listSalePrdctVo.size(); i++) {
                PrdctVo prdctVo = new PrdctVo();
                prdctVo.setPrdctId(listSalePrdctVo.get(i).getPrdctId());

                prdctVo.setInvnTyCd(CommonCode.CODE_INVN_TY_IN);
                prdctVo.setCnt(listSalePrdctVo.get(i).getPrdctCnt());

                int rows = prdctMapper.modifyPrdctInvn(prdctVo);
                if (rows != 1) {
                    int a = 1 / 0;
                }
            }
        }
        saleVo.setSaleId(Integer.parseInt(saleVo.getCJSShopOrderNo()));
        saleMapper.modifySale(saleVo);
        return "0000";
    }

    @Deprecated
    @Override
    public Map pagedListSaleData(SaleVo saleVo) {
        Map resultMap = new HashMap();

        int pageCount = saleMapper.pagedListSaleCount(saleVo);
        List<SaleVo> saleList = saleMapper.pagedListSale(saleVo);
        PagingVo paging = new PagingVo();
        paging.setCurrentPage(saleVo.getCurrentPage());
        paging.setPageSize(saleVo.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listSale", saleList);
        return resultMap;
    }

    @Override
    public Map listSaleHistData(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List<SaleVo> saleList = saleMapper.listSaleHist(searchVo);
        resultMap.put("listsale", saleList);
        return resultMap;
    }

    @Override
    public Map listSalesHistData(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List<SalesVo> salesList = saleMapper.listSalesHist(searchVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public Map listSalesHistDataTotal(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List<SalesVo> salesList = saleMapper.getTotalShopSales(searchVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public Map listPrdctSaleHistData(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List<SaleVo> saleList = saleMapper.listPrdctSaleHist(searchVo);
        resultMap.put("listsale", saleList);
        return resultMap;
    }

    @Deprecated
    @Override
    public SaleVo selectSale(SaleVo saleVo) {
        return saleMapper.getSale(saleVo);
    }

    @Deprecated
    @Override
    public void mListSaleData(HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
        PrintWriter writer = response.getWriter();

        Map resultMap = new HashMap();
        List<SaleVo> saleList = saleMapper.mlistSale();
        resultMap.put("listSale", saleList);

        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Override
    public Map findShopName(ShopVo shopVo) {
        List result = saleMapper.findShopName(shopVo);
        Map resultMap = new HashMap();
        resultMap.put("shopList", result);
        return resultMap;
    }

    @Override
    public Map listSalesHistDatatoCsv(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List salesList = saleMapper.listSalesHist(searchVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public Map getCardInfo(SaleHistSearchVo saleVo) {
        List listCard = saleMapper.getCardInfo(saleVo);
        Map resultMap = new HashMap();
        resultMap.put("listCard", listCard);
        return resultMap;
    }

    @Override
    public Map listSalesHistDataTotalCsv(SaleHistSearchVo searchVo) {
        Map resultMap = new HashMap();
        List salesList = saleMapper.getTotalShopSales(searchVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public Map listSalesHistDataByStaffCsv(SaleHistSearchVo saleVo) {
        Map resultMap = new HashMap();
        List salesList = saleMapper.listSalesHistDataByStaff(saleVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public Map listSalesHistDataByStaff(SaleHistSearchVo saleVo) {
        Map resultMap = new HashMap();
        List salesList = saleMapper.listSalesHistDataByStaff(saleVo);
        resultMap.put("listsales", salesList);
        return resultMap;
    }

    @Override
    public List<SaleVo> listSaleOff4Tax(SaleVo saleVo) {
        String[] cstmrCds = saleVo.getCstmrCds().split("[@]");
        List<SaleVo> listCstmrCds = new ArrayList<SaleVo>();

        for (int i = 0, size = cstmrCds.length; i < size; i++) {
            SaleVo tmpSaleVo = new SaleVo();
            tmpSaleVo.setCstmrCd(cstmrCds[i]);
            listCstmrCds.add(tmpSaleVo);
        }
        HashMap<String, Object> saleMap = new HashMap<String, Object>();
        saleMap.put("listCstmrCds", listCstmrCds);
        saleMap.put("sDate", saleVo.getSDate());
        saleMap.put("eDate", saleVo.getEDate());

        List<SaleVo> saleList = saleMapper.listSaleOff4Tax(saleVo);

        return saleList;
    }

    @Override
    @Transactional
    public String renewalTaxBigo(SaleVo saleVo) {
        saleMapper.renewalTaxBigo(saleVo);
        return "success";
    }
}
