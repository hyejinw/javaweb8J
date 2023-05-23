<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminStoreList.jsp</title>
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
	    margin: 100px 60px 200px 40px;
	  }
	</style>
	
	<script>
		jQuery(function($){
			
			let table = $('#storeTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/AdminStoreListOk.kn_ad',
	    		
		    		complete: function(data) {
		    			$('#storeTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
	              $('#idx').val(rowData.idx);
	              $('#memIdx').val(rowData.memIdx);
	              $('#storeName').val(rowData.storeName);
	              $('#storeTel').val(rowData.storeTel);
	              $('#storeAddress').val(rowData.storeAddress);
	              $('#storePhoto').val(rowData.storePhoto);
	              $('#location').val(rowData.location);
	              $('#opHour').val(rowData.opHour);
	              $('#storeMenu').val(rowData.storeMenu);
	              $('#storeRate').val(rowData.menuRate);
	              $('#storeModify').val(rowData.storeModify);
	              $('#storeOpen').val(rowData.storeOpen);
	              $('#storeDel').val(rowData.storeDel);
		    			})
		    		}
		     },

	      columns: [
	      	{data: "idx"},
	        {data: "memIdx"},
	        {data: "storeName"},
	        {data: "storeTel"},
	        {data: "storeAddress"},
	        {data: "storePhoto"},
	        {data: "location"},
	        {data: "opHour"},
	        {data: "storeMenu" },
	        {data: "storeRate"},
	        {data: "storeModify"},
	        {
	        	data: "storeOpen",
	        	render: function(data) {
	        		return '<button class="btn btn-primary btn-sm" onclick="javascript:falseOpen();" >'+data+'</a>'
	        	}
	        },
	        {
	        	data: "storeDel",
	        	render: function(data) {
	            if(data == "NO") {
	              return '<button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#deleteClick">'+data+'</button>'
	            }
	          }
        	}
	      ],
		    
		    columnDefs: [
		    	{targets:0, width:5},
		    	{targets:16, width:20},
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
	            "next": "▶",
	            "previous": "◀"
	        }
		    }
			});
			
	    $('#memberTable_filter').prepend('<select id="select"></select>');
	    $('#memberTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#memberTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#memberTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

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
    <table id="storeTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
					<th class="text-center">매장번호</th>
					<th class="text-center">매장회원 고유번호</th>
					<th class="text-center">매장명</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">주소</th>
					<th class="text-center">매장 사진</th>
					<th class="text-center">지도</th>
					<th class="text-center">영업시간</th>
					<th class="text-center">가능 메뉴</th>
					<th class="text-center">총 평점</th>
					<th class="text-center">수정 중 유무</th>
					<th class="text-center">공개 유무</th>
					<th class="text-center">삭제 여부</th>
				</tr>
			</thead>
			<tbody class="text-center">
			</tbody>
    </table>
	</div>
	
	
</body>
</html>
