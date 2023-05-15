<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franJoin.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script> 
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>  <!-- sweetalert -->
	<script>
		'use strict';
		
		// 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let idCheckSw = 0;
		let storeCheckSw = 0;
		
		// 아이디 중복 검사 
		function idCheck() {
			let mid = myform.mid.value.trim();
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자
			let url = "${ctp}/IdCheck.kn_mem?mid="+mid;
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myform.mid.focus();
			}
			else if(!regex1.test(mid)) {
				document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    myform.mid.focus();
			}
			else {
  		  document.getElementById("midError").innerHTML="";
				idCheckSw = 1;
				myform.mid.readOnly = true;
				window.open(url, "nWin", "width=580px, height=250px");
			}
		}
		// 매장명 중복 검사 
		function storeCheck() {
			let storeName = myform.storeName.value.trim();
			let regex6 = /^[가-힣\s]+$/; //(매장명) 한글, 공백 허용
			let url = "${ctp}/FranStoreCheck.kn_mem?storeName="+storeName;
			
			if(storeName == "") {
				alert("매장명을 입력하세요");
				myform.mid.focus();
			}
			else if(!regex6.test(storeName)) {
				document.getElementById("storeNameError").innerHTML="매장명이 올바르지 않습니다.";
		    myform.storeName.focus();
			}
			else {
  		  document.getElementById("storeNameError").innerHTML="";
  			storeCheckSw = 1;
				myform.storeName.readOnly = true;
				window.open(url, "nWin", "width=580px, height=250px");
			}
		}
		// 전화번호 길이 제한(4자리 이상부터 입력 불가)
		function handleOnInput(el, maxlength) {
		  if(el.value.length > maxlength)  {
		    el.value 
		      = el.value.substr(0, maxlength);
		  }
		}
		
		// 첫 번째 전화번호 내용 입력 후 자동으로 커서 옮기기
		$(document).ready(function() {
	    $(".inputs").keyup(function () {
        if (this.value.length == this.maxLength) {
          $(this).next('.inputs').focus();
        }
	    });
		});	
		
		
		let check = true;

		// 가입부분 체크
		function joinCheck(){
		  let mid = document.getElementById("mid").value.trim();
		  let pwd1 = document.getElementById("pwd1").value.trim();
		  let pwd2 = document.getElementById("pwd2").value.trim();
		  let name = document.getElementById("name").value.trim();
		  let storeName = document.getElementById("storeName").value.trim();
	  
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
		  let birthday = myform.birthday.value;
		  
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  let storeTel1 = myform.storeTel1.value;
		  let storeTel2 = myform.storeTel2.value;
		  let storeTel3 = myform.storeTel3.value;
		  let storeTel = storeTel1 + "-" + storeTel2 + "-" + storeTel3;
		  
		  let postcode = myform.postcode.value + " ";
		  let roadAddress = myform.roadAddress.value + " ";
		  let detailAddress = myform.detailAddress.value + " ";
		  let extraAddress = myform.extraAddress.value + " ";
		  let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
		  
		  let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
		  let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
		  let regex3 = /^[가-힣a-zA-Z]+$/;  // (성명)한글,영문만 적어도 1자이상 
			/* let regex4 = /^[a-zA-Z0-9]+@[a-zA-Z0-9]$/; // 이메일 */
	 		let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일 
	 		let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
			let regex6 = /^[가-힣\s]+$/; //(매장명) 한글, 공백 허용
		  	
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }
		  
		  // 비밀번호 확인
		  if(!regex2.test(pwd1)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		    check = false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
			    
			  if(pwd2=== "") {
			    document.getElementById("pwdError2").innerHTML="비밀번호를 다시 입력해주세요.";
			    check = false;
			  }
			  else if(pwd1 !== pwd2) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
			    check = false;
			  }
			  else {
		  	  document.getElementById("pwdError").innerHTML="";
		  	  document.getElementById("pwdError2").innerHTML="";
		  	  check = true;
			  }
		  }
				  
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
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }	 
				     
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
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
		    document.getElementById("birthError").innerHTML="생일에 맞춰 특별 쿠폰을 보내드립니다. 생년월일을 입력해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("birthError").innerHTML="";
		    check = true;
		  }		  
		  
		  // 매장명 확인
		  if(!regex6.test(storeName)){
		    document.getElementById("storeNameError").innerHTML="매장명이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("storeNameError").innerHTML="";
			  check = true;
		  }
		  
		  // 매장 전화번호 확인
		  if(storeTel2==="" || storeTel3===""){
		    document.getElementById("storeTelError").innerHTML="매장 전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(storeTel)){
		    document.getElementById("storeTelError").innerHTML="매장 전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("storeTelError").innerHTML="";
		    check = true;
		  }
		  
		  // 매장 주소 확인
		  if(address == ""){
		    document.getElementById("addressError").innerHTML="매장 주소를 입력해주세요.";
		    check = false;
		  }
		  else {
			  document.getElementById("addressError").innerHTML="";
			  check = true;
		  }
		  
		  
		  if(!check){
			  alert('입력된 값을 다시 확인해주세요.');
			  window.scrollTo(0,100); // (그냥 위치만 바뀌는)스크롤 위로 올리기 
			  check = true;
		  }
		  else {
		    if(idCheckSw == 0) {
					alert("아이디 중복확인을 해주세요.");
					document.getElementById("midBtn").focus();
				} 
				else {
			    myform.tel.value = tel;
			    myform.storeTel.value = storeTel;
			    myform.address.value = address;
			    myform.email.value = email;
			   	myform.submit();
				}
		  }
		}
		
		function midCheck() {
			let regex1 = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
			let mid = document.getElementById("mid").value.trim();
			document.getElementById("midError").innerHTML="";
			
		  // 아이디 확인
		  if(!regex1.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    check = false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
			   check = true;
		  }			
		}
		function pwd1Check() {
			let regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
			let pwd1 = document.getElementById("pwd1").value.trim();
			document.getElementById("pwdError").innerHTML="";
			
		  // 비밀번호 확인
		  if(!regex2.test(pwd1)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		    check = false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
	  	  check = true;
	  	}	
		}
		function pwd2Check() {
			let pwd1 = document.getElementById("pwd1").value.trim();
			let pwd2 = document.getElementById("pwd2").value.trim();
			document.getElementById("pwdError").innerHTML="";
			document.getElementById("pwdError2").innerHTML="";
			
			
		  // 비밀번호 확인2
		  if(pwd1 !== pwd2) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
			    check = false;
		  }
		  else {
	  	  document.getElementById("pwdError").innerHTML="";
	  	  document.getElementById("pwdError2").innerHTML="";
	  	  check = true;
		  }
		}
		
		function nameCheck() {
			let regex3 = /^[가-힣a-zA-Z]+$/;  // (성명)한글,영문만 적어도 1자이상 
			let name = document.getElementById("name").value.trim();
			document.getElementById("nameError").innerHTML="";
			
		  // 성명 확인
		  if(!regex3.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 1자이상)";
		    check = false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  check = true;
		  }			
		}
		
		function emailCheck() {
			let regex4 = /^[0-9a-zA-Z]+$/g; // 이메일
    	let email1 = document.getElementById("email1").value.trim();
		  document.getElementById("emailError").innerHTML="";

		  // 이메일확인
		  if(!regex4.test(email1)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
			  check = true;
		  }			
		}
		
		function telCheck() {
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let tel1 = myform.tel1.value;
		  let tel2 = myform.tel2.value;
		  let tel3 = myform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
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
		}
		
		function birthdayCheck() {
			let birthday = myform.birthday.value;
			document.getElementById("birthError").innerHTML="";
			
		  // 생년월일 확인
		  if(birthday==""){
		    document.getElementById("birthError").innerHTML="생일에 맞춰 특별 쿠폰을 보내드립니다. 생년월일을 입력해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("birthError").innerHTML="";
		    check = true;
		  }			
		}
		
		function storeNameCheck() {
			let regex6 = /^[가-힣\s]+$/; //(매장명) 한글, 공백 허용
			let storeName = document.getElementById("storeName").value.trim();
			document.getElementById("storeNameError").innerHTML="";
			
			// 매장명 확인
		  if(!regex6.test(storeName)){
		    document.getElementById("storeNameError").innerHTML="매장명이 올바르지 않습니다.";
		    check = false;
		  }
		  else {
			  document.getElementById("storeNameError").innerHTML="";
			  check = true;
		  }
		}
		
		function storeTelCheck() {
			let regex5 = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let storeTel1 = myform.storeTel1.value;
		  let storeTel2 = myform.storeTel2.value;
		  let storeTel3 = myform.storeTel3.value;
		  let storeTel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 매장 전화번호 확인
		  if(storeTel2==="" || storeTel3===""){
		    document.getElementById("storeTelError").innerHTML="전화번호를 입력해주세요.";
		    check = false;
		  }
		  else if(!regex5.test(storeTel)){
		    document.getElementById("storeTelError").innerHTML="전화번호를 완성해주세요.";
		    check = false;
		  }
		  else {
		    document.getElementById("storeTelError").innerHTML="";
		    check = true;
		  }
		}
	</script>
	<style>
		html {scroll-behavior:smooth;}
		
		.text-primary {
			font-size: 0.8em;
			padding:2px 10px;
		}
		.form-control {
			border-radius:70px; 
		}
		.jClick {
			width:100%;
		  max-width: 300px;
	    padding: 15px;
	    border-radius:500px; 
		}
		.btn {
		  background-color: white;
  		border-color: #ffa0c5;
  		color: #ffa0c5;
  		border-width: medium;
		}
		.btn:hover {
			background-color: #ffa0c5;
			color: white;
		}
		.must {
  		color: #ffa0c5;
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
<div class="container-xl p-5 my-5"  id="top">	
	<form name="myform" method="post" action="${ctp}/FranJoinOk.kn_mem" style="width:80%; margin:0px auto">
    <h2 class="text-center" style="margin-bottom:50px">매장 회원가입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디 <span class="must">*</span> &nbsp; &nbsp;<input type="button" value="아이디 중복체크" class="btn btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" onchange="midCheck()" placeholder="아이디를 입력하세요." required autofocus/>
    	<div id="midError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="pwd1">비밀번호 <span class="must">*</span></label>
      <input type="password" class="form-control" maxlength=20 name="pwd1" id="pwd1" onchange="pwd1Check()" placeholder="비밀번호를 입력하세요." required />
      <div id="pwdError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="pwd2">비밀번호 확인 <span class="must">*</span></label>
      <input type="password" class="form-control" maxlength=20 name="pwd2" id="pwd2" onchange="pwd2Check()" placeholder="비밀번호를 입력하세요." required />
      <div id="pwdError2" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="name">성명 <span class="must">*</span></label>
      <input type="text" class="form-control" name="name" id="name" onchange="nameCheck()" placeholder="성명을 입력하세요." required />
    	<div id="nameError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="email1" >이메일 <span class="must">*</span></label>
        <div class="input-group mb-1">
          <input type="text" class="form-control" id="email1" name="email1" onblur="emailCheck()" placeholder="Email을 입력하세요." required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
    	<div id="emailError" class="text-primary"></div>
      <input type="hidden" name="email" id="email"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-1">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 <span class="must">*</span></span> &nbsp;&nbsp;
            <select name="tel1" name="tel1" id="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
            </select>  -
        </div>
        <input type="number" name="tel2" id="tel2" size=4 maxlength=4 oninput='handleOnInput(this, 4)' class="form-control inputs"/>  -
        <input type="number" name="tel3" id="tel3" size=4 maxlength=4 oninput='handleOnInput(this, 4)' onchange="telCheck()" class="form-control inputs"/>
    	  <input type="hidden" name="tel" id="tel"/>
      </div>
      <div id="telError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <label for="birthday">생년월일 <span class="must">*</span></label>
			<input type="date" name="birthday" id="birthday" onchange="birthdayCheck()" class="form-control"/>
			<div id="birthError" class="text-primary"></div>
    </div>    
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 </span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자">남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="미 선택" checked>미선택
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="name">매장명 <span class="must">*</span> &nbsp; &nbsp;<input type="button" value="매장명 중복체크" class="btn btn-sm" onclick="storeCheck()"/></label>
      <input type="text" class="form-control" name="storeName" id="storeName" onchange="storeNameCheck()" placeholder="매장명을 입력하세요." required />
    	<div id="storeNameError" class="text-primary"></div>
    </div>
    <div class="form-group">
      <div class="input-group mb-1">
        <div class="input-group-prepend">
          <span class="input-group-text">매장 전화번호 <span class="must">*</span></span> &nbsp;&nbsp;
            <select name="storeTel1" id="storeTel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="070">070</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
            </select>  -
        </div>
        <input type="number" name="storeTel2" id="storeTel2" size=4 maxlength=4 oninput='handleOnInput(this, 4)' class="form-control inputs"/>  -
        <input type="number" name="storeTel3" id="storeTel3" size=4 maxlength=4 oninput='handleOnInput(this, 4)' onbl="storeTelCheck()" class="form-control inputs"/>
    	  <input type="hidden" name="storeTel" id="storeTel"/>
      </div>
      <div id="storeTelError" class="text-primary"></div>
    </div>    
    <div class="form-group">
      <label for="address">매장 주소 <span class="must">*</span></label>
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
      <div id="addressError" class="text-primary"></div>
    </div>
  	<hr/>
  	<small style="color:red; margin-top:15px">별(*) 표시는 필수 입력사항입니다.</small>
		<div class="text-center" style="margin: 50px 0px">
    	<button type="button" onclick="joinCheck()" class="jClick" style="background-color:#FFDB7E; border:none; color:brown">회원가입</button>
      <input type="hidden" name="memType" value="매장"/>
  	</div>
  </form>
</div>
<footer>
	<jsp:include page="/include/footer.jsp" />
</footer>
</body>
</html>