<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	        <div class="form-group"><label class="col-sm-2 control-label">평가 평균</label>
                <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCsatDetailAVG" name="textModalCsatDetailAVG" readonly="readonly"/></div>
                <label class="col-sm-2 control-label">조사 건수</label>
                <div class="col-sm-4"><input type="text" class="form-control" id="textModalCsatDetailCount" name="textModalCsatDetailCount" readonly="readonly"/></div>
            </div>
            <div class="hr-line-dashed"></div>                               
	        <div class="col-sm-12">
            <div class="form-group">
            	<table name="clientSatisfactionDetail" id="clientSatisfactionDetail"></table>
            	<p class="text-right">*고객사명, *조사일은 필수 입력값 입니다.</p>
           	</div>
			<p class="text-center pd-t10">
				<!-- <button type="button" class="btn btn-outline btn-seller-outline" onClick="modalModifiedFlag='ins'; modalDetail.gotoDetail(2);">조사결과 추가</button> -->
				<button type="button" class="btn-row-add" onClick="details.addRow();">조사결과 추가</button>
				<!-- <button type="submit" class="btn btn-w-m btn-seller" onclick="modalDetail.submit();" id="buttonModalModifiedSubmit">저장하기</button> -->
			</p>
			<div class="hr-line-bottom"></div>
        </div>
        

<script type="text/javascript">
var lastEditRow;
var initData = [
                // {ROWNUM : '1', COMPANY_ID : ' ', CSAT_SURVEY_NAME:' ',CSAT_METHOD:' ',CSAT_VALUE:' ',CSAT_DETAIL:' ',CSAT_SURVEY_DATE:' '} 
			];

