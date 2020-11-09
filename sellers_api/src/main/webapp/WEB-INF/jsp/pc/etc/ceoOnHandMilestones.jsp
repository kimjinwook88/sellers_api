<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table id="oppMilestone"></table>

<script type="text/javascript">
var lastEditRowMilestone;			
var initData = [
               {ROWNUM : '1', KEY_MILESTONE : '', ACT_ID:'',DUE_DATE:null,CLOSE_DATE:null,STATUS:null},
               {ROWNUM : '2', KEY_MILESTONE : '', ACT_ID:'',DUE_DATE:null,CLOSE_DATE:null,STATUS:null},
               {ROWNUM : '3', KEY_MILESTONE : '', ACT_ID:'',DUE_DATE:null,CLOSE_DATE:null,STATUS:null},
               {ROWNUM : '4', KEY_MILESTONE : '', ACT_ID:'',DUE_DATE:null,CLOSE_DATE:null,STATUS:null},
               {ROWNUM : '5', KEY_MILESTONE : '', ACT_ID:'',DUE_DATE:null,CLOSE_DATE:null,STATUS:null}
		];
		
$(document).ready(function() {
	oppMilestone.init();
});

var oppMilestone = {
		init : function(){
			
		},
		
		draw : function() {
			$("#oppMilestone").jqGrid({
	 			url : "/etc/selectCeoOnHandMilestons.do",
	 			mtype: 'POST',
	 			postData : {
	 				hiddenModalPK : $("#hiddenModalPK").val()
	 			},
				datatype : 'json',
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
					width : 330,
					editable: true
				}, {
					label : 'ACT_ID',
					name : 'ACT_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '책임 담당자',
					name : 'ACT_NAME',
					align : "center",
					width : 120,
					classes : "grid pos-rel",
					editable: true,
					editoptions: {
						  dataEvents: [
       					{ 
       						type: 'change', 
       						fn: function() {
       							oppMilestone.changeStatus();
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
					index : 'DUE_DATE',
					align : "center",
					editable: true,
					sorttype:"date",
					width : 135,
					editoptions: {
                        dataEvents: [
         					{ 
         						type: 'change', 
         						fn: function() {
         							oppMilestone.changeStatus();
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
					name : 'CLOSE_DATE',
					index : 'CLOSE_DATE',
					align : "center",
					editable: true,
					sorttype:"date",
					width : 135,
					editoptions: {
						  dataEvents: [
             					{ 
             						type: 'change', 
             						fn: function() {
             							oppMilestone.changeStatus();
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
								$("#oppMilestone").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#oppMilestone").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#oppMilestone").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								break;
							case "N":
								$("#oppMilestone").setCell(cellval.rowId,"STATUS","",{"background-color": ""});
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
				}
				//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
				],
				height : "100%",
				editurl: 'clientArray',
				shrinkToFit: true,
				onSelectRow : function(id) { //row 선택시 처리. ids는 선택한 row
					//if(id && lastEditRowMilestone != id){
						$(this).jqGrid('saveRow',lastEditRowMilestone,true);
						$(this).jqGrid('editRow',id,true);
						lastEditRowMilestone = id;
					//}
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
					var list = data.rows;
					if(list.length == 0){
						for(var i=0;i<=initData.length;i++){
			                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
			                $(this).jqGrid('addRowData',i+1,initData[i]);
			        	} 							
					}else{
						for(var i=0; i<list.length; i++ ){
							if(list[i].STATUS == 'G'){
								$("#oppMilestone").setCell(i+1,"HIDDEN_STATUS","G");
								$("#oppMilestone").setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
							}else if(list[i].STATUS == 'Y'){
								$("#oppMilestone").setCell(i+1,"HIDDEN_STATUS","Y");
								$("#oppMilestone").setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
							}else if(list[i].STATUS == 'R'){
								$("#oppMilestone").setCell(i+1,"HIDDEN_STATUS","R");
								$("#oppMilestone").setCell(i+1,"STATUS","",{"background-color": "#f20056"});
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
			$("#oppMilestone").jqGrid('clearGridData');
		},
		
		reload : function(){
			$("#oppMilestone").jqGrid('setGridParam', { 
				url : "/etc/selectCeoOnHandMilestons.do",
	 			mtype: 'POST',
	 			postData : {
	 				hiddenModalPK : $("#hiddenModalPK").val()
	 			},
				datatype : 'json'
			}).trigger('reloadGrid');
		},
		
		insert : function(){
			oppMilestone.saveRow();
			$.ajax({
					url : "/bizStrategy/insertMileStonesBizStrategyList.do",
					async : false,
					datatype : 'json',
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(!$("#hiddenModalPK").val()){
							alert("신규 등록 후 작성해 주세요.");
							return false;
						}
						if(!confirm('Key Milsestones을 저장하시겠습니까?')){
							lastEditRowMilestone = 0;
							return false;
						} 
						$.ajaxLoading();
					},
					data : {
						mileStonesData : JSON.stringify($("#oppMilestone").getRowData()),
						biz_id : $("#hiddenModalPK").val(),
						category : $("#selectModalCategory").val(),
						creator_id : $("#hiddenModalCreatorId").val()
					},
					success : function(data){
						if(data.cnt > 0){
							alert("저장하였습니다.");	
						}else{
							alert("Key Milsestones 입력을 실패했습니다.\n관리자에게 문의하세요.");
						}
						lastEditRowMilestone = 0;
						bizList.completeReload();
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
			});
		},
		
		saveRow : function(){
			for(var i=1; i <=5; i++){
				$("#oppMilestone").jqGrid('saveRow', i);
			}
			$("#oppMilestone").jqGrid('saveRow', lastEditRowMilestone);
		},
		
		changeStatus : function(){
			$("#oppMilestone").jqGrid('saveRow', lastEditRowMilestone);
			var dueDate= ($("#oppMilestone").jqGrid('getCell',lastEditRowMilestone,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#oppMilestone").jqGrid('getCell',lastEditRowMilestone,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'STATUS', 'Y');
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'HIDDEN_STATUS', 'Y');
			}else if((dueDate == "" || dueDate == null) && (closeDate == "" || closeDate == null)){
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'STATUS', 'N');
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'HIDDEN_STATUS', null);
			}else if(dueDate < nowDate && closeDate == ""){
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'STATUS', 'R');
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'STATUS', 'G');
				$("#oppMilestone").jqGrid('setCell', lastEditRowMilestone, 'HIDDEN_STATUS', 'G');
			}
			
			lastEditRowMilestone = 0;
		}
}
</script>