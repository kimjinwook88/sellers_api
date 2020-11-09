<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">고객 홈런 축하 방문</h4>
           </div>
           <div class="modal-body">
               <div class="row">
                   <div class="col-lg-12">
                       <!-- <div class="ibox float-e-margins"> -->
                       <div class="ibox" >
                           <!-- <div class="ibox-title">
                               <h5>고객 만족 관리 상세보기</h5>
                               <div class="ibox-tools">
                                   <a class="collapse-link">
                                       <i class="fa fa-chevron-up" id="iModalArrow"></i>
                                   </a>
                               </div>
                           </div> -->
                           <!-- <div class="ibox-content" id="divModalToggle"> -->
                           	<div class="ibox-content border_n" id="divModalToggle">
                               <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
	                               	<div class="form-group">
	                                    <div class="col-sm-12 ag_r mg-b10" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
	                                </div>
	                                
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
	                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
	                                   </div>
	                                   <div class="hr-line-dashed"></div>                                                                                    
	                                   <div class="form-group"><label class="col-sm-2 control-label">상세내용</label>
	                                       <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalContents" name="textareaModalContents"
	                                        onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
	                                   </div>
	                                   <div class="hr-line-dashed"></div>
		                                <div class="form-group"><label class="col-sm-2 control-label">책임자명</label>
	                                       <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCsatSurveyName" name="textModalCsatSurveyName" autocomplete="off"/></div>
	                                       <label class="col-sm-2 control-label">책임자ID</label>
	                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalCsatSurveyId" name="textModalCsatSurveyId" readonly="readonly"/></div>
	                                       </div>
	                                       <div class="hr-line-dashed"></div>
	                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified">조사일</label>
				                           <div class="col-xs-12 col-sm-4">
				                               <div class="data_1">
				                                   <div class="input-group date">
				                                       <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textModalCsatDate" id="textModalCsatDate" value="">
				                                   </div>
				                               </div>
				                           </div>
	                                   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 카테고리</label>
	                                       <div class="col-sm-4">
		                                           <div class="select-com"><!-- <label>항목선택</label> -->
		                                           		<select class="form-control" name="selectModalCategory" id="selectModalCategory">
				                                            <option value="">==== 선택 ====</option>
				                                            <option value="고객만족">고객만족</option>
				                                            <option value="파트너만족">파트너만족</option>
		                                        		</select> 
		                                            </div>
		                                       </div>
	                                    </div>
	                                    
	                                    <div class="hr-line-bottom"></div>
	                                
	                                <!-- TabMenu -->
                                    <div class="tab-area">
                                    
                                    	<!-- tab-menu -->
                                        <ul class="tabmenu-type">
                                            <li><a class="sel" onclick="modalDetail.gotoDetail('1');">조사결과</a></li>
                                            <!-- <li><a class="">조사결과(Detail)</a></li> -->
                                            <li><a class="">Follow-Up-Action</a></li>
											<li><a class="" onclick="modalDetail.gotoDetail('1');">첨부파일</a></li>
                                        </ul>
                                        <!--// tab-menu -->
	                                
	                                <!-- 조사결과 -->
                                    <div class="sub_cont scont1 modaltabmenu">
	                                   
	                                   <!-- <div class="hr-line-dashed"></div>
	                                   <div class="form-group"><label class="col-sm-2 control-label">작성자</label>
		                                    <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalTextName"></div>
		                                </div>
		                                <div class="hr-line-dashed"></div>
		                                <div class="form-group"><label class="col-sm-2 control-label">작성일</label>
		                                    <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalCreateDate"></div>
		                                </div> -->
		                                <!-- <div class="form-group"><label class="col-sm-2 control-label">조사자</label>
	                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalSatName" name="textModalSatName"/></div>
	                                   </div>
	                                    <div class="hr-line-dashed"></div>
	                                   <div class="form-group"><label class="col-sm-2 control-label">조사일</label>
	                                       <div class="col-sm-10">
	                                          <div class="data_1">
	                                              <div class="input-group date">
	                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                                                  <input type="text" class="form-control" id="textModalSatDate" name="textModalSatDate" readOnly>
	                                              </div>
	                                          </div>
	                                      </div>
	                                   </div>
	                                    <div class="hr-line-dashed"></div> -->
	                                    <!-- <div class="hr-line-dashed"></div>
	                                   <div class="form-group"><label class="col-sm-2 control-label">카테고리</label>
	                                       <div class="col-sm-10">
	                                           <div class="select-com"><label>항목선택</label>
	                                           		<select class="form-control m-b" name="selectModalCategory" id="selectModalCategory">
			                                            <option value="">==== 선택 ====</option>
			                                            <option value="고객만족">고객만족</option>
			                                            <option value="파트너만족">파트너만족</option>
	                                        		</select> 
	                                            </div>
	                                       </div>
	                                   </div> -->
	                                  <!--  <div class="form-group"><label class="col-sm-2 control-label">고객명</label>
	                                       <div class="col-sm-10">
	                                           <div class="select-com"><label>항목선택</label> 
	                                               <select class="form-control m-b" name="account">
		                                               <option>고객명을 선택하세요</option>
		                                               <option>손아섭</option>
		                                               <option>김구</option>
	                                           		</select>
	                                           </div>
	                                       </div>
	                                   </div> -->
	                                   
	                                   <!-- <div class="form-group"><label class="col-sm-2 control-label">파일첨부</label>
	                                       <div class="col-sm-10">
	                                            <div class="input-default pop-file">
	                                                
	                                                <div class="file-dragdrap-area" id="divFileUploadArea">
	                                                    <input name="fileModalUploadFile[]" id="buttonSearchFile" type="file" title="파일찾기" onkeydown="event.returnValue=false;" multiple/>
	                                                    <div class="dropzone-previews text-center" id="divFileUploadList">
	                                                    	<span>파일을 선택해 주세요.</span>
	                                                    </div>
	                                                </div>
	                                                
	                                                <input type="file" id="test" />
	                                                	업로드 된 파일 리스트
	                                                <div class="file-in-list" id="divModalFile">
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div> -->
	                                    
	                                     <jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/clientSatisfactionDetail.jsp"/>
	                                     
	                                    </div>
                                        <!--// 조사결과 -->
                                        
                                        <!-- Follow-Up-Action -->
					                    <div class="sub_cont scont2 modaltabmenu off">
					                    <!-- 고객이슈참고 -->
                                   		 <div class="form-group"><!-- <label class="col-sm-2 control-label">Follow-Up-Action</label> -->
                                      	 	<div class="col-sm-12">
                                       			<table id="issueSolvePlanGrid"></table>
                                       			<p class="text-center pd-t10">
													<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal.addRow();">+ Follow-Up-Action 추가</a>
								            	</p>
                                       		</div>
                                  		 </div>
                                  		 <div style="display: none;">
					                   		 <jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/clientSatisfactionDetailModified.jsp"/>
					                   	</div>
					                   		 <!-- 고객이슈참고 -->
		                                     <!-- <div class="hr-line-dashed"></div>                                                                                    
	                                  		 <p class="text-center pd-t20">
										        <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalModifiedDelete" onClick="modalDetail.deleteDetail();">삭제하기</button>
										        <button type="submit " class="btn btn-w-m btn-seller" onclick="" id="buttonModalModifiedSubmit">저장하기</button>
										    </p> -->
					                    <div class="hr-line-bottom"></div>
					                    </div>
					                    <!--// Follow-Up-Action -->
					                    
					                    <!-- 첨부파일 -->
					                    <div class="sub_cont scont3 modaltabmenu off">
		                                   <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
		                                   <div class="hr-line-bottom"></div>
					                    </div>
					                    <!--// 첨부파일 -->
					                    
	                                    <p class="text-center pd-t20">
	                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
	                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
	                                        <!-- <button type="submit " class="btn btn-w-m btn-seller" onclick="modalDetail.submit();" id="buttonModalModifiedSubmit">저장하기</button> -->
	                                    </p>
					                    
					                </div>
                    				<!--// TabMenu -->
                                    
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                </form>
                            </div>
                        </div>
                    </div>

                   <!--  <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Action Items</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <table id="" class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Action Item</th>
                                        <th>진행내용</th>
                                        <th>책임 담당자</th>
                                        <th>목표일</th>
                                        <th>완료일</th>
                                        <th>Status</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>AIX Tuning</td>
                                        <td>- Tuning Parameter 정의(2016/04/20)<br/>- 실행일 협의(2016/05/20)</td>
                                        <td>해결사</td>
                                        <td>2016-03-10</td>
                                        <td>2016-04-10</td>
                                        <td><span class="statusColor statusColor-green"></span></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>WAS Tuning</td>
                                        <td>- Java Core dump 분석 완료 (2016/03/25)<br/> - 실행일 협의(2016/05/20)</td>
                                        <td>해결사</td>
                                        <td>2016-03-10</td>
                                        <td>2016-04-10</td>
                                        <td><span class="statusColor statusColor-red"></span></td>
                                    </tr>
                                    </tbody>
                                </table>
                                
                                <p class="text-center">
                                    <button type="button" class="btn btn-w-m btn-gray">Action Item 신규작성</button>
                                </p>
                            </div>
                            
                        </div>
                    </div> -->
                </div>
            </div>
            <div class="modal-footer">
               	<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
           	</div>
        </div>
    </div>
