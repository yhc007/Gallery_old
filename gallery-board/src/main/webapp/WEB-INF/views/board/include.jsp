<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
	function back(){
		getBoardList(boardTy);
		$.mobile.changePage("#board" + boardTy/* ,{transition:"slide",reverse:"true"} */);
	}
</script>
<style>
</style>
<div data-role="header" id="headerBar">
	<h1><span id="title"></span></h1>
	<a href="javascript:back()" data-role="button" data-icon="arrow-l" class="headerBtn">뒤로</a>
	<a href="javascript:showWriterDiv()" data-role="button" data-icon="plus" class="ui-btn-right headerBtn">글쓰기</a>
	<div  data-role="navbar" class="navbar">
		<ul>
			<li><a href="javascript:changeBoardPage('N',navN)" class="nav" id="navN">공지사항</a></li>
			<li><a href="javascript:changeBoardPage('S',navS)" class="nav" id="navS">커뮤니티</a></li>
			<li><a href="javascript:changeBoardPage('C',navC)" class="nav" id="navC">협력업체</a></li>
		</ul>
	</div>
</div>