<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<style>
	  .bgClass {
	    background-color: pink;
	  }
	  .gray {
	    background-color: #DBDFEA;
	  }
		.settingBtn {
			width:100%;
		  max-width: 350px;
	    padding: 15px;
	    border-radius:500px; 
		}
	</style>
	<script>
	
		// pagelink.js
		function noBack(){
			window.history.forward();
		}
		
		let preGap = '';
		let y = '';
		let m = '';
		let d = '';
		
    function bgColorChange(yy,mm,gap) {
    	console.log("preGap : "+preGap+" , gap : "+gap);
    	if(preGap != "")  $("#bg"+preGap).removeClass('bgClass');
    	preGap = gap;
    	$("#bg"+gap).addClass("bgClass");
    	y = yy;
    	m = mm;
    	d = gap;
    }
    
    function DateSettingCheck() {
    	let time = myform.time.value;
    	if(y=="" || m=="" || d=="") {
    		console.log("y : " + y);
    		Swal.fire('예약 날짜를 선택하세요.');
    		return;
    	}
    	else if(time == "") {
    		Swal.fire('예약 시간을 선택하세요.');
    		return;
    	}
    	else {
	    	location.href = "${ctp}/ResvMenu.kn_re?yy="+y+"&mm="+m+"&dd="+d+"&time="+time+"&idx=${idx}";
    	}
    }
  </script>
</head>
<body 
    onload="noBack();" 
    onpageshow="if(event.persisted) noBack();" 
    onunload="">
