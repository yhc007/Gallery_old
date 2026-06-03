package com.gallery.app.cstmr.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.app.cstmr.domain.CstmrVo;
import com.gallery.web.common.domain.CommonCode;
import com.gallery.web.common.domain.CommonURI;
import com.gallery.web.mail.domain.MailVo;
import com.gallery.web.mail.service.MailService;
import com.gallery.web.prdct.domain.PrdctVo;
import com.gallery.web.sale.domain.SaleVo;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.*;

@Service
@Repository
public class CstmrServiceImpl extends SqlSessionDaoSupport implements
        CstmrService {

    private final static String namespace = "com.gallery.cstmr.";
    private final static String mailspace = "com.gallery.mail.";
    @Autowired
    private MailService mailService;

    @Override
    public void addCstmr(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        logger.error("run addCstmr, cstmrVo:" + cstmrVo);
        SqlSession sqlSession = getSqlSession();
        sqlSession.insert(namespace + "addCstmr", cstmrVo);

        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("SUCCESS");
        writer.flush();
        writer.close();
    }

    @Override
    public void modifyCstmr(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void idDupleCheck(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        int count = (Integer) sqlSession.selectOne(
                namespace + "countCstmrById", cstmrVo);
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        if (count > 0) {
            writer.write("FALSE");
        } else {
            writer.write("TRUE");
        }
        writer.flush();
        writer.close();
    }

    @Override
    public void login(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        int count = (Integer) sqlSession
                .selectOne(namespace + "login", cstmrVo);
        CstmrVo getCstmrVo = selectCstmrForLogin(cstmrVo);

        // response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
        PrintWriter writer = response.getWriter();

        Map resultMap = new HashMap();
        if (count > 0) {
            resultMap.put("result", "SUCCESS");
            List arr = new ArrayList();
            arr.add(getCstmrVo);
            resultMap.put("cstmr", arr);
        } else {
            resultMap.put("result", "FAIL");
        }
        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Override
    public CstmrVo selectCstmrForLogin(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        return (CstmrVo) sqlSession.selectOne(namespace + "getCstmrForLogin",
                cstmrVo);
    }

    @Override
    public void findCstmrId(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        List<CstmrVo> cstmrList = sqlSession.selectList(namespace + "getCstmrLoginId", cstmrVo);

        List list = new ArrayList();
        for (int i = 0; i < cstmrList.size(); i++) {

            Map map = new HashMap();
            map.put("name", ((CstmrVo) cstmrList.get(i)).getCstmrName());
            map.put("phone", ((CstmrVo) cstmrList.get(i)).getCellphone());
            map.put("id", ((CstmrVo) cstmrList.get(i)).getCstmrLoginId());
            list.add(map);

        }

        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
        PrintWriter writer = response.getWriter();

        Map frameMap = new HashMap();
        frameMap.put("cstmrLists", list);
        ObjectMapper om = new ObjectMapper();
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(
                frameMap);

        writer.write(str);
        writer.flush();
        writer.close();

    }

    public String getRandomPassword(int length) {
        char[] charaters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',
                '8', '9'};
        StringBuilder sb = new StringBuilder("");
        Random rn = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(charaters[rn.nextInt(charaters.length)]);
        }
        return sb.toString();
    }

    public MailVo insertKey(MailVo mailVo) {
        SqlSession sqlSession = getSqlSession();
        String key = getRandomPassword(50);
        int count = (Integer) sqlSession.selectOne(mailspace + "getPwKeyCnt",
                key);
        if (count > 0) {
            return insertKey(mailVo);
        } else {
            mailVo.setPwkey(key);
            sqlSession.update(mailspace + "destroyKey", mailVo);
            sqlSession.insert(mailspace + "addKey", mailVo);
        }
        return mailVo;
    }

    @Override
    public void findCstmrPw(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        PrintWriter writer = response.getWriter();

        SqlSession sqlSession = getSqlSession();
        CstmrVo getCstmr = (CstmrVo) sqlSession.selectOne(namespace
                + "getCstmrLoginPw", cstmrVo);
        if (getCstmr == null) {
            writer.write("nomatch");
            writer.flush();
            writer.close();
            return;
        }

        /*
         * Map map=new HashMap(); map.put("phone", getCstmr.getCellphone());
         * map.put("id", getCstmr.getCstmrLoginId()); map.put("pw",
         * getCstmr.getCstmrLoginId()); map.put("email", getCstmr.getEmail());
         */

        MailVo mailVo = new MailVo();
        mailVo.setTitle("갤러리 비밀번호 변경 메일");
        mailVo.setContent("안녕하세요 " + getCstmr.getCstmrName()
                + "고객님\n요청하신 비밀번호 변경을 위해 아래 링크를 클릭하세요\n" + CommonURI.DOMAIN
                + CommonURI.CHANGE_PW + "?pwkey=" + CommonCode.PW_KEY_TAG);
        mailVo.setTo(getCstmr.getEmail());
        mailVo.setCstmrId(getCstmr.getCstmrId());
        mailService.sendMail(insertKey(mailVo));

        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지

        writer.write("success");
        writer.flush();
        writer.close();

    }

    public String updatePw(CstmrVo cstmrVo) throws Exception {
        SqlSession sqlSession = getSqlSession();
        sqlSession.update(namespace + "modifyCsmtrPw", cstmrVo);
        return "success";
    }

    public CstmrVo selectCstmrKey(MailVo mailVo) throws Exception {
        SqlSession sqlSession = getSqlSession();
        CstmrVo cstmrVo = (CstmrVo) sqlSession.selectOne(mailspace
                + "getCstmrForKey", mailVo);
        return cstmrVo;
    }

    public CstmrVo mCstmrData(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        Map resultMap = new HashMap();

        cstmrVo = (CstmrVo) sqlSession.selectOne(namespace + "mgetCstmr",
                cstmrVo);
        return cstmrVo;
    }

    @Override
    public void responseCstmrData(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        Map cstmrMap = new HashMap();

        List filterList = new ArrayList();
        PrdctVo preObj = null;

        List list = new ArrayList();
        cstmrVo = mCstmrData(cstmrVo);

        List listPrdct = new ArrayList();
        String model = "";

        List listBought = new ArrayList();
        Map map = new HashMap();
        // list on loop. get prdct and put to map, and list
        /*
         * for() map.put("still_img_path", .getImgPath()); map.put("color",
         * obj.getColor()); listBought.add(map);
         */

        List listCoupon = new ArrayList();

        logger.info("prdctList:" + listBought.toString());

        List objList = new ArrayList();

        // PrdctVo obj=(PrdctVo)listBought.get(i);
        Map objMap = new HashMap();
        String cstmrName = cstmrVo.getCstmrName();
        if (null == cstmrName) {
            cstmrName = "";
        }
        ;
        objMap.put("cstmrName", cstmrName);

        String birthDay = cstmrVo.getBirthDay();
        if (null == birthDay) {
            birthDay = "";
        }
        ;
        objMap.put("birthDay", birthDay);

        /*
         * String birthDayType = cstmrVo.getBirthDayTyCd(); if(null ==
         * birthDayType){birthDayType = "";};
         * objMap.put("birthDayType",birthDayType);
         */

        String cellPhone = cstmrVo.getCellphone();
        if (null == cellPhone) {
            cellPhone = "";
        }
        ;
        objMap.put("cellPhone", cellPhone);

        String addr = cstmrVo.getAddr();
        if (null == addr) {
            addr = "";
        }
        ;
        objMap.put("addr", addr);

        String cstmrCd = cstmrVo.getCstmrCd();
        if (null == cstmrCd) {
            cstmrCd = "";
        }
        ;
        objMap.put("cstmrCd", cstmrCd);

        Integer coupon = cstmrVo.getCoupon();
        objMap.put("coupon", coupon);

        Integer count = cstmrVo.getBuyCount();
        objMap.put("buyCount", count);

        Integer point = cstmrVo.getPoint();
        objMap.put("point", point);

        String eyeCheckDate = cstmrVo.getDatetime();
        String now = "";
        int checkDate = 0;
        if (null == eyeCheckDate) {
            eyeCheckDate = "";
            objMap.put("eyeCheckDate", eyeCheckDate);
        } else {
            int cyear = Integer.parseInt(eyeCheckDate.substring(0, 4));
            int cmonth = Integer.parseInt(eyeCheckDate.substring(4, 6));

            Calendar calendar = Calendar.getInstance();
            int nyear = calendar.get(Calendar.YEAR);
            int nmonth = calendar.get(Calendar.MONTH) + 1;

            int year = (nyear - cyear) * 12;
            int month = nmonth - cmonth;

            objMap.put("eyeCheckDate", year + month);
        }

        /*
         * String leftEye = cstmrVo.getGsphLeft(); if(null == leftEye){leftEye =
         * "";}; objMap.put("leftEye",leftEye);
         */

        /*
         * String rightEye = cstmrVo.getGsphRight(); if(null ==
         * rightEye){rightEye = "";}; objMap.put("rightEye",rightEye);
         */

        String birthDayTyCd = cstmrVo.getBirthDayTyCd();
        if (null == birthDayTyCd) {
            birthDayTyCd = "";
        }
        ;
        if (birthDayTyCd.equals("00600001")) {
            birthDayTyCd = "양력";
        } else {
            birthDayTyCd = "음력";
        }
        objMap.put("birthDayTyCd", birthDayTyCd);

        String email = cstmrVo.getEmail();
        if (null == email) {
            email = "";
        }
        ;
        objMap.put("email", email);

        String facebook = cstmrVo.getFacebook();
        if (null == facebook) {
            facebook = "";
        }
        objMap.put("facebook", facebook);

        String twitter = cstmrVo.getTwitter();
        if (null == twitter) {
            twitter = "";
        }
        objMap.put("twitter", twitter);

        String instagram = cstmrVo.getInstagram();
        if (null == instagram) {
            instagram = "";
        }
        objMap.put("instagram", instagram);

        /*
         * objMap.put("ListBought", listBought); objMap.put("ListCoupon",
         * listCoupon);
         */

        list.add(objMap);

        cstmrMap.put("prdctList", list);

        // response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(cstmrMap);

        writer.write(str);

        writer.flush();
        writer.close();
    }

    @Override
    public void updateInfo(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        SqlSession sqlSession = getSqlSession();

        String getCstmrPw = (String) sqlSession.selectOne(
                namespace + "checkId", cstmrVo);

        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (getCstmrPw == null) {
            out.write("there is no cstmrInfo");
        } else if (getCstmrPw != null && cstmrVo.getCheckPw() == null) {
            /* sqlSession.selectOne(namespace+"updateInfo", cstmrVo); */
            sqlSession.update(namespace + "updateInfo", cstmrVo);

            logger.error("char : " + cstmrVo);
            out.write("success");
        } else if (getCstmrPw != null && cstmrVo.getCheckPw() != null) {
            if (getCstmrPw.equals(cstmrVo.getCheckPw())) {
                // sqlSession.selectOne(namespace+"updatePw", cstmrVo);
                sqlSession.update(namespace + "updatePw", cstmrVo);
                out.write("success");
            } else {
                out.write("pwError");
            }
        } else {
            out.write("fail");
        }

    }

    @Override
    public void buyList(SaleVo saleVo, HttpServletResponse response)
            throws Exception {

        SqlSession sql = getSqlSession();

        List buyList = sql.selectList(namespace + "buyList", saleVo);
        List list = new ArrayList();
        Map objectMap = new HashMap();

        for (int i = 0; i < buyList.size(); i++) {
            Map objMap = new HashMap();
            SaleVo obj = (SaleVo) buyList.get(i);
            objMap.put("shopName", obj.getShopName());
            objMap.put("frame", obj.getFrame());
            objMap.put("lens", obj.getLens());
            objMap.put("datetime", obj.getDatetime());
            objMap.put("price", obj.getOgnPrice());
            objMap.put("result", obj.getResult());

            list.add(objMap);
        }

        objectMap.put("buyList", list);

        // response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(objectMap);

        writer.write(str);

        writer.flush();
        writer.close();
    }

    @Override
    public void myCoupon(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        SqlSession sql = getSqlSession();

        List buyList = sql.selectList(namespace + "myCoupon", cstmrVo);
        List list = new ArrayList();
        Map objectMap = new HashMap();

        for (int i = 0; i < buyList.size(); i++) {
            Map objMap = new HashMap();
            CstmrVo obj = (CstmrVo) buyList.get(i);
            objMap.put("couponName", obj.getCouponName());
            objMap.put("starDate", obj.getStartDate());
            objMap.put("endDate", obj.getEndDate());
            objMap.put("couponCd", obj.getCouponCd());
            objMap.put("dscntPrcnt", obj.getDscntPrcnt());
            objMap.put("dscntPrc", obj.getDscntPrc());

            list.add(objMap);
        }

        objectMap.put("buyList", list);

        // response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
        PrintWriter writer = response.getWriter();
        String str = "";

        ObjectMapper om = new ObjectMapper();
        str = om.writerWithDefaultPrettyPrinter().writeValueAsString(objectMap);

        writer.write(str);

        writer.flush();
        writer.close();
    }

    @Override
    public Map cstmrEmail() throws Exception {
        SqlSession sql = getSqlSession();
        Map resultMap = new HashMap();
        List cstmrList = sql.selectList(namespace + "cstmrList");
        resultMap.put("cstmrList", cstmrList);
        return resultMap;
    }

}
