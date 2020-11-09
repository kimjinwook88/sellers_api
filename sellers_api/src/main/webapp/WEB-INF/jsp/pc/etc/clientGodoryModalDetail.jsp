<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal inmodal fade" id="myModal2" tabindex="-1" role="dialog"  aria-hidden="true">
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
                                <form class="form-horizontal" id="formModalData2" name="formModalData2" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                  		<div class="col-sm-12 ag_r">
                                    		<span name="divModalNameAndCreateDate1" id="divModalNameAndCreateDate1">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
					           				<button type="button" class="btn btn-gray mg-b10" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView" onclick="coachingTalk.view('issue');">Coaching Talk</button>
	                                    </div>
                                	
	                                	<div id="divModalCoachingTalk" style="display: none;">
	                               			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
	                               		</div>
                                
                          		    </div>
                          		    <div class="hr-line-dashed"></div>
                          		    <div class="form-group">
                          		    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고도리 영역</label>
                                        <div class="col-sm-4">
                                            <div class="select-com"><!-- <label>항목선택</label> --> 
                                                <select class="form-control"  id="selectGodoryTerritory1" name="selectGodoryTerritory1">
	                                                <option value="">== 선택 ==</option>
	                                                <option value="1">고쳐주세요</option>
	                                                <option value="2">도와주세요</option>
	                                                <option value="3">이런건어때요</option>
                                            	</select>
                                            </div>
                                        </div>
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 채택여부</label>
                                        <div class="col-sm-4">
                                            <div class="select-com"><!-- <label>항목선택</label> --> 
                                                <select class="form-control"  id="selectApprovalYN" name="selectApprovalYN">
	                                                <option value="">== 선택 ==</option>
	                                                <option value="1">채택</option>
	                                                <option value="2">미책택</option>
	                                                <option value="3">검토중</option>
                                            	</select>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    

                          		    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject1" name="textModalSubject1"/></div>
                                    </div>
                                    <!-- 
                                   <div class="hr-line-dashed"></div>
								   <div class="form-group">
								   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
	                                     <div class="col-sm-4 pos-rel">
	                                         <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
	                                     </div>
	                                     <label class="col-sm-2 control-label">고객사ID</label>
	                                     <div class="col-sm-4 pos-rel">
                                         	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                         </div>
	                               </div>
                                       
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
	                                     <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명을 검색해 주세요." autocomplete="off"/></div>
                                   <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업대표</label>
                                       <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalSalesRepresentive" name="textModalSalesRepresentive" placeholder="영업대표를 검색해 주세요." autocomplete="off"/></div>
                                   </div>
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 이슈해결책임자</label>
                                       <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalSolveOwner" name="textModalSolveOwner" placeholder="이슈해결책임자를 검색해 주세요." autocomplete="off"/></div>
                                    <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 이슈영역</label>
                                        <div class="col-sm-4">
                                            <div class="select-com"><label>항목선택</label> 
                                                <select class="form-control"  id="selectModalIssueCategory" name="selectModalIssueCategory">
	                                                <option value="">== 선택 ==</option>
	                                                <option value="제품">제품</option>
	                                                <option value="서비스">서비스</option>
	                                                <option value="지원">지원</option>
                                            	</select>
                                            </div>
                                        </div>
                                    </div>
                                     -->
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">내용</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalIssueDetail1" name="textareaModalIssueDetail1"
                                         onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 제안일자</label>
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalIssueDate1" name="textModalIssueDate1">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="detail_if_y_view">
                                    	<label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 목표일자</label>
                                    	<!-- <label class="col-sm-2 control-label" for="date_modified"></i> 해결목표일자</label> -->
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalDueDate1" name="textModalDueDate1">
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                    
                                   <div class="detail_if_y_view2">
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">완료일자</label>
	                                     <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalIssueCloseDate1" name="textModalIssueCloseDate1">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 
                                        <label class="col-sm-2 control-label">해결확인자</label>
                                        <div class="col-sm-4 pos-rel">
                                        	<input type="text" class="form-control" id="textModalIssueConfirmId" name="textModalIssueConfirmId" placeholder="이슈해결확인자를 검색해 주세요." autocomplete="off"/>
                                        </div>
                                         -->
                                   </div>
                                                                                                                   
                                    <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">해결계획</label>
                                       <div class="col-sm-10">
                                       		<table id="issueSolvePlanGrid"></table>
                                       		<p class="text-center pd-t10">
												<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal2.addRow();">+ 해결계획 추가</a>
								            </p>
                                       	</div>
                                   </div>
                                   
                                   
                                    <div class="hr-line-dashed"></div>
						            <div class="form-group pos-rel">
						            	<label class="col-md-3 col-lg-2 control-label">메일공유</label>
	                                    <div class="col-sm-10">
	                                        <div class="company-search mg-b5">
	                                            <div class="company-current">
	                                        	</div>
	                                            <button type="button" class="btn btn-gray btn-file" onClick="$('div.custom-company-pop').show();">직원 검색</button>
	                                        </div>                                                                                            
	                                    </div>
	                                    
	                                    <div class="custom-company-pop off">
	                                        <div class="pop-header">
	                                            <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	                                            <strong class="pop-title">직원 검색</strong>
	                                        </div>
	                                        <div class="col-sm-12 cont">
	                                            <div class="form-group">
	                                                <div class="col-sm-12">
	                                                    <div class="company-search-after mg-b5"><!-- 검색 -->
	                                                        <input type="text" placeholder="직원 검색" class="form-control fl_l mg-r5" id="textCommonSearchMember">
	                                                        <button type="button" class="btn btn-gray btn-file" onClick="commonSearch.multipleMemberPop();">검색</button>
	                                                    </div>
	                                                </div>
	                                                <div class="col-sm-12 company-result mg-b10 "><!-- 검색 결과 노출시 "off" 삭제 -->
	                                                    <strong>[직원 검색 결과]</strong>
	                                                    <ul class="company-list">
	                                                    </ul>
	                                                </div>
	                                            </div>
	                                            <!-- <div class="ta-c">
	                                                <button type="button" class="btn btn-gray btn-file">추가하기</button>
	                                            </div> -->
	                                        </div>
	                                    </div>
	                                </div>
	                                </div>
	                                
                                    <div class="hr-line-dashed"></div>
                                    <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal2.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal2.submit1(1);" id="buttonModalSubmit2">저장하기</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal2.submit1(2);" id="buttonModalSubmitShare2">저장하기 및 공유하기</button>
                                    </p>
                                    <input type="hidden"name="hiddenModalPK1" 			id="hiddenModalPK1" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId1" id="hiddenModalCreatorId1" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalSalesId1" id="hiddenModalSalesId1"/>
                                    <input type="hidden" name="hiddenModalSolveOwnerId1" id="hiddenModalSolveOwnerId1"/>
                                    <input type="hidden" name="hiddenModalIssueConfirmId1" id="hiddenModalIssueConfirmId1"/>
                                    <input type="hidden" name="hiddenModalContactId1" 		id="hiddenModalContactId1"/>
                                    <input type="hidden" name="hiddenModalMemberList"	id="hiddenModalMemberList"/>
                                    <input type="hidden" name="hiddenModalHanName1" id="hiddenModalHanName1" value="${userInfo.HAN_NAME}"/>
                        			<input type="hidden" name="hiddenModalEmail1" id="hiddenModalEmail1" value="${userInfo.EMAIL}"/>
                                </form>
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
var lastEdit;

