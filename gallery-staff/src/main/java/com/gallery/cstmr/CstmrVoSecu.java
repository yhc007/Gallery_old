package com.gallery.cstmr;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("cstmrVoSecu")
public class CstmrVoSecu extends CstmrVo{

	String clearTel;
	String clearCell;
	public String getClearTel(){
		return telephone;
	}
	public String getClearCell(){
		return cellphone;
	}
	public String getTelephone(){
		if(telephone==null)return null;
		else{
			String tmp = telephone;
			char[] arrTmp = tmp.toCharArray();

			if(arrTmp.length > 4){
				for(int i = arrTmp.length-5; i  >= 0 ;i--)
				{
					if(i%2!=0){
						arrTmp[i]='*';
					}
				}
				tmp = new String(arrTmp);
			}

			return tmp.replaceAll("-", "");
		}
	}

	public String getCellphone(){
		if(cellphone==null)return null;
		else{
			String tmp = cellphone;
			char[] arrTmp = tmp.toCharArray();

			if(arrTmp.length > 4){
				for(int i = arrTmp.length-5; i  >= 0 ;i--)
				{
					if(i%2!=0){
						arrTmp[i]='*';
					}
				}
				tmp = new String(arrTmp);
			}

			return tmp.replaceAll("-", "");
		}
	}

}
