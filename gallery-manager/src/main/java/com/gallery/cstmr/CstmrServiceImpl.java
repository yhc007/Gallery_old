package com.gallery.cstmr;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gallery.mail.MailMapper;
import com.gallery.mail.MailVo;
import com.gallery.sale.SaleVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.*;

@Service
@RequiredArgsConstructor
public class CstmrServiceImpl implements CstmrService {
    private final CstmrMapper cstmrMapper;
    private final MailMapper mailMapper;
//    private final MailService mailService;

    @Deprecated
    @Override
    public void addCstmr(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
        cstmrMapper.addCstmr(cstmrVo);

        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("SUCCESS");
        writer.flush();
        writer.close();
    }

    @Deprecated
    @Override
    public void idDupleCheck(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
        Integer count = cstmrMapper.countCstmrById(cstmrVo);
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
    public void login(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
        Integer count = cstmrMapper.login(cstmrVo);
        CstmrVo getCstmrVo = selectCstmrForLogin(cstmrVo);

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
        String str = om.writerWithDefaultPrettyPrinter().writeValueAsString(
            resultMap);

        writer.write(str);
        writer.flush();
        writer.close();
    }

    @Override
    public CstmrVo selectCstmrForLogin(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmrForLogin(cstmrVo);
    }

    @Deprecated
    @Override
    public void findCstmrId(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrLoginId(cstmrVo);

        List list = new ArrayList();
        for (int i = 0; i < cstmrList.size(); i++) {
            Map map = new HashMap();
            map.put("name", (cstmrList.get(i)).getCstmrName());
            map.put("phone", (cstmrList.get(i)).getCellphone());
            map.put("id", (cstmrList.get(i)).getCstmrLoginId());
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

    @Deprecated
    public MailVo insertKey(MailVo mailVo) {
        String key = getRandomPassword(50);
        Integer count = mailMapper.getPwKeyCnt(key); //mail space
        if (count > 0) {
            return insertKey(mailVo);
        }
        mailVo.setPwkey(key);
        mailMapper.destroyKey(mailVo);
        mailMapper.addKey(mailVo);

        return mailVo;
    }

//    @Deprecated
//    @Override
//    public void findCstmrPw(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
//        PrintWriter writer = response.getWriter();
//
//        CstmrVo getCstmr = cstmrMapper.getCstmrLoginPw(cstmrVo);
//
//        if (getCstmr == null) {
//            writer.write("nomatch");
//            writer.flush();
//            writer.close();
//            return;
//        }
//        MailVo mailVo = new MailVo();
//        mailVo.setTitle("갤러리 비밀번호 변경 메일");
//        mailVo.setContent("안녕하세요 " + getCstmr.getCstmrName()
//            + "고객님\n요청하신 비밀번호 변경을 위해 아래 링크를 클릭하세요\n" + CommonURI.DOMAIN
//            + CommonURI.CHANGE_PW + "?pwkey=" + CommonCode.PW_KEY_TAG);
//        mailVo.setTo(getCstmr.getEmail());
//        mailVo.setCstmrId(getCstmr.getCstmrId());
//        mailService.sendMail(insertKey(mailVo));
//
//        response.setContentType("text/html;charset=utf-8"); // 한글깨짐방지
//
//        writer.write("success");
//        writer.flush();
//        writer.close();
//    }

    public String updatePw(CstmrVo cstmrVo) {
        cstmrMapper.modifyCsmtrPw(cstmrVo);
        return "success";
    }

    @Deprecated
    public CstmrVo selectCstmrKey(MailVo mailVo) {
        return mailMapper.getCstmrForKey(mailVo);
    }

    @Override
    @Transactional
    public void updateInfo(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
        String getCstmrPw = cstmrMapper.checkId(cstmrVo);

        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (getCstmrPw == null) {
            out.write("there is no cstmrInfo");
        } else if (getCstmrPw != null && cstmrVo.getCheckPw() == null) {
            cstmrMapper.updateInfo(cstmrVo);
            out.write("success");
        } else if (getCstmrPw != null && cstmrVo.getCheckPw() != null) {
            if (getCstmrPw.equals(cstmrVo.getCheckPw())) {
                cstmrMapper.updatePw(cstmrVo);
                out.write("success");
            } else {
                out.write("pwError");
            }
        } else {
            out.write("fail");
        }
    }

    @Override
    @Transactional
    public void updateEmail4Tax(CstmrVo cstmrVo) {
        cstmrMapper.updateInfo(cstmrVo);
    }

    @Override
    public Map myCoupon(CstmrVo cstmrVo) {
        List<CstmrVo> couponList = cstmrMapper.myCoupon(cstmrVo);
        Map resultMap = new HashMap();
        resultMap.put("couponList", couponList);

        return resultMap;
    }

    @Override
    public Map buyList(SaleVo saleVo) {
        Map resultMap = new HashMap();
        SaleVo buyList = cstmrMapper.buyList(saleVo);
        resultMap.put("buyList", buyList);
        return resultMap;
    }

    @Override
    public CstmrVo mgetCstmrInfo(CstmrVo cstmrVo) {
        cstmrVo = cstmrMapper.mgetCstmr(cstmrVo);

        String eyeCheckDate = cstmrVo.getDatetime();

        if (cstmrVo.getDatetime() == null) {
            cstmrVo.setDatetime("");
        } else {
            int cyear = Integer.parseInt(eyeCheckDate.substring(0, 4));
            int cmonth = Integer.parseInt(eyeCheckDate.substring(4, 6));

            Calendar calendar = Calendar.getInstance();
            int nyear = calendar.get(Calendar.YEAR);
            int nmonth = calendar.get(Calendar.MONTH) + 1;

            int year = (nyear - cyear) * 12;
            int month = nmonth - cmonth;

            cstmrVo.setRecheck(year + month + "");
        }

        if (cstmrVo.getPoint() == null) {
            cstmrVo.setPoint(0);
        }

        String birthDayTyCd = cstmrVo.getBirthDayTyCd();
        if (null == birthDayTyCd) {
            birthDayTyCd = "";
        }
        if (birthDayTyCd.equals("00600001")) {
            cstmrVo.setBirthDayTyCd("양력");
        } else {
            cstmrVo.setBirthDayTyCd("음력");
        }

        if (null == cstmrVo.getFaceBook()) {
            cstmrVo.setFacebook("");
        }
        if (null == cstmrVo.getTwitter()) {
            cstmrVo.setTwitter("");
        }

        if (null == cstmrVo.getInstagram()) {
            cstmrVo.setInstagram("");
        }

        return cstmrVo;
    }

    @Override
    public Map cstmrEyes(CstmrVo cstmrVo) {
        Map resultMap = new HashMap();
        List<CstmrVo> checkList = cstmrMapper.eyesCheckResult(cstmrVo);
        resultMap.put("eyeCheck", checkList);
        return resultMap;
    }

    @Override
    public Map getCstmrListForChk(CstmrVo cstmrVo) {
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrListForChk(cstmrVo);
        Map resultMap = new HashMap();
        resultMap.put("cstmrList", cstmrList);
        return resultMap;
    }

    @Override
    public Map getCstmrListForChk2(CstmrVo cstmrVo) {
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrListForChk2(cstmrVo);
        Map resultMap = new HashMap();
        resultMap.put("cstmrList2", cstmrList);
        return resultMap;
    }

    @Override
    public Map getCstmrForMerge(CstmrVo cstmrVo) {
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrId4Digit(cstmrVo);
        Map resultMap = new HashMap();
        resultMap.put("cstmrList", cstmrList);
        return resultMap;
    }

    @Override
    @Transactional
    public String mergeCstmr(CstmrVo cstmrVo) {
        try {
            cstmrVo.setSCID(cstmrMapper.getSCID(cstmrVo));
            cstmrVo.setDSID(cstmrMapper.getDSID(cstmrVo));
            cstmrMapper.setSaleOff(cstmrVo);
            cstmrMapper.visit_history1(cstmrVo);
            cstmrMapper.visit_history2(cstmrVo);
            cstmrMapper.point_hist1(cstmrVo);
            cstmrMapper.point_hist2(cstmrVo);
            cstmrVo.setPoint(cstmrMapper.getPoint(cstmrVo));
            cstmrMapper.cstmrSet1(cstmrVo);
            cstmrMapper.cstmrSet2(cstmrVo);
            cstmrMapper.delCstmr(cstmrVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "fail";
    }

    @Override
    @Transactional
    public String removeCstmr(CstmrVo cstmrVo) {
        try {
            cstmrMapper.delCstmr(cstmrVo);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public List<CstmrVo> getCstmrCd(CstmrVo cstmrVo) {
        try {
            Integer chkResult = cstmrMapper.cntCstmr(cstmrVo);

            if (chkResult.intValue() < 1) {
                return null;
            }
            return cstmrMapper.getListCstmr4Fmly(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<CstmrVo> getListCstmr4Tax(CstmrVo cstmrVo) {
        try {
            return cstmrMapper.getListCstmr4Tax(cstmrVo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Map getCntVisitor(CstmrVo cstmrVo) {
        Map map = new HashMap();
        List<CstmrVo> listCntVisitor = cstmrMapper.listCntVisitor(cstmrVo);
        map.put("listCntVisitor", listCntVisitor);
        return map;
    }

    @Override
    public Map getCstmrList(CstmrVo cstmrVo) {
        Map map = new HashMap();
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrList(cstmrVo);
        map.put("cstmrList", cstmrList);
        return map;
    }

    @Override
    public String getCntVisitorForCSV(CstmrVo cstmrVo) throws Exception {
        Map map = new HashMap();
        ObjectMapper om = new ObjectMapper();
        List<CstmrVo> cstmrList = cstmrMapper.listCntVisitor(cstmrVo);
        map.put("cstmrList", cstmrList);
        return om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
    }

    @Override
    public String getCstmrListForCSV(CstmrVo cstmrVo) throws Exception {
        Map map = new HashMap();
        ObjectMapper om = new ObjectMapper();
        List<CstmrVo> cstmrList = cstmrMapper.getCstmrList(cstmrVo);
        for (int i = 0; i < cstmrList.size(); i++) {
            String tmpName = cstmrList.get(i).getCstmrName();
            String cstmrName = URLEncoder.encode((tmpName == null) ? "" : tmpName, "utf-8");
            cstmrList.get(i).setCstmrName(cstmrName);
            String tmpAddr = cstmrList.get(i).getAddr();
            String addr = URLEncoder.encode((tmpAddr == null) ? "" : tmpAddr, "utf-8");
            cstmrList.get(i).setAddr(addr);
        }
        map.put("cstmrList", cstmrList);
        return om.writerWithDefaultPrettyPrinter().writeValueAsString(map);
    }
}
