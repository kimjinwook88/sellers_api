<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="divIndividualHistory">
    <div class="col-sm-12 ibox float-e-margins">
        <!-- <div class="ibox-title">
            <h5>비지니스 이력</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up" id="iSalesCycleArrow"></i>
                </a>
            </div>
        </div> -->
        <div class="ibox-content" id="divSalesCycleToggle">
            <!-- 
            <div class="salescycle-step">
                <ul>
                    <li><a href="#">Identify/Validation</a></li>
                    <li><a href="#">Qualification</a></li>
                    <li><a href="#">Close</a></li>
                </ul>
            </div>
             -->
            <table id="individualHistory"></table>
	            <p class="text-center pd-t10">
	               <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="individualHistory.addRowQualification();">+ 리스트 추가</a>
	           	</p>
           		<!-- 
           		<div class="hr-line-dashed"></div>                                                                              
				<p class="text-center">
					<button type="button" class="btn btn-w-m btn-seller" id="buttonSalesCycleSave" onclick="individualHistory.insertQualification();">이전회사 저장하기</button>
				</p>
				 -->
        </div>                                                                            
    </div>
    <%-- <input type="hidden" name="hiddenClientId" id="hiddenClientId" value="${defaultInfo[0].CUSTOMER_ID}" /> --%>
</div>
                   
                   
<script type="text/javascript">
var saleCycleQualiFlag = true;
var rowspan_1 = 1;
var rowspan_2 = 1;
var rowspan_3 = 1;
var rowspan_4 = 1;

$(document).ready(function(){
	individualHistory.init();	
});

