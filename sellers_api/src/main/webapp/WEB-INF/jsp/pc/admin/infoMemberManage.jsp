<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-6">
        <h2>정보관리(직원)</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>정보관리(직원)</strong>
            </li>
        </ol>
    </div> -->
    
    <div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
		    <div class="ibox">
		        <div class="ibox-content border_n pd-no">
					<div class="clear">
					
					<div class="func-top-right fl_r pd-b10">
           				<div class="fl_l">
							<button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="memberManage.insert();">신규등록</button>
							<button type="button" class="btn btn-outline btn-gray-outline" onClick="memberManage.update();">저장하기</button>
						</div>
						<div class="mg-l10 fl_l">
							<div class="mag-area">
   								<div class="input-group"><input type="text" class="input form-control" name="textSearchInfoMember" id="textSearchInfoMember" placeholder="이름 검색" onkeydown="if(event.keyCode == 13){memberManage.reload();}"/></div>
   								<a href="#" class="btn-search" onclick="memberManage.reload();">검색</a>
							</div>
						</div>
					</div>
					<table id="memberManage"></table>
					<div class="func-top-right fl_r pd-b10">
	              			<div class="fl_l">
   							<button type="button" class="btn btn-w-m btn-gray mg-r5" onClick="memberManage.insert();">신규등록</button>
							<button type="button" class="btn btn-outline btn-gray-outline" onClick="memberManage.update();">저장하기</button>
							</div>
						<!-- <div class="mg-l10 fl_l">
							<div class="mag-area">
   								<div class="input-group"><input type="text" class="input form-control" name="textSearchInfoMember" id="textSearchInfoMember" placeholder="이름 검색" onkeydown="if(event.keyCode == 13){memberManage.reload();}"/></div>
   								<a href="#" class="btn-search" onclick="memberManage.reload();">검색</a>
							</div>
						</div> -->
					</div>
    
					    <!-- <table id="memberManage"></table>
					    <button type="button" onClick="memberManage.insert();">신규등록</button>
					    <button type="button" onClick="memberManage.update();">저장하기</button>
					    <input type="text" name="textSearchInfoMember" id="textSearchInfoMember" placeholder="이름 검색"/>
					    <button type="button" onclick="memberManage.reload();">검색</button> -->
					    
					    </div>
				    </div>
			    </div>
		    </div>
	    </div>
    
	    <input type="hidden" name="hiddenPropertiesCode" id="hiddenPropertiesCodePositionType" value="<spring:eval expression="@config['code.positiontype']" />" />
	</div>



</body>

<script type="text/javascript">
var positiontype = $("#hiddenPropertiesCodePositionType").val();

var divisionList = "";
<c:choose>
<c:when test="${fn:length(selelctAllInfoDivisionList) > 0}">
		<c:forEach items="${selelctAllInfoDivisionList}" var="selelctAllInfoDivisionList" varStatus="i">
		<c:choose>
		<c:when test="${i.index == 0}">
		divisionList += "${selelctAllInfoDivisionList.DIVISION_NO}:${selelctAllInfoDivisionList.DIVISION_NAME}";
	</c:when>
	<c:when test="${i.index != 0}">
		divisionList += ";${selelctAllInfoDivisionList.DIVISION_NO}:${selelctAllInfoDivisionList.DIVISION_NAME}";
	</c:when>
		</c:choose>
	</c:forEach>
	</c:when>
</c:choose>

var teamList = "";
<c:choose>
	<c:when test="${fn:length(selelctAllInfoTeamList) > 0}">
 		<c:forEach items="${selelctAllInfoTeamList}" var="selelctAllInfoTeamList" varStatus="i">
 		<c:choose>
 		<c:when test="${i.index == 0}">
 			teamList += "${selelctAllInfoTeamList.TEAM_NO}:${selelctAllInfoTeamList.TEAM_NAME}";
		</c:when>
		<c:when test="${i.index != 0}">
			teamList += ";${selelctAllInfoTeamList.TEAM_NO}:${selelctAllInfoTeamList.TEAM_NAME}";
		</c:when>
 		</c:choose>
    	</c:forEach>
 	</c:when>
</c:choose>

$(document).ready(function(){
	memberManage.init();
});

