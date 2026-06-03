<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	function galleryStaff(){
		var form=document.createElement("form");

		  form.name='tempPost';
		  form.method='post';
		  form.action='https://jaguar.s4g.kr/GalleryStaff/staff/indexStaffForm.do';  

		  var input=document.createElement("input");
		  input.type="hidden";
		  input.name='shopId';
		  input.value= shopId;
		  $(form).append(input);

		  $('#body').append(form); 

		  form.submit();
	}
	function galleryManager(){
		$.ajax({
			url : 'https://jaguar.s4g.kr/Manager/admin/login.do',
			type : "post",
			dataType : "text",
			data : "id=" + "${id}" + "&pwd=" + "${pwd}" + "&shopTy="+"shop",
			success : function(data){
				if(data.trim()=="success"){
					location.href="https://jaguar.s4g.kr/Manager/chart/chart.do";
				}else if(data.trim()=="fail"){
					alert("ID혹은 비밀번호를 확인해 주세요.");
				}
			}
		}); 
	};
	
	function prePage(){
		var t = window.sessionStorage.getItem("board");
		page-=20;
		
		if(page<0){
			alert("첫 페이지 입니다.");
			page = 1;
			return;
		};
		getBoardList(t);
	};
	
	function nxtPage(){
		if(fnlCnt<20){
			alert("마지막 페이지 입니다.");
			return;
		};
		
		var t = window.sessionStorage.getItem("board");
		page+=20;
		getBoardList(t);
	};
</script>
<div data-role="footer" id="footer" data-position="fixed">
	<div  data-role="navbar" class="navbar">
		<ul>
			<li><a href="javascript:prePage()" >이전 페이지</a></li>
			<li><a href="javascript:galleryStaff()">판매관리</a></li>
			<li><a href="javascript:galleryManager()" >매장관리</a></li>
			<li><a href="javascript:nxtPage()" >다음 페이지</a></li>
		</ul>
	</div>
</div>