<jsp:include page="/include/nav.jsp" />
	<div style="padding:100px 200px 200px; background-color:rgba(253, 250, 247, 0.8)">
		<div class="container text-center" style="margin-bottom:30px">
			<h2><b style="color: #ffa0c5; font-family: 'TheJamsil5Bold';">RESERVATION</b></h2>
		</div>
		<div class="container text-center" style="border-style: solid; border-color: #FFDEB4; padding:70px">
			<h4 class=" text-center mb-5" style="margin-top:50px"><i><span class="badge badge-pill badge-warning">step2</span> 날짜와 시간을 선택해주세요 <i class="fa-solid fa-mug-saucer" style="color: #e68ec6;"></i></i></h4>
			
			
			<div class="row">
				<div class="col-sm-7">
				
					<button type="button" onclick="location.href='${ctp}/ResvDate.kn_re?yy=${yy-1}&mm=${mm}&idx=${idx}';" class="btn btn-secondary btn-sm" title="이전 년도">◁◁</button>
					<button type="button" onclick="location.href='${ctp}/ResvDate.kn_re?yy=${yy}&mm=${mm-1}&idx=${idx}';" class="btn btn-secondary btn-sm" title="이전 월">◀</button>
					<font size="5">${yy}년 ${mm+1}월</font>
					
					<button type="button" onclick="location.href='${ctp}/ResvDate.kn_re?yy=${yy}&mm=${mm+1}&idx=${idx}';" class="btn btn-secondary btn-sm" title="다음 월">▶</button>
					<button type="button" onclick="location.href='${ctp}/ResvDate.kn_re?yy=${yy+1}&mm=${mm}&idx=${idx}';" class="btn btn-secondary btn-sm" title="다음 년도">▷▷</button>
					&nbsp;&nbsp;
					<br/><br/>
					<div class="text-center">
						<table class="table table-bordered" style="height:450px">
							<tr class="table-dark text-dark">
				        <th style="color:red; width:14%; vertical-align:middle">일</th>
				        <th style="width:14%; vertical-align:middle">월</th>
				        <th style="width:14%; vertical-align:middle">화</th>
				        <th style="width:14%; vertical-align:middle">수</th>
				        <th style="width:14%; vertical-align:middle">목</th>
				        <th style="width:14%; vertical-align:middle">금</th>
				        <th style="color:blue; width:14%; vertical-align:middle">토</th>
				      </tr>
				      <tr>
				      	<!-- 시작일 이전을 공백처리한다.(오늘이 월요일이면 startWeek가 2이기에 1칸을 공백처리한다. -->
				      	<c:set var="gap" value="1"/>
				      	<c:forEach begin="1" end="${startWeek - 1}">
				      	  <td>&nbsp;</td>
				      	  <c:set var="gap" value="${gap + 1}"/>
				      	</c:forEach>
				      	
				      	<!-- 해당월에 대한 첫째주 날짜부터 출력하되, gap이 7이되면 줄바꿈한다. -->
				      	<c:forEach begin="1" end="${lastDay}" varStatus="st">
										
									<c:if test="${(startYear==yy && startMonth>(mm+1)) || (startYear==yy && startMonth==(mm+1) && st.count < startDay)}"><td id="td${gap}" class="gray">${st.count}</td></c:if>
									<c:if test="${(lastYear==yy && lastMonth<(mm+1)) || (lastYear==yy && lastMonth==(mm+1) && st.count > lastDayC)}"><td id="td${gap}" class="gray">${st.count}</td></c:if>
									<c:if test="${(startYear==yy && startMonth==(mm+1) && lastMonth==(mm+1)) && (startDay <= st.count && st.count <= lastDayC)}"><td id="bg${st.count}" onclick="bgColorChange(${yy},${mm+1},${st.count})">${st.count}</td></c:if>
									<c:if test="${(lastYear==yy && startMonth != lastMonth && startMonth==(mm+1)) && (startDay <= st.count)}"><td id="bg${st.count}" onclick="bgColorChange(${yy},${mm+1},${st.count})">${st.count}</td></c:if>
									<c:if test="${(lastYear==yy && startMonth != lastMonth && ((mm+1) > startMonth && (mm+1 < lastMonth)))}"><td id="bg${st.count}" onclick="bgColorChange(${yy},${mm+1},${st.count})">${st.count}</td></c:if>
									<c:if test="${(lastYear==yy && startMonth != lastMonth && lastMonth==(mm+1)) && (lastDayC >= st.count)}"><td id="bg${st.count}" onclick="bgColorChange(${yy},${mm+1},${st.count})">${st.count}</td></c:if>
									      	
				      	  <c:if test="${gap % 7 == 0}"></tr><tr></c:if>
				      	  <c:set var="gap" value="${gap + 1}"/>
				      	</c:forEach>
				      </tr>
				    </table>
				    
					</div>
				</div>
				<div class="col-sm-5">
					<form name="myform">
						<select name="time" id="pet-select" size="20">
						    <option value="10:00">10:00</option>
						    <option value="10:30">10:30</option>
						    <option value="11:00">11:00</option>
						    <option value="11:30">11:30</option>
						    <option value="12:00">12:00</option>
						    <option value="12:30">12:30</option>
						    <option value="13:00">13:00</option>
						    <option value="13:30">13:30</option>
						    <option value="14:00">14:00</option>
						    <option value="14:30">14:30</option>
						    <option value="15:00">15:00</option>
						    <option value="15:30">15:30</option>
						    <option value="16:00">16:00</option>
						    <option value="16:30">16:30</option>
						    <option value="17:00">17:00</option>
						    <option value="17:30">17:30</option>
						    <option value="18:00">18:00</option>
						    <option value="18:30">18:30</option>
						    <option value="19:00">19:00</option>
						    <option value="19:30">19:30</option>
						</select>
					</form>
				</div>
			</div>
			
			<div class="row mt-5">
				<div class="col">
					<span style="font-size:20px"><i class="fa-solid fa-circle-exclamation" style="color: #491f51;"></i>&nbsp;&nbsp;&nbsp;예약 주의사항</span><br/>
					<span>예약은 최소 2일 전 ~ 최대 7일 전에만 가능합니다.</span><br/>
					<span>모든 메뉴 함께 픽업 가능한 일정이 노출됩니다.</span>
				</div>
			</div>
	  </div>
	  <div class="text-center">
	  	<button class="settingBtn mt-5" onclick="javascript:DateSettingCheck()" style="background-color:#FFDB7E; font-size:1em;">예약시간 설정하기</button>
		</div>
	</div>	
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>