package com.gallery.fileserver;

import com.gallery.common.PagingVo;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("fileServerVo")
public class FileServerVo extends PagingVo {
    String serverId;
    String serverName;
    String serverUrl;
    String isdefault;
    String bigo;
    String birthDay;
    String cstmrCd;
    String cstmrName;
    String email;
    String getEmailYn;
    String cellphone;
    String lastShopName;
    String getSmsYn;
    String couponCd;
    String usingDate;
    String shopName;
    String memo;
    String birthDayTyCd;
}
