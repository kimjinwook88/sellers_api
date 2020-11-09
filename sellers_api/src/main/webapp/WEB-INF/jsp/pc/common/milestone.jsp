<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="milestone"></table>
<script type="text/javascript">
$(document).ready(function(){
	milestone.init();
});

var milestone = {
			//마일스톤 변수		
			lastEdit : 0,
			initData : [
				{ROWNUM : '1', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '2', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '3', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '4', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '5', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null}
			],
			
			//마일스톤 함수
			init : function(){
				$milestone = $("#milestone");
				milestone.draw();
			},
			
			draw : function() {
				$milestone.jqGrid({
					url : '${param.url}',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				hiddenModalPK : $("#hiddenModalPK").val()
		 			},
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : 'No',
						name : 'ROWNUM',
						align : "center",
						width : 50
					}, {
						label : 'Key Milestones',
						name : 'KEY_MILESTONE',
						align : "left",
						editable: true,
						width : 325
					}, {
						label : '책임 담당자',
						name : 'ACT_NAME',
						align : "center",
						width : 120,
						classes : "pos-rel",
						editable: true,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             							milestone.changeStatus();
	             						} 
	             					}
								],
								dataInit: function (element,rwdat) {
									commonSearch.memberGrid($(element), $(element).parent('td').siblings(".hidden_act_id"));
	                            }
						}
					}, {
						label : '목표일',
						name : 'ACT_DUE_DATE',
						index : 'ACT_DUE_DATE',
						align : "center",
						editable: true,
						sorttype:"date",
						width : 135,
						editoptions: {
                            dataEvents: [
             					{ 
             						type: 'change', 
             						fn: function() {
             							milestone.changeStatus();
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
                            
                      	},
					
					}, {
						label : '완료일',
						name : 'ACT_CLOSE_DATE',
						index : 'ACT_CLOSE_DATE',
						align : "center",
						editable: true,
						sorttype:"date",
						width : 135,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             							milestone.changeStatus();
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
						label : 'Status',
						name : 'STATUS',
						align : "center",
						width : 50,
						formatter: function (rowId, cellval , colpos, rwdat, _act){
							if(rwdat == "edit"){
								switch (rowId) {
								case "G":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
									break;
								case "Y":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
									break;
								case "R":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
									break;
								default:
									return "";
									break;
								}	
							}else{
								return "";
							}
						}
					}, {
						label : 'MILESTONE_ID',
						name : 'MILESTONE_ID',
						hidden : true
					}, {
						label : 'HIDDEN_STATUS',
						name : 'HIDDEN_STATUS',
						hidden : true
					}, {
						label : 'HIDDEN_ACT_ID',
						name : 'HIDDEN_ACT_ID',
						classes : "hidden_act_id",
						hidden : true
					}
					],
					height : "100%",
					shrinkToFit: true,
					onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
						$(this).jqGrid('saveRow',milestone.lastEdit,true);
						$(this).jqGrid('editRow',id,true);
						milestone.lastEdit = id;
					},
					loadBeforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					loadComplete : function(data){
						var list = data.rows;
						if(list.length == 0){
							for(var i=0;i<=milestone.initData.length;i++){
				                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
				                $(this).jqGrid('addRowData',i+1,milestone.initData[i]);
				        	} 							
						}else{
							for(var i=0; i<list.length; i++ ){
								if(list[i].STATUS == 'G'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","G");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
								}else if(list[i].STATUS == 'Y'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","Y");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
								}else if(list[i].STATUS == 'R'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","R");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
								}
							}
						}
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			},
			
			clear : function(){
				$milestone.jqGrid('clearGridData');
			},
			
			reload : function(){
				$milestone.jqGrid(
					'setGridParam', 
					{
						url : '${param.url}',
		 				mtype: 'POST',
		 				postData : {
		 					hiddenModalPK : $("#hiddenModalPK").val()
		 				},
		 				datatype : 'json'
		 			}
				).trigger('reloadGrid');
			},
			
			saveRow : function(){
				for(var i=1; i <=5; i++){
					$milestone.jqGrid('saveRow', i);
				}
					$milestone.jqGrid('saveRow', milestone.lastEdit);
			},
			
			changeStatus : function(){
				$milestone.jqGrid('saveRow', milestone.lastEdit);
				var dueDate= ($milestone.jqGrid('getCell',milestone.lastEdit,'ACT_DUE_DATE').replaceAll("-","")).trim();
				var closeDate= ($milestone.jqGrid('getCell',milestone.lastEdit,'ACT_CLOSE_DATE').replaceAll("-","")).trim();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				
				if((dueDate >= nowDate) && closeDate == ""){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'Y');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'Y');
				}else if(dueDate < nowDate && closeDate == ""){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'R');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'R');
				}else if(closeDate != "" && closeDate != null){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'G');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'G');
				}
				milestone.lastEdit = 0;
			}
			
}
</script>