<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
ul.adminAuth > li:hover{
	background-color: yellow;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-6">
        <h2>코드관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>코드관리(제품분류)</strong>
            </li>
        </ol>
    </div> -->
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
	   	<div class="ibox">
      		<div class="ibox-content border_n pd-no">
           		<div class="clear">

					<div class="mg-b20">
				         <ul class="nav nav-tabs">
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeIndustrySegmentManage.do');">산업분류 코드</a></li>
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codePartnerSegmentManage.do');">파트너사분류 코드</a></li>
				             <!-- <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeVendorSolutionAreaManage.do');">솔루션분류 코드</a></li> -->
				             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeOurProductInfoManage.do');">제품분류 코드</a></li>
				         </ul>
				     </div>
				     
				     <table id="codeOurProductInfoManage"></table>
				     <div class="func-top-right fl_r pd-b10">
					    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="codeOurProductInfoManage.insert();">신규등록</button>
					    <button type="button" class="btn btn-outline btn-gray-outline" onClick="codeOurProductInfoManage.update();">저장하기</button>
					 </div>
    
    			<!-- <table id="codeOurProductInfoManage"></table>
			    <button type="button" onClick="codeOurProductInfoManage.insert();">신규등록</button>
			    <button type="button" onClick="codeOurProductInfoManage.update();">저장하기</button> -->
			    
			    </div>
		    </div>
	    </div>

	</div>
</div>
</body>


<script type="text/javascript">
$(document).ready(function(){
	codeOurProductInfoManage.init();
});

var codeOurProductInfoManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$codeOurProductInfoManage = $("#codeOurProductInfoManage");
			codeOurProductInfoManage.lastEdit = 0;
			codeOurProductInfoManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $codeOurProductInfoManage.jqGrid('getGridParam', 'records');
 			$codeOurProductInfoManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			codeOurProductInfoManage.saveRow();
			$.ajax({
				url : "/admin/updateOurProductInfo.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				OurProductInfoList : JSON.stringify($codeOurProductInfoManage.getRowData())	
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						//codeOurProductInfoManage.reload();
						window.location.reload();
					}
				},
				complete : function(){
					
				}
			});
		},
		
		deleteProduct : function(productNo, rownum){
			if(!productNo){
				codeOurProductInfoManage.delRow(rownum);
				return;
			}
			$.ajax({
				url : "/admin/deleteOurProductInfo.do",
				datatype : 'json',
				data : {
					PRODUCT_NO : productNo,
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("삭제하시겠습니까?")){
						lastEditRowQ = 0;
						return false;
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("삭제되었습니다.");
						lastEditRowQ = 0;
						codeOurProductInfoManage.reload();
					}else if(result.cnt == -1){
						alert("연관된 데이터가 있어 삭제 할 수 없습니다.\n관리자에게 문의하세요.");
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		delRow : function(rownum){
			$codeOurProductInfoManage.jqGrid('delRowData', rownum);
		},
		
		//그리드 그리기
		draw : function() {
			$codeOurProductInfoManage.jqGrid({
				url : '/admin/selectOurProductInfoAll.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "selectOurProductInfoAll",
				},  
				colModel : [ {
					label : '제품번호',
					name : 'PRODUCT_NO',
					align : "left",
					editable: true,
					width : 30,
					hidden : true
				},{
					label : '품목코드',
					name : 'PRODUCT_CODE',
					align : "left",
					editable: true,
					width : 30
				},{
					label : '품목',
					name : 'PRODUCT',
					align : "left",
					editable: true,
					width : 30
				},{
					label : '품목명',
					name : 'PRODUCT_NAME',
					align : "left",
					editable: true,
					width : 100
				},{
					label : '공장코드',
					name : 'WORKS_CODE',
					align : "left",
					editable: true,
					width : 30
				},{
					label : '규격',
					name : 'PRODUCT_STANDARD',
					align : "left",
					editable: true,
					width : 30
				},{
					label : '사용여부',
					name : 'USE_YN',
					align : "center",
					width : 30,
					edittype:"select",
					formatter:'select',
					editable: true,
					editoptions:{
						value:"Y:Y;N:N", //대소문자 유의!
					}
				},{
					label : '삭제',
					name : '',
					align : "center",
					width : 30,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='codeOurProductInfoManage.deleteProduct("+colpos.PRODUCT_NO+", "+cellval.rowId+");'><i class='fa fa-trash-o fa-lg'></i></a>"; 
					}
				}
				],
				rowNum : 200,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',codeOurProductInfoManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					codeOurProductInfoManage.lastEdit = id;
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
		},
		
		clear : function(){
			$codeOurProductInfoManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$codeOurProductInfoManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectOurProductInfoAll.do',
	 				mtype: 'POST',
	 				postData : {
		 				use_yn : null
		 			},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $codeOurProductInfoManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$codeOurProductInfoManage.jqGrid('saveRow', i);
			}
			$codeOurProductInfoManage.jqGrid('saveRow', codeOurProductInfoManage.lastEdit);
		}
			
		
}

function moveCodePage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
