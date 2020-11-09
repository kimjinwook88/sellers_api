<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="divProjectIssue">
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
            <table id="salesDetail"></table>
	            <p class="text-center pd-t10">
	               <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="salesDetail.addRowQualification();">+ 리스트 추가</a>
	           	</p>
           		<!-- <div class="hr-line-dashed"></div>                                                                              
				<p class="text-center">
					<button type="button" class="btn btn-w-m btn-seller" id="buttonSalesCycleSave" onclick="salesDetail.insertQualification();">스킬정보 저장하기</button>
				</p> -->
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
	salesDetail.init();	
});

var returnValue = "";
<c:choose>
	<c:when test="${fn:length(VendorSolutionArea) > 0}">
 		<c:forEach items="${VendorSolutionArea}" var="VendorSolutionAreaList" varStatus="i">
 		<c:choose>
 		<c:when test="${i.index == 0 && VendorSolutionAreaList.PRODUCT_VENDOR != VendorSolutionArea[i.index - 1].PRODUCT_VENDOR}">
			returnValue += "${VendorSolutionAreaList.PRODUCT_VENDOR}:${VendorSolutionAreaList.PRODUCT_VENDOR}";
		</c:when>
		<c:when test="${i.index != 0 && VendorSolutionAreaList.PRODUCT_VENDOR != VendorSolutionArea[i.index - 1].PRODUCT_VENDOR}">
			returnValue += ";${VendorSolutionAreaList.PRODUCT_VENDOR}:${VendorSolutionAreaList.PRODUCT_VENDOR}";
		</c:when>
 		</c:choose>
    	</c:forEach>
 	</c:when>
</c:choose>