</div>
                                                

<form  id="formReturnIssue" name="formReturnIssue" method="post" target="formReturnIssue">
	<input type="hidden" id="hiddenCsatDetailId" name="hiddenCsatDetailId">
	<input type="hidden" id="hiddenCsatDetailCompanyName" name="hiddenCsatDetailCompanyName">
	<input type="hidden" id="hiddenCsatDetailCompanyId" name="hiddenCsatDetailCompanyId">
	<input type="hidden" id="hiddenCsatDetailSubject" name="hiddenCsatDetailSubject">
	<input type="hidden" id="hiddenCsatDetailCustomerName" name="hiddenCsatDetailCustomerName">
	<input type="hidden" id="hiddenCsatDetailCustomerRank" name="hiddenCsatDetailCustomerRank">
	<input type="hidden" id="hiddenCsatDetailCustomerId" name="hiddenCsatDetailCustomerId">
	<input type="hidden" id="issue_id" name="issue_id">
</form>                                                
                                                
<script type="text/javascript">
var lastEdit;
$(document).ready(function() { 
		modal.init();
});		

var modalEvent = {
		on : function(){
			//tab menu
			$("ul.tabmenu-type").on('click.modalTab', 'li a', modalEvent.clickModalTab);
			//유효성 검사
			$("#textModalSubject").on("blur", modalEvent.blurValidation);
		},
		
		off : function(){
			//tab menu
			$("ul.tabmenu-type").off('click.modalTab', 'li a', modalEvent.clickModalTab);
			//유효성 검사
			$("#textModalSubject").off("blur", modalEvent.blurValidation);
		},
		
		clickModalTab : function(e){
			e.preventDefault();
			if($(this).html() != "조사결과(Detail)") {
				var idx = $("ul.tabmenu-type li a").index($(this));
				$("ul.tabmenu-type li a").removeClass("sel");
				$(this).addClass("sel");
				$("div.modaltabmenu").addClass("off");
				$("div.modaltabmenu").eq(idx).removeClass("off");
			}
		},
		
		blurValidation : function(e){
			$("#formModalData").find(e.target).valid();
		}
}

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			commonSearch.member($("#formModalData #textModalCsatSurveyName"), $("#formModalData #textModalCsatSurveyId"));
			
			//tab menu
			/* $("ul.tabmenu-type li a").click(function(e){
				e.preventDefault();
				if($(this).html() != "조사결과(Detail)") {
					var idx = $("ul.tabmenu-type li a").index($(this));
					$("ul.tabmenu-type li a").removeClass("sel");
					$(this).addClass("sel");
					$("div.modaltabmenu").addClass("off");
					$("div.modaltabmenu").eq(idx).removeClass("off");
				}
			}); */
			
			//유효성 검사
			/* $("#textModalSubject").on("blur",function(e){
				$("#formModalData").find(e.target).valid();
			}); */
			
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=5&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					$("#divModalFile > p").remove();
					//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfaction.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					commonFile.reloadFile($("#hiddenModalPK").val(), '5');
					//$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			
			//EVENT ON
			modalEvent.on();
			
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			$("#textModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			/* $("#textModalSatName").val("${userInfo.HAN_NAME}"); */
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("h4.modal-title").html("고객만족도 신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			$("#hiddenModalPK").val("");
			
			//details 그리드 생성
			details.clear();
			details.draw();
			details.reload();
			
			modalModifiedFlag = "ins/upd";
			
			$("#textModalModifiedCompanyName").val('');
			$("#textModalModifiedCompanyId").val('');
			$("#textModalModifiedCustomerName").val('');
			$("#selectModalModifiedValue").val('매우만족');
			$("#textModalModifiedDetail").val('');
			$("#textModalModifiedDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#selectModalModifiedMethod").val('대면');
			$("#hiddenModalModifiedDetailId").val('');
			//$("#buttonModalModifiedDelete").hide();
			modalDetail.gotoDetail('1');
			
			modal.drawIssueSolvePlan();
			modal.solvePlanReload();
			
			$("#textModalCsatDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#textModalCsatSurveyName").val("${userInfo.HAN_NAME}");
			$("#textModalCsatSurveyId").val("${userInfo.MEMBER_ID_NUM}");
			$("#myModal1").modal();
			
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					rules : {
						textModalSubject : {
							required : true,
							maxlength : 100
						},
						selectModalCategory : {
							required : true
						},
						/* textModalSatName : {
							required : true,
							maxlength : 10
						},
						textModalSatDate : {
							required : true,
							maxlength : 10
						}, */
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						textareaModalContents : {
							minlength : 1,
							maxlength : 2000
						},
					//pwdConfirm:{required:true, equalTo:"#pwd"}, 
					// equalTo : id가 pwd인 값과 같아야함
					//name:"required", // 검증값이 하나일 경우 이와 같이도 가능
					//personalNo1:{required:true, minlength:6, digits:true},
					// minlength : 최소 입력 개수, digits: 정수만 입력 가능
					//personalNo2:{required:true, minlength:7, digits:true},
					//email:{required:true, email:true},
					// email 형식 검증
					//blog:{required:true, url:true}
					// url 형식 검증
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalSubject : {
							required : "제목을 입력하세요.",
							maxlength:"100글자 이하여야 합니다" 
						},
						selectModalCategory : {
							required : "카테고리를 선택하세요.", // 이와 같이 규칙이름과 메시지를 작성
						//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
						//digits:"숫자만 입력해 주세요."
						},
						/* textModalSatName : {
							required : "조사자명을 입력하세요.",
							maxlength : "10글자 이하여야 합니다"
						},
						textModalSatDate : {
							required : "조사일를 선택해 주세요.",
							maxlength : 10
						}, */
						textareaModalContents : {
							maxlength : "2000글자 이하여야 합니다"
						//rangelength:"1글자 이상, 30글자 이하여야 합니다"
						}
					}
				})
		}, 
		
		submit : function(){
			$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
			$("#clientSatisfactionDetail").jqGrid('saveRow', lastEditRow);
			var url;
			(modalFlag == "ins") ? url = "/clientSatisfaction/insertClientSatisfaction.do" : url = "/clientSatisfaction/updateClientSatisfaction.do";
			 $('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			clientSatisfactionDetail : JSON.stringify($("#clientSatisfactionDetail").getRowData()),
	    			issueSolvePlanGrid : JSON.stringify($("#issueSolvePlanGrid").getRowData()),
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
	            	if(!compareFlag){
						if(!confirm("저장하시겠습니까?")) return false;
	            	}
	            	$.ajaxLoadingShow();
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	                //성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	compareFlag = false;
	                	alert("저장하였습니다.");
	                	
	                	$("#clientSatisfactionDetail").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfactionDetailList.do?csat_id="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
	                	modal.detailCalculation();
	                	
	                	if(modalFlag=="ins") {
	                		clientSatisfactionList.searchReset(); //등록/수정 시 검색 초기화
	                	}else clientSatisfactionList.completeReload();
	                	
						compare_before = $("#formModalData").serialize();
	                	commonFile.reloadFile($("#hiddenModalPK").val(), '5');
	                	
	                	$('#myModal1').modal("hide");
	                	$.ajaxLoadingHide();
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            complete : function(){
					$.ajaxLoadingHide();
				}
	        });
		},
		
		removeFileElement : function(count,obj){
			$("input#inputUploadFile"+count).remove();
			$(obj).parent("p").remove();
			
			if($("#divFileUploadList p.fileModalUploadFile").length == 0){
				$("#divFileUploadList span").show();
			}
			
		},
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSatisfaction/deleteClientSatisfaction.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoading();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					if(data.cnt > 0) alert("삭제하였습니다."); $('#myModal1').modal("hide");
					//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientSatisfaction.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		detailCalculation : function() {
			var DetailCount = $("#clientSatisfactionDetail").jqGrid('getGridParam', 'records');
        	var DetailValue = 0;
        	for(var i=1; i<=DetailCount; i++){
        		DetailValue += parseInt($("#clientSatisfactionDetail > tbody > tr#"+i+" > td:nth-child(5)").html());
        	}
        	$("#textModalCsatDetailAVG").val((DetailValue/DetailCount).toFixed(1));
			$("#textModalCsatDetailCount").val(DetailCount);
		},
		
		drawIssueSolvePlan : function(){
			$("#issueSolvePlanGrid").jqGrid('clearGridData');
			$("#issueSolvePlanGrid").jqGrid({
				url : "/clientSatisfaction/gridSolvePlanClientSatisfaction.do?pkNo="+$("#hiddenModalPK").val(),
				datatype : 'json',
				colModel : [ 
				{
					label : '이슈내용',
					name : 'CSAT_ACTION_DETAIL',
					align : "left",
					width : 235,
					editable: true,
					edittype:'textarea'
				},
				{
					label : '해결계획',
					name : 'SOLVE_PLAN',
					align : "left",
					width : 215,
					editable: true,
					edittype:'textarea'
				}, {
					label : 'SOLVE_OWNER_ID',
					name : 'SOLVE_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '책임자',
					name : 'SOLVE_OWNER',
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
					label : 'Status', 
					name : 'STATUS', 
					align : "center", 
					width : 45,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$("#issueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#issueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#issueSolvePlanGrid").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
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
						return '<a href="javascript:void(0);" onClick="modal.delRow(\''+cellval.rowId+'\',\''+colpos.ACTION_ID+'\');"><i class="fa fa-trash-o fa-lg"></i></a>'; 
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
				/* loadui: 'disable',
				loadonce : true,
				viewrecords : true,
				height : "100%",
				autowidth : true, */
				height : "100%",
				shrinkToFit: true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				/* onCellSelect : function(id) {
					lastEdit = id;
					var rowData = $("#issueSolvePlanGrid").jqGrid("getRowData",id);
					if(id && lastEdit != id){
						$("#issueSolvePlanGrid").jqGrid('editRow',id,true);
						$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
						lastEdit = id;
					}else if(lastEdit == id){
						$("#issueSolvePlanGrid").jqGrid('editRow',id,true);
					}
				}, */
				onSelectRow : function(id) { //row 선택시 처리. ids는 선택한 row
					//신규등록일시 return;
					if(!$("#hiddenModalPK").val()){
						alert("신규 등록 후 작성해 주세요.");
						return;
					}
					if(id && lastEdit != id){
						$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit,true);
						$("#issueSolvePlanGrid").jqGrid('editRow',id,true);
						
						lastEdit = id;
						//$("#"+ id +"_issueAddLink").remove();
					}else if(lastEdit == id){
						$("#issueSolvePlanGrid").jqGrid('editRow',id,true);
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
							$("#issueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$("#issueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$("#issueSolvePlanGrid").setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
		},
		
		solvePlanReload : function(){
			$("#issueSolvePlanGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridSolvePlanClientSatisfaction.do?pkNo="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
		},
		
		addRow : function(){
			if(!$("#hiddenModalPK").val()){
				alert("신규 등록 후 작성해 주세요.");
				return;
			}
			var gridLength = $("#issueSolvePlanGrid").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#issueSolvePlanGrid").jqGrid('saveRow', i);
			}
 			$("#issueSolvePlanGrid").jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$("#issueSolvePlanGrid").jqGrid('saveRow', gridLength+1);
		},
		
		delRow : function(rowId, actionId){
			if(!isEmpty(actionId) && actionId != "undefined"){
				$.ajax({
					url : "/clientSatisfaction/deleteClientSatisfactionFollowUpAction.do",
					datatype : 'json',
					async : false,
					data : {
						actionId : actionId,
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(!confirm("삭제하시겠습니까?")){
							return false;	
						}
						$.ajaxLoadingShow();
					},
					success : function(data){
						if(data.cnt > 0){
							$("#issueSolvePlanGrid").jqGrid('delRowData', rowId);
							alert("삭제되었습니다.");
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
						}
					},
					complete: function(){
						$.ajaxLoadingHide();
					}
				});
			}else{
				$("#issueSolvePlanGrid").jqGrid('delRowData', rowId);
			}
			
		},
		
		reload : function(){
			$("#issueSolvePlanGrid").jqGrid(
				'setGridParam', 
				{
					url : "/clientSatisfaction/gridSolvePlanClientSatisfaction.do",
		 			postData : {
		 				pkNo : $("#hiddenModalPK").val()
	 				},
	 				mtype: 'POST',
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		changeStatus : function(){
			$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
			var dueDate= ($("#issueSolvePlanGrid").jqGrid('getCell',lastEdit,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#issueSolvePlanGrid").jqGrid('getCell',lastEdit,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'Y');
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'R');
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'G');
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'G');
			}
			
			lastEdit = 0;
		}
		
}
</script>