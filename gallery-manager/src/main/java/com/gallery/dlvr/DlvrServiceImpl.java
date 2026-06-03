package com.gallery.dlvr;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DlvrServiceImpl implements DlvrService {

    private final DlvrMapper dlvrMapper;

    @Deprecated
    @Override
    @Transactional
    public String addDlvr(DlvrVo dlvrVo) {
        dlvrMapper.addDlvr(dlvrVo);
        return "success";
    }

    @Deprecated
    @Override
    @Transactional
    public String removeDlvr(DlvrVo dlvrVo) {
        Integer row = dlvrMapper.removeDlvr(dlvrVo);
        return (row > 0) ? "success" : "fail";
    }

    @Deprecated
    @Override
    @Transactional
    public void modifyDlvr(DlvrVo dlvrVo) {
        dlvrMapper.modifyDlvr(dlvrVo);
    }

    @Override
    public Map listDlvrData(DlvrVo dlvrVo) {
        Map resultMap = new HashMap();
        List<DlvrVo> dlvrList = dlvrMapper.listDlvr(dlvrVo);
        resultMap.put("listdlvr", dlvrList);
        return resultMap;
    }

    @Deprecated
    @Override
    public DlvrVo selectDlvr(DlvrVo dlvrVo) {
        return dlvrMapper.getDlvr(dlvrVo);
    }
}
