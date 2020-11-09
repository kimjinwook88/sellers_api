<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">Cadence History 관리</h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox">
                    	<form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                        <div class="ibox-content border_n ofHidden"><!-- ofHidden 는 반드시 넣어주세요 -->
	                          <div class="col-lg-12 m-b">
	                              <div class="form-group">
	                                  <!-- <div class="ag_r">작성자 : 홍길동 / 작성일 : 2016-05-10</div> -->
	                              </div>
	                          </div>

                          		<div class="form-group">
                          			<label class="col-sm-2 control-label">파트너사</label>
									<div class="col-sm-4"><input type="text" class="form-control" id="textModalCompany" name="textModalCompany"/></div>
									<label class="col-sm-2 control-label">유형</label>
									<div class="col-sm-4"><input type="text" class="form-control" id="textModalSegment" name="textModalSegment"/></div>
								</div>
								
								<div class="hr-line-dashed"></div>
                              	<div class="form-group">
                              		<label class="col-sm-2 control-label">영업대표</label>
                                   	<div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalSalesMan" name="textModalSalesMan" placeholder="영업대표를 검색해 주세요." autocomplete="off"/></div>
                                   	<label class="col-sm-2 control-label">BP직원</label>
                                   	<div class="col-sm-4"><input type="text" class="form-control" id="textModalPartnerName" name="textModalPartnerName"/></div>
                               </div>
                               
							   <div class="hr-line-dashed"></div>                                                  
                               <div class="form-group"><label class="col-sm-2 control-label">Cadence 주기</label>
                                   <div class="col-sm-4">
                                       <label class="" style="margin-right:30px"> <input type="radio" checked="" id="optionsRadios1" name="radioModalCadenceCycle" value="Monthly"><span class="va-m">Monthly</span></label>
                                       <label> <input input type="radio" id="optionsRadios2" name="radioModalCadenceCycle" value="Weekly"> <span class="va-m">Weekly</span></label>
                                   </div>
                                   <label class="col-sm-2 control-label">Cadence Type</label>
                                   <div class="col-sm-4">
                                       <label class="" style="margin-right:20px"> <input type="radio" checked="" id="optionsRadios1" name="radioModalCadenceType" value="Face"><span class="va-m">Face</span></label>
                                       <label  style="margin-right:20px"> <input type="radio" id="optionsRadios2" name="radioModalCadenceType" value="Tell"><span class="va-m">Telephone</span></label>
                                       <label> <input type="radio" id="optionsRadios3" name="radioModalCadenceType" value="Mail"><span class="va-m">email</span></label>
                                   </div>
                               </div>       
                               
                               <div class="hr-line-bottom"></div>
                               <div class="form-group">
                                   <p class="text-center mg-b30">
                                       <button type="submit" class="btn btn-w-m btn-gray mg-r10" id="buttonModalSaveLinkage" onClick="modal.saveLinkage();">기본정보 저장</button>
                                   </p>
                               </div>
                               
                               <div class="tab-area">
                                  
                                  <!-- tab-menu -->
                                  <ul class="tabmenu-type">
                                      <li><a href="javascript:void(0);" class="sel" onClick="modal.cadenceHistory();">Cadence History</a></li>
                                      <li><a href="javascript:void(0);" class="" onClick="modal.resetCadence();">Cadence 신규등록</a></li>
                                  </ul>
                                  <!--// tab-menu -->
                                  
                                  <!-- tab-cont -->

                                  <!-- Cadence History 업데이트 -->
                                  <div class="sub_cont scont1 modaltabmenu">
									
                                      <div class="form-group" id="divModalExecDate" style="display: none;"><label class="col-sm-2 control-label pd-t10"><i class="fa fa-check" style="color: green;"></i> 실행일</label>
                                          <div class="col-sm-4">
                                              <div class="data_1">
                                                  <div class="input-group date">
                                                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textHistoryExecDate" name="textHistoryExecDate">
                                                  </div>
                                              </div>
                                          </div>
                                      </div>
                                      
                                      <div class="form-group" id="divModalCadenceHistory" ><label class="col-sm-2 control-label pd-t10">Cadence 이력</label>
                                          <div class="col-sm-4">
                                              <div class="select-com">
                                              		<select class="form-control cadence-history-list m-b" name="account" id="selectModalCadenceDate" size="5" onClick="modal.selectCadenceDetail(this);">
	                                          	   </select> 
                                               </div>
                                          </div>       
                                      </div>

                                      <div class="hr-line-dashed"></div>
                                      <div class="form-group"><label class="col-sm-2 control-label pd-t10">실행내용</label>
                                          <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaExecContent" name="textareaExecContent"
                                           onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                      </div>

                                      <div class="hr-line-dashed"></div>
                                      
                                      <div class="form-group"><label class="col-sm-2 control-label">Action Plan</label>
                                          <div class="col-sm-10">
                                          <table id="cadenceActionPlanGrid"></table>
                                          <p class="text-center pd-t10">
												<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal.addRow();">+ Action Plan 추가</a>
										    </p>
                                          </div>
                                      </div>

                                      <div class="hr-line-dashed"></div>
                                      <div class="form-group">
										<label class="col-sm-2 control-label">회의록</label>
											<div class="col-sm-10">
												<div class="input-default pop-file">
										                <div class="file-dragdrap-area">
										                		<!-- <button id="buttonSearchFile" type="button" class="btn btn-seller btn-file">파일찾기</button> -->
											        		<div class="fileUpload btn btn-gray">
											                  <span>파일찾기</span>
											                  <input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload"
	                   accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />
											                </div>
										            		<div class="file-in-list" id="divFileUploadList"> <!-- id="divModalFile" -->
										                		<!-- 선택된 파일이 없는 경우 아래 멘트 노출 -->
										                		<!-- <span class="blank-ment" style="display:none;">선택된 파일이 없습니다</span> -->
										                	</div>
										             	</div>
												</div>
											</div>
										</div>

                                      <p class="text-center pd-t20">
                                          <button type="submit" class="btn btn-w-m btn-gray btn-cadence-app" onClick="modal.saveHistory();">Cadence 저장</button>
                                      </p>
                                      
                                  </div>

                              </div>
                              
                            <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
							<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
							<input type="hidden" name="hiddenModalSalesMan" id="hiddenModalSalesMan"/>
							<input type="hidden"name="hiddenModalCadenceId" 			id="hiddenModalCadenceId" 		value=""/>
                          
                        </div>
                        </form>
                        
                    	</div>
                	</div>
            	</div>
        	</div>
        	
        	<div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
            </div>
    	</div>
	</div>
