<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>idCheck.jsp</title>
	<jsp:include page="/include/bs4.jsp"/> 
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>  <!-- sweetalert -->
	<script>
		'use strict';
		
		function sendCheck() {
			opener.window.document.myform.mid.value = '${mid}';
			opener.window.document.myform.mid.focus();
			window.close();
		}
		function idCheck() {
			let mid = childForm.mid.value;
			
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				childForm.mid.focus();
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
	<h3>아이디 체크폼</h3><br/>
	<c:if test="${res == 1}">
		<h5 class="mb-4"><mark><b>${mid}</b> 은/(는) 중복되지 않았습니다.</mark></h5>
		<p><input type="button" class="btn" value="사용하기" onclick="sendCheck()"/></p>
	</c:if>
	<c:if test="${res != 1}">
		<h4 class="mb-4"><mark><b>${mid}</b> 은/(는) 이미 사용 중 입니다.</mark></h4>
		<form name="childForm" method="post" action="${ctp}/IdCheck.kn">
			<p>
				<input type="text" name="mid" id="reCheck"/>
		    <input type="button" class="btn" value="아이디 재 검색" onclick="idCheck()"/>
			</p>
		</form>
	</c:if>
</div>	
<P><br /></P>
</body>
</html>