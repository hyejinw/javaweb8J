<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>resvMenuSearch.jsp</title>
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
		.menuHover:hover { 
		  text-decoration: underline;
	  	text-decoration-color: #ffa0c5;
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
		
	</style>
	<script>
		'use strict';
		
		function searchCheck() {
			let searchString = $("#searchString").val();
	    	
    	if(searchString.trim() == "") {
    		alert("검색어를 입력해주세요.");
    		searchForm.searchString.focus();
    		return false;
    	}

  		searchForm.submit();
    	   	
		}
	
	</script>
</head>
<body>
	<jsp:include page="/include/nav.jsp" />
	<div style="padding:100px 200px 200px; background-color:rgba(253, 250, 247, 0.8)">
		<div class="container text-center" style="margin-bottom:30px">
			<h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">RESERVATION</b></h2>
			<h4 class=" text-center mb-5" style="margin-top:50px"><i><span class="badge badge-pill badge-warning">step3</span> 메뉴를 선택해주세요 <i class="fa-solid fa-mug-saucer" style="color: #e68ec6;"></i></i></h4>
		</div>
		<div class="container text-center" style="border-style: solid; border-color: #FFDEB4; padding:70px">

			<hr/>
			<nav class="navbar navbar-expand-md navbar-dark">
			  <div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <div class="navbar-nav mr-auto">
			    
						<div class="pill-nav" style="margin-left:50px">
						  <a class="<c:if test="${part=='전체'}">active</c:if> mr-2" href="${ctp}/ResvMenu.kn_re?pageSize=${pageSize}&pag=1&part=전체&date=${pickupDate}&idx=${storeIdx}">전체</a>
						  <a class="<c:if test="${part=='도넛'}">active</c:if> mr-2" href="${ctp}/ResvMenu.kn_re?pageSize=${pageSize}&pag=1&part=도넛&date=${pickupDate}&idx=${storeIdx}">도넛</a>
						  <a class="<c:if test="${part=='케이크'}">active</c:if> mr-2" href="${ctp}/ResvMenu.kn_re?pageSize=${pageSize}&pag=1&part=케이크&date=${pickupDate}&idx=${storeIdx}">케이크</a>
						  <a class="<c:if test="${part=='베이커리'}">active</c:if>" href="${ctp}/ResvMenu.kn_re?pageSize=${pageSize}&pag=1&part=베이커리&date=${pickupDate}&idx=${storeIdx}">베이커리</a>
						</div>
						
			    </div>
			    <form name="searchForm" method="post" action='${ctp}/ResvMenuSearch.kn_re?pickupDate=${pickupDate}&storeIdx=${storeIdx}' class="form-inline my-2 my-lg-0">
			      <input type="text" name="searchString" id="searchString" class="form-control mr-sm-2" autofocus aria-label="Search" />
			      <button class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()" style="margin-right:100px"><i class="fa-solid fa-magnifying-glass" style="color: #0cc621;"></i></button>
			    	<input type="hidden" name="pag" value="${pag}"/>   <!-- 값을 넘겨줄 때 hidden으로 페이지 위치와 크기를 함께 보내야 한다.  -->
	  				<input type="hidden" name="pageSize" value="${pageSize}"/>
	  				<input type="hidden" name="part" value="${part}"/>
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
						<a href="${ctp}/ResvMenuContent.kn_re?pickupDate=${pickupDate}&storeIdx=${storeIdx}&menuIdx=${vo.idx}" class="menuHover"><div class="d-flex flex-column">
							<img src="${ctp}/images/kn_menu/${vo.menuPhoto}" class="img4" />
							<h5 class="mt-3">
								<c:if test="${vo.day_diff < 31}"><span class="badge badge-pill badge-warning badge-sm" style="font-size:10px">NEW</span></c:if> 
							
							${vo.menuName}</h5>
							<h6>${vo.price}</h6>
						</div></a>
						<div class="d-flex justify-content-around flex-row">
							<div style="font-size:1em;">
								<c:if test="${vo.menuRate == 0}">☆☆☆☆☆</c:if>
								<c:if test="${vo.menuRate == 1}">★☆☆☆☆</c:if>
								<c:if test="${vo.menuRate == 2}">★★☆☆☆</c:if>
								<c:if test="${vo.menuRate == 3}">★★★☆☆</c:if>
								<c:if test="${vo.menuRate == 4}">★★★★☆</c:if>
								<c:if test="${vo.menuRate == 5}">★★★★★</c:if>
								
								(${vo.menuRate})</div>
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
			
			
		<!-- 블록 페이징 -->
		<!-- 4페이지(1블록)에서 0블록으로 가게되면 현재페이지는 1페이지가 블록의 시작페이지가 된다. -->
	  <!-- 첫페이지 / 이전블록 / 1(4) 2(5) 3 / 다음블록 / 마지막페이지 -->
	  <div class="text-center">
	  	<ul class="pagination justify-content-center">
		    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=1&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">◁◁</a></li></c:if>
		    <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">◀</a></li></c:if>
		    <c:forEach var="i" begin="${curBlock*blockSize + 1}" end="${curBlock*blockSize + blockSize}" varStatus="st">
		      <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=${i}&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">${i}</a></li></c:if>
		      <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=${i}&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">${i}</a></li></c:if>
		    </c:forEach>
		    <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">▶</a></li></c:if>
		    <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/ResvMenuSearch.kn_re?pageSize=${pageSize}&pag=${totPage}&part=${part}&pickupDate=${pickupDate}&storeIdx=${storeIdx}">▷▷</a></li></c:if>
	 		</ul>
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