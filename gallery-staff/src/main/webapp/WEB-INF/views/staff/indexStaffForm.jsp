<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/staffLib.jsp"%>

<link rel="stylesheet"
      href="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.css" />
<script src="${ctxPath}/js/jq/jquery-1.8.3.min.js"></script>
<script src="${ctxPath}/js/jqMobile/jquery.mobile-1.2.1.min.js"></script>

<link rel="stylesheet" type="text/css"
      href="${ctxPath}/css/staffTableForm.css">

<%@ include file="/WEB-INF/views/include/asLib.jsp"%>

<script>

  //----------------------
  //화면 초기 실행

  $(function(){
    var n = 1000*60*10;
    setInterval(function(){
      var shopId = window.sessionStorage.getItem("gShopId");
      //alert(shopId)
      if(shopId==''||shopId=='"null"'){
        shopId=-1
      }

      $.ajax({
        url : "${ctxPath}/staff/sessionMaintain.do",
        data : "shopId=" + shopId,
        type : "post",
        success : function(){
          console.log("session reset - staff");
        }
      });
    },n);
  });
  window.sessionStorage.setItem("refresh","false");

  if("${shopVo.shopId}" != ""){
    window.sessionStorage.setItem("gShopId","${shopVo.shopId}");
    gShopId='${shopVo.shopId}';
    console.log("gShopId:"+gShopId);

    console.log("tett3 : ",parseInt('${shopVo.shopId}'));
    console.log("tett3 : ",typeof parseInt('${shopVo.shopId}'));
    console.log("tett4 : ",parseInt('null'));
    console.log("tett4 : ",typeof parseInt('null'));

  }else{
    gShopId = window.sessionStorage.getItem("gShopId");

    if(typeof gShopId == "undefined"){
      alert('로그인 되어있지 않습니다. 매장 페이지로 이동합니다.');
      goShopListPage();}


    if(gShopId!='' &&gShopId!='"null"'){
      var form=document.createElement("form");
      form.name='tempPost';
      form.method='post';
      form.action='${ctxPath}/staff/indexStaffForm.do';

      var input=document.createElement("input");
      input.type="hidden";
      input.name='shopId';
      input.value= gShopId;
      $(form).append(input);
      $('body').append(form);

      form.submit();
    }else{
      alert('로그인 되어있지 않습니다. 매장 페이지로 이동합니다.');
      goShopListPage();
    }
  };



  if("${shopVo.pwd}"!=""){
    gShopPwd ='${shopVo.pwd}';
    window.sessionStorage.setItem("gShopPwd","${shopVo.pwd}");
  }else{
    gShopPwd = window.sessionStorage.getItem("gShopPwd");
  }

  if("${shopVo.shopName}"!=""){
    gShopName = '${shopVo.shopName}';
    window.sessionStorage.setItem("gShopName","${shopVo.shopName}");
  }else{
    gShopName = window.sessionStorage.getItem("gShopName");
  }
  if("${shopVo.id}"!=""){
    gId = '${shopVo.id}';
    window.sessionStorage.setItem("gId","${shopVo.id}");
  }else{
    gId = window.sessionStorage.getItem("Id");
  }

  //----------------------
  var mCstmrCd;
  function fncSelectCstmr(cstmrCd) {
    mCstmrCd = cstmrCd;
  };
  function fncCancel() {
    jQuery('#dialog').dialog('close');
    jQuery('#dialog').html('');
  };

  function staffLogin(staffId) {
    window.sessionStorage.setItem("staffId", staffId);
    var form = document.createElement("form");
    form.name = 'tempPost';
    form.method = 'post';
    form.action = '${ctxPath}/staff/staffLogin.do';

    var input=document.createElement("input");
    input.type="hidden";
    input.name='staffId';
    input.value= staffId;
    $(form).append(input);
    $('body').append(form);
    form.submit();
  };

  function fncGoStaffPage(shopId){

    /* 		var form=document.createElement("form");
          form.name='tempPost';
          form.method='post';
          form.action='${ctxPath}/staff/indexStaffForm.do';

		  var input=document.createElement("input");
		  input.type="hidden";
		  input.name='shopId';
		  input.value= shopId;
		  $(form).append(input);
		  $('body').append(form);
		  form.submit(); */
    goShopListPage();
  };


  function goShopListPage() {

    var OS = navigator.platform;
    var URL = "${ctxPath}/shop/indexShopForm.do";
    if(OS.match(/Win/)){
      console.log('check Win.');
    }else if(OS.match(/Mac/)){
      console.log('check MacOS.');
      //URL+="?SN=UNOMIC_AND";
    }else if(OS.match(/iP/)){
      console.log('check iOS.');
      URL+="?SN=UNOMIC_IOS";
    }else if(OS.match(/arm/)){
      console.log('check android.');
      URL+="?SN=UNOMIC_AND";
    }else{

    }

    var form = document.createElement("form");
    form.name = 'tempPost';
    form.method = 'post';
    //form.action = '${ctxPath}/shop/indexShopForm.do';
    form.action = URL;

    var param = document.createElement("input");
    param.setAttribute("type", "hidden");
    /* param.setAttribute("name", "cstmrName");
    param.setAttribute("value", jQuery('#cstmrSearchForm input[name=cstmrName]').val()); */
    $(form).append(param);
    $('body').append(form);
    form.submit();
  };


  function galleryCummunity(){
    var form = document.createElement("form");

    form.method = "post";
    form.action = "http://jaguar.s4gallery.com/community/board/main.do";

    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "shopTy";
    input.value = 1;

    var input2 = document.createElement("input");
    input2.type = "hidden";
    input2.name = "shopId";
    input2.value=gShopId;


    $(form).append(input);
    $(form).append(input2);

    $("#body").append(form);
    document.body.appendChild(form);
    form.submit();
  }

  // 	function galleryManager(){
  // 		$.ajax({
  // 			url : 'http://jaguar.s4gallery.com/Manager/admin/login.do',
  // 			type : "post",
  // 			dataType : "text",
  // 			data : "id=" + gId + "&pwd=" + gShopPwd + "&shopTy="+"shop",
  // 			success : function(data){
  // 				if(data.trim()=="success"){
  // 					location.href="http://jaguar.s4gallery.com/Manager/chart/chart.do";
  // 				}else if(data.trim()=="fail"){
  // 					alert("ID혹은 비밀번호를 확인해 주세요.");
  // 				}
  // 			}
  // 		});
  // 	}


  function getToday()
  {
    var date = new Date();
    date.setHours(date.getHours() + 9);

    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    if (month < 10) month = "0" + month;
    if (day < 10) day = "0" + day;

    //var today = year + "." + month + "." + day;

    var totalSec = date.getTime() / 1000;
    var hours = parseInt( totalSec / 3600 ) % 24;
    var minutes = parseInt( totalSec / 60 ) % 60;
    var seconds = totalSec % 60;

    //var result = (hours < 10 ? "0" + hours : hours) + "-" + (minutes < 10 ? "0" + minutes : minutes) + "-" + (seconds  < 10 ? "0" + seconds : seconds);
    var result = (hours < 10 ? "0" + hours : hours) + "시" + (minutes < 10 ? "0" + minutes : minutes)+"분";

    var dateTime = year+'년 '+month+'월 '+day+'일 '+result;

    $("#crtTime").html(dateTime);

  }


  function dlgSearchCstmr()
  {
    var url = '${ctxPath}/cstmr/cstmrListDlg.do';

    //javax
    $.ajax({
      url		: url,
      type 	: "post",
      //data 	: "cstmrId="+'${cstmrId}',
      dataType	: "html",
      beforeSend	: function(){
      },
      success: function(data){
        //jQuery('#dlgSearchResult').html('');
        jQuery('#dlgSearchResult').html(data);
      }
    });

    jQuery('#dlgSearchResult').dialog({
      title: '최근 검색',
      modal: true,
      width: "auto",
      height : "auto",
      background: "#000",
      position:{
        my:"left top",
        at:"left top",
        of:window },

    });
  }

