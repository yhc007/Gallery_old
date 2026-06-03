package com.gallery.prdct;

import com.gallery.common.CommonCode;
import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("prdctVo")
public class PrdctVo extends PagingVo {
    Integer comOrder;
    String ar;
    String uv;
    String optionId;
    String isr;
    String isl;
    String pair;
    String optionName;
    Integer itemTy;
    String coating;
    Integer option;
    String optionPrc;
    String isRx;
    String frameType;
    String frameShape;
    String preA;
    String preB;
    String preDBL;
    String preOHR;
    String preOHL;
    String prePDR;
    String prePDL;
    String preET;
    String colorCd;
    String colorCom;
    String colorOpacity;
    String sphR;
    String sphL;
    String cylR;
    String cylL;
    String addr;
    String addL;
    String axisR;
    String axisL;
    String diaR;
    String diaL;
    String prsRIO;
    String prsLIO;
    String prsRUD;
    String prsLUD;
    String prsValRIO;
    String prsValLIO;
    String prsValRUD;
    String prsValLUD;
    String earR;
    String earL;
    String centerR;
    String centerL;
    String noseR;
    String noseL;
    String A;
    String DBL;
    String ED;
    String B;
    String PDR;
    String PDL;
    String total;
    String korea;
    String forign;
    String detail;
    /*public String getDetail(){
        if(detail==null)return null;
        try {
            detail = URLDecoder.decode(detail,"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return detail;
    }

    public String setDetail(){
        if(detail==null)return null;
        try {
            detail = URLEncoder.encode(detail,"UTF-8");
        } catch (UnsupportedEncodingException e) {

            e.printStackTrace();
        }
        return detail;
    }*/
    String reason;
    String curve;
    String returnCnt;
    String returnReason;
    String totalRtnCnt;
    String returnCd;
    String remaind;
    String newLens;
    String adminAllow;
    String comAllow;
    String dueMonth;
    String BC;
    String deliverTime;
    String devide;
    String type1;
    String type2;
    String type3;
    String diam;
    String test;
    String CYL;
    String SPH;
    String x1;
    String x2;
    String y1;
    String y2;
    String data;

    String mac;
    String sn;
    String spec;
    String receive;
    String name;
    String undefined_;
    String chkTy;
    String allPrdct;
    String no;
    String type;

    String shopTy;
    String G;
    String O;
    String S;
    String W;
    String Z;
    Integer Sfull;

    Integer Shalf;
    Integer SUD;
    String cstmrLoginId;
    String tyId;
    String tyId1;
    String tyId2;
    String pNum1;
    String pNum2;
    String cMemo;
    String mtrl;
    String memo;
    String telephone;
    String sdate;
    String edate;
    String rate;
    String ty1;
    String prdctType;
    String ty2;
    String unit;
    String comName;
    String colorName1;
    String colorName2;
    String comTy;
    Integer prdctId;
    String prdctName;
    String prdctTyCd;
    Integer brandId;
    String state;
    String mnfCountry;
    String cntryId;
    String id;
    String cntryName;
    String salePrc;
    Integer oldPrdctId;
    String whDate;
    String prdctStatTyCd;
    String prdctVisibleCd;
    String shopId;
    String prdctTyName;
    String prdctShapeName;
    String shopName;
    String color;
    Integer puchasPrc;
    Integer sum;
    Integer trdePrc;
    String iNum;
    String com;
    String eName;
    String cName;
    Integer eventId;
    String tyName;
    String totalPrc;
    String totalCnt;
    String eventName;
    Integer datetime;
    String puchasPrcF;
    String puchasPrcT;
    Integer dscnt;
    String sort;
    String prdctTy;
    String prdctShape;
    String colorId;
    String colorId2;
    String colorName;
    String mtrlId;
    String mtrlName;

    public Integer getDscnt() {
        if (dscnt == null) {
            return 0;
        }
        return dscnt;
    }

    String regTime;
    String updTime;

    String urlStr;
    String imgPath;
    String invnId;
    //String stillPath;
    String videoCd;
    Integer multiImgCnt;
    String brandName;

    Integer invnHistId;
    Integer remainCnt;

    public Integer getRemainCnt() {
        if (remainCnt == null) return 0;
        return remainCnt;
    }

    String invnTyCd;
    /*public String getInvnTyCd(){
        if(invnTyCd.equals("00900001")){
            invnTyCd = "입고";
        }else{
            invnTyCd = "출고";
        }
        return invnTyCd;

    }*/
    String bigo;
    Integer cnt;

    public String getInvnTyCdMsg() {
        return (String) CommonCode.codeMap.get(invnTyCd);
    }

    Integer cstmrId;

    public String getPrdctStatTyCdMsg() {
        return (String) CommonCode.codeMap.get(prdctStatTyCd);
    }

    public String getPrdctTyCdMsg() {
        return (String) CommonCode.codeMap.get(prdctTyCd);
    }

    Integer jjim;
    Integer typeId;
}
