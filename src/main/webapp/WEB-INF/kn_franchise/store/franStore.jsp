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
			
			let table = $('#franTable').DataTable({
				responsive: true,
	   	  "ajax": {
          "url" : '${ctp}/FranStoreOk.kn_fr',
        
          complete: function(data) {
            $('#franTable > tbody').on('click', 'tr', function (e) {
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
              $('#replyCount').val(rowData.replyCount);
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
	        {data: "opHour"},
	        {data: "storeMenu" },
	        {data: "storeRate"},
	        {data: "replyCount"},
	        {data: "storeModify"},
	        {
	        	data: "storeOpen",
	        	render: function(data) {
	        		if(data == "NO") {
	        			return '<button class="btn btn-primary btn-sm" onclick="javascript:falseOpen();" >'+data+'</a>'
	        		}
	        		else {
	        			return '<span class="text-danger">'+data+'</span>'
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
	      ]
	    });
			
		});
		
		function falseOpen() {
			alert('초기 세팅 완료하시면, 관리자가 공개처리 해드립니다.');
		}
		
		function storeDel() {
			
			let memIdx = storeDelForm.memIdx.value;
			let storeTel = storeDelForm.storeTel.value;
			let storeTelInput = storeDelForm.storeTelInput.value;
			console.log('storeTel : ' + storeTel);
			console.log('storeTelInput : ' + storeTelInput);
			
			if(storeTel != storeTelInput) {
				alert('매장 전화번호 입력 오류입니다.');
				return false;			
			}
			let ans = confirm('정말 삭제하시겠습니까? 1달동안 같은 아이디로 재가입 불가능합니다.'); 
			if(!ans) return false;			
			
			storeDelForm.submit();
		} 		
	</script>
</head>
<body>
  <div class="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">매장 조회</span></div>
		<div style="text-align:center">
			<span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">
				매장 삭제 처리 가능창<br/>
				매장을 비공개처리 하려면 관리자에게 문의해주세요.
			</span>
		</div>
		<button class="btn btn-success text-left mb-4" onclick="location.href='${ctp}/FranInfoModify.kn_fr';">정보 수정창</button>
    <table id="franTable" class="table table-hover table-bordered">
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
					<th class="text-center">댓글 수</th>
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
  <div class="modal fade" id="deleteClick">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">매장 탈퇴창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!--  Modal body -->
        <div class="modal-body">
        	<form name="storeDelForm" method="post" action="${ctp}/FranStoreDel.kn_fr">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">매장을 삭제하시면 매장회원도 자동 탈퇴됩니다.<br/>매장을 삭제하시려면 매장 전화번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">매장 전화번호(- 포함): <input type="text" name="storeTelInput" class="form-control"/></div>
		      		<input type="hidden" name="memIdx" id="memIdx"/>
		      		<input type="hidden" name="storeTel" id="storeTel"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:storeDel()">매장 삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>	
	
</body>
</html>
