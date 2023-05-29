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
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">아이디 찾기 결과</h2>
		<form name="myform" style="margin-top:50px">
			<div class="form-group" style="margin:0px auto; padding-top:50px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right">이메일</div>
					<div class="col-md-8 text-center">${email}</div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right">전화번호(- 포함)</div>
					<div class="col-md-8 text-center">${tel}</div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-4 text-right">아이디</div>
					<div class="col-md-8 text-center">
						<c:choose>
						  <c:when test="${empty mid}">
						    가입 정보를 찾을 수 없습니다.
						  </c:when>
						  <c:otherwise>
						    <font size="3px">입력하신 정보로 아래의 아이디를 찾았습니다.</font><br/>
						    <!-- 아이디가 null이 아닐 때 -->
						    <c:if test="${mid ne null && mid !='' }">
						      <!-- 아이디의 앞 4자리까지 보여 주고 -->
						      ${fn:substring(mid,0,4) }
						      <!-- 5자리부터 id의 길이만큼 *를 찍어줌 -->
						      <c:forEach begin="5" end="${fn:length(mid)}" step="1">
						        *
						      </c:forEach>
						    </c:if>
						  </c:otherwise>
						</c:choose>
					 
					
					
					</div>
				</div>
				<br/><hr/>
				<div class="row text-center" style="margin-top:30px">
					<div class="col">
					  <c:if test="${empty mid}">
							<button type="button" onclick="location.href='${ctp}/IdFinder.kn_mem';" class="btn" style="background-color:#FFDB7E; font-size: 1em;">다시 찾기</button>
						</c:if>
					  <c:if test="${!empty mid}">
							<button type="button" onclick="location.href='${ctp}/Login.kn_mem';" class="btn" style="background-color:#FFDB7E; font-size: 1em;">로그인</button>
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