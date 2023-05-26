<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminContent.jsp</title>
	<jsp:include page="/include/bs4.jsp"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" /> 
	<style>
		body {
			font-family: 'SUITE-Regular'; 
		}
		.card-body {
			font-size: 20px;
		}
	</style>
</head>
<body>
<P><br /></P>
<div class="container">	
  <div style="margin: 100px 0px 0px 0px;">
  	<div class="mb-5 text-center"><i class="fa-solid fa-layer-group" style="font-size:30px"></i><span style="font-size:30px">
  	&nbsp;&nbsp;&nbsp;주요 통계</span></div>
  	<div class="row mb-3">
  		<div class="col">
			</div>
  		<div class="col">
			  <div class="card bg-secondary text-white">
			    <div class="card-body">회원&nbsp;&nbsp;${memNum}</div>
			  </div>
  		
			</div>
  		<div class="col">
			  <div class="card bg-warning text-dark">
			    <div class="card-body">예약&nbsp;&nbsp;${resvNum}</div>
			  </div>
  		
  		</div>
  		<div class="col">
			  <div class="card bg-secondary text-white">
			    <div class="card-body">매장&nbsp;&nbsp;${storeNum}</div>
			  </div>
  		</div>
  		<div class="col">
			</div>
  	</div>
  	<div class="row" style="margin-bottom:30px">
  		<div class="col">
			</div>
  		<div class="col">
			  <div class="card bg-warning text-dark">
			    <div class="card-body">메뉴&nbsp;&nbsp;${menuNum}</div>
			  </div>
  		</div>
  		<div class="col">
			  <div class="card bg-secondary text-white">
			    <div class="card-body">매장 리뷰&nbsp;&nbsp;${storeReplyNum}</div>
			  </div>
  		</div>
  		<div class="col">
			  <div class="card bg-warning text-dark">
			    <div class="card-body">메뉴 리뷰&nbsp;&nbsp;${menuReplyNum}</div>
			  </div>
  		</div>
  		<div class="col">
			</div>		
  	</div>
	</div>
  	
</div>	
<div style="margin:150px 40px 200px 50px;">
	<div class="row mb-5">
		<div class="col-sm">
			<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;신규 회원</span><br/>
	  	<table class="table table-bordered table-hover text-center mb-5">
	  		<tr>
	  			<th>회원번호</th>
	  			<th>아이디</th>
	  			<th>회원 종류</th>
	  			<th>가입일</th>
	  		</tr>
		  	<c:set var="sw" value="${1}"/>
		  	<c:forEach var="vo" items="${vos}">
	  		<tr>
		  		<td>${vo.idx}</td>
		  		<td>${vo.mid}</td>
		  		<td>${vo.memType}</td>
		  		<td>${fn:substring(vo.firstVisit,0,19)}</td>
		  		<c:if test="${sw % 3 == 0}"></tr><tr></c:if>
		  		<c:set var="sw" value="${sw+1}"/>
		  	</c:forEach>
		  	</tr>
	  	</table>
		</div>
		<div class="col-sm">
			<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;신규 매장</span><br/>
	  	<table class="table table-bordered table-hover text-center mb-5">
	  		<tr>
	  			<th>매장번호</th>
	  			<th>매장명</th>
	  			<th>전화번호</th>
	  			<th>평점</th>
	  		</tr>
		  	<c:set var="cn" value="${1}"/>
		  	<c:forEach var="vo" items="${vos2}">
	  		<tr>
		  		<td>${vo.idx}</td>
		  		<td>${vo.storeName}</td>
		  		<td>${vo.storeTel}</td>
		  		<td>${vo.storeRate}</td>
		  		<c:if test="${cn % 4 == 0}"></tr><tr></c:if>
		  		<c:set var="cn" value="${cn+1}"/>
		  	</c:forEach>
		  	</tr>
	  	</table>
		</div>
	</div>
	<div class="row">
		<div class="col-sm">
			<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;신규 예약</span><br/>
	  	<table class="table table-bordered table-hover text-center mb-5">
	  		<tr>
	  			<th>예약번호</th>
	  			<th>회원 아이디</th>
	  			<th>예약 상세내용</th>
	  			<th>예약/픽업 시간</th>
	  			<th>픽업 여부</th>
	  		</tr>
		  	<c:set var="cnt" value="${1}"/>
		  	<c:forEach var="vo" items="${vos3}">
	  		<tr>
		  		<td>${vo.idx}</td>
		  		<td>${vo.memMid}</td>
		  		<td>${vo.storeName} / ${vo.menuName}</td>
		  		<td>${fn:substring(vo.pickupDate,0,19)}</td>
		  		<td>${vo.pickupOk}</td>
		  		<c:if test="${cnt % 5 == 0}"></tr><tr></c:if>
		  		<c:set var="cnt" value="${cnt+1}"/>
		  	</c:forEach>
		  	</tr>
	  	</table>
		</div>
	</div>
</div>
<P><br /></P>
</body>
</html>