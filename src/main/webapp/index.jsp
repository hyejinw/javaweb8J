<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<!-- 여기가 홈페이지 메인 -->
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>index.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
	<style>
		@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 100;
	    font-style: normal;
		}
		#container {font-family: 'TheJamsil5Bold';}
		/* Make the image fully responsive */
		.carousel-inner img {
		  width: 100%;
		  height: 100%;
		}
		.carousel-inner img:hover {
		  opacity: 50%;
		}
		.img {
		  width: 32%;
		}
		#donut:hover {
		  color: #ffa0c5;
		  text-decoration: none;
		}
		.carousel-inner img:hover, .img:hover, .img2:hover, .img3:hover {
		  opacity: 50%;
		}
		.img2 {
			width:80%;
			border-radius: 10px;
		}
		.img3 {
		  float: left;
		  width: 223.5px;
		  height: 223.5px;
		  margin: 5px;
		  border-radius: 10px;
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div id="container">
	<div id="demo" class="carousel slide" data-ride="carousel">
		    <!-- Indicators -->
		<ul class="carousel-indicators">
		  <li data-target="#demo" data-slide-to="0" class="active"></li>
		  <li data-target="#demo" data-slide-to="1"></li>
		  <li data-target="#demo" data-slide-to="2"></li>
		</ul>
			<!-- The slideshow -->
		<div class="carousel-inner">
		  <div class="carousel-item active">
		    <a href="#"><img src="https://img-app.knotted-order.com/app/banners/47/47" alt="Chicago" width="1100" height="500"></a>
		  </div>
		  <div class="carousel-item">
		    <a href="#"><img src="https://img-app.knotted-order.com/app/banners/47/47" alt="Chicago" width="1100" height="500"></a>
		  </div>
		  <div class="carousel-item">
	<!-- 	    <a href="#"><img src="https://img-app.knotted-order.com/app/banners/71/71" alt="Los Angeles" width="1100" height="500"></a> -->
		    <a href="#"><img src="https://img-app.knotted-order.com/app/banners/73/73" alt="New York" width="1100" height="500"></a>
		  </div>
		</div>      
			<!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	</div>
	<div style="background-color: rgba(253, 250, 247, 0.8);">
		<div class="container">
			<div class="row" style="margin-top:50px">
				<div class="col-xl-4">
			    <h1 class="mb-15" style="color: #ffa0c5; margin-top:40px; font-size:1.1em; font-weight:50">OUR BEST MENU</h1>
			    <h3>Milk Cream Dount</h3>
			    <a href="#" id="donut" style="color: #282828">우유 생크림 도넛</a>
			    <p style="font-size: 2em; color: #c3c3c3;">3,900</p>
				</div>
				<div class="col-xl-8 float-right" style="margin:40px 0px">
					<a href="${ctp}/MenuContent.kn_menu?idx=1&pageSize=24&pag=1&part=전체"><img src="${ctp}/images/mainDonut1.png" class="img rounded-circle"/></a>&nbsp;
					<a href="${ctp}/MenuContent.kn_menu?idx=2&pageSize=24&pag=1&part=전체"><img src="${ctp}/images/mainDonut2.png" class="img rounded-circle"/></a>&nbsp;
				  <a href="${ctp}/MenuContent.kn_menu?idx=3&pageSize=24&pag=1&part=전체"><img src="${ctp}/images/mainDonut3.png" class="img rounded-circle" /></a>
				</div>
			</div>
		</div>
	</div>
	<div style="background-color: #eee;">
		<div class="container" style="padding:50px 0px">
			<div class="row" >
				<div class="col-xl-12 text-center font-weight-bolder" style="margin:0px 0px 30px; color: #ffa0c5; font-size:1.6em">EVENT</div>
			</div>
			<div class="row text-center">
					<a href="#" class="col-xl-5 col-sm-5 float-right"><img src="${ctp}/images/20230417_203232.png" class="img2"/></a>
			</div>
		</div>
	</div>
	<div style="background-color: rgba(253, 250, 247, 0.8);">
		<div class="container" style="padding:50px 0px">
			<div class="row" >
				<div class="col-xl-12 text-center font-weight-bolder" style="margin:0px 0px 30px; color: #ffa0c5; font-size:1.6em">INSTAGRAM</div>
			</div>
			<div class="row text-center">
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram1.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram2.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram3.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram4.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram5.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram6.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram7.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram8.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram9.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram10.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram11.png" class="img3" /></a>
				<a href="https://www.instagram.com/cafeknotted/"><img src="${ctp}/images/instagram12.png" class="img3" /></a>
			</div>
		</div>
	</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>