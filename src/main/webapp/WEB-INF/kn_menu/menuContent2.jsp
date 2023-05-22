<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>menuContent.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div style="background-color: rgba(253, 250, 247, 0.8); padding-bottom:300px">
		<div class="container text-center" style="padding:100px 0px">
			<h2><b style="color: #282828;">메뉴안내</b></h2>
		</div>
		<div class="container">
			<div class="row mb-5">
				<div class="col-sm text-right" style="margin-right:100px">
					<img src="${ctp}/images/kn_menu/${vo.menuPhoto}" style="width:300px"/>
				</div>
				<div class="col-sm text-left">
					<span style="font-size:2em">${vo.menuName}</span><br/>
					<div style="margin-bottom:5px">${vo.menuEngName}</div><br/>
					<div style="font-size:1.5em; ">${vo.price}원</div><br/>
					<div style="margin-bottom:5px">${vo.explanation}</div><br/><hr/>
					<a href="#demo1" class="btn form-control text-left" data-toggle="collapse" style="font-size:1.2em">알레르기 유발 요인 <i class="fa-solid fa-chevron-down"></i></a><hr/>
				  <div id="demo1" class="collapse">
				    ${vo.allergy}<br/><br/>
				  </div>
					<a href="#demo2" class="btn form-control text-left" data-toggle="collapse" style="font-size:1.2em">원산지 정보 <i class="fa-solid fa-chevron-down"></i></a><hr/>
				  <div id="demo2" class="collapse">
				    ${vo.origin}
				  </div>
				</div>
			</div>
			<div class="row" style="">
				<div class="col">아이디</div>
				<div class="col">내용</div>
				<div class="col">평점</div>
				<div class="col">추천</div>
				<div class="col">사진</div>
				<div class="col">날짜</div>
			</div>
			
			
		</div>
	</div>

	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>