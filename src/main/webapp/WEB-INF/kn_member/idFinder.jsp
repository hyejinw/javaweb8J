<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>login</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		@import url(https://fonts.googleapis.com/css?family=Raleway:400,100,200,300);
		#container {font-size: 1.2em;}
		
		.form-control {
			border-radius:100px; 
			margin-top: -5px;
		}
		.btn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		
		function idFinderCheck() {
			let email = myform.email.value.trim();
			let tel = myform.tel.value.trim();
			
			let regex4 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // 이메일
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
			
			  // 이메일확인
			  if(!regex4.test(email)){
			    alert("이메일 형식이 올바르지 않습니다.");
			    myform.email.focus();
			    return false;
			  }
					  
			  // 전화번호 확인
   			if(!regex5.test(tel)){
			    alert("전화번호 형식이 올바르지 않습니다.");
			    myform.tel.focus();
			    return false;
			  }
			  
		    myform.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">아이디 찾기</h2>
		<form name="myform" method="post" action="${ctp}/IdFinderOk.kn_mem" style="margin-top:50px">
			<div class="form-group" style="margin:0px auto; padding-top:50px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center">이메일</div>
					<div class="col-md-9"><input type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력해주세요" autofocus required /></div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center">전화번호(- 포함)</div>
					<div class="col-md-9"><input type="text" class="form-control" name="tel" id="tel" placeholder="전화번호를 입력해주세요(- 포함)" required/></div>
				</div>
				<br/><hr/>
				<div class="row text-center" style="margin-top:30px">
					<div class="col"><button type="button" onclick="idFinderCheck()" class="btn" style="background-color:#FFDB7E; font-size: 1em;">아이디 찾기</button></div>
				</div>
			</div>
		</form>
	</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>