$(document).ready(function() {
});
var loadnum = 0;
var details = {
			draw : function() {
				$("#clientSatisfactionDetail").jqGrid('clearGridData');
				$("#clientSatisfactionDetail").jqGrid({ 
		 			url : "/clientSatisfaction/gridClientSatisfactionDetailList.do?csat_id="+$("#hiddenModalPK").val(),
					datatype : 'json',
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : 'No',
						name : 'ROWNUM',
						align : "center",
						width : 40,
						hidden : true
					}, {
						label : '고객사명',
						name : 'COMPANY_NAME',
						classes : "pos-rel",
						align : "left",
						width : 160,
						editable: true,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             						} 
	             					}
								],
								dataInit: function (element,rwdat) {
									commonSearch.companyGrid($(element), $(element).parent('td').siblings(".company_id"), null);
	                            }
						}
					}, {
						label : '응답자',
						name : 'RESP_CUSTOMER_NAME',
						classes : "pos-rel",
						align : "center",
						width : 65,
						editable: true,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             						} 
	             					}
								],
								dataInit: function (element,rwdat) {
									commonSearch.customerGrid($(element), $(element).parent('td').siblings(".resp_customer_id"), $(element).parent('td').siblings(".resp_customer_rank"), $(element).parent('td').siblings(".company_id").html());
	                            }
						}
					}, {
						label : '조사방법',
						name : 'CSAT_METHOD',
						index : "CSAT_METHOD",
						align : "center",
						edittype:"select",
						editable: true,
						width : 65,
						editoptions:{
							value:"대면:대면;전화:전화;메일:메일" //대소문자 유의!
						}
					}, {
						label : '평가',
						align : "center",
						name : 'CSAT_VALUE',
						index : "CSAT_VALUE",
						editable: true,
						edittype:"select",
						width : 50,
						editoptions:{
							value:"5:5;4:4;3:3;2:2;1:1" //대소문자 유의!
						}
					}, {
						label : '코멘트',
						name : 'CSAT_DETAIL',
						align : "left",
						editable: true,
						width : 255
					}, {
						label : '이슈',
						name : 'ISSUE_LINK',
						align : "center",
						width : 80,
						formatter: function (rowId, cellval , colpos, rwdat, _act){
							if(!isEmpty(colpos.ISSUE_ID)){
								return "<a class=\"oppStatusColor oppStatusColor-complete\" id=\""+ cellval.rowId +"_issueGotoLink\" onclick=\"modal.gotoIssue('gotolink' ,'"+ colpos.ISSUE_ID +"');\">바로가기</a>";
							}else if(!isEmpty(colpos.RESP_CUSTOMER_ID)){
								return "<a class=\"oppStatusColor oppStatusColor-complete\" id=\""+ cellval.rowId +"_issueAddLink\" onclick=\"modal.gotoIssue('addlink','"+ colpos.CSAT_DETAIL_ID +"','"+ colpos.COMPANY_NAME +"','"+ colpos.COMPANY_ID +"','"+ colpos.RESP_CUSTOMER_NAME +"','"+ colpos.RESP_CUSTOMER_RANK +"','"+ colpos.RESP_CUSTOMER_ID +"');\">등록하기</a>";
							}else{
								return "";
							}
						}
					}, {
						label : '조사일',
						name : 'CSAT_SURVEY_DATE',
						index : 'CSAT_SURVEY_DATE',
						align : "center",
						editable: true,
						sorttype:"date",
						width : 85,
						editoptions: {
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
						label : '',
						name : '',
						align : "center",
						width : 30,
						formatter: function (rowId, cellval , colpos, rwdat, _act){
							return "<a href='javascript:void(0);' onClick='details.deleteDetail("+colpos.CSAT_DETAIL_ID+");'><i class='fa fa-times-circle'></i></a>"; 
						}
					}, {
						label : 'COMPANY_ID',
						name : 'COMPANY_ID',
						hidden : true,
						classes : "company_id"
					}, {
						label : 'CSAT_DETAIL_ID',
						name : 'CSAT_DETAIL_ID',
						hidden : true
					}, {
						label : 'ISSUE_ID',
						name : 'ISSUE_ID',
						hidden : true
					}, {
						label : 'RESP_CUSTOMER_ID',
						name : 'RESP_CUSTOMER_ID',
						hidden : true,
						classes : "resp_customer_id"
					}, {
						label : 'RESP_CUSTOMER_RANK',
						name : 'RESP_CUSTOMER_RANK',
						hidden : true,
						classes : "resp_customer_rank"
					}
					//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
					],
					/* loadui: 'disable',
					loadonce : true,
					viewrecords : true,
					height : "100%",
					autowidth : true, */
					height : "100%",
					shrinkToFit: true,
					/* onCellSelect : function(ids, icol) { //row 선택시 처리. ids는 선택한 row
						//신규등록일시 return;
						if(!$("#hiddenModalPK").val()){
							alert("신규 등록 후 작성해 주세요.");
							return;
						}
						if(ids && lastEditRow != ids){
							if(icol == 7) {
								return;
							}else {
								var rowData = $(this).jqGrid("getRowData",ids);
								modalDetail.issueCheck(rowData.CSAT_DETAIL_ID);
								
								modalModifiedFlag = "upd"; //업데이트
								$("#textModalModifiedCompanyName").val(rowData.COMPANY_NAME);			//고객사명
								$("#textModalModifiedCompanyId").val(rowData.COMPANY_ID);				//고객사ID
								$("#textModalModifiedCustomerName").val(rowData.RESP_CUSTOMER_NAME);	//응답자명
								$("#selectModalModifiedValue").val(rowData.CSAT_VALUE);					//고객만족밸류
								$("#textModalModifiedDetail").val(rowData.CSAT_DETAIL);					//고객만족상세
								$("#textModalModifiedDate").val(rowData.CSAT_SURVEY_DATE);				//조사일
								$("#hiddenModalModifiedDetailId").val(rowData.CSAT_DETAIL_ID);			//조사일
								//alert($("#hiddenModalModifiedDetailId").val());
								//$("#buttonModalModifiedDelete").show();
								
			                	//modalDetail.drawIssueSolvePlan();
								//modalDetail.solvePlanReload();
						               
								modalDetail.gotoDetail('2');
								compare_before = $("#formModalData").serialize();
							}
						}
					}, */
					onSelectRow : function(id) { //row 선택시 처리. ids는 선택한 row
						//신규등록일시 return;
						if(!$("#hiddenModalPK").val()){
							alert("신규 등록 후 작성해 주세요.");
							return;
						}
						if(id && lastEditRow != id){
							$(this).jqGrid('saveRow', lastEditRow,true);
							$(this).jqGrid('editRow',id,true);
							lastEditRow = id;
							$("#"+ id +"_issueAddLink").remove();
						}else if(lastEditRow == id){
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
						loadnum = jQuery("#clientSatisfactionDetail").getDataIDs().length;
						if(data.rows.length == 0){
							for(var i=0;i<=initData.length;i++){
				                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 addRow한다
				                $(this).jqGrid('addRowData',i+1,initData[i]);
				        	} 							
						}
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			},
			
			clear : function(){
				$("#clientSatisfactionDetail").jqGrid('clearGridData');
			},
			
			reload : function(){
				$("#clientSatisfactionDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfactionDetailList.do?csat_id="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
			},
			
			
			
			
			insert : function(){
				var gridLength = $("#clientSatisfactionDetail").jqGrid('getGridParam', 'records');
				var chkCnt = 0;
				
				for(var i=1; i<=gridLength; i++){
					$("#clientSatisfactionDetail").jqGrid('saveRow', i);
				}
				
				$.each($("#clientSatisfactionDetail").getRowData(), function(i ,val){
					if(!this.CSAT_SURVEY_DATE){
						chkCnt++;
					}
				});
				
				if(chkCnt > 0){
					alert("조사일을 입력해 주세요."); 
					lastEditRow = 0;
					return;
				} 
				
				$.ajax({
						url : "/clientSatisfaction/insertClientSatisfactionDetailList.do",
						datatype : 'json',
						data : {
							detailsData : JSON.stringify($("#clientSatisfactionDetail").getRowData()),
							hiddenModalPK : $("#hiddenModalPK").val(),
							creator_id : $("#hiddenModalCreatorId").val()
						},
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							if(!confirm('ClientSatisfaction Detail을 저장하시겠습니까?')){
								lastEditRow = 0;
								return false;								
							} 
							$.ajaxLoading();
						},
						success : function(data){
							$("#clientSatisfactionDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfactionDetailList.do?csat_id="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
				}).done(function(data){
					if(data.cnt > 0){
						alert("저장하였습니다.");
						lastEditRow = 0;
						details.reload();
					}else{
						alert("ClientSatisfaction Detail 입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
				});
				
			},
			
			addRow : function(){
				if(!$("#hiddenModalPK").val()){
					alert("신규 등록 후 작성해 주세요.");
					return;
				}
				jQuery("#clientSatisfactionDetail").jqGrid('addRow', {
					rowID : jQuery("#clientSatisfactionDetail").getDataIDs().length+1, 
					initdata : {ROWNUM : jQuery("#clientSatisfactionDetail").getDataIDs().length+1},
			        position :"last"           //first, last
				});
			},
			
			delRow : function(){
				jQuery("#clientSatisfactionDetail").jqGrid('delRowData', jQuery("#clientSatisfactionDetail").getDataIDs().length);
			},
			
			
			
			deleteDetail : function(csat_detail_id){
				if(!csat_detail_id){
					details.delRow();
					return;
				}
				$.ajax({
					url : "/clientSatisfaction/deleteClientSatisfactionDetailList.do",
					datatype : 'json',
					data : {
						hiddenModalPK : $("#hiddenModalPK").val(),
						csat_detail_id : csat_detail_id
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("삭제하시겠습니까?"))
						return false;
	                    $.ajaxLoading();
					},
					success : function(result){
						if(result.cnt > 0){
							alert("삭제되었습니다.");
							modal.detailCalculation();
							$("#clientSatisfactionDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfactionDetailList.do?csat_id="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
}
</script>