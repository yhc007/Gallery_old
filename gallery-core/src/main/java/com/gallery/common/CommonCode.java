package com.gallery.common;

import java.util.HashMap;
import java.util.Map;

public class CommonCode {
    public static String PW_KEY_TAG = "##pwkey##";

    /*
     * DB 공통 코드
     */
    public static String CODE_PRDCT_STAT_SALE_STAY = "00100001";
    public static String CODE_PRDCT_STAT_SALE_REQ = "00100002";
    public static String CODE_PRDCT_STAT_SALE_ING = "00100003";
    public static String CODE_PRDCT_STAT_SALE_DNY = "00100004";
    public static String CODE_MEDIA_TY_STILL_CUT = "00200001";
    public static String CODE_MEDIA_TY_MULTI_IMAGE = "00200002";
    public static String CODE_MEDIA_TY_MOVIE = "00200003";
    public static String CODE_PRDCT_TY_FRAME = "00300001";
    public static String CODE_PRDCT_TY_LENS = "00300002";
    public static String CODE_PRDCT_TY_CLENS = "00300003";
    public static String CODE_PRDCT_TY_LENS_DIS = "00300004";
    public static String CODE_SEX_TY_MAN = "00400001";
    public static String CODE_SEX_TY_WOMAN = "00400002";
    public static String CODE_OPR_ING = "00500001";
    public static String CODE_OPR_STOP = "00500002";
    public static String CODE_BIRTH_TY_SUN = "00600001";
    public static String CODE_BIRTH_TY_MOON = "00600002";
    public static String CODE_SMS_RSV_YES = "00700001";
    public static String CODE_SMS_RSV_NO = "00700002";
    public static String CODE_MERGE_TY_NEW = "00800001";
    public static String CODE_MERGE_TY_OLD = "00800002";
    public static String CODE_INVN_TY_IN = "00900001";
    public static String CODE_INVN_TY_OUT = "00900002";
    public static String CODE_EVENT_TY_ALL = "01000001";
    public static String CODE_EVENT_TY_ENT = "01000002";

    public static String CODE_SALE_RST_SUCCESS = "0000";
    public static String CODE_SALE_RST_SUCCESS2 = "sucess";
    public static String CODE_SALE_RST_SUCCESS3 = "0";
    public static String CODE_SALE_RST_CANCEL = "2005";
    public static String CODE_SALE_RST_WAIT = "-1000";
    public static String CODE_SALE_RST_TIME_OVER = "0001";


    public static String MSG_PRDCT_STAT_SALE_STAY = "대기";
    public static String MSG_PRDCT_STAT_SALE_REQ = "승인 요청";
    public static String MSG_PRDCT_STAT_SALE_ING = "승인 완료";
    public static String MSG_PRDCT_STAT_SALE_DNY = "반려";
    public static String MSG_MEDIA_TY_STILL_CUT = "스틸 이미지";
    public static String MSG_MEDIA_TY_MULTI_IMAGE = "회전 이미지";
    public static String MSG_MEDIA_TY_MOVIE = "영상";
    public static String MSG_PRDCT_TY_FRAME = "안경테";
    public static String MSG_PRDCT_TY_LENS = "렌즈";
    public static String MSG_PRDCT_TY_CLENS = "써클 렌즈";
    public static String MSG_PRDCT_TY_LENS_DIS = "홍보 렌즈";
    public static String MSG_SEX_TY_MAN = "남자";
    public static String MSG_SEX_TY_WOMAN = "여자";
    public static String MSG_SHOP_OPR_ING = "영업 중";
    public static String MSG_SHOP_OPR_STOP = "영업 중지";
    public static String MSG_BIRTH_TY_SUN = "양력";
    public static String MSG_BIRTH_TY_MOON = "음력";
    public static String MSG_SMS_RSV_YES = "수신";
    public static String MSG_SMS_RSV_NO = "거부";
    public static String MSG_MERGE_TY_NEW = "신규 회원";
    public static String MSG_MERGE_TY_OLD = "기존 회원";
    public static String MSG_INVN_TY_IN = "입고";
    public static String MSG_INVN_TY_OUT = "출고";
    public static String MSG_EVENT_TY_ALL = "전체";
    public static String MSG_EVENT_TY_ENT = "개별";


    public static String MSG_SALE_RST_SUCCESS = "결제 완료";
    public static String MSG_SALE_RST_SUCCESS2 = "결제 완료";
    public static String MSG_SALE_RST_SUCCESS3 = "결제 완료";
    public static String MSG_SALE_RST_CANCEL = "취소";
    public static String MSG_SALE_RST_WAIT = "결제 대기";
    public static String MSG_SALE_RST_TIME_OVER = "시간 초과";

    /*
     * 메뉴 코드
     */
    public static String MENU_CODE_SHOP = "MSHOP";
    public static String MENU_CODE_HIST = "MHIST";
    public static String MENU_CODE_PRDCT = "MPRDCT";
    public static String MENU_CODE_MEDIA = "MMEDIA";
    public static String MENU_CODE_MFS = "MFS";

