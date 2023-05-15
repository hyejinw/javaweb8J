<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franStoreCheck.jsp</title>
	<jsp:include page="/include/bs4.jsp"/> 
	<script>
		'use strict';
		
		function sendCheck() {
			opener.window.document.myform.storeName.value = '${storeName}';
			opener.window.document.myform.storeName.focus();
			window.close();
		}
		
		function storeCheck() {
			let storeName = childForm.storeName.value;
			
			if(storeName.trim() == "") {
				alert("매장명을 입력하세요");
				childForm.storeName.focus();
			}
			else {
				childForm.submit();
			}
		}
	</script>
	<style>
		.btn {
		  background-color: white;
  		border-color: #ffa0c5;
  		color: #ffa0c5;
  		border-width: medium;
		}
		.btn:hover {
			background-color: #ffa0c5;
			color: white;
		}
		input {
			border-radius:70px; 
		}
		#reCheck {
		  border-radius:70px; 
			padding: 5px;
			width:100%;
			max-width: 200px
		}
	</style>
</head>
<body>
<P><br /></P>
<div class="container text-center">	
	<h3>매장명 체크폼</h3><br/>
	<c:if test="${res == 1}">
		<h5 class="mb-4"><mark><b>${storeName}</b> 은/(는) 중복되지 않았습니다.</mark></h5>
		<p><input type="button" class="btn" value="사용하기" onclick="sendCheck()"/></p>
	</c:if>
	<c:if test="${res != 1}">
		<h4 class="mb-4"><mark><b>${storeName}</b> 은/(는) 이미 사용 중 입니다.</mark></h4>
		<form name="childForm" method="post" action="${ctp}/FranStoreCheck.kn_mem">
			<p>
				<input type="text" name="mid" id="reCheck"/>
		    <input type="button" class="btn" value="매장명 재 검색" onclick="storeCheck()"/>
			</p>
		</form>
	</c:if>
</div>	
<P><br /></P>
</body>
</html>