package com.gallery.sale;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("salePrdctVo")
public class SalePrdctVo {
    Integer saleId;
    Integer prdctId;
    Integer prdctCnt;
    Integer eventId;
    Integer dscnt;
    Integer prc;

    public SalePrdctVo() {

    }

    public SalePrdctVo(int saleId, int prdctId, int prdctCnt) {
        this.saleId = saleId;
        this.prdctId = prdctId;
        this.prdctCnt = prdctCnt;
    }

    public Integer getDscnt() {
        if (dscnt == null) {
            return 0;
        }
        return dscnt;
    }
}
