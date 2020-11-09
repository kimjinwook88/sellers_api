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
        <h2>권한관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>권한관리</strong>
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
					             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authManage.do');">권한 추가 및 삭제</a></li>
					             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authMemberManage.do');">직원 권한 관리</a></li>
					             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authRoleMenu.do');">권한별 메뉴 관리</a></li>
					         </ul>
					     </div>
    
    
    
					    <table class="adminboard_type1 mg-b10" id="authManage"></table>
					    <div class="func-top-right fl_r pd-b10">
						    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="authManage.insert();">신규등록</button>
						    <button type="button" class="btn btn-outline btn-gray-outline" onClick="authManage.update();">저장하기</button>
					    </div>
   
					    <!-- <table id="authManage"></table>
					    <button type="button" onClick="authManage.insert();">신규등록</button>
					    <button type="button" onClick="authManage.update();">저장하기</button> -->
					</div>
				</div>
			</div>
		</div>
	</div>
    
</div>
</body>


<script type="text/javascript">
$(document).ready(function(){
	authManage.init();
});

var authManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$authManage = $("#authManage");
			authManage.lastEdit = 0;
			authManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $authManage.jqGrid('getGridParam', 'records');
 			$authManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"first"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			authManage.saveRow();
			$.ajax({
				url : "/admin/updateAuth.do",
				async : true,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				authList : JSON.stringify($authManage.getRowData())	
	 			},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						//authManage.reload();
						window.location.reload();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//그리드 그리기
		draw : function() {
			$authManage.jqGrid({
				url : '/admin/selectAuthorityAll.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "rows",
				},  
				colModel : [ {
					label : '권한코드',
					name : 'AUTHORITY_CODE',
					align : "center",
					editable: true,
					width : 100
				}, {
					label : '권한이름',
					name : 'AUTHORITY_NAME',
					align : "left",
					editable: true,
					width : 150
				}, {
					label : '권한상세내용',
					name : 'AUTHORITY_DETAIL',
					align : "center",
					width : 300,
					editable: true
				},{
					label : '사용여부',
					name : 'USE_YN',
					align : "center",
					width : 80,
					edittype:"select",
					formatter:'select',
					editable: true,
					editoptions:{
						value:"Y:Y;N:N", //대소문자 유의!
					}
				},{
					label : 'AUTHORITY_ID',
					name : 'AUTHORITY_ID',
					hidden : true
				}
				],
				rowNum : 100,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',authManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					authManage.lastEdit = id;
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
			$authManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$authManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectAuthorityAll.do',
	 				mtype: 'POST',
	 				postData : {
		 				use_yn : null
		 			},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $authManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$authManage.jqGrid('saveRow', i);
			}
			$authManage.jqGrid('saveRow', authManage.lastEdit);
		}
			
		
}

function moveAuthPage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
