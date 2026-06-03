<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/include/unomiclib.jsp"%>
<%@ page import="com.gallerytalk.mobile.common.domain.CommonCode"%>

<%--  공통 context 부분  --%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="request"/> 
<c:set var="newline" value="<%= \"\n\" %>" />
<link rel="stylesheet" type="text/css" href="${ctxPath}/css/tableForm.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