var returnCsatDetailId = "${param.hiddenCsatDetailId}";
var returnCsatDetailCompanyName = "${param.hiddenCsatDetailCompanyName}";
var returnCsatDetailCompanyId = "${param.hiddenCsatDetailCompanyId}";
var returnhiddenCsatDetailSubject = "${param.hiddenCsatDetailSubject}";
var returnCsatDetailCustomerName= "${param.hiddenCsatDetailCustomerName}";

$(document).ready(function() { 
		modal2.init();
});		

var modal2 = {
		init : function(){
			//유효성 체크
			modal2.validate();
			
			//자동완성 검색
			commonSearch.company($('#formModalData2 #textCommonSearchCompany'), $('#formModalData2 #hiddenModalCompanyId'), $('#formModalData2 #textCommonSearchCompanyId'));
			commonSearch.customer($('#formModalData2 #textModalCustomerName'), $('#formModalData2 #hiddenModalCustomerId'), $('#formModalData2 #textModalCustomerRank'), $('#formModalData2 #hiddenModalCompanyId'));
			commonSearch.member($('#formModalData2 #textModalSalesRepresentive'), $('#formModalData2 #hiddenModalSalesId1'));
			commonSearch.member($('#formModalData2 #textModalSolveOwner'), $('#formModalData2 #hiddenModalSolveOwnerId'));
			commonSearch.member($('#formModalData2 #textModalIssueConfirmId'), $('#formModalData2 #hiddenModalIssueConfirmId'));
			
			if($("#hiddenCsatDetailId").val() != '' && $("#hiddenCsatDetailId").val() != null){
				modal2.reset();
				$("#textCommonSearchCompany1").val($("#hiddenCsatDetailCompanyName1").val());
				$("#textCommonSearchCompanyId1").val($("#hiddenCsatDetailCompanyId1").val());
				$("#textModalSubject1").val($("#hiddenCsatDetailSubject1").val());
				$("#textModalCustomerName1").val($("#hiddenCsatDetailCustomerName1").val());
				$("#textModalIssueCreator1").val($("#hiddenCsatDetailCustomerName1").val());
				$("#textModalCustomerRank1").val($("#hiddenCsatDetailCustomerRank1").val());
				$("#hiddenModalCustomerId1").val($("#hiddenCsatDetailCustomerId1").val());
			}

			/* 
			alert($("#selectApprovalYN").val());
			
			if($("#selectApprovalYN").val() == '1'){
				$(".detail_if_y_view").show();
				$(".detail_if_y_view2").show();
			}else{
				$(".detail_if_y_view").hide();
				$(".detail_if_y_view2").hide();
			}
			 */
			 /* 
			 jQuery('#selectApprovalYN').change(function(){
				
				 var state = jQuery('#selectApprovalYN option:selected').val();
				 if(state == '1'){
					$(".detail_if_y_view").show();
					$(".detail_if_y_view2").show();
				 }else{
					 $(".detail_if_y_view").hide();
					$(".detail_if_y_view2").hide();
				 }
			 })
			  */
			
			//직원 검색
			$('#textCommonSearchMember').on('keydown',function(key){
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					commonSearch.multipleMemberPop();
			     }
			});
			
			//유효성 검사
			$("#textCommonSearchCompany, #textModalCustomerName, #textModalSalesRepresentive, #textModalSolveOwner, #textModalSubject, #selectModalIssueCategory, #textModalIssueDate, #textModalDueDate").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData2").find("#hiddenModalCompanyId1").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData2").find("#hiddenModalCustomerId1").valid();
						break;
					case "textModalSalesRepresentive":
						$("#formModalData2").find("#hiddenModalSalesId1").valid();
						break;
					case "textModalSolveOwner":
						$("#formModalData2").find("#hiddenModalSolveOwnerId1").valid();
						break;
					default:
						$("#formModalData2").find(e.target).valid();
						break;
				}
			});
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=4&datatype=json",
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
					issueList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		validate : function(){
				$("#formModalData2").validate({ // joinForm에 validate를 적용
					ignore: "", 
					rules : {
						textModalSubject1 : {
							required : true,
							maxlength : 100
						},
						/* 
						textModalIssueCreator1 : {
							required : true,
							maxlength : 10
						},
						 */
						selectGodoryTerritory1 : {
							required : true
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						textModalIssueDate1 : {
							required : true
						},
						
						//해결목표일자
						textModalDueDate1 : {
							required : true
						},
						
						/* 
						textareaModalIssueDetail1 : {
							minlength : 1,
							maxlength : 2000
						},
						hiddenModalSolveOwnerId1 : {
							required : true,
							maxlength : 10
						},
						textModalIssueCloseDate : {
							required : true
						}, 
						textareaModalSolvePlan1 : {
							minlength : 1,
							maxlength : 2000
						},
						selectModalSolveEvidenceYN1 : {
							required : true
						},
						hiddenModalSalesId1 : {
							required : true
						},
						
						textareaSolveEvidenceDetail1 : {
							minlength : 1,
							maxlength : 2000
						} */
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
						textModalSubject1 : {
							required : "제목을 입력하세요.",
							maxlength:"100글자 이하여야 합니다" 
						},
						textModalIssueCreator1 : {
							required : "이슈제기자를 입력하세요.",
							maxlength:"10글자 이하여야 합니다"
						},
						selectGodoryTerritory1 : {
							required : "고도리영역를 선택하세요."
						},
						
						textModalDueDate1 : {
							required : "목표일자를 선택하세요."
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						/* 
						textModalIssueDate1 : {
							required : "이슈발생일를 선택하세요."
						},
						textareaModalIssueDetail1 : {
							minlength : 1,
							maxlength : 2000
						},
						hiddenModalSolveOwnerId1 : {
							required : "이슈해결책임자를 입력하세요.",
							maxlength:"10글자 이하여야 합니다"
						},
						textModalIssueCloseDate : {
							required : "이슈해결일를 선택하세요."
						}, 
						
						textareaModalSolvePlan1 : {
							minlength : 1,
							maxlength : 2000
						},
						
						selectModalSolveEvidenceYN1 : {
							required : "이슈해결 증빙여부를 선택하세요."
						},
						hiddenModalSalesId1 : {
							required : "영업대표를 입력하세요."
						},
						
						textareaSolveEvidenceDetail1 : {
							minlength : 1,
							maxlength : 2000
						} */
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "hiddenModalCompanyId1") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else if($(element).prop("id") == "hiddenModalCustomerId1") {
					        $("#textModalCustomerName").after(error);
					        location.href = "#textModalCustomerName";
					    }else if($(element).prop("id") == "hiddenModalSalesId1") {
					        $("#textModalSalesRepresentive").after(error);
					        location.href = "#textModalSalesRepresentive";
					    }else if($(element).prop("id") == "hiddenModalSolveOwnerId1") {
					        $("#textModalSolveOwner").after(error);
					        location.href = "#textModalSolveOwner";
					    }else {
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		submit1 : function(shareFlag){
			
				if(!isEmpty(lastEdit)){
					$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
				}
				var url;
				(modalFlag == "ins") ? url = "/etc/insertClientGodory.do" : url = "/etc/updateClientGodory.do";
				 $('#formModalData2').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			issueSolvePlanGrid : JSON.stringify($("#issueSolvePlanGrid").getRowData()),
		    			shareFlag : function(){
		    				if(shareFlag == 1){
		    					return false;
		    				}else{
		    					return true;
		    				}
		    			},
		    			shareFlagDetail : "Y"
		    		},
		            beforeSubmit: function (data,form,option) {
		            	if($('#textModalIssueDate1').val()>$('#textModalDueDate1').val()) {
		            		alert("발생일이 해결목표일보다 이전입니다."); return false;
		            	}else if($('#textModalIssueDate1').val()>$('#textModalIssueCloseDate1').val() && $('#textModalIssueCloseDate1').val()!=''){
		            		alert("발생일이 이슈해결일보다 이전입니다."); return false;
		            	}
						 /* 
						if($('#textModalIssueDate1').val()>$('#textModalIssueCloseDate1').val() && $('#textModalIssueCloseDate1').val()!=''){
		            		alert("이슈발생일이 해결일보다 이전입니다."); return false;
						}
						 */
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
		                	alert("저장하였습니다.");
		                	
		                	compareFlag = false;
		                	compare_before = $("#formModalData2").serialize();
		                	issueList.reset();
							issueList.get();
		                	/* if(compareFlag){ //변경 내용 저장
			            		compare_before = null;
			            		compare_after = null;
			            	}else  */if(modalFlag == "ins"){ //신규등록
			            		$('#myModal1').modal("hide");
								/* issueList.reset();
								issueList.get(); */
			            	}else if(modalFlag == "upd"){ //업데이트
			            		//compare_before = $("#formModalData2").serialize();
			                	issueList.completeReload();
			            		$('#myModal2').modal("hide");
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
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSatisfaction/deleteClientIssue.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK1").val()
				},
				success : function(data){
					alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridClientIssue.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		drawIssueSolvePlan : function(){
			$("#issueSolvePlanGrid").jqGrid('clearGridData');
			$("#issueSolvePlanGrid").jqGrid({
				url : "/etc/selectSolvePlanIssue.do?pkNo="+$("#hiddenModalPK1").val(),
				datatype : 'json',
				colModel : [ 
				{
					label : '해결계획',
					name : 'SOLVE_PLAN',
					align : "left",
					width : 230,
					editable: true,
					edittype:'textarea'
				}, {
					label : '책임자',
					name : 'SOLVE_OWNER',
					align : "center",
					width : 120,
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
				}, {
					label : 'SOLVE_OWNER_ID',
					name : 'SOLVE_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '등록일',
					name : 'SYS_REGISTER_DATE',
					align : "center",
					width : 80
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
		             							modal2.changeStatus();
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
		             							modal2.changeStatus();
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
						return '<a href="javascript:void(0);" onClick="modal2.delRow(\''+cellval.rowId+'\',\''+colpos.ACTION_ID+'\');"><i class="fa fa-trash-o fa-lg"></i></a>'; 
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
				onCellSelect : function(id, col) {
					//var rowData = $(this).jqGrid("getRowData",id);
					if(col != 6){
						if(id && lastEdit != id){
							$(this).jqGrid('editRow',id,true);
							$(this).jqGrid('saveRow', lastEdit);
							lastEdit = id;
						}else if(lastEdit == id){
							$(this).jqGrid('editRow',id,true);
						}
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
			})
		},
		
		addRow : function(){
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
			$.ajax({
				url : "/clientSatisfaction/deleteClientIssueActionPlan.do",
				async : false,
				datatype : 'json',
				data : {
					issueActionId : actionId
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
						//alert("삭제되었습니다.");
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
			
		},
		
		changeStatus : function(){
			$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
			//$("#issueSolvePlanGrid").jqGrid('getGridParam', "selrow" );
			var dueDate= ($("#issueSolvePlanGrid").jqGrid('getCell',lastEdit,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#issueSolvePlanGrid").jqGrid('getCell',lastEdit,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			 if((dueDate >= nowDate) && closeDate == ""){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'Y');
				/* $("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'Y'); */
			}else if(dueDate < nowDate && closeDate == ""){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'R');
				/* $("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'R'); */
			}else if(closeDate != "" && closeDate != null){
				$("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'STATUS', 'G');
				/* $("#issueSolvePlanGrid").jqGrid('setCell', lastEdit, 'HIDDEN_STATUS', 'G'); */
			} 
			
			lastEdit = 0;
		},
		
		solvePlanReload : function(){
			$("#issueSolvePlanGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/etc/selectSolvePlanIssue.do?pkNo="+$("#hiddenModalPK1").val()}).trigger('reloadGrid');
		}
		
}
</script>