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
          회원 관리
        </a>
      </div>
      <div id="collapseOne" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/AdminMemList.kn_ad" target="adminContent">회원 조회 및 수정</a><hr/>
          <a href="${ctp}/" target="adminContent">쿠폰 관리</a>
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
          <a href="${ctp}/AdminMemList.kn_ad" target="adminContent">예약 조회</a>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
      	<a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
        	메뉴 관리
     		</a>
      </div>
      <div id="collapseThree" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/AdminMenuList.kn_ad" target="adminContent">메뉴 조회</a><hr/>
          <a href="${ctp}/AdminMenuModify.kn_ad" target="adminContent">메뉴 수정</a><hr/>
          <a href="${ctp}/AdminMenuInsert.kn_ad" target="adminContent">메뉴 등록</a><hr/>
          <a href="${ctp}/" target="adminContent">메뉴 댓글 관리</a>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
      	<a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
        	매장 관리
     		</a>
      </div>
      <div id="collapseFour" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/" target="adminContent">매장 조회</a>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseFive">
         maybe more
        </a>
      </div>
      <div id="collapseFive" class="collapse" data-parent="#accordion">
        <div class="card-body">
          <a href="${ctp}/" target="adminContent">회원 조회</a>
        </div>
      </div>
    </div>
  </div>
</div>
<P><br /></P>
</body>
</html>


