<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminLeft.jsp</title>
	<jsp:include page="/include/bs4.jsp"/> 
	<style>
		body {
			background-color:#FFF4D2; 
			font-family: 'SUITE-Regular'; 
			font-size: 20px; 
		}
		a {
			color: #282828;
		}
		a:hover {
			text-decoration:none;
			color: blue;
		}
	</style>
</head>
<body>
<P><br /></P>
<div class="text-center">
	<p><a href="${ctp}/" target="_top"><img src="${ctp}/images/knotted_logo.png" style="width: 100px; height: 50px;"/></a></p>
	<hr/>
	<p><a href="#" target="adminContent">방명록 리스트</a></p>
	<hr/>
	<p><a href="#" target="adminContent">게시판 리스트</a></p>
	<hr/>
	<p><a href="#" target="adminContent">회원 리스트</a></p>
</div>
<P><br /></P>
</body>
</html>