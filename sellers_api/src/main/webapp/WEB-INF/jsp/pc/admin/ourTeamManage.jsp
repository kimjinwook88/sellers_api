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
        <h2>본부,팀 관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>본부,팀 관리</strong>
            </li>
        </ol>
    </div> -->
</div>


<!-- 	<br /><br />
	<div class="mg-b20">
         <ul class="nav nav-tabs">
             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/ourTeamManage.do');">권한 추가 및 삭제</a></li>
             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authMemberManage.do');">직원 권한 관리</a></li>
             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authRoleMenu.do');">권한별 메뉴 관리</a></li>
         </ul>
     </div>
 -->    
 
    <table id="ourTeamManage"></table>
    <button type="button" onClick="ourTeamManage.insert();">신규등록</button>
    <button type="button" onClick="ourTeamManage.update();">저장하기</button>
    
</div>
</div>
</body>


<script type="text/javascript">
var memberList = "";
<c:choose>
	<c:when test="${fn:length(selelctInfoMemberManageList) > 0}">
 		<c:forEach items="${selelctInfoMemberManageList}" var="selelctInfoMemberManageList" varStatus="i">
 		<c:choose>
 		<c:when test="${i.index == 0}">
 		memberList += "${selelctInfoMemberManageList.MEMBER_ID_NUM}:${selelctInfoMemberManageList.HAN_NAME}";
		</c:when>
		<c:when test="${i.index != 0}">
		memberList += ";${selelctInfoMemberManageList.MEMBER_ID_NUM}:${selelctInfoMemberManageList.HAN_NAME}";
		</c:when>
 		</c:choose>
    	</c:forEach>
 	</c:when>
</c:choose>

$(document).ready(function(){
	ourTeamManage.init();
});

var ourTeamManage = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			$ourTeamManage = $("#ourTeamManage");
			ourTeamManage.lastEdit = 0;
			ourTeamManage.draw();
		},
		
		
		//메뉴추가
		insert : function(){
			var gridLength = $ourTeamManage.jqGrid('getGridParam', 'records');
 			$ourTeamManage.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
		},
		
		//수정
		update : function(){
			ourTeamManage.saveRow();
			$.ajax({
				url : "/admin/updateTeamInfo.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				teamList : JSON.stringify($ourTeamManage.getRowData())	
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("저장하시겠습니까?")) return false;
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						ourTeamManage.reload();
					}
				},
				complete : function(){
					
				}
			});
		},
		
		//그리드 그리기
		draw : function() {
			$ourTeamManage.jqGrid({
				url : '/admin/selelctInfoTeamList.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				use_yn : null
	 			},
				 jsonReader : { 
				    root: "selelctInfoTeamList",
				},  
				colModel : [ {
					label : '팀번호',
					name : 'TEAM_NO',
					align : "center",
					width : 100
				},{
					label : '팀이름',
					name : 'TEAM_NAME',
					align : "center",
					editable: true,
					width : 100
				}, {
					label : '팀장',
					name : 'TEAM_LEADER',
					align : "left",
					width : 80,
					edittype:"select",
					formatter:"select",
					editable: true,
					editoptions:{
						value: memberList,
						dataEvents:[{ type:'change', fn: function(e){
							var rowid = $ourTeamManage.getGridParam("selrow");
							var rowData = $ourTeamManage.getRowData(rowid);
							var evalue = $(e.target).val();
							$("#"+rowid+"_TEAM_LEADER_NO").val($("#"+rowid+"_TEAM_LEADER option:selected").val());
						}}]
					}
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
					label : 'TEAM_NO',
					name : 'TEAM_NO',
					hidden : true
				},{
					label : 'TEAM_LEADER_NO',
					name : 'TEAM_LEADER_NO',
					align : "center",
					editable: true,
					hidden : true,
					width : 75
				}
				],
				rowNum : 100,
				autowidth : true,
				height : "100%",
				onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
					$(this).jqGrid('saveRow',ourTeamManage.lastEdit,true);
					$(this).jqGrid('editRow',id,true);
					ourTeamManage.lastEdit = id;
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
			$ourTeamManage.jqGrid('clearGridData');
		},
		
		reload : function(){
			$ourTeamManage.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selelctInfoTeamList.do',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				use_yn : null
		 			},
					 jsonReader : { 
					    root: "selelctInfoTeamList",
					}
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $ourTeamManage.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$ourTeamManage.jqGrid('saveRow', i);
			}
			$ourTeamManage.jqGrid('saveRow', ourTeamManage.lastEdit);
		}
			
		
}

function moveAuthPage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
