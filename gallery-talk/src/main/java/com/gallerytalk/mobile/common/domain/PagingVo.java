package com.gallerytalk.mobile.common.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingVo {
	Integer rownum;
	Integer currentPage;
	Integer startPage;
	
	public int getStartPage(){
		if(currentPage==null){
			return 1;
		}
		return ((int)((currentPage-1)/10))*10+1;
	}
	Integer endPage;
	public int getEndPage(){
		int start=getStartPage();
		int total=getTotalPage();
		if(start+10>total){
			return total;
		}else{
			return ((start+10)/10)*10;
		}
	}
	Integer totalPage;
	public int getTotalPage(){
		if(currentPage==null){
			return 1;
		}
		return ((int)(totalSize/pageSize)) + (totalSize%pageSize==0?0:1);
	}
	Integer pageSize;
	Integer totalSize;
	
	Integer prev_prev;
	Integer prev_page;
	Integer next_page;
	Integer next_next;
}
