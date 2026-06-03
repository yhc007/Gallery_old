package com.gallerytalk.mobile.cstmr.service;

import com.gallerytalk.mobile.common.domain.CommonCode;
import com.gallerytalk.mobile.cstmr.domain.CstmrVo;
import com.gallerytalk.mobile.cstmr.domain.CstmrVoSecu;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
public class CstmrServiceImpl extends SqlSessionDaoSupport implements CstmrService {

    private final static String namespace = "com.gallerytalk.gallerystaff.cstmr.";

    @Override
    @Transactional
    public String addCstmr(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        sqlSession.insert(namespace + "addCstmr", cstmrVo);

        return "success";
    }


    @Override
    @Transactional
    public void modifyCstmr(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public String idDupleCheck(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        int count = (Integer) sqlSession.selectOne(namespace + "countCstmrById", cstmrVo);
        if (count > 0) {
            return "false";
        } else {
            return "true";
        }

    }

    @Override
    public void login(CstmrVo cstmrVo, HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        int count = (Integer) sqlSession.selectOne(namespace + "login", cstmrVo);
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        if (count > 0) {
            writer.write("SUCCESS");
        } else {
            writer.write("FAIL");
        }
        writer.flush();
        writer.close();
    }

    @Override
    public List<CstmrVo> listCstmrData(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();

        return sqlSession.selectList(namespace + "listCstmr", cstmrVo);
    }

    public List<CstmrVoSecu> listCstmrDataSecu(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();

        return sqlSession.selectList(namespace + "listCstmrSecu", cstmrVo);
    }

    @Override
    public CstmrVo getCstmrById(CstmrVo cstmrVo) throws Exception {
        SqlSession sqlSession = getSqlSession();
        cstmrVo = (CstmrVo) sqlSession.selectOne(namespace + "getCstmr", cstmrVo);

        return cstmrVo;
    }

    @Override
    @Transactional
    public String mergeCstmr(String info1, String info2) throws Exception {
        // TODO Auto-generated method stub
        SqlSession sqlSession = getSqlSession();
        CstmrVo cstmr1 = new CstmrVo();
        cstmr1.setCstmrId(Integer.valueOf(info1));
        CstmrVo cstmr2 = new CstmrVo();
        cstmr2.setCstmrId(Integer.valueOf(info2));
        cstmr1 = (CstmrVo) sqlSession.selectOne(namespace + "getCstmr", cstmr1);
        cstmr2 = (CstmrVo) sqlSession.selectOne(namespace + "getCstmr", cstmr2);


        DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
        Date nowDate = new Date();
        String tempDate = sdFormat.format(nowDate);

        cstmr1.setPcstmrId(cstmr2.getCstmrId());
        cstmr1.setMrgeTyCd(CommonCode.CODE_MERGE_TY_NEW);
        cstmr1.setMrgeTime(tempDate);

        cstmr2.setPcstmrId(cstmr1.getCstmrId());
        cstmr2.setMrgeTyCd(CommonCode.CODE_MERGE_TY_OLD);
        cstmr2.setMrgeTime(tempDate);
        sqlSession.update(namespace + "addCstmrMrgeHist", cstmr1);
        sqlSession.update(namespace + "addCstmrMrgeHist", cstmr2);

        System.out.println("cstmr1=" + cstmr1.toString());
        System.out.println("cstmr2=" + cstmr2.toString());
        cstmr2 = merge(cstmr1, cstmr2);
        sqlSession.update(namespace + "modifyCstmr", cstmr2);
        sqlSession.delete(namespace + "removeCstmr", cstmr1);
        return "success";
    }

    public CstmrVo merge(CstmrVo cstmr1, CstmrVo cstmr2) {


        if (cstmr1.getAddr() != null) {
            if (!cstmr1.getAddr().equals("")) {
                cstmr2.setAddr(cstmr1.getAddr());
            }
        }

        if (cstmr1.getBirthDay() != null) {
            if (!cstmr1.getBirthDay().equals("")) {
                cstmr2.setBirthDay(cstmr1.getBirthDay());
            }
        }

        if (cstmr1.getBirthDayTyCd() != null) {
            if (!cstmr1.getBirthDayTyCd().equals("")) {
                cstmr2.setBirthDayTyCd(cstmr1.getBirthDayTyCd());
            }
        }

        if (cstmr1.getCellphone() != null) {
            if (!cstmr1.getCellphone().equals("")) {
                cstmr2.setCellphone(cstmr1.getCellphone());
            }
        }


        if (cstmr1.getCstmrLoginId() != null) {
            if (!cstmr1.getCstmrLoginId().equals("")) {
                cstmr2.setCstmrLoginId(cstmr1.getCstmrLoginId());
            }
        }

        if (cstmr1.getCstmrLoginPw() != null) {
            if (!cstmr1.getCstmrLoginPw().equals("")) {
                cstmr2.setCstmrLoginPw(cstmr1.getCstmrLoginPw());
            }
        }

        if (cstmr1.getCstmrName() != null) {
            if (!cstmr1.getCstmrName().equals("")) {
                cstmr2.setCstmrName(cstmr1.getCstmrName());
            }
        }

        if (cstmr1.getEmail() != null) {
            if (!cstmr1.getEmail().equals("")) {
                cstmr2.setEmail(cstmr1.getEmail());
            }
        }

        if (cstmr1.getSexCd() != null) {
            if (!cstmr1.getSexCd().equals("")) {
                cstmr2.setSexCd(cstmr1.getSexCd());
            }
        }

        if (cstmr1.getTelephone() != null) {
            if (!cstmr1.getTelephone().replaceAll("-", "").equals("")) {
                cstmr2.setTelephone(cstmr1.getTelephone());
            }
        }
        if (cstmr1.getZipCd() != null) {
            if (!cstmr1.getZipCd().equals("")) {
                cstmr2.setZipCd(cstmr1.getZipCd());
            }
        }
        return cstmr2;
    }

    @Override
    public String getCstmrMemo(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        String memo = (String) sql.selectOne(namespace + "getCstmrMemo", cstmrVo);
        return memo;
    }

    @Override
    @Transactional
    public void CstmrMemoUpdate(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        sql.update(namespace + "cstmrMemoUpdate", cstmrVo);
    }

    @Override
    @Transactional
    public void CstmrBigoUpdate(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        sql.update(namespace + "cstmrBigoUpdate", cstmrVo);
    }


    @Override
    @Transactional
    public void modifyCstmrFmlyCd(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        sql.update(namespace + "modifyCstmrFmlyCd", cstmrVo);
    }


    @Override
    public String modifyCstmrInfo(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        String result = "";
        try {
            sql.update(namespace + "modifyCstmrInfo", cstmrVo);
            result = "successModify";
        } catch (Exception e) {
            e.printStackTrace();
            result = "fail";
        }
        return result;
    }


    @Override
    public CstmrVo getCstmrInfo(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        cstmrVo = (CstmrVo) sql.selectOne(namespace + "getCstmrInfo", cstmrVo);
        return cstmrVo;
    }


    @Override
    public CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo) throws Exception {
        SqlSession sql = getSqlSession();
        cstmrVo = (CstmrVo) sql.selectOne(namespace + "getCstmrVIsitInfo", cstmrVo);
        return cstmrVo;
    }

    @Override
    public Map getListFmly(CstmrVo cstmrVo) throws Exception {
        // TODO Auto-generated method stub
        logger.info("run getListFmly");
        SqlSession sqlSession = getSqlSession();
        List<CstmrVo> listFmly = sqlSession.selectList(namespace + "listFmly", cstmrVo);
        Map resultMap = new HashMap();

        resultMap.put("listFmly", listFmly);

        return resultMap;
    }

}
