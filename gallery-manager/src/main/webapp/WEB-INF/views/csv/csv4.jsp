<%@page import="java.net.URLDecoder"%>
<%@ page language="java" pageEncoding="utf-8" %>
<%@ page import="java.util.*" %>
<%
String str = request.getParameter("csv");
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");

String fileName = startDate + "-" + endDate + ".csv";
str = str.replaceAll("LINE", "\r\n");
str = URLDecoder.decode(str,"utf-8");

System.out.println(str);
response.setHeader( "Content-Type", "application/octet-stream;charset=utf-8" ); 
response.setHeader( "Content-Disposition", "attachment;filename=" + fileName + ";"); 
response.setHeader("Content-Transfer-Encoding", "binary;"); 
out.clear();
out.print('\ufeff');
out.print(str);
out.flush();
%>