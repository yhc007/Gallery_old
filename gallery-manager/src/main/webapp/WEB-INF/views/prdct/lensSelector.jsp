<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/lib.jsp"%>


<link rel="stylesheet" media="screen and (-webkit-device-pixel-ratio: 1.5)" href="hdpi.css" />
<link rel="stylesheet" media="screen and (-webkit-device-pixel-ratio: 1.0)" href="mdpi.css" />
<link rel="stylesheet" media="screen and (-webkit-device-pixel-ratio: 0.75)" href="ldpi.css" />

<script src="${ctxPath}/js/jq/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
function getMediaEvent(str){
	alert(">>>"+str);
}

function getMediaPath1(){
	alert("in getMediaPath");
	var lensPathList = new Array();
	
	var lensPathList2 = '${lensPath}';
	for (var i in lensPathList2) {
		  alert("listTest:"+lenspathList2[i]);
	}
/* 	 <c:forEach items="${lensPath}" var="item" varStatus="status">
		 lensPathList.push('${item.img_path}');
		 
		 alert("img_path:"+'${item.img_path}');
	 </c:forEach>
	 //path 제대로 나오는지 Test
	 alert("lensPathList:"+lensPathList);
 */
	//return '${lensPath}';
	return lensPathList2 ;

}
</script>
<html lang="en-US">
<head>
	<title>Spinning</title>
    <script src="${ctxPath}/js/rotate/prototype.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxPath}/js/rotate/scriptaculous.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxPath}/js/rotate/browserdetect.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxPath}/js/rotate/apple_core.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxPath}/js/rotate/vr.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxPath}/js/rotate/library.js" type="text/javascript" charset="utf-8"></script>
	
	<script src="${ctxPath}/js/rotate/lens_select.js" type="text/javascript" charset="utf-8"></script>	
	
	<script type="text/javascript" charset="utf-8">
		document.observe("dom:loaded", function() {
			if(AC.Detector.isiPad()) {
				$('main').addClassName('isipad');
			}
		});	
	</script>
</head>
<body style='margin: 0; padding: 0'>
	
		<article id="main" class="content">
			<section id="showcase">
				<div id="html5-showcase" class="showcase">
					<div id="threesixty" class="container">
						<section id="threesixty-main">
							<div id="test" align="center" style="width:100%;height:100%">
								<div align="center"  style="width:100%;height:100%">
									<div style="width:100%;height:100%" id="viewer"></div>
								</div>
							</div>
						</section>
						
					</div>
				</div>
			</section>
		</article>
	
</body>
</html>
