<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMemList.jsp</title>
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
			
			let table = $('#memberTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/AdminMemListOK.kn_ad',
	    		
		    		complete: function(data) {
		    			$('#memberTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
		    				$('#idx').val(rowData.idx);
		    				$('#mid').val(rowData.mid);
		    				$('#name').val(rowData.name);
		    				$('#email').val(rowData.email);
		    				$('#tel').val(rowData.tel);
		    				$('#birthday').val(rowData.birthday);
		    				$('#address').val(rowData.address);
		    				$('#gender').val(rowData.gender);
		    				$('#memType').val(rowData.memType);
		    				$('#level').val(rowData.level);
		    				$('#levelStartDate').val(rowData.levelStartDate);
		    				$('#levelExpireDate').val(rowData.levelExpireDate);
		    				$('#totCnt').val(rowData.totCnt);
		    				$('#todayCnt').val(rowData.todayCnt);
		    				$('#firstVisit').val(rowData.firstVisit);
		    				$('#lastVisit').val(rowData.lastVisit);
		    				$('#memberDel').val(rowData.memberDel);
		    				
		    			})
		    		}
		     },

		    columns: [
  				{data: "idx"},
  				{data: "mid"},
  				{data: "name"},
  				{data: "email"},
  				{data: "tel"},
  				{
  					data: "birthday",
   					render: function(data) {
  						data = data.substring(0,10);
  						return data
						}   	
					},
  				{
  					data: "address",
						render: function(data) {
							let regExp = /^(?=.*[0-9])[0-9/\s]$/g; // 숫자 1개 이상 필수, /와 공백 허용
							
  						if(!regExp.test(data)) {
	  						return ''
  						}
  						else {
	  						return data
  						}
  					}  					
  				},
  				{
  					data: "gender",
						render: function(data) {
  						if(data == "미선택") {
	  						return ''
  						}
  						else {
	  						return data
  						}
  					}    					
  				},
  				{data: "memType"},
  				{data: "level"},
  				{data: "levelStartDate"},
  				{data: "levelExpireDate"},
  				{data: "totCnt"},
  				{data: "todayCnt"},
  				{data: "firstVisit"},
  				{data: "lastVisit"},
  				{
  					data: "memberDel",
  					render: function(data) {
  						if(data == "NO") {
	  						return '<button class="btn btn-primary btn-sm" onclick="falseClick()" >'+data+'</a>'
  						}
  						else {
	  						return '<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteClick">'+data+'</button>'
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
		    }/* ,
		    createdRow: function (row, data, dataIndex, full) {
					// <tr>에 접근하여 속성값 부여하기
		        $(row).attr('id', data.name);
		        $(row).attr('name', data.todayCnt);
		        
		        // <tr>의 <td>에 접근하여 조작하기
 		        $(row).children('td:nth-child(17)').attr('class', 'badge badge-success'); 
		        $(row).children('td').css('background-color', 'white');
		        $(row).children('td:nth-child(17)').text();
				 }, */
		    
			});
			
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
		
		function memberDel() {
			let adminPwd = memberDelForm.pwd.value;
			let idx = memberDelForm.idx.value;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;				
			}
			let ans = confirm('삭제하시겠습니까?');
			if(!ans) return false;
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminMemberDelOK.kn_ad",
	          data: {idx : idx},
	          success: function(res){
	              if(res == 1){
	                  alert("탈퇴 완료");
	                  location.reload();
	              }
	              else{
	                  alert("탈퇴 실패");
	              }
	          },
	          error:function(){
	              alert("전송 오류");
	          }
	      });
			}
		}
	</script>
</head>
<body>
 	<div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">회원 조회</span></div>
		<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">탈퇴 처리 가능창</span></div>
		<button class="btn btn-success text-left mb-4" onclick="location.href='${ctp}/AdminMemModify.kn_ad';">회원 수정창</button>
    <table id="memberTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
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
	
  <!-- The Modal -->
  <div class="modal fade" id="deleteClick">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">회원 탈퇴 승인창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<form name="memberDelForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 회원을 탈퇴 처리하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" id="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:memberDel()">탈퇴 승인</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	
</body>
</html>
