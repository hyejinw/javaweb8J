<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMemModify.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	
<!-- 관리자 페이지 용 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="//cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/> 
	<style>
		body {
			font-family: 'SUITE-Regular';
		}
		#c { 
	    font-size: 15px;
	    margin: 100px 60px 0px 40px;
	  }
	</style>
	
	<script>
		/* $(document).ready(function() { 이렇게 적어도 된다!! */
		jQuery(function($){
			$('#memberTable').DataTable({
				responsive: true,
		     "ajax": {
		        "url" : '${ctp}/AdminMemListOK.kn_ad'
		     },
		    columns: [
  				{data: "idx"},
  				{data: "mid"},
  				{data: "name"},
  				{data: "email"},
  				{data: "tel"},
  				{data: "birthday"},
  				{data: "address"},
  				{data: "gender"},
  				{data: "memType"},
  				{data: "level"},
  				{data: "levelStartDate"},
  				{data: "levelExpireDate"},
  				{data: "totCnt"},
  				{data: "todayCnt"},
  				{data: "firstVisit"},
  				{data: "lastVisit"},
  				{data: "memberDel",
  					render: function(data) {
  						if(data == "NO") {
	  						return data
  						}
  						else {
	  						return '<font color="red">'+data+'</font>'
  						}
  					}
  					
  			  }
		    ],
		    
		    columnDefs: [
		    	{targets:0, width:5},
		    	{targets:16, width:20},
		    	/* {"sClass": "badge badge-success", "aTargets":[4]} */
		    ],
		    
		    scrollX: 100,
		    scrollY: 500,
		    
		    "language": {
	        "emptyTable": "데이터가 없어요.",
	        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
	        "info": "현재 _START_ - _END_ / _TOTAL_건",
	        "infoEmpty": "데이터 없음",
	        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
	        "search": "에서 검색: ",
	        "zeroRecords": "일치하는 데이터가 없어요.",
	        "loadingRecords": "로딩 중...",
	        "processing":     "잠시만 기다려 주세요...",
	        "paginate": {
	            "next": "다음",
	            "previous": "이전"
	        }
		    },
		    createdRow: function (row, data, dataIndex, full) {
					// <tr>에 접근하여 속성값 부여하기
		        $(row).attr('id', data.name);
		        $(row).attr('name', data.todayCnt);
		        
		        // <tr>의 <td>에 접근하여 조작하기
/* 		        $(row).children('td:nth-child(17)').attr('class', 'badge badge-success'); */
		        $(row).children('td').css('background-color', 'white');
		        $(row).children('td:nth-child(17)').text();
				 },
		    
			});
			
			// 값 수정		
			let table = $('#memberTable').DataTable();
			let preClickedTD = null;
			
			// 마우스 클릭 이벤트를 잡아낸다.
			$('#memberTable tbody').on('click','td',function() {
				let ans = confirm('값을 변경하시겠습니까?');
				if(!ans) return false;
			
				if(preClickedTD) {
					
					// 선택 상태에서 원상복귀
					returnTdToOriginal(preClickedTD);
				}
			
				let cell = table.cell(this);
				let clickCellData = cell.data();
				let clickCellInputId = 'td_'+ cell.index().row + '_' + cell.index().column;
				
				let inputData = '<input type="text" id="'+clickCellInputId+'" style="width:150px" />';
				cell.data(inputData).draw();
				cell.inputID = clickCellInputId;
				
				$('#'+clickCellInputId).val(clickCellData);
				$('#'+clickCellInputId).focus();
				preClickedTD = cell;
				
			});
			
			function returnTdToOriginal(preClickedTD) {
				preClickedTD.data($('#'+preClickedTD.inputID).val());
			}
			
			
	    $('#memberTable_filter').prepend('<select id="select"></select>');
	    $('#memberTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#memberTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#memberTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

	/*     $('.dataTables_filter input').unbind().bind('keyup', function () {
	        var colIndex = document.querySelector('#select').selectedIndex;
	        table.column(colIndex).search(this.value).draw();
	    }); */
	    
		});

		
		
		function falseClick() {
			alert('해당 회원은 삭제처리 불가능합니다.');
		}
	</script>
</head>
<body>
	<div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">회원 수정</span></div>
		<button class="btn btn-danger text-left mb-4" onclick="location.href='${ctp}/AdminMemList.kn_ad';">회원 조회창</button> 
    <table id="memberTable" class="table table-hover table-bordered ">
			<thead>
				<tr style="background-color:#FFF4D2">
					<th class="text-center">No</th>
					<th class="text-center">아이디</th>
					<th class="text-center">성명</th>
					<th class="text-center">이메일</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">생년월일</th>
					<th class="text-center">주소</th>
					<th class="text-center">성별</th>
					<th class="text-center">회원 종류</th>
					<th class="text-center">멤버십 레벨</th>
					<th class="text-center">멤버십 시작 날짜</th>
					<th class="text-center">멤버십 만료 날짜</th>
					<th class="text-center">총 방문</th>
					<th class="text-center">오늘 방문</th>
					<th class="text-center">가입일</th>
					<th class="text-center">마지막 방문일</th>
					<th class="text-center">탈퇴신청</th>
				</tr>
			</thead>
			<tbody class="text-center">
			</tbody>
    </table>
	</div>
</body>
</html>
