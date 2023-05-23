<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>storeSearch.jsp</title>
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
			font-size:1em;
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
		<div class="container text-center" style="padding:100px 0px">
	 	 <h2><b style="color: #ffa0c5;">매장</b></h2>
		</div>
		
		<hr/>
		<nav class="navbar navbar-expand-md navbar-dark">
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <div class="navbar-nav mr-auto">
		    
		    </div>
		    <form name="searchForm" method="post" action="${ctp}/StoreSearch.kn_st" class="form-inline my-2 my-lg-0">
		      <input type="text" name="searchString" id="searchString" class="form-control mr-sm-2" autofocus aria-label="Search" />
		      <button class="btn btn-outline-success my-2 my-sm-0" onclick="searchCheck()" style="margin-right:100px"><i class="fa-solid fa-magnifying-glass" style="color: #0cc621;"></i></button>
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
					<a href="${ctp}/StoreContent.kn_st?idx=${vo.idx}" class="menuHover"><div class="d-flex flex-column">
						<img src="${ctp}/images/kn_store/${vo.storePhoto}" class="img4" style="width:250px; height:250px"/>
						<h5 class="mt-3">
						
						${vo.storeName}</h5>
						<h6>${fn:split(vo.storeAddress,'/')[1]}</h6>
					</div></a>
					<div class="d-flex justify-content-around flex-row">
						<div style="font-size:1em;">
							<c:if test="${vo.storeRate == 0}">☆☆☆☆☆</c:if>
							<c:if test="${vo.storeRate == 1}">★☆☆☆☆</c:if>
							<c:if test="${vo.storeRate == 2}">★★☆☆☆</c:if>
							<c:if test="${vo.storeRate == 3}">★★★☆☆</c:if>
							<c:if test="${vo.storeRate == 4}">★★★★☆</c:if>
							<c:if test="${vo.storeRate == 5}">★★★★★</c:if>
							
							(${vo.storeRate})</div>
						<div style="color:#999999; font-size:1em;">댓글(${vo.replyCount})</div>
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