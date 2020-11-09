<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content border_n">
                                <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                                	<div class="form-group">
                                  		<div class="col-sm-12 ag_r">
                                    		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
	                                    </div>
                          		    </div>
                                
                                	<div class="hr-line-dashed"></div>
	                                <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 교육제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
                                    
								   <div class="hr-line-dashed"></div>
	                               <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 교육목표</label>
	                                   <div class="col-sm-10"><input type="text" class="form-control" id="textModalEduTarget" name="textModalEduTarget"/></div>
	                               </div>
                                    
                                    <div class="hr-line-dashed"></div>
	                                  <div class="form-group"><label class="col-sm-2 control-label">교육내용</label>
	                                      <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaEduContent" name="textareaEduContent"
	                                       onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
	                                  </div>
	                                <!-- <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성자</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="홍길동" class="form-control" id="textModalTextName" ></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalCreateDate"></div>
                                    </div> -->
                                    <!-- <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">최종변경일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalUpdateDate"></div>
                                    </div>  -->                                           
                                    <div class="hr-line-dashed"></div>    
	                                <div class="form-group">
	                                	<label class="col-sm-2 control-label">교육영역</label>
	                                    <div class="col-sm-4">
	                                        <div class="select-com"><!-- <label>항목선택</label> --> 
	                                           <select class="form-control m-b" id="selectModalEduArea" name="selectModalEduArea">
		                                           <c:choose>
													<c:when test="${fn:length(searchDetailGroup.edu_area) > 0}">
														<c:forEach items="${searchDetailGroup.edu_area}" var="edu_area">
								                           	<option value="${edu_area.SOLUTION_ID}">${edu_area.VENDOR_SOLUTION}</option>
								                        </c:forEach>
								                    </c:when>
								                 </c:choose>
	                                       	   </select>
	                                       </div>
	                                   </div>
	                                   
	                                   <label class="col-sm-2 control-label">교육레벨</label>
	                                   <div class="col-sm-4">
	                                       <label style="margin-right:5px"><input type="radio" checked="" id="optionsRadios1" name="radioModalEduLevel" value="상"> <span class="va-m">상</span></label>
	                                       <label style="margin-right:5px"><input type="radio" id="optionsRadios2" name="radioModalEduLevel" value="중"> <span class="va-m">중</span></label>
	                                       <label><input type="radio" id="optionsRadios3" name="radioModalEduLevel" value="하"> <span class="va-m">하</span></label>
	                                   </div>
	                               </div>
	                               
	                               <div class="hr-line-dashed"></div>                                                  
	                               <div class="form-group">
	                                  <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 교육예산</label>
	                                    <div class="col-sm-4">
	                                    	<input type="text" placeholder="금액을 입력해주세요"  OnKeyUp="comma(this)" class="form-control" id="textModalEduBudget" name="textModalEduBudget"/>
	                                    </div>
	                                    
	                               		<label class="col-sm-2 control-label">신규구분</label>
	                                   <div class="col-sm-4">
	                                       <label class="" style="margin-right:5px"> 
	                                       	<input type="radio" checked="" id="optionsRadios1" name="radioModalEduKind" value="new"> <span class="va-m">신규</span></label>
	                                       <label> <input type="radio" id="optionsRadios2" name="radioModalEduKind" value="exi"> <span class="va-m">기존</span></label>
	                                   </div>
	                               </div>  
	                                                                                                                 
	                                  <div class="hr-line-dashed"></div>
	                                  <div class="form-group">
	                                  	  <label class="col-sm-2 control-label" for="date_modified">교육 시작일</label>
	                                      <div class="col-sm-4">
	                                          <div id="data_1" class="pd-b10">
	                                              <div class="input-group date">
	                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalStartDate" name="textModalStartDate">
	                                              </div>
	                                          </div>
	                                      </div>
	                                      <label class="col-sm-2 control-label" for="date_modified">교육 종료일</label>
	                                      <div class="col-sm-4">
	                                          <div  id="data_1">
	                                              <div class="input-group date">
	                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalEndDate" name="textModalEndDate">
	                                              </div>
	                                          </div>
	                                      </div>
	                                  </div>
	                                  
	                                  <div class="hr-line-dashed"></div>
	                                  <div class="form-group">
	                                  	  <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 총 교육시간</label> 
	                                      <div class="col-sm-4">
	                                      	<input type="text" class="form-control" id="textModalTotalHours" name="textModalTotalHours" onkeyup="commonCheck.onlyNumber(this);">
	                                      </div>
	                                  </div>
	                                  
	                                  <div class="hr-line-bottom"></div>
	                                  
	                                  
	                                  
	                                  
	                                  <div class="tab-area">

                                        <!-- tab-menu -->
                                        <ul class="tabmenu-type">
                                            <li><a href="#" class="sel">피교육자 정보 및 만족도 평가</a></li>
                                            <li><a href="#" class="">첨부파일</a></li>
                                        </ul>
                                        <!--// tab-menu -->

                                        <!-- 피교육자 정보 및 만족도 평가 -->
                                        <div class="sub_cont scont1 modaltabmenu">
                                        	<jsp:include page="/WEB-INF/jsp/pc/partnerManagement/partnerCooperationEnablementMilestones.jsp"/>	
                                        </div>
                                        <!--// 마일스톤 -->

										<!-- file -->
                                        <div class="sub_cont scont2 modaltabmenu off">
                                            <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                        </div>
                                        <!--// file -->
                                        
                                        
                                        <!--// tab-cont -->

                                    </div>
                                    
                                    	<div class="hr-line-dashed"></div>
		                                 <p class="text-center">
	                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
	                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
	                                    </p>
	                                    
	                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
	                                    <input type="hidden"name="hiddenModalAmount" 			id="hiddenModalAmount" />
	                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                              </form>
                               <%--  <form id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성자</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="홍길동" class="form-control" id="textModalTextName" ></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalCreateDate"></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">최종변경일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalUpdateDate"></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">고객사</label>
                                        <div class="col-sm-10">
                                            <div class="select-com"><!-- <label>항목선택</label> --> 
                                                <select class="form-control m-b" name="selectModalCompany" id="selectModalCompany">
	                                                <option value="">==== 선택 ====</option>
	                                                <c:choose>
														<c:when test="${fn:length(applicationCompanyGroup) > 0}">
															<c:forEach items="${applicationCompanyGroup}" var="companyGroup">
							                                    <option value="${companyGroup.COMPANY_ID}">${companyGroup.COMPANY_NAME}</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    </c:choose>
                                            	</select>
                                            </div>
                                        </div>
                                    </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label">고객명</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName"/></div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label">이슈제기자</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalIssueCreator" name="textModalIssueCreator"/></div>
                                   </div>
                                   
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈종류</label>
                                        <div class="col-sm-10">
                                            <div class="select-com"><!-- <label>항목선택</label> --> 
                                                <select class="form-control m-b"  id="selectModalIssueCategory" name="selectModalIssueCategory">
	                                                <option value="">==== 선택 ====</option>
	                                                <option value="제품">제품</option>
	                                                <option value="서비스">서비스</option>
	                                                <option value="지원">지원</option>
                                            	</select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>                                                
                                     <div class="form-group"><label class="col-sm-2 control-label">영업대표</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalSalesRepresentive" name="textModalSalesRepresentive"/></div>
                                   </div>
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified">이슈발생일</label>
                                        <div class="col-sm-10">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalIssueDate" name="textModalIssueDate">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified">해결목표기한</label>
                                        <div class="col-sm-10">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalDueDate" name="textModalDueDate">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈내용</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalIssueDetail" name="textareaModalIssueDetail"></textarea></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈해결책임자</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalSolveOwner" name="textModalSolveOwner"/></div>
                                   </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified">이슈해결일</label>
                                      <div class="col-sm-10">
                                          <div class="data_1">
                                              <div class="input-group date">
                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                  <input type="text" class="form-control" id="textModalIssueCloseDate" name="textModalIssueCloseDate"y>
                                              </div>
                                          </div>
                                      </div>
                                  </div>                                                
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">해결계획<br/>(Plan)</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalSolvePlan" name="textareaModalSolvePlan"></textarea></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈 상태</label>
                                        <div class="col-sm-10">
                                            <div class="select-com"><!-- <label>항목선택</label> -->
                                                <select class="form-control m-b" name="selectModalIssueStatus" id="selectModalIssueStatus">
                                                <option value="">==== 선택 ====</option>
                                                <option value="1">발생</option>
                                                <option value="2">진행중</option>
                                                <option value="3">완료</option>
                                            </select></div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈해결 증빙여부</label>
                                        <div class="col-sm-10">
                                            <div class="select-com"><!-- <label>항목선택</label> -->  
                                                <select class="form-control m-b" name="selectModalSolveEvidenceYN" id="selectModalSolveEvidenceYN">
                                                <option value="">==== 선택 ====</option>
                                                <option value="Y">Yes</option>
                                                <option value="N">No</option>
                                            </select></div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈해결<br/>(증빙내용)</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" name="textareaSolveEvidenceDetail" id="textareaSolveEvidenceDetail"></textarea></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">파일첨부</label>
                                       <div class="col-sm-10">
                                            <div class="input-default pop-file">
                                                
                                                <div class="file-dragdrap-area" id="divFileUploadArea">
                                                    <input name="fileModalUploadFile[]" id="buttonSearchFile" type="file" title="파일찾기" onkeydown="event.returnValue=false;" multiple/>
                                                    <div class="dropzone-previews" id="divFileUploadList">
                                                    	<span>파일을 선택해 주세요.</span>
                                                    </div>
                                                </div>
                                                
                                                <!-- <input type="file" id="test" /> -->
                                                <!-- 업로드 된 파일 리스트 -->
                                                <div class="file-in-list" id="divModalFile">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
                                    </p>
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                </form> --%>
                            </div>
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
$(document).ready(function() { 
		modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			//파입 업로드 
			//commonFile.upload();
			
			mileStones.draw();
			
			//tab menu
			$("ul.tabmenu-type li a").click(function(e){
				e.preventDefault();
				var idx = $("ul.tabmenu-type li a").index($(this));
				$("ul.tabmenu-type li a").removeClass("sel");
				$(this).addClass("sel");
				$("div.modaltabmenu").addClass("off");
				$("div.modaltabmenu").eq(idx).removeClass("off");
			});
			
			//유효성 검사
			$("#textModalSubject, #textModalEduTarget, #textModalEduBudget, #textModalTotalHours").on("blur",function(e){
				$("#formModalData").find(e.target).valid();
			});
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=7&datatype=json",
				datatype : 'json',
				async : false,
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
					enableList.completeReload();
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
			//$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			
			$("#formModalData #hiddenModalAmount").val("");
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData input:text").val("");
			$("#formModalData select option:first").prop("selected",true);
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			
			$("#buttonModalDelete").hide();
			
			//파일
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("파트너교육 신규 등록");
			$("#buttonModalSubmit").html("저장하기");
			$("small.font-bold").css('display','none');
			
			mileStones.clear();
			
			$("#myModal1").modal();
			
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
						selectModalEduArea : {
							required : true
						},
						textModalEduTarget : {
							required : true,
							maxlength : 100
						},
						textModalEduBudget : {
							required : true
						},
						textModalTotalHours : {
							required : true,
							digits:true
						}
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
						selectModalEduArea : {
							required : "교육영역을 선택하세요."
						},
						textModalEduTarget : {
							required : "교육목표를 입력하세요.",
							maxlength:"100글자 이하여야 합니다"
						},
						textModalEduBudget : {
							required : "교육예산을 입력하세요."
						},
						textModalTotalHours : {
							required : "총 교육시간을 입력하세요.",
							digits : "숫자만 입력 가능합니다."
						}
					}
				})
		}, 
		
		submit : function(){
				var url;
				(modalFlag == "ins") ? url = "/partnerManagement/insertEnablement.do" : url = "/partnerManagement/updateEnablement.do";
				mileStones.saveRow();
				$("#hiddenModalAmount").val(uncomma($("#textModalEduBudget").val()));
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			mileStonesData : JSON.stringify($milestonesEnablement.getRowData()),
		    			datatype : 'json',
		    			fileData : JSON.stringify(commonFile.fileArray)
		    		},
		            beforeSubmit: function (data,form,option) {
		            	if(!compareFlag){
							if(!confirm("저장하시겠습니까?")) return false;
		            	}
		            	$.ajaxLoading();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		            	 //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	alert("저장하였습니다.");
		                	
		                	compareFlag = false;
		                	enableList.reset();
		            		enableList.get();
		            		compare_before = $("#formModalData").serialize();
		                	/* if(compareFlag){ //변경 내용 저장
			            		compareFlag = false;
			            		compare_before = null;
			            		compare_after = null;
			            	}else  */if(modalFlag == "ins"){ //신규등록
			            		$('#myModal1').modal("hide");
			            		/* enableList.reset();
			            		enableList.get(); */
			            	}else if(modalFlag == "upd"){ //업데이트
			            		//compare_before = $("#formModalData").serialize();
			            		enableList.completeReload();
			            	}
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
		
		//사용안함.
		deleteModal : function(){
			$.ajax({
				url : "/partnerManagement/deleteClientIssue.do",
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
					alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridEnablement.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
}
</script>


