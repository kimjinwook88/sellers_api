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
                <strong>코드관리(산업분류)</strong>
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
				             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeIndustrySegmentManage.do');">산업분류 코드</a></li>
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codePartnerSegmentManage.do');">파트너사분류 코드</a></li>
				             <!-- <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeVendorSolutionAreaManage.do');">솔루션분류 코드</a></li> -->
				             <!-- <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeOurProductInfoManage.do');">제품분류 코드</a></li> -->
				         </ul>
				     </div>
				     
				    <div class="func-top-right fl_r pd-b10">
					    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="codeIndustrySegmentManage.insert();">신규등록</button>
					    <button type="button" class="btn btn-outline btn-gray-outline" onClick="codeIndustrySegmentManage.update();">저장하기</button>
				    </div>
				    
				    <table id="codeIndustrySegmentManage"></table>
				    
				    <div class="func-top-right fl_r pd-b10">
					    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="codeIndustrySegmentManage.insert();">신규등록</button>
					    <button type="button" class="btn btn-outline btn-gray-outline" onClick="codeIndustrySegmentManage.update();">저장하기</button>
				    </div>
    
				    <!-- <table id="codeIndustrySegmentManage"></table>
				    <button type="button" onClick="codeIndustrySegmentManage.insert();">신규등록</button>
				    <button type="button" onClick="codeIndustrySegmentManage.update();">저장하기</button> -->
				    
			    </div>
		    </div>
	  	</div>
	</div>
</div>
</body>


<script type="text/javascript">
$(document).ready(function(){
	codeIndustrySegmentManage.init();
});

var codeIndustrySegmentManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$codeIndustrySegmentManage = $("#codeIndustrySegmentManage");
			codeIndustrySegmentManage.lastEdit = 0;
			codeIndustrySegmentManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $codeIndustrySegmentManage.jqGrid('getGridParam', 'records');
 			$codeIndustrySegmentManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"first"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			codeIndustrySegmentManage.saveRow();
			$.ajax({
				url : "/admin/updateIndustrySegment.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				industrySegmentList : JSON.stringify($codeIndustrySegmentManage.getRowData())	
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						//codeIndustrySegmentManage.reload();
						window.location.reload();
					}
				},
				complete : function(){
					
				}
			});
		},
		
		//그리드 그리기
		draw : function() {
			$codeIndustrySegmentManage.jqGrid({
				url : '/admin/selectIndustrySegmentAll.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "industrySegmentAll",
				},  
				colModel : [ {
					label : '산업코드',
					name : 'SEGMENT_CODE',
					align : "left",
					editable: true,
					width : 30
				}, {
					label : '산업명(한)',
					name : 'SEGMENT_HAN_NAME',
					align : "left",
					editable: true,
					width : 200
				}, {
					label : '산업명(영)',
					name : 'SEGMENT_ENG_NAME',
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
				}
				],
				rowNum : 200,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',codeIndustrySegmentManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					codeIndustrySegmentManage.lastEdit = id;
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
			$codeIndustrySegmentManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$codeIndustrySegmentManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectIndustrySegmentAll.do',
	 				mtype: 'POST',
	 				postData : {
		 				use_yn : null
		 			},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $codeIndustrySegmentManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$codeIndustrySegmentManage.jqGrid('saveRow', i);
			}
			$codeIndustrySegmentManage.jqGrid('saveRow', codeIndustrySegmentManage.lastEdit);
		}
			
		
}

function moveCodePage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
