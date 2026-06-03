package com.gallery.prdctType;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Deprecated
@Service
@RequiredArgsConstructor
public class PrdctTypeServiceImpl implements PrdctTypeService {
    private final PrdctTypeMapper prdctTypeMapper;

    @Override
    public List<PrdctTypeVo> mListPrdctTypeData() throws Exception {
        return prdctTypeMapper.getListPrdctType();
    }
}
