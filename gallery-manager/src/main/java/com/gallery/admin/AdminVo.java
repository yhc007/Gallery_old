package com.gallery.admin;

import com.gallery.common.PagingVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@ToString
@Alias("adminVo")
public class AdminVo extends PagingVo {
    String id;
    String pwd;
    String lv;
    String shopId;
    String shopName;
    String shopTy;
    String inum;
    String sdate;
    String edate;
    String comName;
    Integer cnt;
    Integer prc;
    String ip;
}
