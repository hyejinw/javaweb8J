<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	int level = session.getAttribute("sLevel")==null ? 99: (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>menuContent.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		.settingBtn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		
		function suPlus(price) {
			let amount = document.getElementById("amount").value;
			if(amount >= 10) {
				alert('최대 수량은 10개입니다.');
				amount = 10;
			}
			else {
				document.getElementById("amount").value++;		
				document.getElementById("price").value = price * (++amount);		
			}
		}
		
		function suMinus(price) {
			let amount = document.getElementById("amount").value;
			if(amount <= 1) {
				alert('1개 이상 주문해주세요.');
				amount = 1;
			}
			else {
				document.getElementById("amount").value--;		
				document.getElementById("price").value = price * (--amount);		
			}
		}
		
		function cartInputCheck(pickupDate, storeIdx, menuIdx, price) {
			let amount = document.getElementById("amount").value;
			
			Swal.fire({
			  title: '장바구니에 저장하시겠습니까?',
			  icon: 'info',
			  showCancelButton: true,
			  confirmButtonColor: '#ffa0c5',
			  cancelButtonColor: '#FFDB7E',
			  confirmButtonText: '저장',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.value) {
	              //"저장" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	              $.ajax({
	            	  type : "post",
/* 	            	  url : "${ctp}/ResvCartInput.kn_re?pickupDate=${pickupDate}&storeIdx=${storeIdx}&menuIdx=${menuIdx}&amount="+amount, */
	            	  url : "${ctp}/ResvCartInput.kn_re",
	            	  data : {pickupDate : pickupDate, storeIdx : storeIdx, menuIdx : menuIdx, price : price, amount : amount},
	            	  success : function(res) {
	            		  if(res == 1) {
	            			  Swal.fire('저장 완료');    /* 여기도 sweetAlert로 바꿔주기! */
	            		  }
	            		  else {
	            			  Swal.fire('저장 실패');
	            		  }
	            	  }, error : function() {
	            		  Swal.fire('전송 실패');
	            	  }
	              });
			  }
			})
			
		}
		
	</script>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div style="padding:100px 200px 200px; background-color:rgba(253, 250, 247, 0.8)">
		<div class="container text-center" style="margin-bottom:30px">
			<h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">RESERVATION</b></h2>
			<h4 class=" text-center mb-5" style="margin-top:50px"><i><span class="badge badge-pill badge-warning">step3</span> 메뉴 수량을 선택해주세요 <i class="fa-solid fa-mug-saucer" style="color: #e68ec6;"></i></i></h4>
		</div>
		<div class="container text-center" style="border-style: solid; border-color: #FFDEB4; padding:70px">

			<div class="row" style="margin-bottom:30px">
				<div class="col-sm text-right" style="margin-right:100px">
					<img src="${ctp}/images/kn_menu/${vo.menuPhoto}" style="width:300px"/>
				</div>
				<div class="col-sm text-left">
					<span style="font-size:2em">${vo.menuName}</span><br/>
					<div style="margin-bottom:5px">${vo.menuEngName}</div><br/>
					<div style="font-size:1.5em; ">${vo.price}원</div><br/>
					<div style="margin-bottom:5px">${vo.explanation}</div><br/><hr/>
					<a href="#demo1" class="btn form-control text-left" data-toggle="collapse" style="font-size:1.2em">알레르기 유발 요인 <i class="fa-solid fa-chevron-down"></i></a><hr/>
				  <div id="demo1" class="collapse">
				    ${vo.allergy}<br/><br/>
				  </div>
					<a href="#demo2" class="btn form-control text-left" data-toggle="collapse" style="font-size:1.2em">원산지 정보 <i class="fa-solid fa-chevron-down"></i></a><hr/>
				  <div id="demo2" class="collapse">
				    ${vo.origin}
				  </div>
				  
				</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col">
				  <form style="margin-top:30px">
						<input type=button value="감소" onClick="suMinus(${vo.price})"/>
						<input type=text name="amount" id="amount" value="1"/>
						<input type=button value="증가" onClick="suPlus(${vo.price})"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<input type=text name="price" id="price" value="${vo.price}" readonly/>
					</form>
				</div>
			</div>
			
  		<button class="settingBtn mt-5" onclick="javascript:cartInputCheck('${pickupDate}','${storeIdx}','${menuIdx}', '${vo.price}')" style="background-color:#FFDB7E; font-size:1em;">주문하기</button>		
			
		</div>
		
	  
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>