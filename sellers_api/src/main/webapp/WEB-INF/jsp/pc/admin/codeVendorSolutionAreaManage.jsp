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
    <!-- <div class="col-sm-6">
        <h2>코드관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>코드관리(솔루션분류)</strong>
            </li>
        </ol>
    </div> -->
</div>

	<br /><br />
	<div class="mg-b20">
         <ul class="nav nav-tabs">
             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeIndustrySegmentManage.do');">산업분류 코드</a></li>
             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codePartnerSegmentManage.do');">파트너사분류 코드</a></li>
             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeVendorSolutionAreaManage.do');">솔루션분류 코드</a></li>
         </ul>
     </div>
    
    <table id="codeVendorSolutionAreaManage"></table>
    <button type="button" onClick="codeVendorSolutionAreaManage.insert();">신규등록</button>
    <button type="button" onClick="codeVendorSolutionAreaManage.update();">저장하기</button>
    
</div>
</div>
</body>


<script type="text/javascript">
$(document).ready(function(){
	codeVendorSolutionAreaManage.init();
});

var codeVendorSolutionAreaManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$codeVendorSolutionAreaManage = $("#codeVendorSolutionAreaManage");
			codeVendorSolutionAreaManage.lastEdit = 0;
			codeVendorSolutionAreaManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $codeVendorSolutionAreaManage.jqGrid('getGridParam', 'records');
 			$codeVendorSolutionAreaManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			codeVendorSolutionAreaManage.saveRow();
			$.ajax({
				url : "/admin/updateVendorSolutionArea.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				vendorSolutionAreaList : JSON.stringify($codeVendorSolutionAreaManage.getRowData())	
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						//codeVendorSolutionAreaManage.reload();
						window.location.reload();
					}
				},
				complete : function(){
					
				}
			});
		},
		
		//그리드 그리기
		draw : function() {
			$codeVendorSolutionAreaManage.jqGrid({
				url : '/admin/selectVendorSolutionAreaAll.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "selectVendorSolutionAreaAll",
				},  
				colModel : [ {
					label : '제조사',
					name : 'PRODUCT_VENDOR',
					align : "left",
					editable: true,
					width : 30
				}, {
					label : '제품그룹',
					name : 'PRODUCT_GROUP',
					align : "left",
					editable: true,
					width : 200
				}, {
					label : '솔루션 영역',
					name : 'SOLUTION_AREA',
					align : "left",
					width : 200,
					editable: true
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
					label : 'SOLUTION_ID',
					name : 'SOLUTION_ID',
					editable: true,
					hidden : true,
					width : 30
				}
				],
				rowNum : 200,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',codeVendorSolutionAreaManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					codeVendorSolutionAreaManage.lastEdit = id;
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
			$codeVendorSolutionAreaManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$codeVendorSolutionAreaManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectVendorSolutionAreaAll.do',
	 				mtype: 'POST',
	 				postData : {
		 				use_yn : null
		 			},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $codeVendorSolutionAreaManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$codeVendorSolutionAreaManage.jqGrid('saveRow', i);
			}
			$codeVendorSolutionAreaManage.jqGrid('saveRow', codeVendorSolutionAreaManage.lastEdit);
		}
			
		
}

function moveCodePage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
