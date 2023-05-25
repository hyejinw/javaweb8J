<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>myPage</title>
	<script src="${ctp}/js/woo.js"></script> 
	<jsp:include page="/include/bs4.jsp" />
	<script>
		'use strict';
		
		function here1() {
			$("#here").html(
					'<div><br/>예약 실 결제금액이 100,000원 미만일 경우<br/> 아래의 쿠폰이 발행됩니다.<br/><br/>'
					+ '<i class="fa-solid fa-bread-slice" style="color: #ffa0c5;"></i>&nbsp;&nbsp;도넛 무료쿠폰 (1장, 4800원)</div>'
			);
		}
		function here2() {
			$("#here").html(
					'<div><br/>예약 실 결제금액이 100,000원 이상일 경우<br/> 아래의 쿠폰이 발행됩니다.<br/><br/>'
					+ '<i class="fa-solid fa-bread-slice" style="color: #ffa0c5;"></i>&nbsp;&nbsp;베이커리 무료쿠폰 (1장, 6500원)</div>'
			);
		}
		function here3() {
			$("#here").html(
					'<div><br/>예약 실 결제금액이 150,000원 이상일 경우<br/> 아래의 쿠폰이 발행됩니다.<br/><br/>'
					+ '<i class="fa-solid fa-bread-slice" style="color: #ffa0c5;"></i>&nbsp;&nbsp;베이커리 무료쿠폰 (1장, 6500원)<br/><i class="fa-solid fa-cake-candles" style="color: #FFD36B;"></i>&nbsp;&nbsp;케이크 무료쿠폰 (1장, 23000원)</div>'
			);
		}
		

		// 가입부분 체크
		function memModifyCheck(){
			let check = true;
			
		  let name = document.getElementById("name").value.trim();
    	let email = myform.email.value.trim();
		  let birthday = myform.birthday.value;
		  let tel = myform.tel.value;
		  
		 /*  let postcode = myform.postcode.value + " ";
		  let roadAddress = myform.roadAddress.value + " ";
		  let detailAddress = myform.detailAddress.value + " ";
		  let extraAddress = myform.extraAddress.value + " ";
		  */ 
		  
		  let regex3 = /^[가-힣a-zA-Z]+$/;  // (성명)한글,영문만 적어도 1자이상 
			let regex4 = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; // 이메일
	 		/*let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일 */ 
	 		let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)

	 		
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 1자이상)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  check = true;
		  }
		   
		  // 이메일확인
		  if(!regex4.test(email)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }	 
				     
				

		  // 전화번호 확인
		  if(tel===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    check = true;
		  }
		  
		  // 생년월일 확인
		  if(birthday==""){
		    document.getElementById("birthdayError").innerHTML="생일에 맞춰 특별 쿠폰을 보내드립니다. 생년월일을 입력해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("birthdayError").innerHTML="";
		    check = true;
		  }		  
		  
		  
		  if(!check){
			  alert('입력된 값을 다시 확인해주세요.');
			  check = false;
		  }
			else {
		   // myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
		    myform.submit();
			}
		}
	</script>
	<style>
		.btn2 {
			width:100%;
		  max-width: 1000px;
	    padding: 10px;
	    border-radius:500px; 
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div style="padding:0px 0px 200px">
		<div class="container">
		<div style="padding:100px 0px 30px 0px" class="text-center">
		  <h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">
		  <c:if test="${vo.level==2}">옐로우 스마일</c:if>
		  <c:if test="${vo.level==3}">민트 스마일</c:if>
		  <c:if test="${vo.level==4}">퍼플 스마일</c:if>&nbsp;&nbsp;&nbsp;</b>
		  ${vo.name}님</h2>
		  <hr style="border: solid 1px gray; margin:10px 0px 20px 0px"/>
		</div>
	  <div style="margin:10px 10px">
			<div class="container">
				<div class="col"><button class="btn btn2 mb-5" style="background-color:#D2E9E9; font-size:1.1em;" data-toggle="modal" data-target="#memModifyClick">회원 정보 수정</button></div>
			  
			  
			  <a href="#demo" class="btn form-control text-left" style="font-size:20px" data-toggle="collapse">멤버십 정보&nbsp;&nbsp;&nbsp;
			  <i class="fa-solid fa-chevron-down" style="font-color:#282828"></i></a>
			  <div id="demo" class="collapse mt-4">
			  	<span style="font-size:18px"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;회원등급 안내</span><br/>
			  	- 멤버십을 통해 받은 쿠폰은 만료 시, 사용 불가능합니다.<br/>
					- 적정 금액 이상 구매한 회원은 재 로그인 시, 바로 멤버십이 업데이트 됩니다.<br/><br/><br/>
			  	<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;등급별 혜택</span><br/>
			  	<button type="button" class="btn btn-outline-danger ml-4 mt-3 mr-2" onclick="javascript:here1()" style="border-radius:100px">옐로우 스마일</button>
			  	<button type="button" class="btn btn-outline-danger mt-3 mr-2" onclick="javascript:here2()" style="border-radius:100px">민트 스마일</button>
			  	<button type="button" class="btn btn-outline-danger mt-3 mr-2" onclick="javascript:here3()" style="border-radius:100px">퍼플 스마일</button>
			  	<div id="here" class="ml-4 mt-3 mb-5"></div>
			  </div>
			  <hr style="border: solid 0.01px #D2E9E9; margin:10px 0px 20px 0px"/>
			  
			  <a href="#demo1" class="btn form-control text-left" style="font-size:20px" data-toggle="collapse">나의 쿠폰&nbsp;&nbsp;&nbsp;
			  <i class="fa-solid fa-chevron-down" style="font-color:#282828"></i></a>
			  <div id="demo1" class="collapse mt-4">
			  	<span style="font-size:18px"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;쿠폰 안내</span><br/>
			  	- 멤버십을 통해 받은 쿠폰은 만료 시, 사용 불가능합니다.<br/>
					- 예약 후, 차액은 자동으로 소멸됩니다.<br/><br/><br/>
			  	<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;보유 쿠폰</span><br/>
			  	<table class="table table-bordered table-hover text-center mb-5">
			  		<tr>
			  			<th>쿠폰번호</th>
			  			<th>쿠폰명</th>
			  			<th>사용 기한</th>
			  		</tr>
				  	<c:set var="cnt" value="${1}"/>
				  	<c:forEach var="vo" items="${vos}">
			  		<tr>
				  		<td>${vo.idx}</td>
				  		<c:if test="${vo.coupon == 1}"><td>도넛 무료쿠폰 (1장, 4800원)</td></c:if> 
				  		<c:if test="${vo.coupon == 2}"><td>생일축하도넛 무료쿠폰 (1장, 4800원)</td></c:if> 
				  		<c:if test="${vo.coupon == 3}"><td>베이커리 무료쿠폰 (1장, 6500원)</td></c:if> 
				  		<c:if test="${vo.coupon == 4}"><td>케이크 무료쿠폰 (1장, 23000원)</td></c:if> 
				  		<td>${fn:substring(vo.couponExpireDate,0,19)}</td>
				  		<c:if test="${cnt % 3 == 0}"></tr><tr></c:if>
				  		<c:set var="cnt" value="${cnt+1}"/>
				  	</c:forEach>
				  	</tr>
			  	</table>
			  </div>
			  <hr style="border: solid 0.01px #D2E9E9; margin:10px 0px 20px 0px"/>
			  
			  <a href="#demo2" class="btn form-control text-left" style="font-size:20px" data-toggle="collapse">나의 예약&nbsp;&nbsp;&nbsp;
			  <i class="fa-solid fa-chevron-down" style="font-color:#282828"></i></a>
			  <div id="demo2" class="collapse mt-4">
			  	<span style="font-size:18px"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;예약 안내</span><br/>
			  	- 멤버십을 통해 받은 쿠폰은 만료 시, 사용 불가능합니다.<br/>
					- 예약 후, 차액은 자동으로 소멸됩니다.<br/><br/><br/>
			  	<span style="font-size:18px;"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;예약 리스트</span><br/>
			  	<table class="table table-bordered table-hover text-center mb-5">
			  		<tr>
			  			<th>픽업일</th>
			  			<th>주문번호</th>
			  			<th>주문</th>
			  			<th>개수</th>
			  			<th>결제금액</th>
			  			<th>주문상태</th>
			  		</tr>
				  	<c:set var="sw" value="${1}"/>
				  	<c:forEach var="vo" items="${vos2}">
			  		<tr>
				  		<td>${fn:substring(vo.pickupDate,0,19)}</td>
				  		<td>${vo.idx}</td>
				  		<td>${vo.menuName} / ${vo.storeName}</td>
				  		<td>${vo.menuCnt}개</td>
				  		<td>${vo.menuPrice}</td>
				  		<c:if test="${vo.pickupOk == 'NO'}"><td>픽업 전</td></c:if>
				  		<c:if test="${vo.pickupOk == 'OK'}"><td>픽업 완료</td></c:if>
				  		<c:if test="${sw % 6 == 0}"></tr><tr></c:if>
				  		<c:set var="sw" value="${sw+1}"/>
				  	</c:forEach>
				  	</tr>
			  	</table>
			  </div>
			  
			  <hr style="border: solid 0.01px #D2E9E9; margin:10px 0px 20px 0px"/>
			</div>
	  </div>
	</div>
	
	
   <!-- The Modal -->
  <div class="modal fade" id="memModifyClick">
    <div class="modal-dialog modal-dialog-centered modal-lg">  <!--modal-lg 로 할까?  -->
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 정보 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
    		<div class="modal-body">
      		<form name="myform" method="post" action="${ctp}/MemModifyOk.kn_mem">
		      	<div class="row mb-2">
		      		<div class="col-sm-6">고유번호: <input type="text" name="idx" id="idx" value="${vo.idx}" readonly class="form-control" style="background-color:#ECF2FF"/></div>
		      		<div class="col-sm-6">아이디: <input type="text" name="mid" id="mid" value="${vo.mid}" readonly class="form-control"/></div>
		      	</div>
		      	<div class="row mb-1">
		      		<div class="col-sm-6">성명: <input type="text" name="name" id="name" value="${vo.name}" class="form-control"/></div>
		      		<div class="col-sm-6">이메일: <input type="text" name="email" id="email" value="${vo.email}" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6 text-primary" id="nameError"></div>
		      		<div class="col-sm-6 text-primary" id="emailError"></div>
		      	</div>
		      	<div class="row mb-1">
		      		<div class="col-sm-6">전화번호: <input type="text" name="tel" id="tel" value="${vo.tel}" class="form-control"/></div>
		      		<div class="col-sm-6">생년월일: <input type="text" name="birthday" id="birthday" value="${vo.birthday}" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6 text-primary" id="telError"></div>
		      		<div class="col-sm-6 text-primary" id="birthdayError"></div>
		      	</div>		      	
		      	<div class="row mb-1">
		      		<div class="col">
		      			주소: <input type="text" name="address" id="address" value="${vo.address}" class="form-control" />
		      			
	<!-- 					    <div class="form-group">
						      <label for="address">주소 </label>
						      <input type="hidden" name="address" id="address">
						      <div class="input-group mb-1">
						        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
						        <div class="input-group-append">
						          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-sm">
						        </div>
						      </div>
						      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
						      <div class="input-group mb-1">
						        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
						        <div class="input-group-append">
						          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						        </div>
						      </div>
						    </div> -->
						    
							</div>						
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6 text-primary" id="addressError"></div>
		      	</div>		      	
		      	<div class="row mb-2">
		      		<div class="col">
				        성별 : 
				         <select name="gender" id="gender" class="form-control mb-2">
				            <option value="여성">여성</option>
				            <option value="남성">남성</option>
				            <option value="미선택" selected>미선택</option>
				        </select>
		      		</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col">비밀번호 : <input type="password" name="pwd" id="pwd" placeholder="비밀번호가 다르면, 수정이 불가능합니다." class="form-control"/></div>
	      		</div>
      		</form>      
    	  </div>
        
	      <!-- Modal footer -->
	      <div class="modal-footer">
      		<button type="button" class="btn btn-success" onclick="javascript:memModifyCheck()">수정</button>
      		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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