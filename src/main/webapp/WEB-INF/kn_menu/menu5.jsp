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
	<link rel="icon" type="image/png" href="http://example.com/myicon.png"> 
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
		  width: 100%;
		  margin: 5px;
		  border-radius: 10px;
		}
		.img4:hover {
			opacity:50%;
		}
		.menuHover:visited { /* 방문 후 링크 상태 */
    color: pink;
    background-color: transparent;
    text-decoration: none;
		}
		h5 {
			color:#282828;
			font-size:1.3em;
		}
		h5:hover {
			color:#999999;
		}
		h6 {
			font-size:1.1em;
			color:#999999;
		}
		
			
		.star-ratings {
		  color: #aaa9a9; 
		  position: relative;
		  unicode-bidi: bidi-override;
		  width: max-content;
		  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
		  -webkit-text-stroke-width: 1.3px;
		  -webkit-text-stroke-color: #2b2a29;
		}
		 
		.star-ratings-fill {
		  color: #fff58c;
		  padding: 0;
		  position: absolute;
		  z-index: 1;
		  display: flex;
		  top: 0;
		  left: 0;
		  overflow: hidden;
		  -webkit-text-fill-color: gold;
		}
		 
		.star-ratings-base {
		  z-index: 0;
		  padding: 0;
		}
		
	</style>
	<script>
		ratingToPercent() {
		      const score = +this.restaurant.averageScore * 20;
		      return score + 1.5;
		 }
	</script>
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
		
		<div class="row text-center mb-5">
			<c:set var="cnt" 	value="${0}"/>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<div class="col-sm-3">
					<a href="#" class="menuHover"><div class="d-flex flex-column">
						<img src="${ctp}/images/kn_menu/${vo.menuPhoto}" class="img4" />
						<h5 class="mt-3">${vo.menuName}</h5>
						<h6>${vo.price}</h6>
					</div></a>
					<div class="d-flex justify-content-around flex-row">
						<div style="color:#999999; font-size:1em;">
						
						<div class="star-ratings">
							<div class="star-ratings-fill space-x-2 text-lg":style="{ width: ratingToPercent + '%' }">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
							<div class="star-ratings-base space-x-2 text-lg">
								<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
							</div>
						</div>
						
						(${vo.menuRate})</div>
						<div style="color:#999999; font-size:1.1em;">댓글(${vo.replyCount})</div>
					</div>
				</div>
				<c:set var="cnt" value="${cnt + 1}"/>
				<c:if test="${cnt % 4 == 0}">
					</div>
					<div class="row text-center mb-5" >
				</c:if>
			</c:forEach>
			<div>
		</div>
		</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>