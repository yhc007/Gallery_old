package com.gallery.company;

import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("companyVo")
public class CompanyVo extends PagingVo {
    String iNum;
    String cType;
    String cName;
    String eName;
    String pNum1;
    String pNum2;
    String cMemo;
    String comName;
    String comName2;
    String addr;
    String no;
    String type;
    String email;
    String id;
    String pwd;
    String brand;
    String ty;
    String pN1;
    String pN2;
    String cId;
    String cPwd;
    String cState;
    Integer comTy;
}
