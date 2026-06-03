package com.gallery.tax;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Deprecated
@Service
@Repository
public class TaxServiceImpl implements TaxService {

    private final static String namespace = "com.gallery.sale.";
    private final static String prdctspace = "com.gallery.prdct.";
    private final static String eventspace = "com.gallery.event.";

//    @Autowired
//    PrdctService prdctService;
//
//    @Override
//    public Map listSaleData(SaleVo saleVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List saleList = sqlSession.selectList(namespace + "listSale", saleVo);
//        resultMap.put("listSale", saleList);
//
//        return resultMap;
//    }
//
//    @Override
//    public Map listSaleHistData(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List saleList = sqlSession.selectList(namespace + "listSaleHist", searchVo);
//        System.out.println(saleList);
//        resultMap.put("listsale", saleList);
//
//        return resultMap;
//    }
//
//    @Override
//    public Map listSalesHistData(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List salesList = sqlSession.selectList(namespace + "listSalesHist", searchVo);
//        resultMap.put("listsales", salesList);
//
//        return resultMap;
//    }
//
//    @Override
//    public Map listSalesHistDataTotal(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List salesList = sqlSession.selectList(namespace + "getTotalShopSales", searchVo);
//        resultMap.put("listsales", salesList);
//
//        return resultMap;
//    }
//
//    @Override
//    public Map listPrdctSaleHistData(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List saleList = sqlSession.selectList(namespace + "listPrdctSaleHist", searchVo);
//        resultMap.put("listsale", saleList);
//
//        return resultMap;
//    }
//
//
//    @Override
//    public SaleVo selectSale(SaleVo saleVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        return (SaleVo) sqlSession.selectOne(namespace + "getSale", saleVo);
//    }
//
//
//    @Override
//    public void mListSaleData(HttpServletResponse response) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        String str = "";
//        //response.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=utf-8"); //한글깨짐방지
//        PrintWriter writer = response.getWriter();
//
//        Map resultMap = new HashMap();
//        List saleList = sqlSession.selectList(namespace + "mlistSale");
//        resultMap.put("listSale", saleList);
//
//        ObjectMapper om = new ObjectMapper();
//        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
//
//
//        writer.write(str);
//        writer.flush();
//        writer.close();
//    }
//
//
//    @Override
//    public Map findShopName(ShopVo shopVo) throws Exception {
//        SqlSession sql = getSqlSession();
//        List result = sql.selectList(namespace + "findShopName", shopVo);
//        Map resultMap = new HashMap();
//        resultMap.put("shopList", result);
//        return resultMap;
//
//    }
//
//    @Override
//    public Map listSalesHistDatatoCsv(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        logger.info("@@@@@@@@@:" + searchVo);
//        List salesList = sqlSession.selectList(namespace + "listSalesHist", searchVo);
//        resultMap.put("listsales", salesList);
//        return resultMap;
//    }
//
//
//    @Override
//    public Map getCardInfo(SaleHistSearchVo saleVo) throws Exception {
//        SqlSession sql = getSqlSession();
//        List listCard = sql.selectList(namespace + "getCardInfo", saleVo);
//        Map resultMap = new HashMap();
//        resultMap.put("listCard", listCard);
//        return resultMap;
//    }
//
//    @Override
//    public Map listSalesHistDataTotalCsv(SaleHistSearchVo searchVo) throws Exception {
//
//        SqlSession sqlSession = getSqlSession();
//        Map resultMap = new HashMap();
//        List salesList = sqlSession.selectList(namespace + "getTotalShopSales", searchVo);
//        resultMap.put("listsales", salesList);
//        return resultMap;
//    }
//
//    @Override
//    public Map listSalesHistDataByStaffCsv(SaleHistSearchVo saleVo)
//            throws Exception {
//        SqlSession sql = getSqlSession();
//        Map resultMap = new HashMap();
//        List salesList = sql.selectList(namespace + "listSalesHistDataByStaff", saleVo);
//        resultMap.put("listsales", salesList);
//        return resultMap;
//    }
//
//    @Override
//    public Map listSalesHistDataByStaff(SaleHistSearchVo saleVo)
//            throws Exception {
//        SqlSession sql = getSqlSession();
//        Map resultMap = new HashMap();
//        List salesList = sql.selectList(namespace + "listSalesHistDataByStaff", saleVo);
//        resultMap.put("listsales", salesList);
//        return resultMap;
//    }
}
