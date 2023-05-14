<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>location</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		.img5 {
		  float: left;
		  width: 270px;
		  height: 270px;
		  margin: 5px;
		  border-radius: 10px;
		}
		.img5:hover {
			opacity:50%;
		}
		h6 {
			font-size:0.8em;
			color:#999999;
		}
		span {
			font-size:1.1em;
			padding:7px 0px;
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
		<div class="container text-center" style="padding:100px 0px">
	 	 <h2><b style="color: #ffa0c5;">매장안내</b></h2>
		</div>
		<hr/>
		<nav class="navbar navbar-expand-sm navbar-dark">
	  <form class="form-inline" action="/action_page.php">
	    <input class="form-control mr-sm-2" type="text" placeholder="찾고싶은 매장 입력" />
	    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
	  </form>
	</nav>
	<hr/>
		<div style="background-color:#fdfaf7; padding-bottom:100px">
		<div class="container" style="padding:50px 0px">
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/stores/1/1.thumb?1669698473" class="img5" /></a>
					<span>노티드 청담</span>
					<h6>서울 강남구 도산대로53길 15</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/stores/4/4.thumb?1681972447" class="img5" /></a>
					<span>노티드 잠실</span>
					<h6>서울 송파구 백제고분로45길 3</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/stores/5/5.thumb?1681972479" class="img5" /></a>
					<span>노티드 안국</span>
					<h6>서울 종로구 북촌로 6-3</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/stores/8/8.thumb?1680481930" class="img5" /></a>
					<span>노티드 연남</span>
					<h6>서울 마포구 월드컵북로6길 12-13</h6>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>