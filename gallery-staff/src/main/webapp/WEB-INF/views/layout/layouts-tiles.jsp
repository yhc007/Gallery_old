<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"       prefix="t"%>

<div align="center" style='width:100%; height:100%;'>
<div style='width:100%; '>
<table border=0 style='valign:top; width:100%;'>
<tr>
<td colspan="2">
	<t:insertAttribute name="header"/>
</td>
</tr>
<tr>
<!-- 
<td width="20%" valign="top"><t:insertAttribute name="menu"/></td>
 -->
<td width="80%" style='padding:10px'>
<t:insertAttribute name="content"/>
</td>

</tr>

</table>
</div>
</div>