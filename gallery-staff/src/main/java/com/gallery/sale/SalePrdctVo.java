package com.gallery.sale;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

@Data
@Alias("salePrdctVo")
public class SalePrdctVo{
	Integer saleId;
	Integer prdctId;
	Integer itemTy;
	String 	prdctName;
	String  colorName;
	Integer prdctCnt;
	Integer eventId;
	Integer dscnt;
	String curve;
	Integer pointRule;
	Integer prc;
	//String prc;
	Integer partnerDscnt;
	Integer asmbly;
	Integer dlvry;
	Integer Inform;

	Integer dscntPrcnt;
	Integer earnPrcnt;
	Integer usingPoint;

	Integer cnt;
	Integer shopId;
	String invnTyCd;
	Integer CstmrId;

	Integer staffId;

	String imgPath;
	String brandName;
	String endtime;
	String datetime;
	String dateTile;

	public String getDateTile()
	{
		if( null == dateTile || dateTile.isEmpty())
		{
			TimeZone tz;
		    Date today = new Date();
		    //DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss (z Z)");
		    DateFormat df = new SimpleDateFormat("yyyy.MM.dd");
		    tz = TimeZone.getTimeZone("Asia/Seoul");
		    df.setTimeZone(tz);
		    dateTile=df.format(today);
		}
		return dateTile;
	}
//	ArrayList<Integer> listDscntPrdctId = new ArrayList<Integer>();
//	List<Integer> listDscntPrdctId = new ArrayList<Integer>();
//	ArrayList<Integer> listPointRulePrdctId = new ArrayList<Integer>();

//	public List<Integer> getListDscntPrdctId()
//	{
//		return listDscntPrdctId;
//	}
//	public void setListDscntPrdctId(List<Integer> listDscntPrdctId)
//	{
//		this.listDscntPrdctId = listDscntPrdctId;;
//	}

//	List<String> orgMap = new ArrayList();
	public SalePrdctVo(){

	}

	public SalePrdctVo(int saleId,int prdctId,int prdctCnt){
		this.saleId=saleId;
		this.prdctId=prdctId;
		this.prdctCnt=prdctCnt;
	}
	public Integer getDscnt(){
		if(dscnt==null){
			return 0;
		}
		return dscnt;
	}
	String salePrdctId;
	String salePrdctDscnt;
	String salePrdctEarn;

	public String getPrdctName(){
		String tmp;
		if(prdctName==null)return "";
		else{
			tmp = prdctName.replace("'", "`");
			return tmp;
		}
	}

	String damdangName;
	String gframe1;
	String gframe2;
	String gframe3;
	String glens1;
	String glens2;
	String glens3;
	String clensR;
	String clensL;
	String shopName;
	Integer ognPrice;

}
