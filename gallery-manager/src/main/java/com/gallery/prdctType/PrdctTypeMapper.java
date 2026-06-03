package com.gallery.prdctType;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Deprecated
@Mapper
public interface PrdctTypeMapper {
    List<PrdctTypeVo> getListPrdctType();
}
