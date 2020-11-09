<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table id="projectIssue"></table>
<p class="text-center pd-t10">
   <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="projectIssue.addRowQualification();">+ 프로젝트 이슈 추가</a>
</p>
                   
<script type="text/javascript">
var saleCycleQualiFlag = true;
var rowspan_1 = 1;
var rowspan_2 = 1;
var rowspan_3 = 1;
var rowspan_4 = 1;

$(document).ready(function(){
	projectIssue.init();	
});
var lastEditRowIV;	
var lastEditRowQ;
/* var initData =[
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}}
               ]; */
var projectIssue = {
		init : function(){
			/* 
			$("div.salescycle-step li").click(function(){
				if($(this).hasClass("active")){
					$("div.divStepSaleCycle").hide();
					$("div.divStepSaleCycle").eq($("div.salescycle-step li").index($(this))).show();
					projectIssue.buttonStep($("div.salescycle-step li").index($(this))+1);
				}
			});
			 */
		},
		
		reset : function(){
			$("div.divStepSaleCycle").hide();
			$("#projectIssue").jqGrid('clearGridData');
			$("#projectIssue").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $("#projectIssue").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#projectIssue").jqGrid('saveRow', i);
			}
			$("#projectIssue").jqGrid('saveRow', lastEditRowQ);
		},
		
		insertQualification : function(){
			$.ajax({
				url : "/clientSatisfaction/insertProjectIssue.do",
				datatype : 'json',
				data : {
					projectIssueData : JSON.stringify($("#projectIssue").getRowData()),
					hiddenModalPK : $("#hiddenModalPK").val(),
					creator_id : $("#hiddenModalCreatorId").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("저장하시겠습니까?")){
						lastEditRowQ = 0;
						return false;	
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("저장하였습니다.");
						lastEditRowQ = 0;
						$("#projectIssue").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
						$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectMGMT.do?"+searchSerialize}).trigger('reloadGrid');
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		updateClose : function(){
			$.ajax({
				url : "/clientSatisfaction/updateProjectIssue.do",
				datatype : 'json',
				data : {
					hiddenModalPK : $("#hiddenModalPK").val(),
					CLOSE_CATEGORY : $("#selectSalesCloseCategory").val(), 
					CLOSE_DETAIL : $("#textareaSalesCloseDetail").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("저장하시겠습니까?")){
						return false;	
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("저장하였습니다.");
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		deleteQualification : function(ISSUE_ID){
			if(!ISSUE_ID){
				projectIssue.delRowQualification();
				return;
			}
			$.ajax({
				url : "/clientSatisfaction/deleteProjectIssue.do",
				datatype : 'json',
				data : {
					hiddenModalPK : $("#hiddenModalPK").val(),
					ISSUE_ID : ISSUE_ID
				},
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
						$("#projectIssue").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectIssue.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
						$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectMGMT.do?"+searchSerialize}).trigger('reloadGrid');
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		drawQualification : function(){
			//$("#projectIssue").jqGrid('clearGridData');
			$("#projectIssue").jqGrid({
	 			url : "/clientSatisfaction/gridProjectIssue.do?hiddenModalPK="+$("#hiddenModalPK").val(),
				datatype : 'json',
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '단계',
					name : 'CHECKLIST_SEQ',
					align : "center",
					width : 50,
					editable: true,
					edittype:"select",
					formatter:'select',
					editoptions:{
						value:"1:분석;2:설계;3:구현;4:테스트;5:이행"
					}
				},{
					label : '이슈내용',
					name : 'ISSUE_DETAIL',
					align : "left",
					width : 165,
					editable: true
				},{
					label : '해결계획',
					name : 'SOLVE_PLAN',
					align : "left",
					width : 205,
					editable: true
				},{
					label : '발생일',
					name : 'ISSUE_DATE',
					align : "center",
					width : 75,
					editable: true,
					editoptions: {
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
				},{
					label : 'SOLVE_OWNER_ID',
					name : 'SOLVE_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '책임 담당자',
					name : 'SOLVE_OWNER',
					align : "center",
					width : 90,
					editable: true,
					classes : "grid pos-rel",
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
				},{
					label : '해결기한',
					name : 'DUE_DATE',
					align : "center",
					width : 75,
					editable: true,
					editoptions: {
						dataEvents: [
         					{ 
         						type: 'change', 
         						fn: function() {
         							projectIssue.changeStatus();
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
				},{
					label : '해결일',
					name : 'ISSUE_CLOSE_DATE',
					align : "center",
					width : 75,
					editable: true,
					editoptions: {
						dataEvents: [
         					{ 
         						type: 'change', 
         						fn: function() {
         							projectIssue.changeStatus();
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
				},{
					label : 'Status',
					name : 'ISSUE_STATUS',
					align : "center",
					width : 45,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							$("#projectIssue").setCell(cellval.rowId,"ISSUE_STATUS_COLOR",rowId);
							switch (rowId) {
							case "G":
								$("#projectIssue").setCell(cellval.rowId,"ISSUE_STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#projectIssue").setCell(cellval.rowId,"ISSUE_STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#projectIssue").setCell(cellval.rowId,"ISSUE_STATUS","",{"background-color": "#f20056"});
								break;
							case "N":
								$("#projectIssue").setCell(cellval.rowId,"ISSUE_STATUS","",{"background-color": ""});
								break;
							default:
								return "";
								break;
							}	
						}else{
							return "";
						}
					}
				},{
					label : 'ISSUE_STATUS_COLOR',
					name : 'ISSUE_STATUS_COLOR',
					hidden : true,
					classes : 'issue_status_color'
				},{
					label : 'ISSUE_ID',
					name : 'ISSUE_ID',
					hidden : true
				},{
					label : '삭제',
					name : 'del',
					align : "center",
					width : 40,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='projectIssue.deleteQualification("+colpos.ISSUE_ID+");'><i class='fa fa-trash-o fa-lg'></i></a>";
					}
				}
				],
				loadui: 'disable',
				loadonce : true,
				viewrecords : true,
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					if(id && lastEditRowQ != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastEditRowQ);
						lastEditRowQ = id;
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
					var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						$("#projectIssue").setCell(i+1,"ISSUE_STATUS_COLOR",list[i].ISSUE_STATUS);
						if(list[i].ISSUE_STATUS == 'G'){
							$("#projectIssue").setCell(i+1,"ISSUE_STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].ISSUE_STATUS == 'Y'){
							$("#projectIssue").setCell(i+1,"ISSUE_STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].ISSUE_STATUS == 'R'){
							$("#projectIssue").setCell(i+1,"ISSUE_STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
			/* 	
			if(saleCycleQualiFlag){
				$("#projectIssue").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'ISSUE_DATE', numberOfColumns: 5, titleText: 'How to Fix'},
					  ]
				});
				saleCycleQualiFlag = false;
			} */
		},
		
		
		
		addRowValidation : function(seq,status,rownum){
			/* rowId : 추가되는 행의 ID를 설정해줍니다.
			data : 추가될 데이터입니다. 기존에 존재하는 데이터의 길이가 같아야 합니다.
			position : 데이터가 추가될 위치를 정해줍니다. ‘first’, ‘last’, ‘before’, ‘after’ 4가지의 속성이 있습니다.
			srcRowId : position의 값이 ‘before’, ‘after’일 때 설정해줍니다. ID값이 들어옵니다.
			 */
			//initData = [{ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}}];
			var rowspanCount;
			switch (seq) {
				case 1:
					rowspan_1++;
					rowspanCount = rowspan_1; 
					break;
				case 2:
					rowspan_2++;
					rowspanCount = rowspan_2;
					break;
				case 3:
					rowspan_3++;
					rowspanCount = rowspan_3;
					break;
				case 4:
					rowspan_4++;
					rowspanCount = rowspan_4;
					break;
			}

			//console.log($("#1_CHECKLIST_NAME option").eq(0));
			//$("#1_CHECKLIST_NAME option").eq(0).css({"background":"url(/img/p7.jpg)", 'background-repeat' : 'no-repeat', 'background-position':'center center'});
		},
		
		delRowValidation : function(seq,status,rownum){
			var rowspanCount;
			switch (seq) {
				case 1:
					rowspan_1--;
					rowspanCount = rowspan_1; 
					break;
				case 2:
					rowspan_2--;
					rowspanCount = rowspan_2;
					break;
				case 3:
					rowspan_3--;
					rowspanCount = rowspan_3;
					break;
				case 4:
					rowspan_4--;
					rowspanCount = rowspan_4;
					break;
			}
		},
		
		addRowQualification : function(){
			$("#projectIssue").jqGrid('addRow', {
				rowID : $("#projectIssue").getDataIDs().length+1, 
		        position :"last"           //first, last
			});
		},
		
		delRowQualification : function(){
			$("#projectIssue").jqGrid('delRowData', $("#projectIssue").getDataIDs().length);
		},
		
		changeStatus : function(){
			$("#projectIssue").jqGrid('saveRow', lastEditRowQ);
			var dueDate= ($("#projectIssue").jqGrid('getCell',lastEditRowQ,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#projectIssue").jqGrid('getCell',lastEditRowQ,'ISSUE_CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'ISSUE_STATUS', 'Y');
				//$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'Y');
			}else if((dueDate == "" || dueDate == null) && (closeDate == "" || closeDate == null)){
				$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'ISSUE_STATUS', 'N');
				//$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', null);
			}else if(dueDate < nowDate && closeDate == ""){
				$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'ISSUE_STATUS', 'R');
				//$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'ISSUE_STATUS', 'G');
				//$("#projectIssue").jqGrid('setCell', lastEditRowQ, 'HIDDEN_STATUS', 'G');
			}
			lastEditRowQ = 0;
		}
}

</script> 
