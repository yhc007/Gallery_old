package com.gallery.prdctType;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Deprecated
@Data
@Alias("prdctTypeVo")
public class PrdctTypeVo {
    Integer typeId;
    String typeName;
    Integer prdctId;
    String prdctName;
}
