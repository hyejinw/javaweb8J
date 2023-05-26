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
			
			let table = $('#menuReplyTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/AdminMenuReplyOK.kn_ad',
	    		
		    		complete: function(data) {
		    			$('#menuReplyTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
		    				$('#idx').val(rowData.idx);
		    				$('#menuIdx').val(rowData.menuIdx);
		    				$('#memMid').val(rowData.memMid);
		    				$('#m_ReplyContent').val(rowData.m_ReplyContent);
		    				$('#m_ReplyRate').val(rowData.m_ReplyRate);
		    				$('#m_ReplyGood').val(rowData.m_ReplyGood);
		    				$('#m_ReplyPhoto').val(rowData.m_ReplyPhoto);
		    				$('#m_ReplyDate').val(rowData.m_ReplyDate);
		    				$('#m_ReplyHostIp').val(rowData.m_ReplyHostIp);
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
  				{data: "menuIdx"},
  				{data: "memMid"},
  				{data: "m_ReplyContent"},
  				{data: "m_ReplyRate"},
  				{data: "m_ReplyGood"},
  				{data: "m_ReplyPhoto"},
  				{data: "m_ReplyDate"},
  				{data: "m_ReplyHostIp"}
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
			
	    $('#menuReplyTable_filter').prepend('<select id="select"></select>');
	    $('#menuReplyTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#menuReplyTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#menuReplyTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

	    
		});

		function menuReplyDel() {
			let adminPwd = menuReplyDelForm.pwd.value;
			let idx = menuReplyDelForm.idx.value;
			let menuIdx = menuReplyDelForm.menuIdx.value;
			
			if(adminPwd != '1234') {
				alert('관리자 비밀번호 오류입니다.');
				return false;				
			}
			
			let ans = confirm('작성자가 직접 삭제하지 않은 댓글입니다.\n정말 삭제하시겠습니까?');
			if(!ans) return false;
			
			else {
	      $.ajax({
	          type: "post",
	          url: "${ctp}/AdminMenuReplyDelOK.kn_ad",
	          data: {idx : idx, menuIdx : menuIdx},
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
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">메뉴 댓글 조회</span></div>
		<div style="text-align:center"  class="mb-5"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">고유번호를 누르시면, 댓글 삭제가 가능합니다.</span></div>
    <table id="menuReplyTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
					<th class="text-center">No</th>
					<th class="text-center">메뉴 고유번호</th>
					<th class="text-center">회원 아이디</th>
					<th class="text-center">내용</th>
					<th class="text-center">평점</th>
					<th class="text-center">추천(좋아요)</th>
					<th class="text-center">사진</th>
					<th class="text-center">올린 날짜</th>
					<th class="text-center">IP주소</th>
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
          <h4 class="modal-title text-center">댓글 삭제창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<form name="menuReplyDelForm">
		      	<div class="row mb-4">
		      		<div class="col-sm text-danger">해당 댓글을 삭제하시려면 관리자 비밀번호를 입력해주세요.</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm">관리자 비밀번호: <input type="password" name="pwd" id="pwd" class="form-control"/></div>
		      		<input type="hidden" name="idx" id="idx"/>
		      		<input type="hidden" name="menuIdx" id="menuIdx"/>
		      	</div>
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:menuReplyDel()">삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
	

</body>
</html>
