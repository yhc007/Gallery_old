package com.gallerytalk.mobile.sale.domain;

import java.net.URLDecoder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SaleVo implements Comparable{
	Integer saleId;
	Integer cstmrId;
	Integer histId;
	String ShopOrderNo;
	String cnt;
	String prc;
	String GoodsName;
	//String ShopID; //결제 회사 승인 번호
	Integer shopId;
	String shopName;
	String UserID;
	String UserName;
	String UserEmail;
	String UserPhone;
	String UserAddr;
	String AmountTotal;
	String RedirectUrl;
	String CallbackUrl;
	String IsEncryption;

	String prdct;
	String prdctId;
	String prdctName;
	Integer prdctPrc;
	String prdctCnt;
	
	Integer couponId;
	Integer ognPrice;
	Integer eventId;
	Integer partnerDscnt;
	Integer partnerId;
	Integer dscntPrice;
	Integer etcDscnt;
	String etcDscntMemo;
	
	Integer dscntPrcnt;
	Integer earnPrcnt;
	
	Integer price;
	//Integer salePrice;
	
	Integer payCash;
	Integer payCard;
	Integer cardTy;
	String cardDate;
	String cardName;
	Integer payPoint;
	Integer oldDigit;
	Integer cancel;
	String cancelDate;
	
	
	public Integer getPayCash(){
		if(payCash==null){
			return 0;
		}
		return payCash;
	}
	public String getEtcDscntMemo(){
		if(etcDscntMemo==null){
			return null;
		}
		if(etcDscntMemo.equals("")){
			return null;
		}
		return etcDscntMemo;
	}
	String memo;
	public String getMemo(){
		if(memo==null){
			return "";
		}
		if(memo.equals("")){
			return null;
		}
		return memo;
	}
	
	public Integer getEtcDscnt(){
		if(etcDscnt==null){
			return 0;
		}
		return etcDscnt;
	}
	
	public Integer getPayPoint(){
		if(payPoint==null){
			return 0;
		}
		
		return payPoint;
	}
	
	public Integer getPayCard(){
		if(payCard==null){
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
	public void setOrderCode(String orderCode){
		this.orderCode=orderCode;
		CJSShopOrderNo=orderCode;
	}
	String answer;
	public void setAnswer(String answer){
		this.answer=answer;
		CJSResultCode=answer;
	}
	String totalPrice;
	public void setTotalPrice(String totalPrice){
		this.totalPrice=totalPrice;
		CJSAmountTotal=totalPrice;
	}
	
	public String getCJSResultCode() {
		String src=CJSResultCode;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSResultMessage() {
		String src=CJSResultMessage;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSAmountTotal() {
		String src=CJSAmountTotal;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSShopOrderNo() {
		String src=CJSShopOrderNo;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSPayMethod() {
		String src=CJSPayMethod;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSPayID() {
		String src=CJSPayID;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSTradeID() {
		String src=CJSTradeID;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSShopID() {
		String src=CJSShopID;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCJSPaydate() {
		String src=CJSPaydate;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	public String getCrd_pgctrl_Cd_p() {
		String src=Crd_pgctrl_Cd_p;
		if(src==null)return null;
		String rtn=null;
		try{
			rtn=URLDecoder.decode(src, "utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	
	public String getUserAddr(){
		String rtn=null;
		try{
			if(null==UserAddr)
			{UserAddr="";}
			rtn= URLDecoder.decode(UserAddr,"utf-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	
	public String datetime;
	public String regtime;
	public String result;
	
	String gframe1;
	String gframe2;
	String gframe3;
	String glens1;
	String glens2;
	String glens3;
	String clensR;
	String clensL;
	
//Comparable 의 compareTo 메서드 구현함  
    public int compareTo(Object o){
        return datetime.compareTo(((SaleVo)o).datetime);
    }
	
}
