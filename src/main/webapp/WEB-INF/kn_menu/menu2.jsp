<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>menu</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		.img4 {
		  float: left;
		  width: 90%;
		  margin: 5px;
		  border-radius: 10px;
		}
		.img4:hover {
			opacity:50%;
		}
		h6 {
			font-size:0.8em;
			color:#999999;
		}
		h5 {
			font-size:1.1em;
		}
	</style>
</head>
<body>
	<jsp:include page="/include/nav.jsp" />
		<div class="container text-center" style="padding:100px 0px">
	 	 <h2><b style="color: #ffa0c5;">메뉴</b></h2>
		</div>
		
		<hr/>
		<nav class="navbar navbar-expand-md navbar-dark">
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <div class="navbar-nav mr-auto">
		      <div class="btn-group">
	 				 <button type="button" class="btn">전체</button>
					 <button type="button" class="btn">도넛</button>
				   <button type="button" class="btn">케이크</button>
				   <button type="button" class="btn">베이크</button>
					</div>
		    </div>
		    <form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-2" type="search" autofocus aria-label="Search" />
		      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		    </form>
		  </div>
		</nav>
		<hr/>
		<div style="background-color:#fdfaf7; padding-bottom:100px">
		<div class="container" style="padding:50px 0px">
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/2/2.thumb?1680578550" class="img4" /></a>
					<h5>우유 생크림 도넛</h5>
					<h6>3,900</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/3/3.thumb?1680578577" class="img4" /></a>
					<h5>클래식 바닐라 도넛</h5>
					<h6>3,500</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/4/4.thumb?1680578597" class="img4" /></a>
					<h5>얼그레이 도넛</h5>
					<h6>3,500</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/5/5.thumb?1680578607" class="img4" /></a>
					<h5>초코푸딩 도넛</h5>
					<h6>3,900</h6>
				</div>
			</div>
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/6/6.thumb?1680578640" class="img4" /></a>
					<h5>카야버터 도넛</h5>
					<h6>3,900</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/7/7.thumb?1681865893" class="img4" /></a>
					<h5>옐로우 스마일</h5>
					<h6>22,000</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/8/8.thumb?1681865902" class="img4" /></a>
					<h5>망고 스마일</h5>
					<h6>22,000</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/9/9.thumb?1681865912" class="img4" /></a>
					<h5>클로버 스마일</h5>
					<h6>22,000</h6>
				</div>
			</div>
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/5/5.thumb?1680578607" class="img4" /></a>
					<h5>라즈베리 도넛</h5>
					<h6>3,500</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/14/14.thumb?1680578658" class="img4" /></a>
					<h5>민트초코 도넛</h5>
					<h6>3,900</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/17/17.thumb?1677679426" class="img4" /></a>
					<h5>제주 청귤 도넛</h5>
					<h6>3,900</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/18/18.thumb?1677679438" class="img4" /></a>
					<h5>녹차 도넛</h5>
					<h6>3,900</h6>
				</div>
			</div>
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/24/24.thumb?1677679515" class="img4" /></a>
					<h5>바또피치 도넛</h5>
					<h6>3,900</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/12/12.thumb?1680578633" class="img4" /></a>
					<h5>라즈베리 도넛</h5>
					<h6>3,500</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="	https://img-app.knotted-order.com/products/25/25.thumb?1677679467" class="img4" /></a>
					<h5>초코 타이어 도넛</h5>
					<h6>4,800</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/26/26.thumb?1679443847" class="img4" /></a>
					<h5>퓨어 스트로베리 주니어</h5>
					<h6>21,000</h6>
				</div>
			</div>
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/27/27.thumb?1681865931" class="img4" /></a>
					<h5>크러쉬드 초코</h5>
					<h6>21,000</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/28/28.thumb?1681179278" class="img4" /></a>
					<h5>스마일 고스트</h5>
					<h6>21,000</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/29/29.thumb?1677680733" class="img4" /></a>
					<h5>브라운베어</h5>
					<h6>19,000</h6>
				</div>
				<div class="d-flex flex-column">
					<a href="#"><img src="https://img-app.knotted-order.com/products/30/30.thumb?1677680763" class="img4" /></a>
					<h5>그랑 몽블랑</h5>
					<h6>21,000</h6>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>