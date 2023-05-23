<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franMain.jsp</title>
	<frameset cols="200px, *">
		<frame src="${ctp}/FranLeft.kn_fr" name="franLeft" frameborder="0">
		<frame src="${ctp}/FranContent.kn_fr" name="franContent" frameborder="0">
	</frameset>
</head>
</html>