</script>

<style>
  #cmnt, #mng, #as {
    cursor: pointer;
  }
  /* #asBoardDiv{
    display: none;
  } */
  .round-image {
    border-radius: 100%;
    -o-border-radius: 100%;
    -webkit-border-radius: 100%;
    -moz-border-radius: 100%;
  }
</style>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>GalleryStaffWeb</title>
</head>

<body>
<center>
  <div class="transStaffTable">
    <table class="listCstmr" width="800" border="0.5">
      <tr>
        <td width="20%" height="26" onclick="galleryCummunity()" id='cmnt'>커뮤니티</td>
        <!-- <td width="160" height="26" onclick="dlgSearchCstmr()" id='srch'>최근검색</td> -->
        <td width="20%" height="26" onclick="galleryManager()" id="mng">
          매장관리</td>
        <td width="20%" height="26" onclick="getAsBoard()" id="as">
          A/S 관리</td>
        <td width="20%" height="26"
            onclick="fncGoStaffPage(${shopVo.shopId});return false;">Log-out</td>
      </tr>
      <tr>
        <td height="24" colspan="4">&nbsp;</td>
      </tr>
    </table>

    <table width="800" border="0.5">
      <tr>
        <td height="78" colspan="5">
          <div class="head_title">Gallery Eyewear Cloud System</div>
        </td>
      </tr>
      <tr>
      </tr>
      <tr>
        <td height="3" colspan="5"><img
          src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
          height="1" /></td>
      </tr>
      <tr>
        <td height="63" colspan="5" class="head_title">${shopVo.shopName}</td>
      </tr>
    </table>

    <table class="staffList" width="800" border="0.5">
      <tr>
        <td height="3" colspan="4"><img
          src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
          height="1" /></td>
      </tr>
      <%-- <tr onclick="goCstrmInfo('${shop.shopId}');return false;" class="listData"> --%>

      <c:choose>
        <c:when test="${!empty listStaffShop}">
          <c:forEach var="staff" items="${listStaffShop}" varStatus="status">

            <%-- <td onclick="goCstmrListPage('${staff.staffId}');return false;"> --%>
            <td onclick="staffLogin('${staff.staffId}');return false;">
              <a href='javascript:;'> <%-- <img src="http://106.240.234.114:8080/media${staff.imgPath}" width=200 /></a> --%>
                <img src="${staff.imgPath}"
                     width="180px" , height="180px" class="round-image" /></a> <br />${staff.staffName }
            </td>
            <c:if test="${0==((status.count)%4)}">
              </tr>
              <tr>
            </c:if>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="4" align="center">매장 데이터가 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      </tr>
      <tr>
        <td height="3" colspan="4"><img
          src="<c:url value="/images/content/GrayLine.jpg" />" width="800"
          height="1" /></td>
      </tr>
    </table>
    <div class="btnSave">
      <img onclick="goShopListPage();return false;"
           src="<c:url value="/images/content/setting.png" />"
           onmousedown="this.src='<c:url value="/images/content/setting_push.png" />'"
           onmouseup="this.src='<c:url value="/images/content/setting.png" />'" />
    </div>
    <div id='tableCstmrIssue'></div>
    <table class="staffList" width="800" border="0.5">
      <tr>
        <td width="206">&nbsp;</td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <center>
          <td>Copyright (c) 2013 UNOMIC All right reserved.</td>
        </center>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table>
</center>
</div>
<div id="dlgSearchResult" hidden></div>
</body>
</html>
