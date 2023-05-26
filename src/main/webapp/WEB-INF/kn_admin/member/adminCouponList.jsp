<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminCouponList.jsp</title>
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
			
			let table = $('#couponTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/AdminCouponListOK.kn_ad',
	    		
		    		complete: function(data) {
		    			$('#couponTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
		    				$('#idx').val(rowData.idx);
		    				$('#memMid').val(rowData.memMid);
		    				$('#level').val(rowData.level);
		    				$('#levelExpireDate').val(rowData.levelExpireDate);
		    				$('#coupon').val(rowData.coupon);
		    				$('#couponStartDate').val(rowData.couponStartDate);
		    				$('#couponExpireDate').val(rowData.couponExpireDate);
		    				$('#couponDel').val(rowData.couponDel);
		    				$('#couponUsed').val(rowData.couponUsed);
		    				$('#couponUsedDate').val(rowData.couponUsedDate);
		    				
		    			})
		    		}
		     },

		    columns: [
  				{data: "idx"},
  				{data: "memMid"},
  				{
  					data: "level",
  					render: function(data) {
  						if(data == "2") {
	  						return '<span>레벨1) 옐로우 스마일</span>'
  						}
  						else if(data == "3") {
	  						return '<span>레벨2) 민트 스마일</span>'
  						}
  						else {
	  						return '<span>레벨3) 퍼플 스마일</span>'
  						}
  					}
  				},
  				{
  					data: "levelExpireDate",
  					render: function(data) {
  						return '<font color="blue">'+data+'</font>'
  					}
  				},
  				{
  					data: "coupon",
  					render: function(data) {
  						if(data == "1") {
	  						return '<span>쿠폰1) 도넛 무료쿠폰 (1장, 4800원)</span>'
  						}
  						else if(data == "2") {
	  						return '<span>쿠폰2) 생일축하도넛 무료쿠폰 (1장, 4800원)</span>'
  						}
  						else if(data == "3") {
	  						return '<span>쿠폰3) 베이커리 무료쿠폰 (1장, 6500원)</span>'
  						}
  						else {
	  						return '<span>쿠폰4) 케이크 무료쿠폰 (1장, 23000원)</span>'
  						}
  					}
  				},
  				{data: "couponStartDate"},
  				{data: "couponExpireDate"},
  				{
  					data: "couponDel",
  					render: function(data) {
  						if(data == "NO") {
	  						return '<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#deleteClick">'+data+'</button>'
  						}
  					}
  				},
  				{
  					data: "couponUsed",
  					render: function(data) {
  						if(data == "사용") {
	  						return '<font color="red">'+data+'</font>'
  						}
  						else {
	  						return data
  						}
  					}
  				},
  				{data: "couponUsedDate"},
		    ],
		    
 		    columnDefs: [
		    	{targets:0, width:5},
		    ], 
		    /* 
		    scrollX: 100,
		     */
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
			
 	    $('#couponTable_filter').prepend('<select id="select"></select>');
	    $('#couponTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#couponTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#couponTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

/*      $('.dataTables_filter input').unbind().bind('keyup', function () {
	        var colIndex = document.querySelector('#select').selectedIndex;
	        table.column(colIndex).search(this.value).draw();
	    }); */ 
	    
		});

		function couponDel() {
			let adminPwd = couponDelForm.pwd.value;
			let idx = couponDelForm.idx.value;
			let levelExpireDate = couponDelForm.levelExpireDate.value;
			let level = couponDelForm.level.value;
			let coupon = couponDelForm.coupon.value;
			let couponUsed = couponDelForm.couponUsed.value;
			let couponExpireDate = couponDelForm.couponExpireDate.value;
			
			// 현재 날짜 시간 구하기
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
			var dateString = year + '-' + month  + '-' + day;

			var hours = ('0' + today.getHours()).slice(-2); 
			var minutes = ('0' + today.getMinutes()).slice(-2);
			var seconds = ('0' + today.getSeconds()).slice(-2); 
			var timeString = hours + ':' + minutes  + ':' + seconds;
			
			let todayDate = dateString + " " + timeString;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;				
			}
			
 			if(couponUsed == '미사용' || couponExpireDate > todayDate) {
				alert('미사용 쿠폰이거나, 쿠폰 만료일 전입니다. 해당 쿠폰은 삭제하실 수 없습니다.');
				return false;				
			}
			
			if(((level==2 && coupon==1) || (level==3 && coupon==3) || (level==4 && (coupon==4 || coupon==3)) ) && levelExpireDate > todayDate) {
				alert('멤버십 만료 전입니다. 해당 쿠폰은 삭제하실 수 없습니다.');
				return false;				
			}
			
			let ans = confirm('삭제하시겠습니까?');
			if(!ans) return false;
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminCouponDelOK.kn_ad",
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
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">쿠폰 조회</span></div>
		<div style="text-align:center" class="mb-5"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">
			멤버십 쿠폰은 쿠폰 및 멤버십 만료일 후에, 삭제 가능합니다.<br/>
			옐로우 - 쿠폰1) / 민트 - 쿠폰3) / 퍼플 - 쿠폰3 & 4)
		</span></div>
    <table id="couponTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF;">
					<th class="text-center">No</th>
					<th class="text-center">아이디</th>
					<th class="text-center">멤버십 레벨</th>
					<th class="text-center">멤버십 만료일</th>
					<th class="text-center">쿠폰 종류</th>
					<th class="text-center">쿠폰 발행일</th>
					<th class="text-center">쿠폰 만료일</th>
					<th class="text-center">삭제 유무</th>
					<th class="text-center">사용 유무</th>
					<th class="text-center">쿠폰 사용일</th>
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
          <h4 class="modal-title text-center">쿠폰 삭제창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<form name="couponDelForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 쿠폰을 삭제하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" id="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx"/>
		      		<input type="hidden" name="levelExpireDate" id="levelExpireDate"/>
		      		<input type="hidden" name="level" id="level"/>
		      		<input type="hidden" name="coupon" id="coupon"/>
		      		<input type="hidden" name="couponUsed" id="couponUsed"/>
		      		<input type="hidden" name="couponExpireDate" id="couponExpireDate"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:couponDel()">삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	
</body>
</html>