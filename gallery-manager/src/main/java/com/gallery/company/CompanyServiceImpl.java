package com.gallery.company;

import com.gallery.common.PagingVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CompanyServiceImpl implements CompanyService {
    private final CompanyMapper companyMapper;

    @Override
    @Transactional
    public String addCompany(CompanyVo companyVo) {
        Integer cnt = companyMapper.countCompany(companyVo);
        if (cnt == 0) {
            String id = companyMapper.chkComId(companyVo);
            if (id != null) {
                return "idDuple/null";
            } else {
                companyMapper.addCompany(companyVo);
                return "addsuccess/" + companyVo.getINum();
            }
        } else {
            return "duple/null";
        }
    }

    @Override
    @Transactional
    public void modifyCompany(CompanyVo companyVo) {
        companyMapper.modifyCompany(companyVo);
        companyMapper.modifyComTy(companyVo);
    }

    @Override
    public Map pagedListCompanyData(CompanyVo company) {
        Map resultMap = new HashMap();

        Integer pageCount = companyMapper.pagedListCompanyCount(company);
        List<CompanyVo> companyList = companyMapper.pagedListCompany(company);

        PagingVo paging = new PagingVo();
        paging.setCurrentPage(company.getCurrentPage());
        paging.setPageSize(company.getPageSize());
        paging.setTotalSize(pageCount);

        resultMap.put("pv", paging);
        resultMap.put("listCompany", companyList);
        return resultMap;
    }

    @Override
    public Map selectCompanyData(CompanyVo company) {
        Map resultMap = new HashMap();
        List<CompanyVo> companyList = companyMapper.companyList(company);
        resultMap.put("listCompany", companyList);

        return resultMap;
    }

    @Override
    public CompanyVo selectCompany(CompanyVo company) {
        return companyMapper.getCompany(company);
    }

    @Override
    public String removeCompany(CompanyVo companyVo) {
        companyMapper.removeCompany(companyVo);
        return "success";
    }

    @Override
    public Map getListCom(CompanyVo companyVo) {
        List<CompanyVo> ListCom = companyMapper.getListCom(companyVo);
        Map resultMap = new HashMap();
        resultMap.put("listCom", ListCom);
        return resultMap;
    }

    @Override
    public String getComTy(CompanyVo companyVo) {
        List<CompanyVo> comTyList = companyMapper.getComTy(companyVo);
        String comTy = "";
        String comma = "";
        for (int i = 0; i < comTyList.size(); i++) {
            comTy += comma + comTyList.get(i).getCType();
            comma = ",";
        }
        return comTy;
    }

    @Override
    public void addCompanyTy(CompanyVo companyVo) {
        companyMapper.delComTy(companyVo);
        companyMapper.addCompanyTy(companyVo);
    }

}