    /*
     * 매장 코드
     */
    public static String SHOP_CODE_MOBILE = "999";
    /*
     * 코드 메시지 매핑
     */


    public static Map codeMap = new HashMap();

    static {
        codeMap.put(CODE_PRDCT_STAT_SALE_STAY, MSG_PRDCT_STAT_SALE_STAY);
        codeMap.put(CODE_PRDCT_STAT_SALE_REQ, MSG_PRDCT_STAT_SALE_REQ);
        codeMap.put(CODE_PRDCT_STAT_SALE_ING, MSG_PRDCT_STAT_SALE_ING);
        codeMap.put(CODE_PRDCT_STAT_SALE_DNY, MSG_PRDCT_STAT_SALE_DNY);
        codeMap.put(CODE_MEDIA_TY_STILL_CUT, MSG_MEDIA_TY_STILL_CUT);
        codeMap.put(CODE_MEDIA_TY_MULTI_IMAGE, MSG_MEDIA_TY_MULTI_IMAGE);
        codeMap.put(CODE_MEDIA_TY_MOVIE, MSG_MEDIA_TY_MOVIE);
        codeMap.put(CODE_PRDCT_TY_FRAME, MSG_PRDCT_TY_FRAME);
        codeMap.put(CODE_PRDCT_TY_LENS, MSG_PRDCT_TY_LENS);
        codeMap.put(CODE_PRDCT_TY_CLENS, MSG_PRDCT_TY_CLENS);
        codeMap.put(CODE_PRDCT_TY_LENS_DIS, MSG_PRDCT_TY_LENS_DIS);
        codeMap.put(CODE_SEX_TY_MAN, MSG_SEX_TY_MAN);
        codeMap.put(CODE_SEX_TY_WOMAN, MSG_SEX_TY_WOMAN);
        codeMap.put(CODE_OPR_ING, "O");
        codeMap.put(CODE_OPR_STOP, "X");
        codeMap.put(CODE_BIRTH_TY_SUN, MSG_BIRTH_TY_SUN);
        codeMap.put(CODE_BIRTH_TY_MOON, MSG_BIRTH_TY_MOON);
        codeMap.put(CODE_SMS_RSV_YES, MSG_SMS_RSV_YES);
        codeMap.put(CODE_SMS_RSV_NO, MSG_SMS_RSV_NO);
        codeMap.put(CODE_MERGE_TY_NEW, MSG_MERGE_TY_NEW);
        codeMap.put(CODE_MERGE_TY_OLD, MSG_MERGE_TY_OLD);
        codeMap.put(CODE_INVN_TY_IN, MSG_INVN_TY_IN);
        codeMap.put(CODE_INVN_TY_OUT, MSG_INVN_TY_OUT);
        codeMap.put(CODE_EVENT_TY_ALL, MSG_EVENT_TY_ALL);
        codeMap.put(CODE_EVENT_TY_ENT, MSG_EVENT_TY_ENT);
        codeMap.put(CODE_SALE_RST_SUCCESS, MSG_SALE_RST_SUCCESS);
        codeMap.put(CODE_SALE_RST_SUCCESS2, MSG_SALE_RST_SUCCESS2);
        codeMap.put(CODE_SALE_RST_SUCCESS3, MSG_SALE_RST_SUCCESS3);
        codeMap.put(CODE_SALE_RST_CANCEL, MSG_SALE_RST_CANCEL);
        codeMap.put(CODE_SALE_RST_WAIT, MSG_SALE_RST_WAIT);
        codeMap.put(CODE_SALE_RST_TIME_OVER, MSG_SALE_RST_TIME_OVER);

        codeMap.put(CODE_PRDCT_STAT_SALE_STAY, MSG_PRDCT_STAT_SALE_STAY);
        codeMap.put(CODE_PRDCT_STAT_SALE_REQ, MSG_PRDCT_STAT_SALE_REQ);
        codeMap.put(CODE_PRDCT_STAT_SALE_ING, MSG_PRDCT_STAT_SALE_ING);
        codeMap.put(CODE_PRDCT_STAT_SALE_DNY, MSG_PRDCT_STAT_SALE_DNY);
        codeMap.put(CODE_MEDIA_TY_STILL_CUT, MSG_MEDIA_TY_STILL_CUT);
        codeMap.put(CODE_MEDIA_TY_MULTI_IMAGE, MSG_MEDIA_TY_MULTI_IMAGE);
        codeMap.put(CODE_MEDIA_TY_MOVIE, MSG_MEDIA_TY_MOVIE);
        codeMap.put(CODE_PRDCT_TY_FRAME, MSG_PRDCT_TY_FRAME);
        codeMap.put(CODE_PRDCT_TY_LENS, MSG_PRDCT_TY_LENS);
        codeMap.put(CODE_PRDCT_TY_CLENS, MSG_PRDCT_TY_CLENS);
        codeMap.put(CODE_SEX_TY_MAN, MSG_SEX_TY_MAN);
        codeMap.put(CODE_SEX_TY_WOMAN, MSG_SEX_TY_WOMAN);
        codeMap.put(CODE_BIRTH_TY_SUN, MSG_BIRTH_TY_SUN);
        codeMap.put(CODE_BIRTH_TY_MOON, MSG_BIRTH_TY_MOON);
        codeMap.put(CODE_SMS_RSV_YES, MSG_SMS_RSV_YES);
        codeMap.put(CODE_SMS_RSV_NO, MSG_SMS_RSV_NO);
        codeMap.put(CODE_MERGE_TY_NEW, MSG_MERGE_TY_NEW);
        codeMap.put(CODE_MERGE_TY_OLD, MSG_MERGE_TY_OLD);

    }

