package com.gallery.sale;

import com.gallery.common.CommonCode;
import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.net.URLDecoder;

@Data
@Alias("saleVo")
public class SaleVo extends PagingVo {
    Integer saleId;
    String ShopOrderNo;
    String GoodsName;
    //String ShopID; //결제 회사 승인 번호
    String shopName;
    String shopId;
    String jsonTax;
    String email;

    String UserID;
    String cstmrId;
    String cstmrCd;
    String cstmrCds;
    String fmlyCd;
    String cstmrName;
    Integer digit4;
    String taxBigo;

    String sDate;
    String eDate;

    String UserName;
    String UserEmail;
    String UserPhone;
    String UserAddr;
    String AmountTotal;
    String RedirectUrl;
    String CallbackUrl;
    String IsEncryption;
    String datetime;
    String pointFmlyCd;

    String prdct;
    String prdctId;
    String prdctName;
    String prdctCnt;
    String frame;
    String lens;

    public String getFrame() {
        if (frame == null) {
            frame = "";
        }
        return frame;
    }

    public String getLens() {
        if (lens == null) {
            lens = "";
        }
        return lens;
    }

    public String getShopName() {
        if (shopName == null) {
            shopName = "온라인";
        }
        return shopName;
    }


    public String getResult() {
        if (result == null) {
            result = "결제완료";
        } else if (result.equals("0000")) {
            result = "결제완료";
        } else if (result.equals("-1000")) {
            result = "결제대기";
        } else if (result.equals("2005")) {
            result = "취소";
        } else if (result.equals("0001")) {
            result = "시간초과";
        }
        return result;
    }

    Integer couponId;
    Integer ognPrice;
    Integer eventId;
    Integer dscnt;
    Integer price;
    //Integer salePrice;
    Integer payCash;
    Integer payCard;
    Integer cardTy;
    String cardName;
    Integer jobId;

    public Integer getPayCash() {
        if (payCash == null) {
            return 0;
        }

        return payCash;
    }

    public Integer getPayCard() {
        if (payCard == null) {
            return 0;
        }

        return payCard;
    }


    String CJSResultCode;
    String CJSResultMessage;
    String CJSAmountTotal;
    String CJSShopOrderNo;

    String CJSPayMethod;
    String CJSPayID;
    String CJSTradeID;
    String CJSShopID;
    String CJSPaydate;
    String Crd_pgctrl_Cd_p;

    Integer shopNumber; //안경 판매 매장 번호

    String orderCode;

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
        CJSShopOrderNo = orderCode;
    }

    String answer;

    public void setAnswer(String answer) {
        this.answer = answer;
        CJSResultCode = answer;
    }

    String totalPrice;

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
        CJSAmountTotal = totalPrice;
    }

    public String getCJSResultCode() {
        String src = CJSResultCode;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSResultMessage() {
        String src = CJSResultMessage;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSAmountTotal() {
        String src = CJSAmountTotal;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSShopOrderNo() {
        String src = CJSShopOrderNo;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSPayMethod() {
        String src = CJSPayMethod;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSPayID() {
        String src = CJSPayID;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSTradeID() {
        String src = CJSTradeID;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSShopID() {
        String src = CJSShopID;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCJSPaydate() {
        String src = CJSPaydate;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getCrd_pgctrl_Cd_p() {
        String src = Crd_pgctrl_Cd_p;
        if (src == null) return null;
        String rtn = null;
        try {
            rtn = URLDecoder.decode(src, "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rtn;
    }

    public String getUserAddr() {

        String rtn = null;
        if (UserAddr == null) {
            rtn = "";
        } else {
            try {
                rtn = URLDecoder.decode(UserAddr, "utf-8");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rtn;
    }


    public String regtime;
    public String result;
    public String vpresult;

    public String getResultCd() {

        return (String) CommonCode.codeMap.get(result);
    }
}
