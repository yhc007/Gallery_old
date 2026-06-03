<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"       prefix="t"%>

<div align="center" style='width:100%; height:100%;'>
<div style='min-width:1024px;width:80%; '>
<table style='valign:top; width:100%;'>
<tr>
<td width="5%"></td>
<td>
<t:insertAttribute name="header"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td colspan="3" width="100%" valign='top'>
<t:insertAttribute name="menu"/>
</td>
</tr>
<tr>
<td width="107px"></td>
<td valign='top'>
<t:insertAttribute name="content"/>
</td>
<td width="107px"></td>
</tr>
</table>
</div>
</div>