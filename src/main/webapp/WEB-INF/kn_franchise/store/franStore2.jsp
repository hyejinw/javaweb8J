<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>franStore.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	
<!-- 관리자 페이지 용 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="//cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/> 
	<style>
		body {
			font-family: 'SUITE-Regular';
		}
		.c { 
      font-size: 15px;
      margin: 100px 60px 200px 40px;
	  }
	  div.dataTables_wrapper {
        margin-bottom: 3em;
    }
	</style>
	
	<script>
		/* $(document).ready(function() { 이렇게 적어도 된다!! */
		jQuery(function($){
			
			let table = $('#FranTable').DataTable({
				responsive: true,
	   	  "ajax": {
          "url" : '${ctp}/FranStoreOk.kn_fr',
        
          complete: function(data) {
            $('#menuTable > tbody').on('click', 'tr', function (e) {
              const rowData = table.row(this).data()
              console.log('클릭한 행 데이터', rowData);
              $('#idx').val(rowData.idx);
              $('#memIdx').val(rowData.memIdx);
              $('#storeName').val(rowData.storeName);
              $('#storeTel').val(rowData.storeTel);
              $('#storeAddress').val(rowData.storeAddress);
              $('#storePhoto').val(rowData.storePhoto);
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
	        {data: "menuEngName"},
	        {data: "storeTel"},
	        {data: "storeAddress"},
	        {data: "storePhoto"},
	        {data: "opHour"},
	        {
	        	data: "storeMenu",
	          render: function(data) {
              return '<span style="font-size:9px">'+data+'</span>'
	          } 
	        },
	        {data: "storeRate"},
	        {data: "storeModify"},
	        {
	        	data: "storeOpen",
	          render: function(data) {
	            if(data == "NO") {
	              return '<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#openClick" >'+data+'</a>'
	            }
	            else {
	              return '<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#closeClick">'+data+'</button>'
	            }
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
	        {targets:10, width:20},
	        {targets:11, width:20},
	        /* {"sClass": "badge badge-success", "aTargets":[4]} */
	      ],		    
			  
	      scrollX: 200,
	      scrollY: 800,
			  
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
			

			function menuClose() {
				
				let adminPwd = menuCloseForm.pwd.value;
				let idx = menuCloseForm.idx.value;
				let sw = menuCloseForm.sw.value;
				
				if(adminPwd != '1234') {
					alert('관리자 비밀번호 오류입니다.');
					return false;			
				}
				let ans = confirm('비공개하시겠습니까?');
				if(!ans) return false;			
				
				else {
		      $.ajax({
		          type: "post",
		          url: "${ctp}/AdminMenuCloseOK.kn_ad",
		          data: {idx : idx, sw : sw},
		          success: function(res) {
		              if(res == 1){
		                  alert("비공개 처리 완료");
		                  location.reload();
		              }
		              else{
		                  alert("비공개 처리 실패");
		              }
		          },
		          error:function(){
		              alert("전송 오류");
		          }
		      });
				}
			} 	 
			
			
		function menuOpen() {
			
			let adminPwd = menuOpenForm.pwd.value;
			let idx = menuOpenForm.idx.value;
			let sw = menuOpenForm.sw.value;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;			
			}
			let ans = confirm('공개하시겠습니까?');
			if(!ans) return false;			
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminMenuOpenOK.kn_ad",
	          data: {idx : idx, sw : sw},
	          success: function(res) {
	              if(res == 1){
	                  alert("공개 처리 완료");
	                  location.reload();
	              }
	              else{
	                  alert("공개 처리 실패");
	              }
	          },
	          error:function(){
	              alert("전송 오류");
	          }
	      });
			}
		} 
		function menuDel() {
			
			let adminPwd = menuDelForm.pwd.value;
			let idx = menuDelForm.idx.value;
			let menuPhoto = menuDelForm.menuPhoto.value;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;			
			}
			let ans = confirm('삭제하시겠습니까?');
			if(!ans) return false;			
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminMenuDelOK.kn_ad",
	          data: {idx : idx, menuPhoto : menuPhoto},
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
  <div class="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">메뉴 조회</span></div>
		<div style="text-align:center">
			<span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">
				메뉴 공개/삭제 처리 가능창<br/>
			  댓글 수를 클릭하면 댓글 관리창으로 이동합니다.
			</span>
		</div>
		<button class="btn btn-success text-left mb-4" onclick="location.href='${ctp}/FranInfoModify.kn_fr';">정보 수정창</button>
    <table id="FranTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
					<th class="text-center">매장번호</th>
					<th class="text-center">매장회원 고유번호</th>
					<th class="text-center">매장명</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">주소</th>
					<th class="text-center">매장 사진</th>
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
	
  <!-- The Modal -->
  <div class="modal fade" id="openClick">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">메뉴 공개창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
       <!--  Modal body -->
        <div class="modal-body">
        	<form name="menuOpenForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 메뉴를 공개하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx1"/>
		      		<input type="hidden" name="sw" id="sw1" value="OK"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:menuOpen()">메뉴 공개</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div> 
	
  <!-- The Modal -->
  <div class="modal fade" id="closeClick">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">메뉴 비공개창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!--  Modal body -->
        <div class="modal-body">
          <form name="menuCloseForm">
            <div class="row mb-4">
              <div class="col-sm text-danger">해당 메뉴를 비공개하시려면 관리자 비밀번호를 입력해주세요.</div>
            </div>
            <div class="row mb-2">
              <div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" class="form-control"/></div>
              <input type="hidden" name="idx" id="idx2"/>
              <input type="hidden" name="sw" id="sw2" value="NO"/>
            </div>
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:menuClose()">메뉴 비공개</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div> 


  <!-- The Modal -->
  <div class="modal fade" id="deleteClick">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">메뉴 삭제창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!--  Modal body -->
        <div class="modal-body">
        	<form name="menuDelForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 메뉴를 삭제하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx3"/>
		      		<input type="hidden" name="menuPhoto" id="menuPhoto"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:menuDel()">메뉴 삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	
	
</body>
</html>