</div>
                                                
<script type="text/javascript">
var lastEdit;

$(document).ready(function(){
	modal.init();
});		

var modal = {
		cadenceFlag : false,
		
		init : function(){
			commonSearch.member($("#formModalData #textModalSalesMan"), $('#formModalData #hiddenModalSalesMan')); //OI
		},
		
		selectCadenceDetail : function(obj){
			$("#hiddenModalCadenceId").val($(obj).val());
			modal.cadenceFlag = false;
			$("#h3CadenceTitle").text("Cadence History 상세보기");
			$.ajax({
				url : "/partnerManagement/selectCadenceDetail.do",
				datatype : 'json',
				async : false,
				data : {
					cadence_id : $(obj).val(),
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var map = data.selectCadenceDetail; 
					if(!isEmpty(map)){
						$("#textareaExecContent").val(map.EXEC_CONTENT); //실행내용
						$("#textareaHistoryVoice").val(map.PARTNER_VOICE);
						$("#textHistoryExecDate").val(map.EXEC_DATE);
						
						//textarea 높이 계산
						textAreaAutoSize($("#textareaExecContent"));
					}
					commonFile.reset();
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
			
			$.ajax({
		    	url: "/partnerManagement/salesLinkageFileList.do",
		    	datatype : 'json',
		    	data : {
		    		linkage_id : $("#hiddenModalPK").val(),
		    		cadence_id : $(obj).val(),
		    		datatype : 'json'
		    	},
		    	beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
		    	},
		    	success : function(result){
		    		var fileList = result.salesLinkageFileList;
		    		//파일
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=11"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
		    	},
		    	complete : function(){
					$.ajaxLoadingHide();
				}
		    });
			
			modal.actionPlanClear();
			modal.drawCadenceActionPlan($(obj).val());
			modal.actionPlanReload($(obj).val());
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=11&datatype=json",
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
					jqGrid.reload();
					modal.selectCadenceDetail($("#hiddenModalCadenceId"));
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		saveLinkage : function(){
			var gridLength = $("#cadenceActionPlanGrid").jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$("#cadenceActionPlanGrid").jqGrid('saveRow', i);
			}
			$("#cadenceActionPlanGrid").jqGrid('saveRow', lastEdit);
			
			 $('#formModalData').ajaxForm({
		    		url : "/partnerManagement/updateSalesLinkage.do",
		    		async : false,
		    		dataType: "json",
		    		data : {
						selectAccountYear : $("#selectAccountYear").val(),
						selectViewList : $("#selectViewList").val(),
						cadenceActionPlanGrid : JSON.stringify($("#cadenceActionPlanGrid").getRowData()),
						datatype : 'json'
					},
		            beforeSubmit: function (data,form,option) {
						if(!confirm("저장하시겠습니까?")){
							return false;
						}
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	compare_before = $("#formModalData").serialize();
		                	compareFlag = false;
		                	alert("저장하였습니다.");
		                	jqGrid.reload();
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		            },
		            complete : function(){
						$.ajaxLoadingHide();
					}
		        });
		},
		
		openHistory : function(){
			$("div.cadence-edit-pop").show();
		},
		
		saveHistory : function(){
			var gridLength = $("#cadenceActionPlanGrid").jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$("#cadenceActionPlanGrid").jqGrid('saveRow', i);
			}
			$("#cadenceActionPlanGrid").jqGrid('saveRow', lastEdit);
			
			 $('#formModalData').ajaxForm({
		    		url : "/partnerManagement/insertSalesLinkageHistory.do",
		    		async : false,
		    		dataType: "json",
		    		data : {
						selectAccountYear : $("#selectAccountYear").val(),
						selectViewList : $("#selectViewList").val(),
						cadence_id : $("#selectModalCadenceDate").val(),
						cadenceFlag : modal.cadenceFlag,
						cadenceActionPlanGrid : JSON.stringify($("#cadenceActionPlanGrid").getRowData()),
						datatype : 'json',
		    			fileData : JSON.stringify(commonFile.fileArray)
					},
		            beforeSubmit: function (data,form,option) {
		            	if(isEmpty($("#textHistoryExecDate").val())){
		    				alert("날짜를 선택해 주세요.");
		    				return false;
		    			}
						if(!confirm("저장하시겠습니까?")){
							return false;
						}
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	compare_before = $("#formModalData").serialize();
		                	compareFlag = false;
		                	alert("저장하였습니다.");
		                	jqGrid.reload();
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		                
		            	$('#myModal1').modal("hide");
		            },
		            complete : function(){
						$.ajaxLoadingHide();
					}
		     });
		},
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			//$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			//$("#textModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData .followUpCheck").prop("checked",false);
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#spanModalReturnIssue").html("");
			
			$("#buttonModalDelete").hide();
			
			commonFile.reset();
			$("#divFileUploadList span").not(".blank-ment").hide();
			$('#divFileUploadList span.blank-ment').show();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			$("#myModal1").modal();
		},
		
		resetCadence : function(){
			modal.cadenceFlag = true;
			$("#selectModalCadenceDate").val(null);
			$("#textareaExecContent").val(null);
			$("#textareaExecContent").height(1).height(33);
			$("#textareaHistoryVoice").val(null);
			//$("#textareaHistoryVoice").height(1).height(33);
			$("#textHistoryExecDate").val(null);
			
			$('.tabmenu-type li a').removeClass("sel");
			$('.tabmenu-type li a').eq(1).addClass("sel");
			$('#divModalCadenceHistory').hide();
			$('#divModalExecDate').show();
			
			commonFile.reset();
			$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			modal.actionPlanClear();
		},
		
		cadenceHistory : function(){
			modal.cadenceFlag = false;
			$('.tabmenu-type li a').removeClass("sel");
			$('.tabmenu-type li a').eq(0).addClass("sel");
			$('#divModalCadenceHistory').show();
			$('#divModalExecDate').hide();
		},
		
		drawCadenceActionPlan : function(cadence_id){
			$("#cadenceActionPlanGrid").jqGrid({
				url : "/partnerManagement/gridActionPlanSalesLinkage.do?pkNo="+cadence_id,
				datatype : 'json',
				 jsonReader : { 
					    root: "rows",
				},  
				colModel : [ 
				{
					label : 'Action',
					name : 'DETAIL_CONENTS',
					align : "center",
					width : 360,
					edittype:'textarea',
					editable: true
				}, {
					label : '담당자',
					name : 'ACTION_OWNER',
					align : "center",
					width : 85,
					editable: true
				},{
					label : '해결목표일',
					name : 'DUE_DATE',
					align : "center",
					width : 85,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modal.changeStatus();
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
					width : 85,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modal.changeStatus();
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
					label : '상태', 
					name : 'STATUS', 
					align : "center", 
					width : 45,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$("#cadenceActionPlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#cadenceActionPlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#cadenceActionPlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
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
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					var rowData = $(this).jqGrid("getRowData",id);
					if(id && lastEdit != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastEdit);
						lastEdit = id;
					}else if(lastEdit == id){
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
							$("#cadenceActionPlanGrid").setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$("#cadenceActionPlanGrid").setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$("#cadenceActionPlanGrid").setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
		},
		
		addRow : function(){
			var gridLength = $("#cadenceActionPlanGrid").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#cadenceActionPlanGrid").jqGrid('saveRow', i);
			}
 			$("#cadenceActionPlanGrid").jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$("#cadenceActionPlanGrid").jqGrid('saveRow', gridLength+1);
		},

		
		delRow : function(){
			$("#cadenceActionPlanGrid").jqGrid('delRowData', $("#cadenceActionPlanGrid").getDataIDs().length);
		},
		
		
		changeStatus : function(){
			$("#cadenceActionPlanGrid").jqGrid('saveRow', lastEdit);
			var dueDate= ($("#cadenceActionPlanGrid").jqGrid('getCell',lastEdit,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#cadenceActionPlanGrid").jqGrid('getCell',lastEdit,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'Y');
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'R');
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'G');
				$("#cadenceActionPlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'G');
			}
			
			lastEdit = 0;
		},
		
		actionPlanClear : function(){
			$("#cadenceActionPlanGrid").jqGrid('clearGridData');
		},
		
		actionPlanReload : function(cadence_id){
			$("#cadenceActionPlanGrid").jqGrid('setGridParam', {url : "/partnerManagement/gridActionPlanSalesLinkage.do?pkNo="+cadence_id}).trigger('reloadGrid');
		}
}
</script>