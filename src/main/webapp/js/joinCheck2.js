/* joinCheck() */ 
  
// 가입부분 체크
function joinCheck(){
	const regex1 = /^[a-zA-Z0-9]{3,19}/g; //(아이디) 영문자 또는 숫자 4~20자 
	const regex2 = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}/g; //(비밀번호)4자 이상 20자 이하, 영어, 숫자, 특수문자
	const regex3 = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;  // (닉네임)2자 이상 16자 이하, 영어 또는 숫자 또는 한글
	const regex4 = /[A-Za-z가-힣]/g;  // (성명)한글,영문만 적어도 1자이상 
	const regex5 = /^[0-9a-zA-Z]+/g; // 이메일

  let mid = document.getElementById("mid").value.trim();
  let pwd1 = document.getElementById("pwd1").value.trim();
  let pwd2 = document.getElementById("pwd2").value.trim();
  let nickName = document.getElementById("nickName").value.trim();
  let name = document.getElementById("name").value.trim();
  let email1 = document.getElementById("email1").value.trim();
  let tel2 = document.getElementById("tel2").value.trim();
  let tel3 = document.getElementById("tel3").value.trim();
  let check = true;
	
  // 아이디 확인
  if(mid===""){
	  console.log('여기는 아이디 체크용',mid);
    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자 4~20자)"
    check = false;
    
  }
  else if(!regex1.test(mid)) {
	  	console.log('여기는 아이디 체크용22',mid);
    	document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요222.(영어/숫자 4~20자)"
    	check = false;
    
	} else{
	  document.getElementById("midError").innerHTML="";
	  check = true;
  }
 	
  
  // 비밀번호 확인
  if(pwd1==="" || !regex2.test(pwd1)){
    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수,특수문자 허용 4~20자)";
    check = false;
  }
  else if(pwd2===""){
    document.getElementById("pwdError2").innerHTML="비밀번호를 다시 입력해주세요.";
    check = false;
  }
  else if(pwd1 !== pwd2){
    document.getElementById("pwdError").innerHTML="";
    document.getElementById("pwdError2").innerHTML="비밀번호가 동일하지 않습니다.";
    check = false;
  }
  else {
    document.getElementById("pwdError").innerHTML="";
    document.getElementById("pwdError2").innerHTML="";
    check = true;
  }
  

  // 닉네임 확인 
  if(nickName==="" || !regex3.test(nickName)){
    document.getElementById("nickNameError").innerHTML="닉네임 형식에 맞춰주세요.(영어/숫자/한글 2~16자)";
    check = false;
  }
  else {
    document.getElementById("nickNameError").innerHTML="";
  }
  
  // 성명 확인
  if(name==="" || !regex4.test(name)){
    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문 1자이상)";
    check = false;
  }
  else {
    document.getElementById("nameError").innerHTML="";
  }
  
  // 이메일 확인
  if(email1==="" || !regex5.test(email1)){
    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
    check = false;
  }
  else {
    document.getElementById("emailError").innerHTML="";
  }

  // 전화번호 확인
  if(tel2==="" || tel3===""){
    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
    check = false;
  }
  else if(tel2.length!==4 || tel3.length!==4){
    document.getElementById("telError").innerHTML="전화번호를 완성해주세요.";
    check = false;
  }
  else {
    document.getElementById("telError").innerHTML="";
  }
  
  if(!check){
	  alert('입력된 값을 다시 확인해주세요.');
	  window.scrollTo(0,100); // (그냥 위치만 바뀌는)스크롤 위로 올리기 
	 
/*		let scrollTopBtn = document.getElementById('top');
		
		scrollTopBtn.addEventListener('click',function(){
		    window.scrollTo({top: 0, behavior:'smooth'});
		});*/
  }
  else {
    document.getElementById("midError").innerHTML="";
    document.getElementById("pwdError").innerHTML="";
    document.getElementById("pwdError2").innerHTML="";
    document.getElementById("nickNameError").innerHTML="";
    document.getElementById("nameError").innerHTML="";
    document.getElementById("emailError").innerHTML="";
    document.getElementById("telError").innerHTML="";
   	myform.submit();
  }
}