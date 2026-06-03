package com.gallery.sale;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("salesVo")
public class SalesVo {
    String shopId;
    String cancel;
    String rownum;
    String shopName;
    String staffName;
    Integer total;
    Integer payCash;
    Integer payCard;
    String cstmrName;
    String cstmrCd;
    Integer framePrc;
    Integer lensPrc;
    String dateTime;
    Integer payPoint;
    String cardName;
    Integer clensPrc;
    Integer accPrc;
    Integer sunPrc;
    Integer disPrc;

    String cardCom;
    String payStatus;
    Integer etcDscnt;
    Integer dscntPrice;
    String phone;

    public SalesVo() {

    }

    public Integer getTotal() {
        if (total == null) {
            total = 0;
        }
        return total;
    }

    public Integer getPayCash() {
        if (payCash == null) {
            payCash = 0;
        }
        return payCash;
    }

    public Integer getPayCard() {
        if (payCard == null) {
            payCard = 0;
        }
        return payCard;
    }

    public Integer getFramePrc() {
        if (framePrc == null) {
            framePrc = 0;

        }
        return framePrc;
    }

    public Integer getLensPrc() {
        if (lensPrc == null) {
            lensPrc = 0;
        }
        return lensPrc;
    }

    String cnt;
}
