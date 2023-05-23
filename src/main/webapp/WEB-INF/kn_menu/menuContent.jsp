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
		#replyForm fieldset{
		    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
		    direction: rtl; /* 이모지 순서 반전 */
		    border: 0; /* 필드셋 테두리 제거 */
		}
		#replyForm fieldset legend{
		    text-align: left;
		}
		#replyForm input[type=radio]{
		    display: none; /* 라디오박스 감춤 */
		}
		#replyForm label{
		    font-size: 1.2em; /* 이모지 크기 */
		    color: transparent; /* 기존 이모지 컬러 제거 */
		    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
		}
		#replyForm label:hover{
		    text-shadow: 0 0 0 #FFD95A; /* 마우스 호버 */
		}
		#replyForm label:hover ~ label{
		    text-shadow: 0 0 0 #FFD95A; /* 마우스 호버 뒤에오는 이모지들 */
		}
		#replyForm input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 #FFD95A; /* 마우스 클릭 체크 */
		}
	</style>
	<script>
  	// 댓글 달기(ajax로 처리)
  	function replyCheck() {
  		let m_ReplyContent = $("#m_ReplyContent").val();
  	
  		if(${level} > 5) {
  			alert("로그인이 필요합니다.");
  			location.href="${ctp}/Login.kn_mem";
  			return false;
  		}
  		
  		if(m_ReplyContent.trim() == ""){
  			alert("댓글을 입력하세요");
  			$("#m_ReplyContent").focus();
  			return false;
  		}
  		
  		var formData = new FormData($('#replyForm')[0]);
  		
  		$.ajax({
  			type : 'post',
  			enctype: "multipart/form-data",
  			url : '${ctp}/MenuReplyInput.kn_menu',
  			data : formData,
        cache: false,
        contentType: false,
        processData: false,
  			success : function(res) {
  				if(res == '1') {
  					alert('댓글이 입력되었습니다.');
  					location.reload();
  				}
  				else {
  					alert('댓글이 입력되지 않았습니다.');
  				}
  			},
  			error : function() {
					alert("전송되지 못했습니다.");  				
  			}
  		});
  	}
  	
  	// 댓글 삭제(ajax이용)
  	function replyDelete(replyIdx, menuIdx) {
  		let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
  		if(!ans) return false;
  		
 			$.ajax({
 				type : 'post',
 				url : '${ctp}/MenuReplyDelete.kn_menu',
 				data : {replyIdx : replyIdx, menuIdx : menuIdx},
 				success : function(res) {
 					if(res == '1') {
  					alert('댓글이 삭제되었습니다.');
  					location.reload();
 					}
 					else {
  					alert('댓글이 삭제되지 않았습니다.');
  					location.reload();
 					}
 				},
 				error : function() {
 					alert('전송되지 못했습니다.');
 				}
 			});
  	}
  	
  	// 좋아요 누르기
  	function goodCheck(idx,menuIdx) {
  		location.href = "${ctp}/MenuGood.kn_menu?idx="+idx+"&menuIdx="+menuIdx;
  	}
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<div style="background-color: rgba(253, 250, 247, 0.8); padding-bottom:300px">
		<div class="container text-center" style="padding:100px 0px">
			<h2><b style="color: #282828;">메뉴안내</b></h2>
		</div>
		<div class="container">
			<div class="row" style="margin-bottom:150px">
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
		</div>
		
					  <!-- 댓글 입력창 -->
	  <div class="container">
		  <form name="replyForm" id="replyForm" method="post" enctype="multipart/form-data" style="margin-bottom:70px">
		  	<table class="table table-center">
		  		<tr>
		  			<td style="width:75%" class="text-left">   <!-- 이렇게 비율로 설정해주면 반응형으로 바뀐다. -->
		  				<textarea rows="4" name="m_ReplyContent" id="m_ReplyContent" class="form-control"></textarea>
		  			</td>
		  			<td style="width:25%" class="text-center">
		  				<br/>
				    	<span style="font-size:1.3em">평점</span>&nbsp;&nbsp;
					    <fieldset>
				        <input type="radio" name="m_ReplyRate" value="5" id="rate1"><label for="rate1">⭐</label>
				        <input type="radio" name="m_ReplyRate" value="4" id="rate2"><label for="rate2">⭐</label>
				        <input type="radio" name="m_ReplyRate" value="3" id="rate3"><label for="rate3">⭐</label>
				        <input type="radio" name="m_ReplyRate" value="2" id="rate4"><label for="rate4">⭐</label>
				        <input type="radio" name="m_ReplyRate" value="1" id="rate5"><label for="rate5">⭐</label>
				   	 </fieldset>
		  			</td>
		  		</tr>
		  		<tr>
		  			<td style="width:75%" class="text-left">   <!-- 이렇게 비율로 설정해주면 반응형으로 바뀐다. -->
		  				<input type="file" name="m_ReplyPhoto" id="m_ReplyPhoto" class="form-control"/>
		  			</td>
		  			<td style="width:25%" class="text-center">
		  				<input type="button" value="댓글 달기" onclick="replyCheck()" class="btn btn-info"/>
		  				<input type="hidden" name="menuIdx" value="${vo.idx}" />
		  				<input type="hidden" name="memMid" value="${sMid}" />
		  				<input type="hidden" name="m_ReplyHostIp" value="${pageContext.request.remoteAddr}" />
		  			</td>
		  		</tr>
		  	</table>
		  </form>
		
	  <!-- 댓글 리스트 보여주기 -->
	  	<span style="font-size:1.8em" class="m-3">댓글</span><hr/>
  		<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
				<div class="row mt-3">
					<div class="col" style="font-size:1.4em">
  					<c:if test="${sMid == replyVo.memMid || sLevel == 0}">
  						<a href="javascript:replyDelete(${replyVo.idx}, ${replyVo.menuIdx})"><span class="badge badge-pill badge-danger">❌</span></a>
  					</c:if>&nbsp;
  					${replyVo.memMid}
						<span style="font-size:0.6em">&nbsp;&nbsp;${fn: substring (replyVo.m_ReplyDate,0,10)}</span>
						<span style="font-size:0.7em">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:goodCheck(${replyVo.idx}, ${replyVo.menuIdx})"><i class="fa-regular fa-thumbs-up" style="color: #65d435; font-size:25px"></i></a> (${replyVo.m_ReplyGood})</span>
						<div style="font-size:0.8em; margin-left:60px">
						<c:if test="${replyVo.m_ReplyRate == 0}">☆☆☆☆☆</c:if>
						<c:if test="${replyVo.m_ReplyRate == 1}">★☆☆☆☆</c:if>
						<c:if test="${replyVo.m_ReplyRate == 2}">★★☆☆☆</c:if>
						<c:if test="${replyVo.m_ReplyRate == 3}">★★★☆☆</c:if>
						<c:if test="${replyVo.m_ReplyRate == 4}">★★★★☆</c:if>
						<c:if test="${replyVo.m_ReplyRate == 5}">★★★★★</c:if>
						
						(${replyVo.m_ReplyRate})</div>
					</div>
				</div>
				<div class="row">
					<c:if test="${replyVo.m_ReplyPhoto != ''}">
						<div class="col text-left" style="margin: 20px 0px 20px 60px">
							<img src="${ctp}/images/kn_menuReply/${replyVo.m_ReplyPhoto}" style="width:150px"/>
						</div>
						</div>
						<div class="row">
						<div class="col text-left" style="margin: 20px 0px 20px 60px">
							<span style="font-size:1em;">${fn: replace(replyVo.m_ReplyContent, newLine, "<br/>")}</span>
						</div>
					</c:if>
					<c:if test="${replyVo.m_ReplyPhoto == ''}">
						<div class="col" style="margin: 20px 0px 20px 60px">
							<span style="font-size:1em;">${fn: replace(replyVo.m_ReplyContent, newLine, "<br/>")}</span>
						</div>
					</c:if>
				</div>
				<hr/>	
  		</c:forEach>
	  </div>
	  
	  
	</div>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>