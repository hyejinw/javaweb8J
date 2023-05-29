<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		
		.btn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		
		function pwdUpdateCheck() {
			let pwd = myform.pwd.value.trim();
			let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
			
		  // 비밀번호 확인
		  if(!regex2.test(pwd)) {
		    alert("비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)");
		    myform.pwd.focus();
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
	<h2 class="text-center" style="margin:0px auto;">비밀번호 재설정</h2>
		<form name="myform" method="post" action="${ctp}/PwdUpdateOk.kn_mem" style="margin-top:50px">
			<div class="form-group" style="margin:0px auto; padding-top:50px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right">아이디</div>
					<div class="col-md-8 text-center">${mid}</div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right">이메일</div>
					<div class="col-md-8 text-center">${email}</div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right"></div>
					<div class="col-md-8 text-center">
						<c:choose>
						  <c:when test="${empty pwd}">
						    가입 정보를 찾을 수 없습니다.
						  </c:when>
						  <c:otherwise>
						    <font size="3px">비밀번호 재설정이 필요합니다.</font><br/>
						    <input type="password" class="form-control" name="pwd" id="pwd" placeholder="재설정할 비밀번호를 입력해주세요" autofocus required />
						  </c:otherwise>
						</c:choose>
					 
					
					
					</div>
				</div>
				<br/><hr/>
				<div class="row text-center" style="margin-top:30px">
					<div class="col">
					  <c:if test="${empty pwd}">
							<button type="button" onclick="location.href='${ctp}/PwdFinder.kn_mem';" class="btn" style="background-color:#FFDB7E; font-size: 1em;">다시 찾기</button>
						</c:if>
					  <c:if test="${!empty pwd}">
							<button type="button" onclick="javascript:pwdUpdateCheck()" class="btn" style="background-color:#FFDB7E; font-size: 1em;">재설정</button>
						</c:if>
						</div>
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