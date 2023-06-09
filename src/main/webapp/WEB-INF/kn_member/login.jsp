<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>login</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
		@import url(https://fonts.googleapis.com/css?family=Raleway:400,100,200,300);
		#container {font-size: 1.2em;}
		
		form .checkbox {
	    margin: 1em 0;
	    padding: 20px;
	    visibility: hidden;
	    text-align: left;
		}
		form .checkbox:checked + label:after {
	    -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
	    filter: alpha(opacity=100);
	    opacity: 1;
		}
		form label[for] {
	    position: relative;
		  padding-left: 15px;
	    cursor: pointer;
		}
		label[for]:before {
	    position: absolute;
	    width: 17px;
	    height: 17px;
	    top: 0px;
	    left: -14px;
	    content: '';
	    border: 1px solid #5A6374;
		}
		label[for]:after {
	    position: absolute;
	    top: 1px;
	    left: -10px;
	    width: 15px;
	    height: 8px;
	    -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	    filter: alpha(opacity=0);
	    opacity: 0;
	    content: '';
	    background-color: transparent;
	    border: solid #04BEBD;
	    border-width: 0 0 3px 3px;
	    -webkit-transform: rotate(-45deg);
	    -moz-transform: rotate(-45deg);
	    -o-transform: rotate(-45deg);
	    transform: rotate(-45deg);
		}
		
		
		.form-control {
			border-radius:100px; 
			margin-top: -5px;
		}
		.btn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
		.btn2 {
			width:100%;
		  max-width: 170px;
	    padding: 15px;
	    border-radius:500px; 
		}
		small {
			color:#282828;
		}
		small:hover {
			color:gray;
			text-decoration:none;
		}
	</style>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div id="container">
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">로그인</h2>
		<form name="myform" method="post" action="${ctp}/LoginOk.kn_mem" style="margin-top:50px">
			<div class="form-group" style="margin:0px auto; padding-top:50px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center">아이디</div>
					<div class="col-md-9"><input type="text" class="form-control" name="mid" id="mid" value="${cMid}" placeholder="아이디를 입력해주세요" autofocus required /></div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center">비밀번호</div>
					<div class="col-md-9"><input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" required/></div>
				</div>
				<hr/>
				<div class="row" style="margin:30px 0px">
					<div class="col-md-4 text-right p-0"><input type="checkbox" name="idSave" id="remember_me" class="checkbox" checked /><label for="remember_me"><small>&nbsp; 아이디 저장</small></label></div>
					<div class="col-md-8 text-right">
						<a href="${ctp}/IdFinder.kn_mem" class="text-decoration-none"><small>아이디 찾기</small></a>&nbsp;&nbsp;|&nbsp;
		    		<a href="${ctp}/PwdFinder.kn_mem" class="text-decoration-none"><small>비밀번호 찾기</small></a>
			    </div>
				</div>
				<div class="row text-center" style="margin-bottom:10px">
					<div class="col"><button type="submit" class="btn" style="background-color:#FFDB7E; font-size: 1em;">로그인</button></div>
				</div>
				<div class="row text-center" style="margin-bottom:10px">
					<div class="col pr-1 text-right"><button type="button" onclick="location.href='${ctp}/Join.kn_mem';" class="btn2" style="background-color:#ffa0c5; font-size: 1em; border-color:#ffa0c5; color:black">회원가입</button></div>
					<div class="col pl-1 text-left"><button type="button" onclick="location.href='${ctp}/FranJoin.kn_mem';" class="btn2" style="background-color:#000; font-size: 1em; color:white">매장회원가입</button></div>
				</div>
			</div>
		</form>
	</div>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>