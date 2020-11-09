<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="form-group"><label class="col-sm-2 control-label">고객사</label>
	<div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalModifiedCompanyName" name="textModalModifiedCompanyName"/></div>
	<label class="col-sm-2 control-label">고객사ID</label>
	<div class="col-sm-4"><input type="text" class="form-control" id="textModalModifiedCompanyId" name="textModalModifiedCompanyId" readonly="readonly"/></div>
</div>
<div class="hr-line-dashed"></div>
<div class="form-group"><label class="col-sm-2 control-label">응답자명</label>
	<div class="col-sm-4"><input type="text" class="form-control" id="textModalModifiedCustomerName" name="textModalModifiedCustomerName"/></div>
	<label class="col-sm-2 control-label">만족도</label>
	<div class="col-sm-4">
		<div class="select-com">
			<select class="form-control" id="selectModalModifiedValue" name="selectModalModifiedValue">
				<option value="매우만족">매우만족</option>
				<option value="만족">만족</option>
				<option value="불만족">불만족</option>
			</select>
		</div>
	</div>
	<!-- <input type="text" class="form-control" id="textModalModifiedValue" name="textModalModifiedValue"/></div> -->
</div>
<div class="hr-line-dashed"></div>
<div class="form-group"><label class="col-sm-2 control-label">상세내용</label>
	<div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textModalModifiedDetail" name="textModalModifiedDetail"
	 onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
</div>
<div class="hr-line-dashed"></div>
<div class="form-group"><label class="col-sm-2 control-label" for="date_modified">조사일</label>
	<div class="col-xs-12 col-sm-4 pd-b10">
	    <div class="data_1">
	        <div class="input-group date">
	            <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textModalModifiedDate" id="textModalModifiedDate" value="">
	        </div>
	    </div>
	</div>
	<label class="col-sm-2 control-label">조사방법</label>
	<div class="col-sm-4">
		<div class="select-com">
			<select class="form-control" id="selectModalModifiedMethod" name="selectModalModifiedMethod">
				<option value="대면">대면</option>
				<option value="전화">전화</option>
				<option value="메일">메일</option>
			</select>
		</div>
	</div>
	<!-- <div class="col-sm-4"><input type="text" class="form-control" id="textModalModifiedMethod" name="textModalModifiedMethod"/></div> -->
	
</div>

<div class="hr-line-dashed"></div>
<div class="form-group" id="divIssueAdd"><label class="col-sm-2 control-label">이슈추가</label>
	<div class="col-sm-4">
		<input type="checkbox" value="N" class="" name="checkboxIssue" id="checkboxIssue" style="margin-top:10px;"/>&nbsp;
		<!-- <a href="/clientSatisfaction/listClientContact.do?returnPK" class="oppStatusColor oppStatusColor-complete">바로가기</a> -->
	</div>
</div>
<div class="form-group" id="divIssueLink"><label class="col-sm-2 control-label">이슈여부</label>
	<div class="col-sm-4" id="relationIssue">
	</div>
</div>

<input type="hidden" id="hiddenModalModifiedDetailId" name="hiddenModalModifiedDetailId">

<script type="text/javascript">
var modalModifiedFlag = 'ins/upd';
var lastGridIssueId;

$(document).ready(function() {
	modalDetail.init();
});

