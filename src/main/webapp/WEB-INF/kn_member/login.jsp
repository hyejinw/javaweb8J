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
		input[type="checkbox"]{
    	display: none;
    }
		input[type="checkbox"] + label{
      display: inline-block;
      width: 20px;
      height: 20px;
      border:3px solid #707070;
      position: relative;
    }
		input[id="idSave"]:checked + label::after{
      content:'✔';
      font-size: 15px;
      width: 20px;
      height: 20px;
      text-align: center;
      position: absolute;
      left: -3px;
      top: -5px;
    }
		.form-control {
			border-radius:100px; 
			margin-top: -5px;
		}
		.btn {
			width:100%;
		  max-width: 300px;
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
	<div class="container-xl p-5 my-5" style="margin-top:100px">
	<h2 class="text-center" style="margin:0px auto;">로그인</h2>
		<form name="myform" method="post" action="${ctp}/LoginOk.kn_mem" style="margin-top:50px">
			<div class="form-group" style="margin:0px auto; padding-top:50px; width:60%"> <!-- 이 부분 추후에 반응형 사이즈로 재조절 필요 -->
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center"><label for="mid">아이디</label></div>
					<div class="col-md-9"><input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요" autofocus required /></div>
				</div>
				<div class="row">
					<div class="col"><div id="midError" class="text-left text-danger"></div></div>
				</div>
				<div class="row" style="margin-bottom:30px">
					<div class="col-md-3 text-center"><label for="pwd">비밀번호</label></div>
					<div class="col-md-9"><input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" required/></div>
				</div>
				<div class="row">
					<div class="col"><div id="midError" class="text-left text-danger"></div></div>
				</div>
				<hr/>
				<div class="row" style="margin:30px 0px">
					<div class="col-md-2 text-right p-0"><input type="checkbox" name="idSave" id="idSave" checked /><label for="idSave"></label></div>
					<div class="col-md-2 text-left p-0"><small class="">&nbsp; 아이디 저장</small></div>
					<div class="col-md-8 text-right">
						<a href="${ctp}/IdFinder.kn_mem" class="text-decoration-none"><small>아이디 찾기</small></a>&nbsp;&nbsp;|&nbsp;
		    		<a href="${ctp}/PwdFinder.kn_mem" class="text-decoration-none"><small>비밀번호 찾기</small></a>
			    </div>
				</div>
				<div class="row text-center" style="margin-bottom:10px">
					<div class="col"><button type="submit" class="btn" style="background-color:#FFDB7E">로그인</button></div>
				</div>
				<div class="row text-center" style="margin-bottom:10px">
					<div class="col"><button type="button" onclick="location.href='${ctp}/Join.kn_mem';" class="btn" style="background-color:#000; color:white">회원가입</button></div>
				</div>
			</div>
		</form>
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>