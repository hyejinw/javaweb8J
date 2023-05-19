<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>reservation</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 100;
	    font-style: normal;
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div style="padding:0px 0px 200px">
		<div class="container text-center">
		<div  style="padding:100px 0px">
		  <h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">RESERVATION</b></h2>
		</div>
		  <div  style="margin:10px 220px">
			  <div class="card-deck"  style="width:700px">
			    <div class="card">
			    	 <img class="card-img-top" src="${ctp}/images/reservation1.png" alt="Card image" style="width:100%" class="text-center">
			       <div class="card-body text-center">
			     	 <a href="#" class="btn btn-outline-danger">날짜 선택 예약(클릭!)</a>
			       <p class="card-text"><br/>예약 원하시는 날짜가 있다면<br/>날짜를 먼저 선택해주세요</p>
			       <p class="card-text"><a href="#" class="text-secondary" style="text-decoration:underline">날짜 선택 예약이란?</a></p>
			      </div>
			    </div>
			    <div class="card">
			    	 <img class="card-impaddingg-top" src="${ctp}/images/reservation2.png" alt="Card image" style="width:100%">
			       <div class="card-body text-center">
			     	 <a href="#" class="btn btn-outline-danger">메뉴 선택 예약(클릭!)</a>
			       <p class="card-text"><br/>구매 원하시는 메뉴가 있다면<br/>메뉴를 먼저 선택해주세요</p>
			       <p class="card-text"><a href="#" class="text-secondary" style="text-decoration:underline">메뉴 선택 예약이란?</a></p>
			      </div>
			    </div>
			  </div>
		  </div>
		</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>