var lastEditRowIV;	
var lastEditRowQ;
/* var initData =[
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}},
						{CHECKLIST_SEQ:'1',STATUS:'G',ACTION_PLAN_NAME:'',ACTION_OWNER:null,DUE_DATE:null,CLOSE_DATE:null,NOTE:null,attr: {CHECKLIST_SEQ: {display: 'none'}, STATUS: {display: 'none'}}}
               ]; */
  var salesDetail = {
		init : function(){
			$("#divProjectIssue").click(function(){
				salesDetail.drawQualification();
			});
		},
		
		reset : function(){
			$("div.divStepSaleCycle").hide();
			$("#salesDetail").jqGrid('clearGridData');
			$("#salesDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/selectPartnerIndividualSkill.do?customerId="+$("#hiddenPartnerIndividualId").val()}).trigger('reloadGrid');
		},
		
		insertQualification : function(){
			var gridLength = $("#salesDetail").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				salesDetail.selectVendor(lastEditRowQ);
				$("#salesDetail").jqGrid('saveRow', i);
			}
			$.ajax({
				url : "/partnerManagement/insertSolutionArea.do",
				datatype : 'json',
				data : {
					salesDetailData : JSON.stringify($("#salesDetail").getRowData()),
					customerId : $("#hiddenPartnerIndividualId").val(),
					creatorId : $("#hiddenModalCreatorId").val(),
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(modalFlag == 'ins') {
						alert("신규등록 완료 후 사용해 주세요.");
						return false;
					}else {
						/* if (!confirm("저장하시겠습니까?")){
							lastEditRowQ = 0;
							return false;	
						} */
                    $.ajaxLoading();
					}
				},
				success : function(result){
					if(result.cnt > 0){
						//alert("저장하였습니다.");
						lastEditRowQ = 0;
						$("#salesDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/selectPartnerIndividualSkill.do?customerId="+$("#hiddenPartnerIndividualId").val()}).trigger('reloadGrid');
					}else if(result.cnt != 0){
						alert("스킬정보 입력을 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		/* updateClose : function(){
			$.ajax({
				url : "/clientManagement/updateSalesStatus.do",
				data : {
					customerId : $("#hiddenClientId").val(),
					SEQ_NUM : SEQ_NUM
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
		}, */
		
		deleteQualification : function(SKILL_MAP_ID){
			if(!SKILL_MAP_ID){
				salesDetail.delRowQualification();
				return;
			}
			$.ajax({
				url : "/partnerManagement/deleteSolutionArea.do",
				datatype : 'json',
				data : {
					customerId : $("#hiddenPartnerIndividualId").val(),
					SKILL_MAP_ID : SKILL_MAP_ID,
					datatype : 'json'
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
						$("#salesDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/selectPartnerIndividualSkill.do?customerId="+$("#hiddenPartnerIndividualId").val()}).trigger('reloadGrid');
					}else{
						alert("스킬정보 삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		drawQualification : function(){
			//$("#salesDetail").jqGrid('clearGridData');
			$("#salesDetail").jqGrid({
	 			url : "/partnerManagement/selectPartnerIndividualSkill.do?customerId="+$("#hiddenPartnerIndividualId").val(),
				datatype : 'json',
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '스킬맵아이디',
					name : 'SKILL_MAP_ID',
					align : "center",
					hidden : true
				},
				{
					label : '파트너개인아이디',
					name : 'PARTNER_INDIVIDUAL_ID',
					align : "center",
					hidden : true
				},
				{
					label : '스킬영역',
					name : 'SKILL_CATEGORY',
					align : "center",
					width : 80,
					editable: true,
					edittype:"select",
					formatter:'select',
					editoptions:{
						value: "1:영업;2:기술;3:기타"
					}
				},
				{
					label : '제조사',
					name : 'PRODUCT_VENDOR',
					align : "center",
					width : 140,
					editable: true,
					edittype:"select",
					formatter:"select",
					editoptions:{
						//value: "1:a;2:b;3:c;4:d",
						value: returnValue,
						dataEvents:[{ type:'change', fn: function(e){
							
							var rowid = $("#salesDetail").getGridParam("selrow");
							var rowData = $("#salesDetail").getRowData(rowid);
							var evalue = $(e.target).val();
							//alert(rowId);
							//console.log(rowData);
							
							$.ajax({
								url : "/partnerManagement/selectSolutionArea.do",
								datatype : 'json',
								data : {
									PRODUCT_VENDOR : evalue
								},
								beforeSend : function(xhr){
									xhr.setRequestHeader("AJAX", true);
				                    $.ajaxLoading();
								},
								success : function(data){
									$("#"+rowid+"_SOLUTION_AREA").html(data.rows);
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
				},
				{
					label : '솔루션영역',
					name : 'SOLUTION_AREA',
					align : "center",
					width : 300,
					editable: true,
					edittype:"select",
					formatter:'custom',
					editoptions:{
						value: ":",
						dataInit: function (element,rwdat) {
							//commonSearch.memberGrid($(element), $(element).parent('td').siblings(".hidden_act_id"));
							var rowData = $("#salesDetail").getRowData(rwdat.rowId);
							var selRow = rwdat.rowId;
							var loadVal = $(element).parent('td').siblings(".solution_id").html();
							//console.log(rowData);
							//console.log(selRow);
							
							if(loadVal != '&nbsp;'){
								$("#"+selRow+"_SOLUTION_AREA option[value="+loadVal+"]").attr('selected', 'selected');
							}
							
							$.ajax({
								url : "/partnerManagement/selectSolutionArea.do",
								datatype : 'json',
								data : {
									PRODUCT_VENDOR : rowData.SOLUTION_AREA
								},
								beforeSend : function(xhr){
									xhr.setRequestHeader("AJAX", true);
				                    $.ajaxLoading();
								},
								success : function(data){
									//$("#"+rwdat.rowId+"_SOLUTION_AREA").val($(element).parent('td').siblings(".solution_id").html()).prop("selected", true);
									//element.value = $(element).parent('td').siblings(".solution_id").html();
									$("#"+selRow+"_SOLUTION_AREA").html(data.rows);
									if(loadVal != '&nbsp;'){
										$("#"+selRow+"_SOLUTION_AREA option[value="+loadVal+"]").attr('selected', 'selected');
									}
								},
								complete: function() {
									$.ajaxLoadingHide();
								}
							});
                        },
                        dataEvents:[{ type:'change', fn: function(e){
							
							var rowid = $("#salesDetail").getGridParam("selrow");
							var rowData = $("#salesDetail").getRowData(rowid);
							var cValue = $(e.target).val();
							var cText = e.target.options[e.target.selectedIndex].text;
							//$("#salesDetail").saveRow(rowid, true);
							//alert(rowid);
							$('#'+rowid+'_SOLUTION_ID').val(cValue);
							$('#'+rowid+'_PRODUCT_GROUP').val(cText);
							//console.log(e.target.selectedIndex);
							//console.log(e.target.options[e.target.selectedIndex].text);
							

					        }}]
    					}
				},
				{
					label : 'SOLUTION_ID',
					name : 'SOLUTION_ID',
					classes : "solution_id",
					align : "center",
					editable: true,
					width : 80,
					hidden : true,
					editoptions:{
						//value: "1:a;2:b;3:c;4:d",
						value: returnValue,
						dataEvents:[{ type:'change', fn: function(e){
							
							var rowid = $("#salesDetail").getGridParam("selrow");
							var rowData = $("#salesDetail").getRowData(rowid);
							var evalue = $(e.target).val();
							//alert(rowId);
							//console.log(rowData);
							

					        }}]
					}
				},
				{
					label : 'PRODUCT_GROUP',
					name : 'PRODUCT_GROUP',
					align : "center",
					editable: true,
					hidden : true,
					width : 80
				},
				{
					label : '스킬레벨',
					name : 'SKILL_LEVEL',
					align : "center",
					width : 80,
					editable: true,
					edittype:"select",
					formatter:'select',
					editoptions:{
						value: "1:상;2:중;3:하"
					}
				},
				{
					label : '등록일',
					name : 'SYS_REGISTER_DATE',
					align : "center",
					width : 80,
					editable: false
				},
				{
					label : '최근수정일',
					name : 'SYS_UPDATE_DATE',
					align : "center",
					width : 80,
					editable: false
				},{
					label : '',
					name : '',
					align : "center",
					width : 30,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='salesDetail.deleteQualification("+colpos.SKILL_MAP_ID+");'><i class='fa fa-times-circle'></i></a>"; 
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
						salesDetail.selectVendor(lastEditRowQ);
						//$("#"+id+"_SOLUTION_AREA").html($("#"+id+"_PRODUCT_GROUP").html());
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastEditRowQ);
						lastEditRowQ = id;
					}
					//var rowData = $("#salesDetail").getRowData(id);
					//console.log(rowData);
					//rowData.test.html();
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
		
		selectVendor : function(selectRow) {
			if(!isEmpty(selectRow)) {
				var elementSolutionArea = '#'+selectRow+'_SOLUTION_AREA';
				var elementProductGroup = '#'+selectRow+'_PRODUCT_GROUP';
				$(elementSolutionArea).html("<option role=\"option\" value=\"" +$(elementProductGroup).val()+ "\">" +$(elementProductGroup).val()+ "</option>");
			}
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
				$("#salesDetail").jqGrid('addRow', {
					rowID : $("#salesDetail").getDataIDs().length+1, 
		        	position :"last"           //first, last
				});
			}
		},
		
		delRowQualification : function(){
			$("#salesDetail").jqGrid('delRowData', $("#salesDetail").getDataIDs().length);
		},
}

</script> 
</script> 