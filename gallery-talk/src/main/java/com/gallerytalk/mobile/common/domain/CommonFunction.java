package com.gallerytalk.mobile.common.domain;

import org.springframework.ui.ModelMap;

public class CommonFunction {
	
	public static String onlyNum(String str) {
		if ( str == null ) return "";

		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < str.length(); i++){
			if( Character.isDigit( str.charAt(i) ) ) {
				sb.append( str.charAt(i) );
			}
		}
		return sb.toString();
	}
	public static Boolean isNew(String str) {
		if ( str == null ) return false;

		StringBuffer sb = new StringBuffer();

		if( !Character.isDigit( str.charAt(0)) ) {
			return true;
		}else{
			return false;
		}
		

	}
	
	public static ModelMap setButton(String result, ModelMap model, int type)
	{
		
		String selectButton = "0_";
		String checkButton = "0_";
		String assemblyButton = "0_";
		String paymentButton = "0_";
		String deliveryButton = "0_";
		String changed="1_";
		switch (type)
		{
			case CommonCode.ARRAY_SELECT:
				selectButton = changed;
				break;
			case CommonCode.ARRAY_CHECK:
				checkButton = changed;
				break;
			case CommonCode.ARRAY_ASSEMBLY:
				assemblyButton = changed;
				break;
			case CommonCode.ARRAY_PAYMENT:
				paymentButton = changed;
				break;
			case CommonCode.ARRAY_DELIVERY:
				deliveryButton = changed;
				break;
		}
		
		char saleResult[]=result.toCharArray();
		selectButton+=((saleResult[CommonCode.ARRAY_SELECT]=='1')?'F':'U');
		checkButton+=((saleResult[CommonCode.ARRAY_CHECK]=='1')?'F':'U');
		assemblyButton+=((saleResult[CommonCode.ARRAY_ASSEMBLY]=='1')?'F':'U');
		paymentButton+=((saleResult[CommonCode.ARRAY_PAYMENT]=='1')?'F':'U');
		deliveryButton+=((saleResult[CommonCode.ARRAY_DELIVERY]=='1')?'F':'U');
		
		model.addAttribute("slctBtn",selectButton);
		model.addAttribute("chckBtn",checkButton);
		model.addAttribute("asblBtn",assemblyButton);
		model.addAttribute("paymBtn",paymentButton);
		model.addAttribute("dlvrBtn",deliveryButton);
		
		return model;
	}
}

