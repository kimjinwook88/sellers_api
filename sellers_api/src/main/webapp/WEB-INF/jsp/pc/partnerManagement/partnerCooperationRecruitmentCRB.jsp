<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="crb-area">
	<h3>CRB 평가</h3>
	<div class="func-top-left fl_l">
       <div class="table-sel-view fl_l">
           <div class="selgrid selgrid1 mg-r5">
               <select class="form-control m-b" name="selectCRBseq" id="selectCRBseq">
	               <c:choose>
						<c:when test="${fn:length(searchCRBGroup.crb_seq) > 0}">
							<c:forEach items="${searchCRBGroup.crb_seq}" var="searchCRBGroup">
		                   		<option value="${searchCRBGroup.CRB_SEQ}" <c:if test="${selectCRBseq eq searchCRBGroup.CRB_SEQ}">selected="selected"</c:if>>${searchCRBGroup.SYS_REGISTER_DATE}</option>
		                	</c:forEach>
	                	</c:when>
	                	<c:otherwise>
	                		<option value="">== 평가일 ==</option>
	                	</c:otherwise>
	                </c:choose>
               </select>
           </div>
       </div>
    </div>
    
    <div class="func-top-right fl_r pd-b20">
		<button type="button" class="btn btn-outline btn-seller-outline" id="buttonCreateCRB" onClick="CRB.create();">CRB 생성</button>
    </div>
                                    
    <br /><br /><br />
	
	<table id="sellersGridCRB" ></table>
	
	<p class="text-center pd-t10">
		<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="CRB.addRow();">+ CRB 평가 추가</a>
    </p>
    
	<div class="file-dragdrap-area crb-file">
        <div class="fileUpload btn btn-gray">
            <span>파일찾기</span>
             <input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload"
	                   accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />
        </div>
        <div class="file-in-list" id="divFileUploadList">
            <span class="blank-ment" style="display: none;">선택된 파일이 없습니다</span>
        </div>
    </div>     
                                    
	<p class="text-right">
		<button type="submit" class="btn btn-w-m btn-seller" id="buttonSaveCRB" onClick="CRB.submit();">CRB 저장</button>
	</p>
</div>

<script type="text/javascript">
$(document).ready(function(){
	CRB.init();
	CRB.draw();
});		

