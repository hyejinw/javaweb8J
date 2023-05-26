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
	    margin: 100px 60px 200px 40px;
	  }
	</style>
	
	<script>
		/* $(document).ready(function() { 이렇게 적어도 된다!! */
		jQuery(function($){
			
			let table = $('#resvTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/AdminResvListOK.kn_ad',
	    		
		    		complete: function(data) {
		    			$('#resvTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
		    				$('#idx').val(rowData.idx);
		    				$('#memMid').val(rowData.memMid);
		    				$('#storeIdx').val(rowData.storeIdx);
		    				$('#storeName').val(rowData.storeName);
		    				$('#menuIdx').val(rowData.menuIdx);
		    				$('#menuName').val(rowData.menuName);
		    				$('#couponIdx').val(rowData.couponIdx);
		    				$('#menuCnt').val(rowData.menuCnt);
		    				$('#menuPrice').val(rowData.menuPrice);
		    				$('#pickupDate').val(rowData.pickupDate);
		    				$('#pickupOk').val(rowData.pickupOk);
		    			})
		    		}
		     },

		    columns: [
  				{
  					data: "idx",
  					render: function(data) {
  						return '<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#deleteClick">'+data+'</button>'
  					}
  				},  					
  				{data: "memMid"},
  				{data: "storeIdx"},
  				{data: "storeName"},
  				{data: "menuIdx"},
  				{data: "menuName"},
  				{data: "couponIdx"},
  				{data: "menuCnt"},
  				{data: "menuPrice"},
  				{data: "pickupDate"},
  				{data: "pickupOk"}
		    ],
		    
		    columnDefs: [
		    	{targets:0, width:5}
		    ],
/* 		    
		    scrollX: 100,
		    scrollY: 500, */
		    
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
			
	    $('#resvTable_filter').prepend('<select id="select"></select>');
	    $('#resvTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#resvTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#resvTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

	    
		});

		function resvDel() {
			let adminPwd = resvDelForm.pwd.value;
			let idx = resvDelForm.idx.value;
			let pickupOk = resvDelForm.pickupOk.value;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;				
			}
			
 			if(pickupOk == 'NO') {
				alert('매장에서 아직 픽업 확정을 하지 않았습니다. 삭제가 불가능합니다.');
				return false;				
			}
			
			let ans = confirm('삭제하시겠습니까?');
			if(!ans) return false;
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminResvDelOK.kn_ad",
	          data: {idx : idx},
	          success: function(res){
	              if(res == 1){
	                  alert("삭제 완료");
	                  location.reload();
	              }
	              else{
	                  alert("삭제 실패");
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
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">예약 조회</span></div>
		<div style="text-align:center"  class="mb-5"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">고유번호를 누르시면, 예약 삭제가 가능합니다.</span></div>
    <table id="resvTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
					<th class="text-center">No</th>
					<th class="text-center">회원 아이디</th>
					<th class="text-center">매장번호</th>
					<th class="text-center">매장명</th>
					<th class="text-center">메뉴번호</th>
					<th class="text-center">메뉴명</th>
					<th class="text-center">쿠폰번호</th>
					<th class="text-center">메뉴 개수</th>
					<th class="text-center">총 가격</th>
					<th class="text-center">예약/픽업 날짜</th>
					<th class="text-center">픽업 유무</th>
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
          <h4 class="modal-title text-center">예약 삭제창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<form name="resvDelForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 예약을 삭제하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" id="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx"/>
		      		<input type="hidden" name="pickupOk" id="pickupOk"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:resvDel()">삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	

</body>
</html>
