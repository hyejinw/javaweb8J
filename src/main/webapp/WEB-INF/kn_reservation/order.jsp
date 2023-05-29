<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>order.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		.updown {
	    	border: 1px solid #282828;
        width: 0.1px;
        height: 500px;
        margin-left: 75px;
	    }
		.settingBtn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
		'use strict';
		let coupon = '';
		
		function couponCheck(getCartTotPrice) {
			coupon = conponForm.coupon.value;
			let couponInput = document.getElementById("couponInput");
			let totPriceInput = document.getElementById("totPriceInput");
			let resPrice = '';
			
			Swal.fire({
				  title: '쿠폰 적용하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '적용',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
					  if(coupon == 1 || coupon == 2) {
						  couponInput.innerHTML = '- <fmt:formatNumber value="4800" pattern="#,###" />원';
						  resPrice = getCartTotPrice - 4800;
							if(resPrice < 0) resPrice = 0;
						  totPriceInput.innerHTML = resPrice+"원";
					  }
					  else if(coupon == 3) {
						  couponInput.innerHTML = '- <fmt:formatNumber value="6500" pattern="#,###" />원';
						  resPrice = getCartTotPrice - 6500;
							if(resPrice < 0) resPrice = 0;
						  totPriceInput.innerHTML = resPrice+"원";
					  }
					  else if(coupon == 4) {
						  couponInput.innerHTML = '- <fmt:formatNumber value="23000" pattern="#,###" />원';
						  resPrice = getCartTotPrice - 23000;
							if(resPrice < 0) resPrice = 0;
						  totPriceInput.innerHTML = resPrice+"원";
					  }
			  }
			})
		}
	
		function orderCheck(storeIdx, pickupDate, menuIdx) {
			
			Swal.fire({
				  title: '결제하시겠습니까?',
				  icon: 'info',
				  showCancelButton: true,
				  confirmButtonColor: '#ffa0c5',
				  cancelButtonColor: '#FFDB7E',
				  confirmButtonText: '결제',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.value) {
	              //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
	              $.ajax({
	            	  type : "post",
	            	  url : "${ctp}/OrderCheck.kn_re",
	            		data : {coupon : coupon, storeIdx : storeIdx, pickupDate : pickupDate, menuIdx : menuIdx},
	            	  success : function(res) {
	            		  if(res == 1) {
	            			  Swal.fire('결제가 완료되었습니다.\n오늘도 맛있는 하루되세요.').then(function(){
	            				  location.href = '${ctp}/'; 
	            			  });
	            		  }
	            		  else {
	            			  Swal.fire('결제 실패\n재시도해주세요.').then(function(){
	            				  location.reload(); 
	            			  });

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
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">결제</h2>
		<div class="container" style="padding-top:100px; width:100%"> 
			<div class="row">
				<div class="col-sm-5">
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px" class="mb-3 ml-3">주문매장 : ${vos[0].storeName}</div>
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px" class="ml-3">주문일자 : ${vos[0].pickupDate}</div>
					<div>
						<div style="border-radius: 100px; background-color:#FFD36B; padding:10px"  class="mb-1 mt-5 ml-3">
							<div class="ml-3"><i class="fa-solid fa-bread-slice"></i>&nbsp;&nbsp;&nbsp;&nbsp;주문 내역</div>
						</div><br/>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<div class="row">
								<div class="col-sm-6"><span class="ml-4">${vo.menuName}</span></div>
								<div class="col-sm-3">${vo.menuCnt}개</div>
								<div class="col-sm-3"><fmt:formatNumber value="${vo.menuPrice}" pattern="#,###" />원</div>
							</div>
							<br/>
						</c:forEach>
					</div>
				
				</div>
				<div class="col-sm-2"><div class="updown text-center"></div></div>
				<div class="col-sm-5">
					<span style="margin-right:270px">쿠폰</span>
					<button class="btn btn-success" data-toggle="modal" data-target="#couponClick">쿠폰적용</button>
					<hr style="border: solid 1px #282828; margin:10px 0px 20px 0px"/>
					<span style="margin-right:250px">주문금액</span><fmt:formatNumber value="${getCartTotPrice}" pattern="#,###" />원<br/>
					<span style="margin-right:250px">쿠폰할인</span><span id="couponInput"></span><br/>
					<span style="margin-right:250px">결제금액</span><span id="totPriceInput"><fmt:formatNumber value="${getCartTotPrice}" pattern="#,###" />원</span><br/>
					<hr style="border: solid 1px #282828; margin:20px 0px 40px 0px"/>
					<div>
						<span style="font-size:23px"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;예약주문시 유의사항</span><br/>
						- 픽업시 예약자명과 예약자의 전화 번호를 말씀해주세요.<br/>
						- 예약 취소는 마이페이지 [나의 예약]에서 픽업일 1일 전까지 가능합니다.(당일 취소 불가)<br/>
						- 주문 내역 확인은 마이페이지 [나의 예약]에서 확인 하실 수 있습니다.<br/>
						- 제품 품질 유지를 위해 예약 시간 1시간 경과 시 상품은 폐기됩니다. (환불 및 픽업일 변경 불가)<br/>
						- 쿠폰 적용 후 차액은 자동으로 삭제됩니다.
					</div>
					<button class="settingBtn mt-5" onclick="javascript:orderCheck('${vos[0].storeIdx}', '${vos[0].pickupDate}', '${vos[0].menuIdx}')" style="background-color:#FFDB7E; font-size:1em;">결제하기</button>
				</div>
			</div>
		
		  <!-- The Modal -->
		  <div class="modal fade" id="couponClick">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title text-center">쿠폰 적용창</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		        	<form name="conponForm">
				      	<div class="row mb-4">
				      		<c:if test="${vos2[0].idx != null}"><div class="col-sm text-primary">사용할 쿠폰을 선택해주세요.</div></c:if>
				      		<c:if test="${vos2[0].idx == null}">
				      			<div class="col-sm text-primary"><i class="fa-regular fa-face-grin-squint-tears"></i>&nbsp;&nbsp;&nbsp;쿠폰함이 비었습니다.</div>
			      			</c:if>
				      	</div>
				      	<c:if test="${vos2[0].idx != null}">
					      	<div class="row mb-2">
					      		<div class="col-sm">쿠폰 
					      			<select name="coupon" id="coupon" class="form-control">
					      				<c:forEach var="vo2" items="${vos2}" varStatus="st">
						      				<c:if test="${vo2.coupon == 1}"><option value="1">도넛 무료쿠폰 (1장, 4800원)</option></c:if>
						      				<c:if test="${vo2.coupon == 2}"><option value="2">생일축하도넛 무료쿠폰 (1장, 4800원)</option></c:if>
						      				<c:if test="${vo2.coupon == 3}"><option value="3">베이커리 무료쿠폰 (1장, 6500원)</option></c:if>
						      				<c:if test="${vo2.coupon == 4}"><option value="4">케이크 무료쿠폰 (1장, 23000원)</option></c:if>
					      				</c:forEach>
				      				</select>
				      			</div>
					      		<input type="hidden" name="idx" id="idx"/>  <!-- 안 필요할 듯 -->
					      	</div>
				      	</c:if>
			        </form>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-warning" onclick="javascript:couponCheck(${getCartTotPrice})">쿠폰적용하기</button>
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        </div>
		        
		      </div>
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