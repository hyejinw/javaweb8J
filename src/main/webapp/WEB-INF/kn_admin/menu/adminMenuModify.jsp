<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminMenuList.jsp</title>
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
			
			let table = $('#menuTable').DataTable({
				responsive: true,
	   	  "ajax": {
          "url" : '${ctp}/AdminMenuListOK.kn_ad',
        
          complete: function(data) {
            $('#menuTable tbody').on('click', 'tr', function (e) {
              const rowData = table.row(this).data()
              console.log('클릭한 행 데이터', rowData);
              $('#idx').val(rowData.idx);
              $('#category').val(rowData.category);
              $('#menuName').val(rowData.menuName);
              $('#menuEngName').val(rowData.menuEngName);
              $('#price').val(rowData.price);
              $('#explanation').val(rowData.explanation);
              $('#allergy').val(rowData.allergy);
              $('#origin').val(rowData.origin);
              $('#menuPhoto').val(rowData.menuPhoto);
              $('#menuStartDate').val(rowData.menuStartDate);
              $('#menuOpen').val(rowData.menuOpen);
              $('#menuDel').val(rowData.menuDel);
            })
          }
        },
	      columns: [
	      	{data: "idx"},
	        {data: "category"},
	        {
	        	data: "menuName",
						render: function(data) {
							if(data != "") {
	  						return '<button class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#modifyClick">'+data+'</a>'
							}
						}
					},	        	
	        {data: "menuEngName"},
	        {data: "price"},
	        {
	        	data: "explanation",
	          render: function(data) {
              return '<span style="font-size:12px">'+data+'</span>'
	          } 
	        },
	        {
	        	data: "allergy",
	          render: function(data) {
              return '<span style="font-size:13px">'+data+'</span>'
	          } 
	        },
	        	   					
	        {
	        	data: "origin",
	          render: function(data) {
              return '<span style="font-size:10px">'+data+'</span>'
	          } 
	        },
	        {
	        	data: "menuPhoto",
	          render: function(data) {
              return '<span style="font-size:12px">'+data+'</span>'
	          } 
	        },
	        {data: "menuStartDate"},
	        {
	          data: "menuOpen",
	          render: function(data) {
	            if(data == "NO") {
	              return '<font color="blue"><b>'+data+'</b></font>'
	            }
	            else {
	              return '<font color="red"><b>'+data+'</b></font>'
	            }
	          }
	        },
	        {
	          data: "menuDel",
	          render: function(data) {
	            if(data == "NO") {
	              return '<font color="blue"><b>'+data+'</b></font>'
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
		});
			
    $('#memuTable_filter').prepend('<select id="select"></select>');
    $('#memuTable > thead > tr').children().each(function (indexInArray, valueOfElement) { 
        $('#select').append('<option>'+valueOfElement.innerHTML+'</option>');
    });
    $('#memuTable_filter').prepend('<input type="text" id="toDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;">');
    $('#memuTable_filter').prepend('<input type="text" id="fromDate" placeholder="yyyy-MM-dd" style="width:150px; border-radius: 20px;"> ~ ');
    

    
    function menuModify() {
			let ans = confirm('수정하시겠습니까?');
			if(!ans) return false;
      
      var formData = new FormData($('#menuForm')[0]);
      
      $.ajax({
          type: "post",
          enctype: "multipart/form-data",
          url: "${ctp}/AdminMenuModifyOK.kn_ad",
          data: formData,
          cache: false,
          contentType: false,
          processData: false,
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
		
		// 이미지 1장 미리보기
		function imgCheck(input) {
			if(input.files && input.files[0]) { //둘의 표현이 같은 얘기.
				
				let reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('demo').src	= e.target.result;
				}
				reader.readAsDataURL(input.files[0]);  // 이렇게하면 stream 단위 input/output 그거 안 써도 된다.
			}
			else {
				document.getElementById('demo').src = "";
			}
		}
	</script>
</head>
<body>
  <div id="c">
		<div style="text-align:center"><span class="text-center" style="font-size:40px; text-align:center; font-weight:500">메뉴 수정</span></div>
		<div style="text-align:center"><span class="text-center" style="font-size:15px; text-align:center; font-weight:300; color:red">수정할 메뉴명을 클릭하세요</span></div>
		<button class="btn btn-danger text-left mb-4" onclick="location.href='${ctp}/AdminMenuList.kn_ad';">메뉴 조회창</button>
    <table id="menuTable" class="table table-hover table-bordered">
			<thead>
				<tr style="background-color:#FFF4D2">
					<th class="text-center">No</th>
					<th class="text-center">카테고리</th>
					<th class="text-center">메뉴명</th>
					<th class="text-center">영문 메뉴명</th>
					<th class="text-center">가격</th>
					<th class="text-center">설명</th>
					<th class="text-center">알레르기 유발 요인</th>
					<th class="text-center">원산지 정보</th>
					<th class="text-center">메뉴 사진</th>
					<th class="text-center">시작 날짜</th>
					<th class="text-center">공개 유무</th>
					<th class="text-center">삭제 여부</th>
				</tr>
			</thead>
			<tbody class="text-center">
			</tbody>
    </table>
	</div>

  <!-- The Modal -->
  <div class="modal fade" id="modifyClick">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title text-center">메뉴 상세 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
       <!--  Modal body -->
        <div class="modal-body">
        	<form name="menuForm" id="menuForm" method="post" enctype="multipart/form-data">
		      	<div class="row mb-2">
		      		<div class="col-sm-6">고유번호: <input type="text" name="idx" id="idx" readonly class="form-control" style="background-color:#ECF2FF"/></div>
		      		<div class="col-sm-6">
				        카테고리 : 
				         <select name="category" id="category" class="form-control mb-2">
				            <option value="도넛">도넛</option>
				            <option value="케이크">케이크</option>
				            <option value="베이커리">베이커리</option>
				        </select>
		      		</div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm-6">메뉴명: <input type="text" name="menuName" id="menuName" class="form-control"/></div>
		      		<div class="col-sm-6">영문 메뉴명: <input type="text" name="menuEngName" id="menuEngName" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-3">
		      		<div class="col-sm-6">가격: <input type="number" name="price" id="price" class="form-control"/></div>
		      		<div class="col-sm-6">알레르기 유발 요인: <input type="text" name="allergy" id="allergy" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-3">
		      		<div class="col-sm text-left">설명: <input type="text" name="explanation" id="explanation" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-4">
		      		<div class="col-sm text-left">원산지 정보: <textarea rows="10" name="origin" id="origin" class="form-control"></textarea></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm text-left">등록 날짜: <input type="text" name="menuStartDate" id="menuStartDate" class="form-control"/></div>
		      	</div>
		      	<div class="row mb-2">
		      		<div class="col-sm text-left">메뉴 사진: <input type="file" name="menuPhotoModified" onchange="imgCheck(this)" class="form-control-file border form-control"/></div>
		      	</div>
						<div class="row mb-4">
							<div class="col"><img id="demo" width="200px" /></div>
						</div>		      	
						<input type="hidden" name="menuPhoto" id="menuPhoto"/>  <!-- 기존 사진은 삭제하고 수정해야 해서 보낸다. -->
	        </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" onclick="javascript:menuModify()">수정</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div> 
	
	
</body>
</html>