var lastEditRowIV;	
var lastEditRowQ;
var individualHistory = {
		init : function(){
			$("#divIndividualHistory").click(function(){
				individualHistory.drawQualification();
			});
		},
		
		reset : function(){
			$("div.divStepSaleCycle").hide();
			$("#individualHistory").jqGrid('clearGridData');
			individualHistory.reload();
		},
		
		reload : function(){
			$("#individualHistory").jqGrid(
				'setGridParam', 
				{
					url : "/clientManagement/selectIndividualHistory.do",
	 				mtype: 'POST',
	 				postData : {
	 					customerId : $("#hiddenClientId").val()
	 				},
	 				datatype : 'json',
	 				colModel : [ 
	 					{
	 						label : '고객개인이력 정보 선택',
	 						name : 'SELECT_INDIVIDUAL_HISTORY',
	 						align : "center",
	 						width : 240,
	 						editable: true,
	 						edittype:"select",
	 						formatter:"select",
	 						editoptions:{
	 							//value: "1:a;2:b;3:c;4:d",
	 							value: returnValue,
	 							dataEvents:[{ type:'change', fn: function(e){
	 								
	 								var rowid = $("#individualHistory").getGridParam("selrow");
	 								var rowData = $("#individualHistory").getRowData(rowid);
	 								var evalue = $(e.target).val();
	 								//alert(rowId);
	 								//console.log(rowData);
	 								
	 								$.ajax({
	 									url : "/clientManagement/selectIndividualDetail.do",
	 									datatype : 'json',
	 									data : {
	 										customerId : evalue
	 									},
	 									beforeSend : function(xhr){
	 										xhr.setRequestHeader("AJAX", true);
	 					                    $.ajaxLoading();
	 									},
	 									success : function(data){
	 										//console.log(rowid);
	 										//console.log(data.rows[0]);
	 										$("#"+rowid+"_COMPANY_NAME").val(data.rows[0].COMPANY_NAME);
	 										$("#"+rowid+"_DIVISION").val(data.rows[0].DIVISION);
	 										$("#"+rowid+"_POSITION").val(data.rows[0].POSITION);
	 										$("#"+rowid+"_CUSTOMER_NAME").val(data.rows[0].CUSTOMER_NAME);
	 										$("#"+rowid+"_COMPANY_ID").val(data.rows[0].COMPANY_ID);
	 										$("#"+rowid+"_CURRENT_CUST_ID").val($("#hiddenClientId").val());
	 										$("#"+rowid+"_BEFORE_CUST_ID").val(data.rows[0].CUSTOMER_ID);
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
	 						label : 'HISTORY_ID',
	 						name : 'HISTORY_ID',
	 						align : "center",
	 						hidden : true
	 					},{
	 						label : '회사명',
	 						name : 'COMPANY_NAME',
	 						align : "center",
	 						width : 180,
	 						editable: true
	 					},{
	 						label : '본부',
	 						name : 'DIVISION',
	 						align : "center",
	 						width : 80,
	 						editable: true
	 					},{
	 						label : '직위',
	 						name : 'POSITION',
	 						align : "center",
	 						width : 65,
	 						editable: true
	 					},{
	 						label : '고객명',
	 						name : 'CUSTOMER_NAME',
	 						align : "center",
	 						width : 70,
	 						editable: true
	 					},{
	 						label : '회사ID',
	 						name : 'COMPANY_ID',
	 						align : "center",
	 						width : 80,
	 						editable: true,
	 						hidden : true
	 					},{
	 						label : '현재 고객ID',
	 						name : 'CURRENT_CUST_ID',
	 						align : "center",
	 						width : 80,
	 						editable: true,
	 						hidden : true
	 					},{
	 						label : '이전 고객ID',
	 						name : 'BEFORE_CUST_ID',
	 						align : "center",
	 						width : 80,
	 						editable: true,
	 						hidden : true
	 					},{
	 						label : '입사일',
	 						name : 'HIRE_DATE',
	 						align : "center",
	 						width : 80,
	 						editable: true,
	 						sorttype:"date",
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
	 	                        
	 	                  	},
	 					},{
	 						label : '퇴사일',
	 						name : 'LEAVE_DATE',
	 						align : "center",
	 						width : 80,
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
	 						label : '',
	 						name : '',
	 						align : "center",
	 						width : 30,
	 						formatter: function (rowId, cellval, colpos, rwdat, _act){
	 							return "<a href='javascript:void(0);' onClick='individualHistory.deleteQualification("+colpos.HISTORY_ID+", "+colpos.BEFORE_CUST_ID+");'><i class='fa fa-times-circle'></i></a>"; 
	 						}
	 					}]
	 			}
			).trigger('reloadGrid');
		},
		
		insertQualification : function(){
			var gridLength = $("#individualHistory").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#individualHistory").jqGrid('saveRow', i);
			}
			$.ajax({
				url : "/clientManagement/insertIndividualHistory.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
				data : {
					datatype : 'json',
					individualHistoryData : JSON.stringify($("#individualHistory").getRowData()),
					customerId : $("#hiddenClientId").val(),
					creatorId : $("#hiddenModalCreatorId").val(),
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					/* if(modalFlag == 'ins') {
						alert("신규등록 완료 후 사용해 주세요.");
						return false;
					}else {
						if (!confirm("저장하시겠습니까?")){
							lastEditRowQ = 0;
							return false;	
						}
					} */
					$.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						//alert("저장하였습니다.");
						lastEditRowQ = 0;
						$("#individualHistory").jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/selectIndividualHistory.do?customerId="+$("#hiddenClientId").val()}).trigger('reloadGrid');
						$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/viewClientIndividualInfoDetail.do?"+searchSerialize}).trigger('reloadGrid');
					}else if(result.cnt == 0){
						console.log("Data empty");
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		deleteQualification : function(HISTORY_ID, BEFORE_CUST_ID){
			if(!HISTORY_ID){
				individualHistory.delRowQualification();
				return;
			}
			$.ajax({
				url : "/clientManagement/deleteIndividualHistory.do",
				async : false,
	 			datatype : 'json',
	 			type: 'POST',
				data : {
					datatype : 'json',
					customerId : $("#hiddenClientId").val(),
					HISTORY_ID : HISTORY_ID,
					CURRENT_CUST_ID : $("#hiddenClientId").val()
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
						if(confirm("삭제한 고객을 재직으로 수정 하겠습니까?")){
							individualHistory.updateClientIndividualUseYN(BEFORE_CUST_ID);
						}
						lastEditRowQ = 0;
						$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/viewClientIndividualInfoDetail.do?"+searchSerialize}).trigger('reloadGrid');
						clientSerchList.get(1, 20);
						clientList.goDetail($("#hiddenModalPK").val(), $("#hiddenModalCompanyId").val(), $("#hiddenCustomerName").val());
						individualHistory.reload();
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
			//alert("삭제 막아둠");
		},
		
		updateClientIndividualUseYN : function(BEFORE_CUST_ID) {
			$.ajax({
				url : "/clientManagement/updateClientIndividualUseYN.do",
				async : false,
	 			datatype : 'json',
	 			type: 'POST',
				data : {
					datatype : 'json',
					BEFORE_CUST_ID : BEFORE_CUST_ID
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(result){
					if(result.cnt > 0){
						alert("재직으로 변경되었습니다.");
						clientSerchList.get(1, 20);
						clientList.goDetail($("#hiddenModalPK").val(), $("#hiddenModalCompanyId").val(), $("#hiddenCustomerName").val());
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					
				}
			});
		},
		
		drawQualification : function(){
			//$("#individualHistory").jqGrid('clearGridData');
			$("#individualHistory").jqGrid({
	 			url : "/clientManagement/selectIndividualHistory.do?customerId="+$("#hiddenClientId").val(),
				datatype : 'json',
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '고객개인이력 정보 선택',
					name : 'SELECT_INDIVIDUAL_HISTORY',
					align : "center",
					width : 240,
					editable: true,
					edittype:"select",
					formatter:"select",
					editoptions:{
						//value: "1:a;2:b;3:c;4:d",
						value: returnValue,
						dataEvents:[{ type:'change', fn: function(e){
							
							var rowid = $("#individualHistory").getGridParam("selrow");
							var rowData = $("#individualHistory").getRowData(rowid);
							var evalue = $(e.target).val();
							//alert(rowId);
							//console.log(rowData);
							
							$.ajax({
								url : "/clientManagement/selectIndividualDetail.do",
								datatype : 'json',
								data : {
									customerId : evalue
								},
								beforeSend : function(xhr){
									xhr.setRequestHeader("AJAX", true);
				                    $.ajaxLoading();
								},
								success : function(data){
									//console.log(rowid);
									//console.log(data.rows[0]);
									$("#"+rowid+"_COMPANY_NAME").val(data.rows[0].COMPANY_NAME);
									$("#"+rowid+"_DIVISION").val(data.rows[0].DIVISION);
									$("#"+rowid+"_POSITION").val(data.rows[0].POSITION);
									$("#"+rowid+"_CUSTOMER_NAME").val(data.rows[0].CUSTOMER_NAME);
									$("#"+rowid+"_COMPANY_ID").val(data.rows[0].COMPANY_ID);
									$("#"+rowid+"_CURRENT_CUST_ID").val($("#hiddenClientId").val());
									$("#"+rowid+"_BEFORE_CUST_ID").val(data.rows[0].CUSTOMER_ID);
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
					label : 'HISTORY_ID',
					name : 'HISTORY_ID',
					align : "center",
					hidden : true
				},{
					label : '회사명',
					name : 'COMPANY_NAME',
					align : "center",
					width : 180,
					editable: true
				},{
					label : '본부',
					name : 'DIVISION',
					align : "center",
					width : 80,
					editable: true
				},{
					label : '직위',
					name : 'POSITION',
					align : "center",
					width : 65,
					editable: true
				},{
					label : '고객명',
					name : 'CUSTOMER_NAME',
					align : "center",
					width : 70,
					editable: true
				},{
					label : '회사ID',
					name : 'COMPANY_ID',
					align : "center",
					width : 80,
					editable: true,
					hidden : true
				},{
					label : '현재 고객ID',
					name : 'CURRENT_CUST_ID',
					align : "center",
					width : 80,
					editable: true,
					hidden : true
				},{
					label : '이전 고객ID',
					name : 'BEFORE_CUST_ID',
					align : "center",
					width : 80,
					editable: true,
					hidden : true
				},{
					label : '입사일',
					name : 'HIRE_DATE',
					align : "center",
					width : 80,
					editable: true,
					sorttype:"date",
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
                        
                  	},
				},{
					label : '퇴사일',
					name : 'LEAVE_DATE',
					align : "center",
					width : 80,
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
					label : '',
					name : '',
					align : "center",
					width : 30,
					formatter: function (rowId, cellval, colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='individualHistory.deleteQualification("+colpos.HISTORY_ID+", "+colpos.BEFORE_CUST_ID+");'><i class='fa fa-times-circle'></i></a>"; 
					}
				}
				],
				loadui: 'disable',
				loadonce : false,
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
					//noDataFn(this);
					//$.ajaxLoading();
					
					/* 결과 내 검색을 위한 작업  */
					/* var pkArray = [];
				    for(var key in data.rows) {
				      if(data.rows[key].OPPORTUNITY_ID) {
				    	  pkArray.push(data.rows[key].OPPORTUNITY_ID);
				      } 
				    } */
				    
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
			
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
			if(modalFlag == 'ins') {
				alert("신규등록 완료 후 사용해 주세요.");
			}else {
				$("#individualHistory").jqGrid('addRow', {
					rowID : $("#individualHistory").getDataIDs().length+1, 
		        	position :"last"           //first, last
				});
			}
		},
		
		delRowQualification : function(){
			$("#individualHistory").jqGrid('delRowData', $("#individualHistory").getDataIDs().length);
		},
}

</script> 