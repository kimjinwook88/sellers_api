<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table id="BizStrategyActionPlan"></table>
<p class="text-center pd-t10">
   <a href="javascript:void(0);" class="btn-row-add" name="buttonActionPlanAddRow" onclick="actionPlan.addRowActionPlan();">+ 이슈 추가</a>
</p>
                   
<script type="text/javascript">
var actionPlanFlag = true;
var rowspan_1 = 1;
var rowspan_2 = 1;
var rowspan_3 = 1;
var rowspan_4 = 1;
var status_1;
var status_2;
var status_3;
var status_4;
var lastEditRowIV;	
var lastEditRowQ;
var lastEditRowCheckList;

var actionPlanLength;

var actionPlan = {

		init : function(){
			$bizStrategyActionPlan = $("#BizStrategyActionPlan");
		},

		reset : function(){
			$bizStrategyActionPlan.jqGrid('setGridParam', { datatype: 'json' , url : "/bizStrategy/selectBizStrategyIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $bizStrategyActionPlan.jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$bizStrategyActionPlan.jqGrid('saveRow', i);
			}
			$bizStrategyActionPlan.jqGrid('saveRow', lastEditRowQ);
		},
		
		/**
		 * @author 	: 준이
		 * @Date		: 2017. 03. 17.
		 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세정보 이슈 개별저장 -> 없어진 기능.
		 */
		/* insert : function(){
			$.ajax({
				url : "/bizStrategy/insertBizStrategyActionPlan.do",
				async : false,
				data : {
					actionPlanData : JSON.stringify($bizStrategyActionPlan.getRowData()),
					hiddenModalPK : $("#hiddenModalPK").val(),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("Action Plan을 저장하시겠습니까?")){
						lastEditRowQ = 0;
						return false;	
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("저장하였습니다.");
						lastEditRowQ = 0;
						$bizStrategyActionPlan.jqGrid('setGridParam', { datatype: 'json' , url : "/bizStrategy/selectBizStrategyIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
//						projectList.completeReload();
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}, */
		
		deleteActionPlan : function(actionplan_id){
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalPK").val(),
				actionplan_id : actionplan_id
			});
			
			if(!actionplan_id){
				actionPlan.delRowActionPlan();
				return;
			}
			$.ajax({
				url : "/bizStrategy/deleteBizStrategyIssue.do",
				datatype : 'json',
				data : params,
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
						actionPlan.reload();
						//$bizStrategyActionPlan.jqGrid('setGridParam', { datatype: 'json' , url : "/bizStrategy/selectBizStrategyIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
						// projectList.completeReload();
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		draw : function() {
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalPK").val()
			});
			$bizStrategyActionPlan.jqGrid({
	 			url : "/bizStrategy/selectBizStrategyIssue.do",
	 			mtype: 'POST',
	 			postData : params,
				datatype : 'json',
				jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '이슈영역',
					name : 'ISSUE_NAME',
					align : "center",
					width : 100,
					editable: true
				},	{
					label : '이슈항목',
					name : 'ISSUE_ITEM',
					align : "center",
					width : 140,
					editable: true
				}, {
					label : '실행계획 상세내용',
					name : 'ACTION_PLAN_NAME',
					align : "left",
					width : 220,
					editable: true
				}, {
					label : 'ACTION_OWNER_ID',
					name : 'ACTION_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '책임 담당자',
					name : 'ACTION_OWNER',
					align : "center",
					width : 90,
					classes : "grid pos-rel",
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
					name : 'DUE_DATE',
					align : "center",
					width : 90,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							actionPlan.changeStatusActionPlan();
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
                               autoclose: true,
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        	//.datepicker("setDate", new Date());
                        }
                  	}
				}, {
					label : '완료일',
					name : 'CLOSE_DATE',
					align : "center",
					width : 90,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							actionPlan.changeStatusActionPlan();
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
				}, {
					label : 'Status',
					name : 'STATUS',
					align : "center",
					width : 50,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$bizStrategyActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$bizStrategyActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$bizStrategyActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
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
					label : '',
					name : '삭제',
					align : "center",
					width : 35,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='actionPlan.deleteActionPlan("+colpos.ACTION_ID+");'><i class='fa fa-trash-o fa-lg'></i></a>"; 
					}
				}, {
					label : 'ACTION_ID',
					name : 'ACTION_ID',
					hidden : true
				}, {
					label : 'BIZ_ID',
					name : 'BIZ_ID',
					hidden : true
				}, {
					label : 'CREATOR_ID',
					name : 'CREATOR_ID',
					hidden : true
				}, {
					label : 'SYS_REGISTER_DATE',
					name : 'SYS_REGISTER_DATE',
					hidden : true
				}
				],
				loadui: 'disable',
				loadonce : false,
				viewrecords : true,
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					var rowData = $(this).jqGrid("getRowData",id);
					if(id && lastEditRowQ != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastEditRowQ);
						lastEditRowQ = id;
					}else if(lastEditRowQ == id){
						$(this).jqGrid('editRow',id,true);
					}
				},
				
				onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
					/*  if(action == 'next'){
						currPage = getGridParam("page");
					} */
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					actionPlanLength = $bizStrategyActionPlan.jqGrid('getGridParam', 'records');
					var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						if(list[i].STATUS == 'G'){
							$bizStrategyActionPlan.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$bizStrategyActionPlan.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$bizStrategyActionPlan.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
			
			if(actionPlanFlag){
				$bizStrategyActionPlan.jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'ACTION_PLAN_NAME', numberOfColumns: 4, titleText: '이슈해결계획 (How to Fix)'},
					  ]
				});
				actionPlanFlag = false;
			}
		},
		
		addRowActionPlan : function(){
			var gridLength = $bizStrategyActionPlan.jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$bizStrategyActionPlan.jqGrid('saveRow', i);
			}
 			$bizStrategyActionPlan.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$bizStrategyActionPlan.jqGrid('saveRow', gridLength+1);
		},
		
		delRowActionPlan : function(){
			$bizStrategyActionPlan.jqGrid('delRowData', $bizStrategyActionPlan.getDataIDs().length);
		},
		
		changeStatusActionPlan : function(){
			$bizStrategyActionPlan.jqGrid('saveRow', lastEditRowQ);
			var dueDate= ($bizStrategyActionPlan.jqGrid('getCell',lastEditRowQ,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($bizStrategyActionPlan.jqGrid('getCell',lastEditRowQ,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'STATUS', 'Y');
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'STATUS', 'R');
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'STATUS', 'G');
				$bizStrategyActionPlan.jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'G');
			}
			
			lastEditRowQ = 0;
		},
		
		clear : function(){
			$bizStrategyActionPlan.jqGrid('clearGridData');
		},
		
		reload : function(){
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalPK").val()
			});
			
			$bizStrategyActionPlan.jqGrid(
				'setGridParam', 
				{ 
					url : '/bizStrategy/selectBizStrategyIssue.do',
	 				mtype: 'POST',
	 				postData : params,
	 				datatype : 'json'
				}
			).trigger('reloadGrid');
		}
		
}
            
</script> 

