<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://kit.fontawesome.com/0dd280ba9a.js" crossorigin="anonymous"></script>
<%
	String member2 = request.getParameter("member")==null? "": request.getParameter("member"); 
%>

<style>
	.hover:hover {
		color: #ffa0c5;
    top: -4px;
	}
	.hover {position: relative; top: 0px; transition: top 0.1s;}
	
</style>

<nav class="navbar navbar-expand-sm navbar-dark" style="background-color: rgba(253, 250, 247, 0.8)">
  <a class="navbar-brand" href="http://localhost:9090/javaweb8J/"><img src="${ctp}/images/knotted_logo.png" style="width: 90px; height: 50px;"/></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" style="background-color: #ffa0c5;">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link"  style="color: #282828" href="${ctp}/Reservation.kn_re" ><b class="hover">RESERVATION</b></a>
      </li>
      <li class="nav-item">
        <a class="nav-link"  style="color: #282828" href="${ctp}/Menu.kn_menu"><b class="hover">MENU</b></a>
      </li>
      <li class="nav-item">
	      <a class="nav-link"  style="color: #282828" href="${ctp}/Location.kn_lo"><b class="hover">LOCATION</b></a>
      </li>    
      <li class="nav-item">
	      <a class="nav-link" style="color: #282828"  href="${ctp}/Brand.kn_br"><b class="hover">BRAND</b></a>
      </li>    
    </ul>
    <ul class="navbar-nav mr-4 my-lg-0">
    <% if(member2.equals("OK")) {%>
      <li class="nav-item">
        <a class="nav-link hover" style="color: #282828" href="${ctp}/MyPage.kn_mem" ><i class="fas fa-heart"></i><b class="text-success">${sMid}</b>님<i class="fas fa-heart"></i></a>
      </li>
      <li class="nav-item">
        <a class="nav-link hover" style="color: #282828" href="${ctp}/Logout.kn_mem" >
        	<i class="fa-solid fa-user-check" style="color: #e58ad9; font-size:35px"></i><br/>
        	<font size="2">LogOut</font>
        </a>
      </li>
    <% } else {%>
      <li class="nav-item text-center">
        <a class="nav-link hover" style="color: #282828" href="${ctp}/Login.kn_mem" >
        	<i class="fa-solid fa-user-tag" style="color: #7bb883; font-size:28px"></i><br/>
        	<font size="2">Login</font>
      	</a>
      </li>
		<% } %>
      <li class="nav-item text-center">
        <a class="nav-link hover" style="color: #282828" href="${ctp}/MyPage.kn_mem">
        	<i class="fa-solid fa-face-laugh-wink" style="color: #fae28e; font-size:28px"></i><br/>
        	<font size="2">My Page</font>
        </a>
      </li>
      <li class="nav-item text-center">
	      <a class="nav-link hover" style="color: #282828" href="${ctp}/Cart.kn_re">
	     	 <i class="fas fa-shopping-bag" style="color: #e7bbc8; font-size:28px"></i><br/>
    	   <font size="2">Cart</font>
	      </a>
      </li>       
    </ul>
	</div>
</nav>