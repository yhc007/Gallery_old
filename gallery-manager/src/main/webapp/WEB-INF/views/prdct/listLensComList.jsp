<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
	<c:when test="${!empty listCom }">
		<c:forEach var="com" items="${listCom }">
				<li data-role="collapsible" data-iconpos="right" data-shadow="false" data-corners="false">
				 <h2>${com.comName}</h2>
					 <form>
				      <fieldset data-role="controlgroup" data-type="horizontal">
				        <button onclick="getLensList('${com.test}','Single',this);return false" class='ty3Btn'>단초점</button>
				        <button onclick="getLensList('${com.test}','Multi',this);return false" class='ty3Btn'>다초점</button>
				      </fieldset>
				    </form>			
			   </li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li data-role="collapsible" data-iconpos="right" data-shadow="false" data-corners="false">
				 <h2>해당 협력업체가 없습니다.</h2>
			   </li>
	</c:otherwise>
</c:choose>

