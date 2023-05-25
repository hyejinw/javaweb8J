<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>resvContent.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 100;
	    font-style: normal;
		}
		.settingBtn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
<div style="padding:100px 200px 200px; background-color:rgba(253, 250, 247, 0.8)">
	<div class="container text-center">
		<h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">RESERVATION</b></h2>
		<h4 class=" text-center mb-5" style="margin-top:100px"><i><span class="badge badge-pill badge-warning">step1</span> 매장을 먼저 선택해주세요 <i class="fa-solid fa-mug-saucer" style="color: #e68ec6;"></i></i></h4>
    <!-- <p class="text-center mb-5"><a href="#" class="text-secondary" style="text-decoration:underline">날짜 선택 예약이란?</a></p>  --> 
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<div class="media border p-3">
	    	<img src="${ctp}/images/kn_store/${vo.storePhoto}" alt="매장 대표 이미지" class="mr-3 mt-3 rounded-circle" style="width:50px; height:50px">
	   		<div class="media-body">
	   			<a href="#demo${st.count}" class="btn form-control text-left" data-toggle="collapse" >
	   				<span style="font-size:1.3em">${vo.storeName}&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-chevron-down"></i></span>
   				</a>
	   		</div>
		  </div>
		  
		 	<div id="demo${st.count}" class="collapse">
			  <div style="background-color:white; padding:50px 0px 20px 100px">
					<div class="row">
						<div class="col-sm text-left">
							<span style="font-size:1em">${vo.storeName}</span><br/>
							<div style="font-size:1em; ">${vo.storeTel}</div><br/>
							<div style="font-size:1em; ">
								${fn:split(vo.storeAddress,'/')[1]}
								<span onclick="location.href='${vo.location}';" class="location">
									&nbsp;&nbsp;&nbsp;&nbsp;[<i class="fa-solid fa-map-location-dot" style="color: #52c931;"></i>지도보기]
								</span>
							</div><br/>
							<div style="margin-bottom:5px">${vo.opHour}</div><br/>
							<button class="settingBtn" onclick="location.href='${ctp}/ResvDate.kn_re?idx=${vo.idx}';" style="background-color:#FFDB7E; font-size:1em;">매장 설정하기</button>
						</div>	
	  	  	</div>
    		</div>
    	</div>
	  </c:forEach>
	  
	  
	</div>
</div>

	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>