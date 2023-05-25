<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>order.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">결제</h2>
		<div class="container" style="padding-top:100px; width:100%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
			<div class="row">
				<div class="col-sm-5">
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px">주문매장 : ${vos[0].storeName}</div>
					<div style="border-radius: 100px; background-color:#ebebeb; padding:10px">주문일자 : ${vos[0].pickupDate}</div>
					<div>
						주문 내역<br/>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							${vo.menuName}${vo.menuCnt}${vo.menuPrice}
						</c:forEach>
					</div>
				
				</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-5"></div>
			</div>
		
		
		
			<div style="border-radius: 100px; background-color:#FDF7C3; padding:10px">
				<c:if test="${vos[0].storeName == null}"><span style="margin-left:40px">장바구니를 채워주세요😀</span></c:if>
				<span style="margin-left:40px">${vos[0].storeName}&nbsp;&nbsp;&nbsp;${vos[0].pickupDate}&nbsp;&nbsp;&nbsp;</span>
				<c:if test="${vos[0].storeName != null}"><button class="btn btn-success" onclick="javascript:cartChange()">변경</button></c:if>
			</div>
			<hr style="border: solid 1px #282828; margin:10px 0px"/>
			<br/>
			<c:if test="${vos[0].storeName != null}">
				<div class="row text-center" style="margin-bottom:7px">
					<div class="col-sm-4">메뉴명</div>
					<div class="col-sm-3">수량</div>
					<div class="col-sm-3">금액</div>
					<div class="col-sm-2"></div>
				</div>
			</c:if>
			<div class="row text-center" style="margin-bottom:10px">
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<div class="col-sm-4">${vo.menuName}</div>
					<div class="col-sm-3">${vo.menuCnt}</div>
					<div class="col-sm-3">${vo.menuPrice}</div>
					<div class="col-sm-2">
						<a href="javascript:cartMenuDel(${vo.idx})"><i class="fa-solid fa-xmark" style="color: #008bf5; font-size:30px"></i></a>
					</div>
					<br/>
				</c:forEach>
			<br/>
			</div>
			<hr style="border: solid 1px #282828; margin:10px 0px"/>
			<c:if test="${vos[0].storeName != null}">
				<div class="text-right mb-5 mr-5">결제 금액&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${totMenuPrice}</div>
			</c:if>
			<div class="row text-center" style="margin-bottom:10px">
				<div class="col pr-1 text-right"><button type="button" onclick="javascript:cartDelCheck('${vos[0].storeName}')" class="btn2" style="background-color:#ffa0c5; font-size: 1em; border-color:#ffa0c5; color:black">장바구니 비우기</button></div>
				<div class="col pl-1 text-left"><button type="button" onclick="javascript:order('${vos[0].memMid}')" class="btn2" style="background-color:#FFDB7E; font-size: 1em; color:black">결제하기</button></div>
			</div>
		</div>
	</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>