    /*
     * Admin E-mail Address
     */
    public static String ADMIN_MAIL_ADDRESS = "no-reply@s4dm.com";


    public static String myApiKey = "AIzaSyA2X_BiUXtFdM-nbCPgcPq88kbzagmP50Q";
    /*
     * DB 공통 코드
     */
    public static String CODE_PRDCT_TY_ACC = "00300004";

    public static int NUMBER_PRDCT_TY_FRAME = 1;
    public static int NUMBER_PRDCT_TY_LENS = 2;
    public static int NUMBER_PRDCT_TY_CLENS = 3;
    public static int NUMBER_PRDCT_TY_ACC = 4;
    public static String CODE_SHOP_OPR_ING = "00500001";
    public static String CODE_SHOP_OPR_STOP = "00500002";
    public static String CODE_INVN_TY_ADD = "00900001";
    public static String CODE_INVN_TY_REMOVE = "00900002";

    public static String CODE_STAFF_PROCESS_TY_SELECT = "01200001";//제품선택
    public static String CODE_STAFF_PROCESS_TY_CHECK = "01200002";//시력검사
    public static String CODE_STAFF_PROCESS_TY_ASSEMBLY = "01200003";//제품조립
    public static String CODE_STAFF_PROCESS_TY_PAYMENT = "01200004";//결제
    public static String CODE_STAFF_PROCESS_TY_DELIVERY = "01200005";//전달


    // security cd
    public static String CODE_DVC_IOS = "01300001";
    public static String CODE_DVC_ANDROID = "01300002";

    /*
     * ADD and REMOVE is using on select and assembly, delivery.
     */
    public static char CODE_SALE_JOB_ACTION_TY_ADD = 'A';
    public static char CODE_SALE_JOB_ACTION_TY_REMOVE = 'R';
    public static char CODE_SALE_JOB_ACTION_TY_FORCE_PAY = 'F';

    public static Integer CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_YES = 1;
    public static Integer CODE_SALE_PRDCT_OFF_ASSEMBLY_STATUS_NO = 0;
    public static Integer CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_YES = 1;
    public static Integer CODE_SALE_PRDCT_OFF_DELIVERY_STATUS_NO = 0;

    /*
     * Others are using on Eyecheck case.
     */
    public static char CODE_SALE_JOB_ACTION_TY_SAVE = 'S';
    public static char CODE_SALE_JOB_ACTION_TY_LOAD = 'L';
    public static char CODE_SALE_JOB_ACTION_TY_EDIT = 'E';
    public static char CODE_SALE_JOB_ACTION_TY_DELETE = 'D';


    public static String MENU_CODE_BRAND = "MBRAND";


    /*
     * Session Attribute
     */
    public static final String ATTR_CSTMR = "cstmr";
    public static final String ATTR_SALE = "sale";
    public static final String ATTR_SHOP = "shop";
    public static final String ATTR_STAFF = "staff";

    /*
     * process Job Array define.
     */
    public static final int ARRAY_SELECT = 0;
    public static final int ARRAY_CHECK = 1;
    public static final int ARRAY_ASSEMBLY = 2;
    public static final int ARRAY_PAYMENT = 3;
    public static final int ARRAY_DELIVERY = 4;
    public static final String RESULT_INIT = "00000";
    public static final char COMPLETED = '1';
    public static final char INCOMPLETED = '0';
    public static final int INT_COMPLETED = 1;
    public static final int INT_INCOMPLETED = 0;

    /*
     * domEye Cd
     */
    public static final int EYE_CHECK_CD_DOMEYE_NO = 0;
    public static final int EYE_CHECK_CD_DOMEYE_RIGHT = 1;
    public static final int EYE_CHECK_CD_DOMEYE_LEFT = 2;

    /*
     *cstmrInfo.
     */
    public static final int CSTMR_NAME = 0;
    public static final int CSTMR_ADDR = 1;
    public static final int CSTMR_BIRTH = 2;
    public static final int CSTMR_TELEPHONE = 3;
    public static final int CSTMR_CELLPHONE = 4;
    public static final int CSTMR_EMAIL = 5;
    public static final int CSTMR_FMLYCD = 6;


    public static final String ATTR_SHOP_ID = "shopId";
    public static final String ATTR_CSTMRS = "cstmrs";

    /*
     * POINT HIST DEFINE.
     */
    public static final String POINT_STATUS_PLUS = "P";
    public static final String POINT_STATUS_MINUS = "M";

    /*
     *
     */
    public static final int SALE_OFF_CANCEL = 1;
    public static final int SALE_OFF_RETURN = 2;
}