var memberManage = {
			//변수		
			lastEdit : 0,
			
			//초기화
			init : function(){
				$memberManage = $("#memberManage");
				memberManage.lastEdit = 0;
				memberManage.draw();
			},
			
			//추가
			insert : function(){
				var gridLength = $memberManage.jqGrid('getGridParam', 'records');
	 			$memberManage.jqGrid('addRow', {
					rowID : gridLength+1, 
					id : gridLength+1,
			        position :"first"           //first, last
				});
	 			
	 			//추가시 팀명 로딩
	 			var rowid = $memberManage.getGridParam("selrow");
				var rowData = $memberManage.getRowData(rowid);
				var division_no = rowData.MEMBER_DIVISION;
				//alert(division_no);
				//var evalue = $(e.target).val();
				//alert(evalue);
				
				$.ajax({
					url : "/admin/selelctInfoTeamList.do",
					datatype : 'json',
					data : {
						divisionNo : division_no
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						//$.ajaxLoading();
					},
					success : function(data){
						var list = data.selelctInfoTeamList;
						
						teamList = "<option role=\"option\">==선택==</option>";
						for(var i=0; i<list.length; i++){
							teamList += "<option role=\"option\" value=\"" + list[i].TEAM_NO + "\">" + list[i].TEAM_NAME + "</option>";
						}
						
						$("#"+rowid+"_MEMBER_TEAM").html(teamList);
						$("#"+rowid+"_DIVISION_TEAM").val(teamList);
						//$memberManage.setCell(rowid, 'MEMBER_TEAM', teamList);
						//$(rowData)[0].SOLUTION_AREA.innerHTML = data.rows;
						//$(rowData)[0].SOLUTION_AREA = data.rows;
						//console.log($(rowData)[0].SOLUTION_AREA);
					},
					complete: function() {
						//$.ajaxLoadingHide();
					}
				});
				
			},
			
			//수정
			update : function(){
				memberManage.saveRow();
				$.ajax({
					url : "/admin/updateInfoMember.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				memberList : JSON.stringify($memberManage.getRowData())	
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						var cnt = data.cnt;
						if(cnt > 0){
							alert("저장하였습니다.");
							//memberManage.reload();
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
				$memberManage.jqGrid({
					url : '/admin/selelctInfoMemberManageList.do',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				use_yn : null
		 			},
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : '사번',
						name : 'MEMBER_ID_NUM',
						placeholder:"ui-state-highlight",
						align : "center",
						editable: true,
						width : 80
					},{
						label : 'MEMBER_ID',
						name : 'MEMBER_ID',
						align : "center",
						hidden : true
					},{
						label : '소속본부',
						name : 'MEMBER_DIVISION',
						align : "left",
						editable: true,
						width : 130,
						edittype:"select",
						formatter:"select",
						editoptions:{
							value: divisionList,
							dataEvents:[{ type:'change', fn: function(e){
								
								var rowid = $memberManage.getGridParam("selrow");
								var rowData = $memberManage.getRowData(rowid);
								var evalue = $(e.target).val();
								//alert(evalue);
								
								$.ajax({
									url : "/admin/selelctInfoTeamList.do",
									datatype : 'json',
									data : {
										divisionNo : evalue
									},
									beforeSend : function(xhr){
										xhr.setRequestHeader("AJAX", true);
					                    $.ajaxLoading();
									},
									success : function(data){
										var list = data.selelctInfoTeamList;
										
										teamList = "<option role=\"option\">==선택==</option>";
										for(var i=0; i<list.length; i++){
											teamList += "<option role=\"option\" value=\"" + list[i].TEAM_NO + "\">" + list[i].TEAM_NAME + "</option>";
										}
										
										$("#"+rowid+"_MEMBER_TEAM").html(teamList);
										$("#"+rowid+"_DIVISION_TEAM").val(teamList);
										//$memberManage.setCell(rowid, 'MEMBER_TEAM', teamList);
										//$(rowData)[0].SOLUTION_AREA.innerHTML = data.rows;
										//$(rowData)[0].SOLUTION_AREA = data.rows;
										//console.log($(rowData)[0].SOLUTION_AREA);
									},
									complete: function() {
										$.ajaxLoadingHide();
									}
								});

						        }}]
						}
					},{
						label : '소속팀',
						name : 'MEMBER_TEAM',
						align : "left",
						editable: true,
						width : 130,
						edittype:"select",
						formatter:"select",
						editoptions:{
							value: teamList,
							dataEvents:[{ type:'change', fn: function(e){
								var rowid = $memberManage.getGridParam("selrow");
								var rowData = $memberManage.getRowData(rowid);
								var evalue = $(e.target).val();
								$("#"+rowid+"_TEAM_VALUE").val($("#"+rowid+"_MEMBER_TEAM option:selected").val());
							}}]
						}
					},{
						label : '이름',
						name : 'HAN_NAME',
						align : "center",
						editable: true,
						width : 50,
					},{
						label : '직위',
						name : 'POSITION_STATUS',
						align : "center",
						width : 55,
						editable: true
					},{
						label : '직급',
						name : 'POSITION_RANK',
						align : "center",
						width : 75,
						editable: true
					},{
						label : '직책',
						name : 'POSITION_DUTY',
						align : "center",
						width : 75,
						editable: true
					},{
						label : '직군',
						name : 'POSITION_TYPE',
						align : "center",
						width : 60,
						editable: true,
						edittype:"select",
						formatter:"select",
						editoptions:{
							value: positiontype,
						}
					},{
						label : '직군2',
						name : 'POSITION_TYPE2',
						align : "center",
						width : 75,
						hidden : true,
						editable: true
					},{
						label : '입사일',
						name : 'JOIN_DATE',
						align : "center",
						width : 80,
						sorttype:"date",
						editable: true,
						editoptions: {
	                        dataEvents: [
	         					{ 
	         						type: 'change', 
	         						fn: function() {
	         						} 
	         					}
							],
							
							// dataInit is the client-side event that fires upon initializing the toolbar search field for a column
	                        // use it to place a third party control to customize the toolbar
	                        dataInit: function (element) {
	                           $(element).datepicker({
	                        	   todayBtn: "linked",
	                               keyboardNavigation: false,
	                               forceParse: false,
	                               calendarWeeks: true,
	                               autoclose: true
	                            }).on('hide.bs.modal', function(event) {
	                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
	                        	    event.stopPropagation(); 
	                        	});
	                        }
	                  	}
					},{
						label : '퇴사일',
						name : 'STOP_DATE',
						align : "center",
						width : 80,
						sorttype:"date",
						editable: true,
						editoptions: {
	                        dataEvents: [
	         					{ 
	         						type: 'change', 
	         						fn: function() {
	         						} 
	         					}
							],
							
							// dataInit is the client-side event that fires upon initializing the toolbar search field for a column
	                        // use it to place a third party control to customize the toolbar
	                        dataInit: function (element) {
	                           $(element).datepicker({
	                        	   todayBtn: "linked",
	                               keyboardNavigation: false,
	                               forceParse: false,
	                               calendarWeeks: true,
	                               autoclose: true
	                            }).on('hide.bs.modal', function(event) {
	                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
	                        	    event.stopPropagation(); 
	                        	});
	                        }
	                  	}
					},{
						label : '휴대전화',
						name : 'CELL_PHONE',
						align : "center",
						width : 90,
						editable: true
					},{
						label : '일반전화',
						name : 'PHONE',
						align : "center",
						width : 90,
						editable: true
					},{
						label : '전자메일',
						name : 'EMAIL',
						align : "center",
						width : 150,
						editable: true
					},{
						label : '재직여부',
						name : 'USE_YN',
						align : "center",
						width : 70,
						edittype:"select",
						formatter:'select',
						editable: true,
						editoptions:{
							value:"Y:Y;N:N", //대소문자 유의!
						}
					},{
						label : 'DIVISION_TEAM',
						name : 'DIVISION_TEAM',
						align : "center",
						editable: true,
						hidden : true,
						width : 75
					},{
						label : 'TEAM_VALUE',
						name : 'TEAM_VALUE',
						align : "center",
						editable: true,
						hidden : true,
						width : 75
					}
					],
					rowNum : 200,
					autowidth : true,
					height : "100%",
					onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
						var rowData = $memberManage.getRowData(id);
						$(this).jqGrid('saveRow',memberManage.lastEdit,true);
						$(this).jqGrid('editRow',id,true);
						memberManage.lastEdit = id;
						
						$("#"+id+"_MEMBER_TEAM").html(rowData.DIVISION_TEAM);
						if(memberManage.lastEdit != id){
							$("#"+id+"_MEMBER_TEAM").val(rowData.TEAM_VALUE);
						}
						else{
							$("#"+id+"_MEMBER_TEAM").html($("#"+id+"_DIVISION_TEAM").val());
							$("#"+id+"_MEMBER_TEAM").val($("#"+id+"_TEAM_VALUE").val());
						}
					},
					loadBeforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					loadComplete : function(data){
						/* $('td[aria-describedby="memberManage_MENU_LEVEL"][title="1"]').parent('tr').css("background-color","#FFFFE4");
						$('td[aria-describedby="memberManage_MENU_LEVEL"][title="2"]').parent('tr').css("background-color","#F6F6F6"); */
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			},
			
			clear : function(){
				$memberManage.jqGrid('clearGridData');
			},
			
			reload : function(){
				$memberManage.jqGrid(
					'setGridParam', 
					{
						url : '/admin/selelctInfoMemberManageList.do',
		 				mtype: 'POST',
		 				postData : {
			 				use_yn : null,
			 				searchHanName : $("#textSearchInfoMember").val()
			 			},
		 				datatype : 'json'
		 			}
				).trigger('reloadGrid');
			},
			
			saveRow : function(){
				var gridLength = $memberManage.jqGrid('getGridParam', 'records');
				for(var i=1; i <=gridLength; i++){
					$memberManage.jqGrid('saveRow', i);
				}
				$memberManage.jqGrid('saveRow', memberManage.lastEdit);
			}
			
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
