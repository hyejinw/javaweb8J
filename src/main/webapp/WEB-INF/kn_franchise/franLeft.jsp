<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franLeft.jsp</title>
	<jsp:include page="/include/bs4.jsp"/> 
	<style>
		body {
			background-color:#FFF4D2; 
			font-family: 'SUITE-Regular'; 
			font-size: 18px;
		}
		a {
			color: #282828;
		}
		a:hover {
			text-decoration:none;
			color: blue;
		}
		.card-header {
			background-color:#FFEEB3;
/* 			background-color:#E5D1FA; */
			font-weight: 500;
			font-size: 20px
		}
	</style>
</head>
<body>
<P><br /></P>
<div class="text-center">
	<div class="mt-5 mb-4"><a href="${ctp}/" target="_top"><img src="${ctp}/images/knotted_logo.png" style="width: 100px; height: 50px;"/></a></div>
  <div id="accordion">
    <div class="card">
      <div class="card-header">
        <a class="card-link" data-toggle="collapse" href="#collapseOne">
          매장 관리
        </a>
      </div>
      <div id="collapseOne" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/FranInfoModify.kn_fr" target="franContent">매장 정보 수정</a><hr/>
          <a href="${ctp}/FranStore.kn_fr" target="franContent">매장 조회</a><hr/>
          <a href="${ctp}/" target="franContent">댓글 조회</a><hr/>
          <a href="${ctp}/" target="franContent">쿠폰 관리</a>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="card-link" data-toggle="collapse" href="#collapseTwo">
          예약 관리
        </a>
      </div>
      <div id="collapseTwo" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/" target="franContent">예약 조회</a>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseFive">
         문의
        </a>
      </div>
      <div id="collapseFive" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/" target="franContent">문의 남기기</a>
        </div>
      </div>
    </div>
  </div>
</div>
<P><br /></P>
</body>
</html>


