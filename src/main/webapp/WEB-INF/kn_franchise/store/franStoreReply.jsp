<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminStoreReply.jsp</title>
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
			
			let table = $('#storeReplyTable').DataTable({
				responsive: true,
	   	  "ajax": {
		        "url" : '${ctp}/FranStoreReplyOK.kn_fr',
	    		
		    		complete: function(data) {
		    			$('#storeReplyTable tbody').on('click', 'tr', function (e) {
		    				const rowData = table.row(this).data()
		    				console.log('클릭한 행 데이터', rowData);
		    				$('#idx').val(rowData.idx);
		    				$('#storeIdx').val(rowData.storeIdx);
		    				$('#memMid').val(rowData.memMid);
		    				$('#s_ReplyContent').val(rowData.s_ReplyContent);
		    				$('#s_ReplyRate').val(rowData.s_ReplyRate);
		    				$('#s_ReplyGood').val(rowData.s_ReplyGood);
		    				$('#s_ReplyPhoto').val(rowData.s_ReplyPhoto);
		    				$('#s_ReplyDate').val(rowData.s_ReplyDate);
		    				$('#s_ReplyHostIp').val(rowData.s_ReplyHostIp);
		    			})
		    		}
		     },

		    columns: [
  				{data: "idx"},  					
  				{data: "storeIdx"},
  				{data: "memMid"},
  				{data: "s_ReplyContent"},
  				{data: "s_ReplyRate"},
  				{data: "s_ReplyGood"},
  				{data: "s_ReplyPhoto"},
  				{data: "s_ReplyDate"},
  				{data: "s_ReplyHostIp"}
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
			
	    $('#storeReplyTable_filter').prepend('<select id="select"></select>');
	    $('#storeReplyTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
	        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
	    });
	    $('#storeReplyTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
	    $('#storeReplyTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');

	    
		});

	</script>
</head>
<body>
 	<div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">매장 댓글 조회</span></div>
		<div style="text-align:center"  class="mb-5"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:blue">댓글 삭제 및 관련 문의는 관리자에게 남겨주세요</span></div>
    <table id="storeReplyTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#ECF2FF">
					<th class="text-center">No</th>
					<th class="text-center">매장 고유번호</th>
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
</body>
</html>