var modalDetail = {
		init : function(){
			//유효성 체크
			modalDetail.validate();
			
			//자동완성 검색
			//commonSearch.member($("#formModalData #textModalExecOwner"), $('#formModalData #hiddenModalExecId')); //실행임원
			//commonSearch.member($("#formModalData #textModalOpportunityOwner"), $('#formModalData #hiddenModalOwnerId')); //OO
			//commonSearch.member($("#formModalData #textModalOpportunityIdentifier"), $('#formModalData #hiddenModalIdentifierId')); //OI
			commonSearch.company($('#formModalData #textModalModifiedCompanyName'), $('#formModalData #textModalModifiedCompanyId'), $('#formModalData #textModalModifiedCompanyId'));
			//commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
		},
		
		validate : function(){
			
		},
		
		gotoDetail : function(num) {
			if(num != 2){
				$("#textModalModifiedCompanyName").val('');
				$("#textModalModifiedCompanyId").val('');
				$("#textModalModifiedCustomerName").val('');
				$("#selectModalModifiedValue").val('매우만족');
				$("#textModalModifiedDetail").val('');
				$("#textModalModifiedDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
				$("#selectModalModifiedMethod").val('대면');
				$("#hiddenModalModifiedDetailId").val('');
				//$("#buttonModalModifiedDelete").hide();
			}
			$('#formReturnIssue input[type="hidden"]').val(""); 
			$("#checkboxIssue").attr("checked", false);
			
			if(modalModifiedFlag == 'ins') {
				$("#divIssueAdd").show();
				$("#divIssueLink").hide();
			}else{
				$("#divIssueAdd").hide();
				$("#divIssueLink").show();
			}
			
			var idx = $("ul.tabmenu-type li a").index($("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a"));
			$("ul.tabmenu-type li a").removeClass("sel");
			$("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		},
		
		issueCheck : function (csatDetailId) {
			$.ajax({
				url : "/clientSatisfaction/gridClientSatisfactionDetailIssue.do",
				async : false,
				datatype : 'json',
				data : {
					pkNo : csatDetailId
	    		},
	    		beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					if(data.rows.length == 0){
						$("#relationIssue").html("<a class=\"oppStatusColor oppStatusColor-complete\" id=\"issueAddLink\" onclick=\"modal.gotoIssue('addlink');\">등록하기</a>");
					}else {
						$("#relationIssue").html('<a href="/clientSatisfaction/listClientIssue.do?issue_id='+data.rows[0].ISSUE_ID+'" class="oppStatusColor oppStatusColor-complete" id="issueGotoLink">바로가기</a>');
					}
				},
				complete: function(){
					
				}
			});
		},
		
		drawIssueSolvePlan : function(){
			$("#detailIssueSolvePlanGrid").jqGrid('clearGridData');
			$("#detailIssueSolvePlanGrid").jqGrid({
				url : "/clientSatisfaction/gridClientSatisfactionDetailIssue.do?pkNo="+$("#hiddenModalModifiedDetailId").val(),
				datatype : 'json',
				colModel : [ 
				{
					label : '이슈내용',
					name : 'ISSUE_DETAIL',
					align : "center",
					width : 170,
					editable: true,
					edittype:'textarea'
				}, {
					label : '해결계획',
					name : 'SOLVE_PLAN',
					align : "center",
					width : 170,
					editable: true,
					edittype:'textarea'
				}, {
					label : '책임자',
					name : 'SOLVE_OWNER',
					align : "center",
					width : 70,
					editable: true
				},{
					label : '해결목표일',
					name : 'DUE_DATE',
					align : "center",
					width : 80,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modalDetail.changeStatus();
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
					label : '실제완료일',
					name : 'CLOSE_DATE',
					align : "center",
					width : 80,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modalDetail.changeStatus();
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
					width : 45,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$("#detailIssueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#detailIssueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#detailIssueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
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
					label : '',
					name : '삭제',
					align : "center",
					width : 45,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='modalDetail.delRow();'><i class='fa fa-trash-o fa-lg'></i></a>"; 
					}
				},{
					label : 'HIDDEN_STATUS',
					name : 'HIDDEN_STATUS',
					hidden : true
				},{
					label : 'ACTION_ID',
					name : 'ACTION_ID',
					hidden : true
				}
				],
				loadui: 'disable',
				loadonce : true,
				viewrecords : true,
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					lastGridIssueId = id;
					var rowData = $(this).jqGrid("getRowData",id);
					if(id && lastGridIssueId != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastGridIssueId);
						lastGridIssueId = id;
					}else if(lastGridIssueId == id){
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
					var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						if(list[i].STATUS == 'G'){
							$("#detailIssueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$("#detailIssueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$("#detailIssueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
		},
		
		solvePlanReload : function(){
			$("#detailIssueSolvePlanGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridSolvePlanClientSatisfactionDetail.do?pkNo="+$("#hiddenModalModifiedDetailId").val()}).trigger('reloadGrid');
		},
		
		addRow : function(){
			var gridLength = $("#detailIssueSolvePlanGrid").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#detailIssueSolvePlanGrid").jqGrid('saveRow', i);
			}
 			$("#detailIssueSolvePlanGrid").jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$("#detailIssueSolvePlanGrid").jqGrid('saveRow', gridLength+1);
		},
		
		delRow : function(){
			$("#detailIssueSolvePlanGrid").jqGrid('delRowData', $("#detailIssueSolvePlanGrid").getDataIDs().length);
		},
		
		changeStatus : function(){
			$("#detailIssueSolvePlanGrid").jqGrid('saveRow', lastGridIssueId);
			var dueDate= ($("#detailIssueSolvePlanGrid").jqGrid('getCell',lastGridIssueId,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#detailIssueSolvePlanGrid").jqGrid('getCell',lastGridIssueId,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'STATUS', 'Y');
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'STATUS', 'R');
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'STATUS', 'G');
				$("#detailIssueSolvePlanGrid").jqGrid('setCell', lastGridIssueId, 'HIDDEN_STATUS', 'G');
			}
			
			lastGridIssueId = 0;
		},
		
		submit : function(){
			$("#detailIssueSolvePlanGrid").jqGrid('saveRow', lastGridIssueId);
			var url;
			
			if(modalModifiedFlag == "ins"){
				url = "/clientSatisfaction/insertClientSatisfactionDetail.do";
			}else if(modalModifiedFlag == "upd"){
				url = "/clientSatisfaction/updateClientSatisfactionDetail.do";
				//follow up action
			}
			$('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			detailIssueSolvePlanGrid : JSON.stringify($("#detailIssueSolvePlanGrid").getRowData())
	    		},
	    		beforeSubmit: function (data,form,option) {
	    			
	            },
	    		beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	                //성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	compareFlag = false;
	                	alert("저장하였습니다.");
	                	//if(modalModifiedFlag=="ins") $('#myModal1').modal("hide");
	                	//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfaction.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
	                	
	                	modalModifiedFlag = "ins/upd";
						modalDetail.gotoDetail('1');
	                	
	                	//details 그리드 생성
						details.clear();
						details.draw();
						details.reload();
						
						compare_before = $("#formModalData").serialize();
	                	
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            complete: function() {
	            	
				} 
	        });
		}
}

</script>