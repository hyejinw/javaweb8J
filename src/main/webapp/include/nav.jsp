<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://kit.fontawesome.com/0dd280ba9a.js" crossorigin="anonymous"></script>
<%
	int level = session.getAttribute("sLevel")==null ? 99: (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	'use strict';
	
	function memCheck(level) {
		if(level > 4) {   /* 회원이 아님 */
			
			Swal.fire({
				titleText: '로그인이 필요합니다.',

				}).then((result) => {
					location.href = '${ctp}/Login.kn_mem'; 
				})
		}
		else {
			location.href = '${ctp}/MyPage.kn_mem';
		}
	}
</script>
<style>
	@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
	} 
	/* @import url('https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,200;0,400;0,500;1,600&display=swap'); */
	@font-face {
	    font-family: 'TheJamsil5Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
	    font-weight: 100;
	    font-style: normal;
	}

	
	 /* body {font-family: 'TheJamsil5Bold'; font-weight: 100;} */
 	 body {font-family: 'SUITE-Regular';}
	.hover:hover {
		color: #ffa0c5;
    top: -4px;
	}
	.hover {position: relative; top: 0px; transition: top 0.1s;}
	
	.engFont{font-family: 'TheJamsil5Bold'; font-weight: 500; margin-left:10px}
</style>

<nav class="navbar navbar-expand-sm navbar-dark" style="background-color: rgba(253, 250, 247, 0.8)">
  <a class="navbar-brand" href="http://localhost:9090/javaweb8J/"><img src="${ctp}/images/knotted_logo.png" style="width: 90px; height: 50px;"/></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" style="background-color: #ffa0c5;">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link"  style="color: #282828;" href="${ctp}/Reservation.kn_re" ><b class="hover engFont">RESERVATION</b></a>
      </li>
      <li class="nav-item">
        <a class="nav-link"  style="color: #282828" href="${ctp}/Menu.kn_menu"><b class="hover engFont">MENU</b></a>
      </li>
      <li class="nav-item">
	      <a class="nav-link"  style="color: #282828" href="${ctp}/Store.kn_st"><b class="hover engFont">STORE</b></a>
      </li>    
      <li class="nav-item">
	      <a class="nav-link" style="color: #282828"  href="${ctp}/Brand.kn_br"><b class="hover engFont">BRAND</b></a>
      </li>    
    </ul>
    <ul class="navbar-nav mr-5 my-lg-0">
      <c:if test="${level < 5}">
	      <li class="nav-item mr-2 text-center">
	        <a class="nav-link hover" style="color: #282828" href="${ctp}/Logout.kn_mem" >
	        	<i class="fa-solid fa-user-check" style="color: #3E7C17; font-size:28px"></i><br/>
	        	<font size="2" style="font-weight:500">Logout</font>
	        </a>
	      </li>
      </c:if>
      <c:if test="${level > 5}">
	      <li class="nav-item mr-3 text-center">
	        <a class="nav-link hover" style="color: #282828" href="${ctp}/Login.kn_mem" >
	        	<i class="fa-solid fa-user-tag" style="color: #7bb883; font-size:28px"></i><br/>
	        	<font size="2" style="font-weight:500">Login</font>
	      	</a>
	      </li>
      </c:if>
      <c:if test="${level == 0}">  <!-- 관리자창 -->
	      <li class="nav-item mr-3 text-center">
	        <a class="nav-link hover" style="color: #282828" href="${ctp}/AdminMain.kn_ad">
	        	<i class="fa-solid fa-screwdriver-wrench" style="color: #FFD36B; font-size:28px"></i><br/>
	        	<font size="2" style="font-weight:500">관리자 창</font>
	        </a>
	      </li>
      </c:if>
      <c:if test="${level == 1}">  <!-- 매장회원창 -->
	      <li class="nav-item mr-3 text-center">
	        <a class="nav-link hover" style="color: #282828" href="${ctp}/FranPage.kn_fr">
	        	<i class="fa-solid fa-face-laugh-wink" style="color: #FFD36B; font-size:28px"></i><br/>
	        	<font size="2" style="font-weight:500">매장관리 창</font>
	        </a>
	      </li>
	    </c:if>  
      <c:if test="${level > 1}">  <!-- 회원창 -->
	      <li class="nav-item mr-3 text-center">
	        <a class="nav-link hover" style="color: #282828" href="javascript:memCheck(${level})">
	        	<i class="fa-solid fa-face-laugh-wink" style="color: #FFD36B; font-size:28px"></i><br/>
	        	<font size="2" style="font-weight:500">My Page</font>
	        </a>
	      </li>
	    </c:if>  
      <li class="nav-item text-center">
	      <a class="nav-link hover" style="color: #282828" href="${ctp}/Cart.kn_re">
	     	 <i class="fas fa-shopping-bag" style="color: #FFA6D5; font-size:28px"></i><br/>
    	   <font size="2" style="font-weight:500">Cart</font>
	      </a>
      </li>       
    </ul>
	</div>
</nav>