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
		.pill-nav a {
		  display: inline-block;
		  color: black;
		  text-align: center;
		  padding: 8px 20px;
		  text-decoration: none;
		  font-size: 17px;
		  border-radius: 5px;
		}
		
		.pill-nav a:hover {
		  background-color: #ddd;
		  color: black;
		}
		
		.pill-nav a.active {
		  background-color: #ffa0c5;
		  color: white;
		}
		
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
			font-size:1em;
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
		    
					<div class="pill-nav" style="margin-left:100px">
					  <a class="active mr-2" href="#home">전체</a>
					  <a class="active mr-2" href="#news">도넛</a>
					  <a class="active mr-2" href="#contact">케이크</a>
					  <a class="active" href="#about">베이크</a>
					</div>
					
		    </div>
		    <form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-2" type="search" autofocus aria-label="Search" />
		      <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="margin-right:100px">검색</button>
		    </form>
		  </div>
		</nav>
		<hr/>
		<div style="background-color:#fdfaf7; padding-bottom:100px">
		<div class="container" style="padding:50px 0px">
		
		
			<div class="d-flex flex-row text-center" style="padding:20px 0px">
				<c:set var="cnt" 	value="${0}"/>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<div class="d-flex flex-column">
						<a href="#"><img src="https://img-app.knotted-order.com/products/2/2.thumb?1680578550" class="img4" /></a>
						<h5>${vo.menuName}</h5>
						<h6>${vo.price}</h6>
					</div>
					<c:set var="cnt" value="${cnt + 1}"/>
					<c:if test="${cnt % 4 == 0}">
						</div>
						<div class="d-flex flex-row text-center" style="padding:20px 0px">
					</c:if>
				</c:forEach>
			</div>
				
			
			
		</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>