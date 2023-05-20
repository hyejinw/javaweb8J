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
		    				
		    				// $(input).val(rowData.mid);
		    			})
		    		}
		    },
 			
		    columns: [
  				{data: "idx"},
  				{
  					data: "mid",
						render: function(data) {
  						if(data != "") {
	  						return '<button class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#modifyClick">'+data+'</a>'
  						}
  					}
  				},
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
	  						return '<font color="blue"><b>'+data+'</b></font>'
  						}
  						else {
	  						return '<font color="red"><b>'+data+'</b></font>'
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
			
			
			
			
			
	/* 		
 			// 값 수정용		
			let table = $('#memberTable').DataTable();
			
			// 마우스 클릭 이벤트를 잡아낸다.
			$('#memberTable tbody').on('click','td',function() {
				let cell = table.cell(this);
				clickCellInputId = cell.index().row;
				console.log('clickCellInputId : ',clickCellInputId);
			});
			 */
			
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

		function memberModify(){
			let ans = confirm('수정하시겠습니까?');
			if(!ans) return false;
			
/* 		  let idx =	$('#idx').val(),
			let mid =	$('#mid').val();
			let name =	$('#name').val();
			let email =	$('#email').val();
			let tel =	$('#tel').val();
			let birthday =	$('#birthday').val();
			let address =	$('#address').val();
			let gender = $('#gender').val();
			let memType =	$('#memType').val();
			let level =	$('#level').val();
			let levelStartDate =	$('#levelStartDate').val();
			let levelExpireDate =	$('#levelExpireDate').val();
			let totCnt =	$('#totCnt').val();
			let todayCnt =	$('#todayCnt').val();
			let firstVisit =	$('#firstVisit').val();
			let lastVisit =	$('#lastVisit').val();
			let memberDel =	$('#memberDel').val();
		 */
		  let idx =	memberForm.idx.value
			let mid =	memberForm.mid.value;
			let name =	memberForm.name.value;
			let email =	memberForm.email.value;
			let tel =	memberForm.tel.value;
			let birthday =	memberForm.birthday.value;
			let address =	memberForm.address.value;
			let gender =	memberForm.gender.value;
			let memType =	memberForm.memType.value;
			let level =	memberForm.level.value;
			let levelStartDate =	memberForm.levelStartDate.value;
			let levelExpireDate =	memberForm.levelExpireDate.value;
			let totCnt =	memberForm.totCnt.value;
			let todayCnt =	memberForm.todayCnt.value;
			let firstVisit =	memberForm.firstVisit.value;
			let lastVisit =	memberForm.lastVisit.value;
			let memberDel =	memberForm.memberDel.value;
		
      let query = {
    		  idx : idx,
    		  mid : mid,
    		  name : name,
    		  email : email,
    		  tel : tel,
    		  birthday : birthday,
    		  address : address,
    		  gender : gender,
    		  memType : memType,
    		  level : level,
    		  levelStartDate : levelStartDate,
    		  levelExpireDate : levelExpireDate,
    		  totCnt : totCnt,
    		  todayCnt : todayCnt,
    		  firstVisit : firstVisit,
    		  lastVisit : lastVisit,
    		  memberDel : memberDel
      } 
      
      $.ajax({
          type: "post",
          url: "${ctp}/AdminMemModifyOK.kn_ad",
          data: query,
          success: function(res){
              if(res == 1){
                  alert("수정 완료");
                  location.reload();
              }
              else{
                  alert("수정 실패");
              }
          },
          error:function(){
              alert("전송 오류");
          }
      });
    }
	</script>
</head>
<body>
	<div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">회원 수정</span></div>
		<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red">수정할 아이디를 클릭하세요</span></div>
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
	
	  <!-- The Modal -->
  <div class="modal fade" id="modifyClick">
    <div class="modal-dialog modal-dialog-centered modal-lg">  <!--modal-lg 로 할까?  -->
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 상세 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
    		<div class="modal-body">
      		<form name="memberForm">
		      	<div class="row mb-2">
		      		<div class="col-sm-6">고유번호: <input type="text" name="idx" id="idx" readonly class="form-control" style="background-color:#ECF2FF"/></div>
		      		<div class="col-sm-6">아이디: <input type="text" name="mid" id="mid" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6">성명: <input type="text" name="name" id="name" class="form-control"/></div>
		      		<div class="col-sm-6">이메일: <input type="text" name="email" id="email" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-4">
		      		<div class="col-sm-6">전화번호: <input type="text" name="tel" id="tel" class="form-control"/></div>
		      		<div class="col-sm-6">생년월일: <input type="text" name="birthday" id="birthday" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm text-left">주소: <input type="text" name="address" id="address" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col">
				        성별 : 
				         <select name="gender" id="gender" class="form-control mb-2">
				            <option value="여성">여성</option>
				            <option value="남성">남성</option>
				            <option value="미선택">미선택</option>
				        </select>
		      		</div>
		      	</div>
		      	<div class="row">
		      		<div class="col-sm-6">
				        회원 종류 : 
				        <select name="memType" id="memType" class="form-control mb-2">
				            <option value="개인">개인</option>
				            <option value="매장">매장</option>
				        </select>
		      		</div>
		      		<div class="col-sm-6">
				      	멤버십 레벨 : 
				        <select name="level" id="level" class="form-control mb-4">
				            <option value="0">관리자</option>
				            <option value="1">매장회원</option>
				            <option value="2">옐로우스마일</option>
				            <option value="3">민트스마일</option>
				            <option value="4">퍼플스마일</option>
				        </select>
		      		</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6">멤버십 시작 날짜: <input type="text" name="levelStartDate" id="levelStartDate" class="form-control"/></div>
		      		<div class="col-sm-6">멤버십 만료 날짜: <input type="text" name="levelExpireDate" id="levelExpireDate" class="form-control"/></div>
		      	</div>      	
		      	<div class="row mb-2">
		      		<div class="col-sm-6">총 방문 수: <input type="number" name="totCnt" id="totCnt" class="form-control"/></div>
		      		<div class="col-sm-6">오늘 방문 수: <input type="number" name="todayCnt" id="todayCnt" class="form-control"/></div>
		      	</div>      
		      	<div class="row mb-2">
		      		<div class="col-sm-6">가입일: <input type="text" name="firstVisit" id="firstVisit" class="form-control"/></div>
		      		<div class="col-sm-6">마지막 방문일: <input type="text" name="lastVisit" id="lastVisit" class="form-control"/></div>
		      	</div>      
		      	<div class="row mb-2">
		      		<div class="col-sm-6">탈퇴 신청 여부: <input type="text" name="memberDel" id="memberDel" readonly style="background-color:#ECF2FF" class="form-control"/></div>
		      		<div class="col-sm-6">&nbsp;&nbsp;<input type="button" value="수정" onclick="memberModify()" class="btn btn-success form-control"/></div>
		      	</div>
      		</form>      
    	  </div>
        
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>