var columnFlag = true;
var CRB = {
		init : function(){
			$("#selectCRBseq").change(function(){
				/* var params = $.param({
					selectAccountYear:$("#selectAccountYear").val(), 
					selectViewList:$("#selectViewList").val(), 
					selectCRBseq:$(this).val()
				});
				location.href = "/partnerManagement/viewPartnerRecruitment.do?"+params; */
				CRB.reload();
				//commonFile.reset();
			});
		},
		
		create : function(){
			var CRBseq;
			if(isEmpty($("#selectCRBseq").val())){
				CRBseq = 1;
			}else{
				CRBseq = parseInt($("#selectCRBseq option:first").val())+1
			}
			$.ajax({
				url : "/partnerManagement/createCRB.do",
				datatype : 'json',
				type : "POST",
				data : {
					selectAccountYear:$("#selectAccountYear").val(), 
					selectViewList:$("#selectViewList").val(), 
					selectCRBseq:CRBseq,
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					//if (!confirm($("#selectAccountYear").val()+"년 "+CRBseq+"회차 "+$("#selectViewList option:selected").text()+"새로운 CRB 평가를 생성하시겠습니까?")){
					if (!confirm($("#selectAccountYear").val()+"년 "+"새로운 CRB 평가를 생성하시겠습니까?")){
						return false;	
					}
		            $.ajaxLoadingShow();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("생성하였습니다.");
					}else{
						alert("생성을 실패했습니다.\n관리자에게 문의하세요.");	
					}
					var params = $.param({
						selectAccountYear:$("#selectAccountYear").val(), 
						selectViewList:$("#selectViewList").val(), 
						selectCRBseq:CRBseq
					});
					location.href = "/partnerManagement/viewPartnerRecruitment.do?"+params;
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		draw : function(){
			$("#sellersGridCRB").jqGrid('clearGridData');
			$("#sellersGridCRB").jqGrid({
	 			url : "/partnerManagement/gridRecruitmentCRB.do?",
				datatype : 'json',
				mtype: 'POST',
				ajaxRowOptions: { 
					async: false 
				},
				postData : { 
					selectAccountYear:$("#selectAccountYear").val(), 
					selectViewList:$("#selectViewList").val(), 
					selectCRBseq:$("#selectCRBseq").val(),
					datatype:'json'
				},
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				   {
					label : 'No',
					name : 'ROWNUM',
					align : "center",
					width : 50
				},{
					label : '파트너 후보',
					name : 'PARTNER_NAME',
					editable:true,
					align : "center",
					width : 200
				}, {
					label : $("#selectViewList option:selected").text(),
					name : 'ALIGNMENT_ID',
					align : "center",
					width : 150,
					editable: true,
					edittype:"select",
					editoptions: {
						dataUrl : "/partnerManagement/selectCRBbpNameJson.do?selectAccountYear="+$("#selectAccountYear").val()+"&selectViewList="+$("#selectViewList").val()
						,buildSelect:function (data){
							var result =$.parseJSON(data);
							var list = result.rows;
						var rtSlt = '<select>';
						for ( var idx = 0 ; idx < list.length ; idx ++) {
						rtSlt +='<option value="'+list[idx].ALIGNMENT_ID+'">'+list[idx].BP_NAME+'</option>';
						}
						rtSlt +='</select>';
						return rtSlt;
						}
					},formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_ALIGNMENT_ID', rowId);
							return $("#"+cellval.rowId+"_ALIGNMENT_ID option:selected").text();
						}else if(rwdat == "add"){
							setTimeout(function(){
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_ALIGNMENT_ID', colpos.ALIGNMENT_ID);
							},200)
							return colpos.SEGMENT_NAME;
						}
					}
				},{
					label : '영역',
					name : 'PARTNER_CODE',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 100,
					editoptions:{
						value:"IBMHW:IBMHW;IBMSW:IBMSW;AHNLAB:AHNLAB", //대소문자 유의!
					}
				},{
					label : '인력',
					name : 'EVAL_ITEM1_RESULT',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 80,
					editoptions:{
						value:"G:Green;Y:Yellow;R:Red", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "Green":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM1_RESULT', 'G');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM1_RESULT","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM1_RESULT', 'Y');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM1_RESULT","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM1_RESULT', 'R');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM1_RESULT","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM1_RESULT', null);
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM1_RESULT","",{"background-color": ""});
								return "";
								break;
							}	
						}
					}
				},{
					label : '스킬',
					name : 'EVAL_ITEM2_RESULT',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 80,
					editoptions:{
						value:"G:Green;Y:Yellow;R:Red", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "Green":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM2_RESULT', 'G');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM2_RESULT","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM2_RESULT', 'Y');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM2_RESULT","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM2_RESULT', 'R');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM2_RESULT","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM2_RESULT', null);
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM2_RESULT","",{"background-color": ""});
								return "";
								break;
							}	
						}
					}
				},{
					
					label : '재무역량',
					name : 'EVAL_ITEM3_RESULT',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 80,
					editoptions:{
						value:"G:Green;Y:Yellow;R:Red", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "Green":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM3_RESULT', 'G');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM3_RESULT","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM3_RESULT', 'Y');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM3_RESULT","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM3_RESULT', 'R');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM3_RESULT","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM3_RESULT', null);
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM3_RESULT","",{"background-color": ""});
								return "";
								break;
							}	
						}
					}
				},{
					label : '업계평가',
					name : 'EVAL_ITEM4_RESULT',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 80,
					editoptions:{
						value:"G:Green;Y:Yellow;R:Red", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "Green":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM4_RESULT', 'G');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM4_RESULT","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM4_RESULT', 'Y');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM4_RESULT","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM4_RESULT', 'R');
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM4_RESULT","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#sellersGridCRB").jqGrid('setCell', cellval.rowId, 'HIDDEN_EVAL_ITEM4_RESULT', null);
								$("#sellersGridCRB").setCell(cellval.rowId,"EVAL_ITEM4_RESULT","",{"background-color": ""});
								return "";
								break;
							}	
						}
					}
				},{
					label : '평가자',
					name : 'CRB_MEMBERS',
					align : "center",
					editable: true,
					width : 120
				},{
					label : '평가일',
					name : 'CRB_DATE',
					align : "center",
					editable: true,
					sorttype:"date",
					width : 100,
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
                           if(isEmpty($(element).val())){
                        	   $(element).val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);   
                           }
                        }
                        
                  	},
				},{
					label : '평가종류',
					name : 'CRB_CATEGORY',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 80,
					editoptions:{
						value:"New:New;Renewal:Renewal", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						switch (colpos.CRB_CYCLE) {
						case "New":
							return "New";
							break;
						case "Renewal":
							return "Renewal";
							break;
						default:
							return "New";
							break;
						}	
					}
				},{
					label : '평가결과',
					name : 'EVAL_FINAL_RESULT',
					align : "center",
					editable: true,
					edittype:"select",
					formatter:'select',
					width : 100,
					editoptions:{
						value:":-;Accept:Accept;Reject:Reject", //대소문자 유의!
					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						switch (colpos.EVAL_FINAL_RESULT) {
						case "Accept":
							return "Accept";
							break;
						case "Reject":
							return "Reject";
							break;
						default:
							return "-";
							break;
						}	
					}
				},{
					label : 'CRB_LOG_ID,',
					name : 'CRB_LOG_ID',
					hidden : true
				},{
					label : 'HIDDEN_EVAL_ITEM1_RESULT,',
					name : 'HIDDEN_EVAL_ITEM1_RESULT',
					hidden : true
				},{
					label : 'HIDDEN_EVAL_ITEM2_RESULT,',
					name : 'HIDDEN_EVAL_ITEM2_RESULT',
					hidden : true
				},{
					label : 'HIDDEN_EVAL_ITEM3_RESULT,',
					name : 'HIDDEN_EVAL_ITEM3_RESULT',
					hidden : true
				},{
					label : 'HIDDEN_EVAL_ITEM4_RESULT,',
					name : 'HIDDEN_EVAL_ITEM4_RESULT',
					hidden : true
				},{
					label : 'HIDDEN_ALIGNMENT_ID,',
					name : 'HIDDEN_ALIGNMENT_ID',
					hidden : true
				}
				],
				loadui: 'disable',
				viewrecords : true,
				gridview: true,	
				height : "100%",
				autowidth : true,
				height : "100%",
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(ids, icol) {
					var rowData = $(this).jqGrid("getRowData",ids);
					var groupHeadersOptions = $(this).jqGrid("getGridParam", "groupHeader");
					
					if(ids && lastEdit != ids){
						$(this).jqGrid('editRow',ids,true);
						if(rowData.HIDDEN_EVAL_ITEM1_RESULT) $("select#"+ids+"_EVAL_ITEM1_RESULT").val(rowData.HIDDEN_EVAL_ITEM1_RESULT);
						if(rowData.HIDDEN_EVAL_ITEM2_RESULT) $("select#"+ids+"_EVAL_ITEM2_RESULT").val(rowData.HIDDEN_EVAL_ITEM2_RESULT);
						if(rowData.HIDDEN_EVAL_ITEM3_RESULT) $("select#"+ids+"_EVAL_ITEM3_RESULT").val(rowData.HIDDEN_EVAL_ITEM3_RESULT);
						if(rowData.HIDDEN_EVAL_ITEM4_RESULT) $("select#"+ids+"_EVAL_ITEM4_RESULT").val(rowData.HIDDEN_EVAL_ITEM4_RESULT);
						$(this).jqGrid('saveRow', lastEdit);
						lastEdit = ids;
					}
				},
				onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
					/*  if(action == 'next'){
						currPage = getGridParam("page");
					} */
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				loadComplete : function(data){
					/* var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						console.log(list[i].ALIGNMENT_ID);
						$("#sellersGridCRB").setCell(i+1,"HIDDEN_ALIGNMENT_ID",list[i].ALIGNMENT_ID);
						$("#sellersGridCRB").setCell(i+1,"ALIGNMENT_ID",list[i].ALIGNMENT_ID);
					} */
					//jqGrid.cursorPointer();
					//No Data 처리 bottom.jsp
					//noDataFn(this);
					 $.ajax({
					    	url: "/partnerManagement/recruitmentCRBFileList.do",
					    	datatype : 'json',
					    	data : {
					    		selectViewList : $("#selectViewList").val(),
					    		selectAccountYear : $("#selectAccountYear").val(),
					    		selectCRBseq : $("#selectCRBseq").val(),
					    		datatype : 'json'
					    	},
					    	beforeSend : function(xhr){
								xhr.setRequestHeader("AJAX", true);
					    	},
					    	success : function(result){
					    		var fileList = result.fileList;
					    		if(fileList.length > 0){
					    			$("#divFileUploadList span").not(".blank-ment").remove();
					    			$('.blank-ment').hide();
					    		}else{
					    			$("#divFileUploadList span").not(".blank-ment").remove();
					    			$('.blank-ment').show();
					    		}
					    		
					    		for(var i=0; i<fileList.length; i++){
					    			var fileType = fileList[i].FILE_TYPE.toLowerCase();
					    			if(fileType == '.jpg' || fileType == '.png' || fileType == '.gif'){
					    				$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=10"><i class="fa fa-file-image-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="CRB.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
					    			}else if(fileType == '.xlsx' || fileType == '.xls'){
					    				$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=10"><i class="fa fa-file-excel-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="CRB.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
					    			}else if(fileType == '.pdf'){
					    				$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=10"><i class="fa fa-file-pdf-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="CRB.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
					    			}else if(fileType == '.ppt' || fileType == '.pptx'){
					    				$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=10"><i class="fa fa-file-powerpoint-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="CRB.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');			    				
					    			}else if(fileType == '.doc' || fileType == '.docx' || fileType == '.hwp' || fileType == '.txt'){
					    				$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=10"><i class="fa fa-file-word-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="CRB.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');											    				
					    			}
					    		}
					    	},
					    	complete : function(){
								$.ajaxLoadingHide();
							}
					    });
					var list = data.rows;
				 	for(var i=0; i<list.length; i++ ){
						if(list[i].EVAL_ITEM1_RESULT == 'G'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM1_RESULT","Green",{"background-color": "#1ab394"});
						}else if(list[i].EVAL_ITEM1_RESULT == 'Y'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM1_RESULT","Yellow",{"background-color": "#ffc000"});
						}else if(list[i].EVAL_ITEM1_RESULT == 'R'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM1_RESULT","Red",{"background-color": "#f20056"});
						}
						
						if(list[i].EVAL_ITEM2_RESULT == 'G'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM2_RESULT","Green",{"background-color": "#1ab394"});
						}else if(list[i].EVAL_ITEM2_RESULT == 'Y'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM2_RESULT","Yellow",{"background-color": "#ffc000"});
						}else if(list[i].EVAL_ITEM2_RESULT == 'R'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM2_RESULT","Red",{"background-color": "#f20056"});
						}
						
						if(list[i].EVAL_ITEM3_RESULT == 'G'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM3_RESULT","Green",{"background-color": "#1ab394"});
						}else if(list[i].EVAL_ITEM3_RESULT == 'Y'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM3_RESULT","Yellow",{"background-color": "#ffc000"});
						}else if(list[i].EVAL_ITEM3_RESULT == 'R'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM3_RESULT","Red",{"background-color": "#f20056"});
						}
						
						if(list[i].EVAL_ITEM4_RESULT == 'G'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM4_RESULT","Green",{"background-color": "#1ab394"});
						}else if(list[i].EVAL_ITEM4_RESULT == 'Y'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM4_RESULT","Yellow",{"background-color": "#ffc000"});
						}else if(list[i].EVAL_ITEM4_RESULT == 'R'){
							$("#sellersGridCRB").setCell(i+1,"EVAL_ITEM4_RESULT","Red",{"background-color": "#f20056"});
						}
					}
					 
					 $("div.crb-area").addClass("off");
					 $.ajaxLoadingHide();
					/* 최근 업데이트 */
				   /*  if(data.rows.length > 0){
				    	$("#LATELY_UPDATE_DATE").html(data.rows[0].LATELY_UPDATE_DATE);	
				    } */
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
			
			if(columnFlag){
				$("#sellersGridCRB").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'EVAL_ITEM1_RESULT', numberOfColumns: 4, titleText: '평가항목'}
						          	
					  ]
				});
				columnFlag = false;
			}
		},
		
		reset : function() { //신규등록 시 팝업창 초기화
		},
		
		submit : function(){
			var gridLength = $("#sellersGridCRB").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#sellersGridCRB").jqGrid('saveRow', i);
			}
			$("#sellersGridCRB").jqGrid('saveRow', lastEdit);
			
			$('#formRecruitmentData').ajaxForm({ 
	    		url : "/partnerManagement/insertRecruitmentCRB.do",
	    		dataType: "json",
	    		data : {
	    			selectViewList : $("#selectViewList").val(),
	    			selectAccountYear : $("#selectAccountYear").val(),
	    			//selectCRBseq : $("#selectCRBseq").val(),
	    			recruitmentCRBData : JSON.stringify($("#sellersGridCRB").getRowData()),
	    			hiddenModalCreatorId : "${userInfo.MEMBER_ID_NUM}",
	    			datatype : "json",
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
	            	if (!confirm("저장하시겠습니까?")){
						lastEdit = 0;
						return false;	
					}
	            },
	            beforeSend : function(xhr){
	            	xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
	            success: function(result){
	            	if(result.cnt > 0){
						alert("저장하였습니다.");
						lastEdit = 0;
					}else{
						alert("저장을 실패했습니다.\n관리자에게 문의하세요.");	
					}
					$("#sellersGridCRB").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridRecruitmentCRB.do", postData : { selectAccountYear:$("#selectAccountYear").val(), selectViewList:$("#selectViewList").val()}}).trigger('reloadGrid');
			 		CRB.reload();
			 		commonFile.reloadFile($("#selectCRBseq").val(), 10);
	            	//commonFile.fileArray = [];
	            },
	            complete: function() {
	            	$.ajaxLoadingHide();
				}  
	        });
			
			/* var gridLength = $("#sellersGridCRB").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#sellersGridCRB").jqGrid('saveRow', i);
			}
			$("#sellersGridCRB").jqGrid('saveRow', lastEdit);
			
			var formData = new FormData();
			$("input[name='fileModalUploadFile[]']").each(function(i,v){
				if($(this)[0].files[0]){
					formData.append("fileModalUploadFile[]",$(this)[0].files[0]);
				}
			});
			formData.append("selectViewList",$("#selectViewList").val());
			formData.append("selectAccountYear",$("#selectAccountYear").val());
			formData.append("selectCRBseq",$("#selectCRBseq").val());
			formData.append("recruitmentCRBData",JSON.stringify($("#sellersGridCRB").getRowData()));
			formData.append("hiddenModalCreatorId","${userInfo.MEMBER_ID_NUM}");
			formData.append("datatype", "json");
			formData.append("fileData", commonFile.fileArray);
			$.ajax({
				url : "/partnerManagement/insertRecruitmentCRB.do",
				datatype : 'json',
				async : false,
				type: 'POST',
				processData : false, //true : data의 파일형태가 query String으로 전송. false : non-processed data
				contentType : false, // false : multipart/form-data 형태로 전송되기 위한 옵션값
				data : formData,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("저장하시겠습니까?")){
						lastEdit = 0;
						return false;	
					}
	             $.ajaxLoadingShow();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("저장하였습니다.");
						lastEdit = 0;
					}else{
						alert("저장을 실패했습니다.\n관리자에게 문의하세요.");	
					}
					$("#sellersGridCRB").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridRecruitmentCRB.do", postData : { selectAccountYear:$("#selectAccountYear").val(), selectViewList:$("#selectViewList").val()}}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			}); */
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=10&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					$("#sellersGridCRB").jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridRecruitmentCRB.do", postData : { selectAccountYear:$("#selectAccountYear").val(), selectViewList:$("#selectViewList").val(), selectCRBseq:$("#selectCRBseq").val()}}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		
		reload : function(){
			$("#sellersGridCRB").jqGrid('setGridParam', { 
					url : "/partnerManagement/gridRecruitmentCRB.do?",
					datatype : 'json',
					mtype: 'POST',
					postData : { 
						selectAccountYear:$("#selectAccountYear").val(), 
						selectViewList:$("#selectViewList").val(),
						selectCRBseq:$("#selectCRBseq").val(),
						datatype : 'json'
					},
					loadui: 'disable',
					loadonce : true,
					viewrecords : true,
					gridview: true,	
					//rowList : [ 10, 20, 30 ],
					autowidth : true,
					height : "100%"
				}
			).trigger('reloadGrid');
		},
		
		addRow : function(){
			var gridLength = $("#sellersGridCRB").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#sellersGridCRB").jqGrid('saveRow', i);
			}
			$("#sellersGridCRB").jqGrid('addRow',{
				initdata : {
					ROWNUM :gridLength+1,
				},
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			});
			//$("#sellersGridCRB").jqGrid('addRowData',"",[{ROWNUM :gridLength+1,ALIGNMENT_ID:"10001360"}],"last",gridLength+1);
		}
}
		
function jqGridCellStatus(g_obj, s_val, rowId, name){ //grid obj, stuats value, rowid
	switch(s_val){
		case "G":
			g_obj.setCell(rowId,"HIDDEN_"+name,"G");
			g_obj.setCell(rowId,name,"",{"background-color": "#1ab394"});	
			break;
		case "Y":
			g_obj.setCell(rowId,"HIDDEN_"+name,"Y");
			g_obj.setCell(rowId,name,"",{"background-color": "#ffc000"});
			break;
		case "R":
			g_obj.setCell(rowId,"HIDDEN_"+name,"R");
			g_obj.setCell(rowId,name,"",{"background-color": "#f20056"});
			break;
		default:
			g_obj.setCell(rowId,"HIDDEN_"+name,null);
			g_obj.setCell(rowId,name,"",{"background-color": ""});
			break;
	}
}
</script>