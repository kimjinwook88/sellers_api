<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-6">
        <h2>메뉴관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>메뉴관리</strong>
            </li>
        </ol>
    </div> -->
    
    <div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
			<div class="ibox">
				<div class="ibox-content border_n pd-no">
					<div class="clear">
					
						<div class="func-top-right fl_r pd-b10">
						    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="menuManage.insert();">신규등록</button>
						    <button type="button" class="btn btn-outline btn-gray-outline" onClick="menuManage.update();">저장하기</button>
					    </div>
						<table id="menuManage"></table>
						<div class="func-top-right fl_r pd-b10">
						    <button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="menuManage.insert();">신규등록</button>
						    <button type="button" class="btn btn-outline btn-gray-outline" onClick="menuManage.update();">저장하기</button>
					    </div>
					    
					    <!-- <table id="menuManage"></table>
					    <button type="button" onClick="menuManage.insert();">신규등록</button>
					    <button type="button" onClick="menuManage.update();">저장하기</button> -->
				    
				    </div>
			    </div>
		    </div>
	    </div>
    </div>
    
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	menuManage.init();
});

var menuManage = {
			//변수		
			lastEdit : 0,
			
			//초기화
			init : function(){
				$menuManage = $("#menuManage");
				menuManage.lastEdit = 0;
				menuManage.draw();
			},
			
			//메뉴추가
			insert : function(){
				var gridLength = $menuManage.jqGrid('getGridParam', 'records');
	 			$menuManage.jqGrid('addRow', {
					rowID : gridLength+1, 
					id : gridLength+1,
			        position :"first"           //first, last
				}); 
			},
			
			//수정
			update : function(){
				menuManage.saveRow();
				$.ajax({
					url : "/admin/updateMenu.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				menuList : JSON.stringify($menuManage.getRowData())	
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						var cnt = data.cnt;
						if(cnt > 0){
							alert("저장하였습니다.");
							//menuManage.reload();
							window.location.reload();
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			deleteMenu : function(menuId, rownum, childrenCount){
				if(!menuId){
					menuManage.delRow(rownum);
					return;
				}
				$.ajax({
					url : "/admin/deleteMenu.do",
					datatype : 'json',
					data : {
						MENU_ID : menuId,
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("삭제하시겠습니까?") || childrenCount > 0){
							alert("하위 메뉴를 먼저 삭제하세요.");
							lastEditRowQ = 0;
							return false;
						}
	                    $.ajaxLoading();
					},
					success : function(result){
						if(result.cnt > 0){
							alert("삭제되었습니다.");
							lastEditRowQ = 0;
							menuManage.reload();
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
				$menuManage.jqGrid('delRowData', rownum);
			},
			
			//그리드 그리기
			draw : function() {
				$menuManage.jqGrid({
					url : '/admin/selelctMenuManageList.do',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				use_yn : null
		 			},
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : 'MENU_ID',
						name : 'MENU_ID',
						align : "center",
						width : 90
					}, {
						label : '메뉴이름',
						name : 'MENU_TITLE',
						align : "left",
						editable: true,
						width : 150
					}, {
						label : '메뉴주소',
						name : 'MENU_URL',
						align : "left",
						width : 300,
						editable: true
					}, {
						label : '상위메뉴',
						name : 'MENU_PARENT',
						align : "center",
						editable: true,
						width : 100
					}, {
						label : '메뉴순서',
						name : 'MENU_SEQ',
						align : "center",
						editable: true,
						width : 80,
					},{
						label : '메뉴레벨(depth)',
						name : 'MENU_LEVEL',
						align : "center",
						width : 100,
						editable: true
					},{
						label : '메뉴 아이콘',
						name : 'MENU_ICON',
						align : "center",
						width : 100,
						editable: true
					},{
						label : '웹 메뉴 사용여부',
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
						label : '모바일 랜딩 사용여부',
						name : 'MOBILE_LANDING_PAGE_USE_YN',
						align : "center",
						width : 80,
						edittype:"select",
						formatter:'select',
						editable: true,
						editoptions:{
							value:"N:N;Y:Y", //대소문자 유의!
						}
					},{
						label : 'CHILDREN_COUNT',
						name : 'CHILDREN_COUNT',
						align : "center",
						width : 25,
						hidden : true,
						editable: true
					},{
						label : '삭제',
						name : '',
						align : "center",
						width : 30,
						formatter: function (rowId, cellval , colpos, rwdat, _act){
							return "<a href='javascript:void(0);' onClick='menuManage.deleteMenu("+colpos.MENU_ID+", "+cellval.rowId+", "+colpos.CHILDREN_COUNT+");'><i class='fa fa-trash-o fa-lg'></i></a>"; 
						}
					}
					],
					rowNum : 100,
					autowidth : true,
					height : "100%",
					onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
						$(this).jqGrid('saveRow',menuManage.lastEdit,true);
						$(this).jqGrid('editRow',id,true);
						menuManage.lastEdit = id;
					},
					loadBeforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					loadComplete : function(data){
						$('td[aria-describedby="menuManage_MENU_LEVEL"][title="1"]').parent('tr').css("background-color","#FFFFE4");
						$('td[aria-describedby="menuManage_MENU_LEVEL"][title="2"]').parent('tr').css("background-color","#F6F6F6");
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			},
			
			clear : function(){
				$menuManage.jqGrid('clearGridData');
			},
			
			reload : function(){
				$menuManage.jqGrid(
					'setGridParam', 
					{
						url : '/admin/selelctMenuManageList.do',
		 				mtype: 'POST',
		 				postData : {
			 				use_yn : null
			 			},
		 				datatype : 'json'
		 			}
				).trigger('reloadGrid');
			},
			
			saveRow : function(){
				var gridLength = $menuManage.jqGrid('getGridParam', 'records');
				for(var i=1; i <=gridLength; i++){
					$menuManage.jqGrid('saveRow', i);
				}
				$menuManage.jqGrid('saveRow', menuManage.lastEdit);
			}
			
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
