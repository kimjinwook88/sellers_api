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
                <strong>코드관리(파트너사분류)</strong>
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
				             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codePartnerSegmentManage.do');">파트너사분류 코드</a></li>
				             <!-- <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeVendorSolutionAreaManage.do');">솔루션분류 코드</a></li> -->
				             <!-- <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveCodePage('/admin/codeOurProductInfoManage.do');">제품분류 코드</a></li> -->
				         </ul>
				     </div>
				     
				     <div class="func-top-right fl_r pd-b10">
					    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="codePartnerSegmentManage.insert();">신규등록</button>
					    <button type="button" class="btn btn-outline btn-gray-outline" onClick="codePartnerSegmentManage.update();">저장하기</button>
					 </div>
				     <table id="codePartnerSegmentManage"></table>
				     <div class="func-top-right fl_r pd-b10">
					    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="codePartnerSegmentManage.insert();">신규등록</button>
					    <button type="button" class="btn btn-outline btn-gray-outline" onClick="codePartnerSegmentManage.update();">저장하기</button>
					 </div>
    
    			<!-- <table id="codePartnerSegmentManage"></table>
			    <button type="button" onClick="codePartnerSegmentManage.insert();">신규등록</button>
			    <button type="button" onClick="codePartnerSegmentManage.update();">저장하기</button> -->
			    
			    </div>
		    </div>
	    </div>

	</div>
</div>
</body>


<script type="text/javascript">
$(document).ready(function(){
	codePartnerSegmentManage.init();
});

var codePartnerSegmentManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$codePartnerSegmentManage = $("#codePartnerSegmentManage");
			codePartnerSegmentManage.lastEdit = 0;
			codePartnerSegmentManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $codePartnerSegmentManage.jqGrid('getGridParam', 'records');
 			$codePartnerSegmentManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"first"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			if(!codePartnerSegmentManage.saveRow()) return false;
			$.ajax({
				url : "/admin/updatePartnerSegment.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				PartnerSegmentList : JSON.stringify($codePartnerSegmentManage.getRowData())	
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("저장하였습니다.");
					//codePartnerSegmentManage.reload();
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		
		delete : function(partnerCode, rownum){
			if(isEmpty(partnerCode) || partnerCode == "undefined"){
				codePartnerSegmentManage.delRow(rownum);
				return;
			}
			$.ajax({
				url : "/admin/deletePartnerSegment.do",
				datatype : 'json',
				data : {
					PARTNER_CODE : partnerCode,
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("삭제하시겠습니까?")){
						return false;
					}
                    $.ajaxLoading();
				},
				success : function(result){
					console.log(result.returnMap.error_msg);
					if(result.returnMap.cnt > 0){
						alert("삭제되었습니다.");
						window.location.reload();
					}else{
						alert(result.returnMap.error_msg);
						window.location.reload();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		delRow : function(rownum){
			$codePartnerSegmentManage.jqGrid('delRowData', rownum);
		},
		
		
		//그리드 그리기
		draw : function() {
			$codePartnerSegmentManage.jqGrid({
				url : '/admin/selectPartnerSegmentAll.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "selectPartnerSegmentAll",
				},  
				colModel : [ {
					label : '파트너사분류코드',
					name : 'PARTNER_CODE_NAME',
					align : "left",
					editable: true,
					width : 150
				}, {
					label : '파트너사 티어 레벨',
					name : 'PARTNER_LEVEL',
					align : "left",
					editable: true,
					width : 50
				}, {
					label : '파트너사분류 코드 내용',
					name : 'PARTNER_DETAIL',
					align : "left",
					width : 150,
					editable: true
				},{
					label : '사용여부',
					name : 'USE_YN',
					align : "center",
					width : 40,
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
					width : 40,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='codePartnerSegmentManage.delete(\""+colpos.PARTNER_CODE+"\", "+cellval.rowId+");'><i class='fa fa-trash-o fa-lg'></i></a>"; 
					}
				},{
					label : 'PARTNER_CODE',
					name : 'PARTNER_CODE',
					hidden : true
				}
				],
				rowNum : 200,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',codePartnerSegmentManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					codePartnerSegmentManage.lastEdit = id;
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
			$codePartnerSegmentManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$codePartnerSegmentManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectPartnerSegmentAll.do',
	 				mtype: 'POST',
	 				postData : {
		 				use_yn : null
		 			},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var flag = true;
			var gridLength = $codePartnerSegmentManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$codePartnerSegmentManage.jqGrid('saveRow', i);
				if(isEmpty($codePartnerSegmentManage.jqGrid('getCell', i, "PARTNER_CODE_NAME"))){
					alert("파트너사분류코드를 입력해 주세요.");
					flag = false;
					break;
				}
			}
			return flag;
		}
			
		
}

function moveCodePage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>