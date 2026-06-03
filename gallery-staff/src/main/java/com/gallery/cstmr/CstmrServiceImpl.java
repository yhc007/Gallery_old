package com.gallery.cstmr;

import com.gallery.common.CommonCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Repository
@RequiredArgsConstructor
public class CstmrServiceImpl implements CstmrService {

    private final CstmrMapper cstmrMapper;

    @Override
    @Transactional
    public String addCstmr(CstmrVo cstmrVo) {
        cstmrMapper.addCstmr(cstmrVo);
        return "success";
    }

//    @Deprecated
//	@Override
//	@Transactional
//	public void modifyCstmr(CstmrVo cstmrVo) throws Exception {
//
//
//	}

    @Override
    public String idDupleCheck(CstmrVo cstmrVo) {
        int count = cstmrMapper.countCstmrById(cstmrVo);
        return (count > 0) ? "false" : "true";
    }

//    @Deprecated
//    @Override
//    public void login(CstmrVo cstmrVo, HttpServletResponse response) throws Exception {
//        int count = cstmrMapper.login(cstmrVo);
//        response.setCharacterEncoding("UTF-8");
//        PrintWriter writer = response.getWriter();
//
//        if (count > 0) {
//            writer.write("SUCCESS");
//        } else {
//            writer.write("FAIL");
//        }
//        writer.flush();
//        writer.close();
//    }

    @Override
    public List<CstmrVo> listCstmrData(CstmrVo cstmrVo) {
        return cstmrMapper.listCstmr(cstmrVo);
    }

    @Override
    public List<CstmrVo> listCstmr4Fmly(CstmrVo cstmrVo) {
        return cstmrMapper.getListCstmr4Fmly(cstmrVo);
    }

    public List<CstmrVoSecu> listCstmrDataSecu(CstmrVo cstmrVo) {
        return cstmrMapper.listCstmrSecu(cstmrVo);
    }

    @Override
    public CstmrVo getCstmrById(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmr(cstmrVo);
    }

//    @Deprecated
//	@Override
//	public CstmrVo getCstmrByCd(CstmrVo cstmrVo) {
//		SqlSession sqlSession=getSqlSession();
//		cstmrVo=(CstmrVo)sqlSession.selectOne(namespace+"getCstmrByCd",cstmrVo);
//
//		return cstmrVo;
//	}


    @Override
    @Transactional
    public String mergeCstmr(String info1, String info2) {
        CstmrVo cstmr1 = new CstmrVo();
        cstmr1.setCstmrId(Integer.valueOf(info1));
        CstmrVo cstmr2 = new CstmrVo();
        cstmr2.setCstmrId(Integer.valueOf(info2));
        cstmr1 = cstmrMapper.getCstmr(cstmr1);
        cstmr2 = cstmrMapper.getCstmr(cstmr2);

        DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
        Date nowDate = new Date();
        String tempDate = sdFormat.format(nowDate);

        cstmr1.setPcstmrId(cstmr2.getCstmrId());
        cstmr1.setMrgeTyCd(CommonCode.CODE_MERGE_TY_NEW);
        cstmr1.setMrgeTime(tempDate);

        cstmr2.setPcstmrId(cstmr1.getCstmrId());
        cstmr2.setMrgeTyCd(CommonCode.CODE_MERGE_TY_OLD);
        cstmr2.setMrgeTime(tempDate);
        cstmrMapper.addCstmrMrgeHist(cstmr1);
        cstmrMapper.addCstmrMrgeHist(cstmr2);

        System.out.println("cstmr1=" + cstmr1.toString());
        System.out.println("cstmr2=" + cstmr2.toString());
        cstmr2 = merge(cstmr1, cstmr2);
        cstmrMapper.modifyCstmr(cstmr2);
        cstmrMapper.removeCstmr(cstmr1);
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
    public String getCstmrMemo(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmrMemo(cstmrVo);
    }

    @Override
    @Transactional
    public void CstmrMemoUpdate(CstmrVo cstmrVo) {
        cstmrMapper.cstmrMemoUpdate(cstmrVo);
    }

//    @Deprecated
//	@Override
//	@Transactional
//	public void CstmrBigoUpdate(CstmrVo cstmrVo)throws Exception {
//
//		sql.update(namespace + "cstmrBigoUpdate",cstmrVo);
//	}

    @Override
    public String getCstmrBigo(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmrBigo(cstmrVo);
    }

    @Override
    @Transactional
    public void modifyCstmrFmlyCd(CstmrVo cstmrVo) {
        cstmrMapper.modifyCstmrFmlyCd(cstmrVo);
    }

    @Override
    public String modifyCstmrInfo(CstmrVo cstmrVo) {
        try {
            cstmrMapper.modifyCstmrInfo(cstmrVo);
            return "successModify";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @Override
    public CstmrVo getCstmrInfo(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmrInfo(cstmrVo);
    }

    @Override
    public CstmrVo getCstmrVIsitInfo(CstmrVo cstmrVo) {
        return cstmrMapper.getCstmrVIsitInfo(cstmrVo);
    }

    @Override
    public Map getListFmly(CstmrVo cstmrVo) {
        List<CstmrVo> listFmly = cstmrMapper.listFmly(cstmrVo);
        Map resultMap = new HashMap();
        resultMap.put("listFmly", listFmly);
        return resultMap;
    }

    @Override
    @Transactional
    public void editCstmrInfo(CstmrVo cstmrVo) {
        cstmrMapper.editCstmrInfo(cstmrVo);
    }

    @Override
    @Transactional
    public void editCstmrLastShop(CstmrVo cstmrVo) {
        cstmrMapper.editCstmrLastShop(cstmrVo);
    }

    @Override
    public String joinChk(CstmrVo cstmrVo) {
        return cstmrMapper.joinChk(cstmrVo);
    }

    @Override
    public Map getFmlyList(CstmrVo cstmrVo) {
        Map resultMap = new HashMap();
        List<CstmrVo> fmlyList = cstmrMapper.getFmlyList(cstmrVo);
        resultMap.put("fmlyList", fmlyList);
        return resultMap;
    }

    @Override
    public Integer countNewCstmr(CstmrVo cstmrVo) {
        return cstmrMapper.countNewCstmr(cstmrVo);
    }

    @Override
    @Transactional
    public String addNewCstmr(CstmrVo cstmrVo) {
        cstmrMapper.addNewCstmr(cstmrVo);
        return "success";
    }

    @Override
    public CstmrVo getNewCstmr(CstmrVo cstmrVo) {
        return cstmrMapper.getNewCstmr(cstmrVo);
    }

    @Override
    @Transactional
    public String modifyNewCstmr(CstmrVo cstmrVo) {
        cstmrMapper.modifyNewCstmr(cstmrVo);
        return "success";
    }

}
