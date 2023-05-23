<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franInfoModify.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		body {
			font-family: 'SUITE-Regular';
		}
		#c { 
	    font-size: 15px;
	    margin: 100px 60px 200px 40px;
	  }
	  .head {
	 		background-color:#FFF4D2;
	 		font-size: 20px;
	  }
	</style>	
	<script>
		'use strict';
		
		function modifyCheck() {
			let storePhoto = document.getElementById('storePhoto').value;
			let ext = storePhoto.substring(storePhoto.lastIndexOf(".")+1).toUpperCase();
			let maxSize = 1024 * 1024 * 10; // 업로드 가능 파일은 10MByte까지
			
			if(storePhoto.trim() == "") {
				alert("대표 매장 사진을 업로드해주세요.");
				return false;
			}
			
			let fileSize = document.getElementById("storePhoto").files[0].size;
			if(ext != "JPG" && ext != "GIF" && ext != "PNG") {
				alert("업로드 가능한 사진 파일은 'jpg/gif/png' 입니다.");
			}
			else if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 10MByte 입니다.");
			}
			else {
				storeModify.submit();
			}
		}
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('demo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  // 이렇게하면 stream 단위 input/output 그거 안 써도 된다.
			}
			else {
				document.getElementById('demo').src = "";
			}
		}
		
		function selectAll1(selectAll)  {
			  const checkboxes 
			       = document.getElementsByName('donut');
			  
			  checkboxes.forEach((checkbox) => {
			    checkbox.checked = selectAll.checked;
			  })
			}
		function selectAll2(selectAll)  {
			  const checkboxes 
			       = document.getElementsByName('cake');
			  
			  checkboxes.forEach((checkbox) => {
			    checkbox.checked = selectAll.checked;
			  })
			}
		function selectAll3(selectAll)  {
			  const checkboxes 
			       = document.getElementsByName('bakery');
			  
			  checkboxes.forEach((checkbox) => {
			    checkbox.checked = selectAll.checked;
			  })
			}
		
	</script>
</head>
<body>
	<div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">매장 정보 수정</span></div>
		<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red">초기 설정 시, 관리자 확인 후 매장이 공개됩니다.</span></div>
		<button class="btn btn-danger text-left mb-4" onclick="location.href='${ctp}/FranStore.kn_fr';" style="margin-left: 100px">매장 관리창</button>
    
    <form name="storeModify" method="post" action="${ctp}/FranStoreInfoModifyOk.kn_fr" enctype="multipart/form-data" style="width:90%; margin:0px auto; padding:20px 50px" class="border">
			<div class="row mb-3">
				<div class="col-sm-2 head">매장명</div>
				<div class="col-sm-10"><input type="text" name="storeName" id="storeName" value="${vo.storeName}" readonly class="form-control"/></div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 head">전화번호</div>
				<div class="col-sm-10"><input type="text" name="storeTel" id="storeTel" value="${vo.storeTel}" class="form-control"/></div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 head">주소</div>
				<div class="col-sm-10"><input type="text" name="storeAddress" id="storeAddress" value="${vo.storeAddress}" class="form-control"/></div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 head">영업시간</div>
				<div class="col-sm-10"><input type="text" name="opHour" id="opHour" value="${vo.opHour}" class="form-control"/></div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 head">가능 메뉴</div>
				<div class="col-sm-10">
					<table class="table table-bordered">
						<tr>
							<th>도넛류<br/><label for="donut">(<span style="font-size:13px">전체 선택</span>&nbsp;<input type="checkbox" id="donut" onclick='selectAll1(this)'>)</label></th>
							<td>  <!-- 카테고리별 나누기 -->
								<c:set var="cnt" value="${1}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
								<c:if test="${vo.category == '도넛'}">
									<input type="checkbox" id="donut${st.count}" name="donut" value="${vo.menuName}"><label for="donut${st.count}">${vo.menuName}</label>&nbsp;&nbsp;&nbsp;
									<c:set var="cnt" value="${cnt+1}"/>
									<c:if test="${cnt % 6 ==0}"><br/></c:if>
								</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>케이크류<br/><label for="cake">(<span style="font-size:13px">전체 선택</span>&nbsp;<input type="checkbox" id="cake" onclick='selectAll2(this)'>)</label></th>
							<td>  <!-- 카테고리별 나누기 -->
								<c:set var="cnt" value="${1}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
								<c:if test="${vo.category == '케이크'}">
									<input type="checkbox" id="cake${st.count}" name="cake" value="${vo.menuName}"><label for="cake${st.count}">${vo.menuName}</label>&nbsp;&nbsp;&nbsp;
									<c:set var="cnt" value="${cnt+1}"/>
									<c:if test="${cnt % 6 ==0}"><br/></c:if>
								</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>베이커리류<br/><label for="bakery">(<span style="font-size:13px">전체 선택</span>&nbsp;<input type="checkbox" id="bakery" onclick='selectAll3(this)'>)</label></th>
							<td>  <!-- 카테고리별 나누기 -->
								<c:set var="cnt" value="${1}"/>
								<c:forEach var="vo" items="${vos}" varStatus="st">
								<c:if test="${vo.category == '베이커리'}">
									<input type="checkbox" id="bakery${st.count}" name="bakery" value="${vo.menuName}"><label for="bakery${st.count}">${vo.menuName}</label>&nbsp;&nbsp;&nbsp;
									<c:set var="cnt" value="${cnt+1}"/>
									<c:if test="${cnt % 6 ==0}"><br/></c:if>
								</c:if>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 head">매장 사진</div>
				<div class="col-sm-10"><input type="file" name="storePhoto" id="storePhoto" onchange="imgCheck(this)" class="form-control-file border form-control"/></div>
			</div>
			<div class="row mb-4">
				<div class="col"><img id="demo" width="300px" /></div>
			</div>
			<div class="row mb-3 text-center">
				<div class="col-sm">
					<input type="reset" value="다시 입력" class="btn btn-dark mr-5" style="width:200px; height:50px; border-radius:30px;"/>
					<input type="button" value="등록" onclick="modifyCheck()" class="btn btn-success" style="width:200px; height:50px; border-radius:30px;" />
				</div>
			</div>
			
    </form>
	</div>
	
</body>
</html>










