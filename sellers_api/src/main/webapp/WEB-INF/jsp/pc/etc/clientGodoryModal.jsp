<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
					           				<!-- <button type="button" class="btn btn-gray mg-b10" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView" onclick="coachingTalk.view('issue');">Coaching Talk</button> -->
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
                                                <select class="form-control"  id="selectModalIssueCategory" name="selectModalIssueCategory">
                                                <spring:eval expression="@config['code.clientGodoryCategory']" />
                                                <!-- 
	                                                <option value="">== 선택 ==</option>
	                                                <option value="category01">고쳐주세요</option>
	                                                <option value="category02">도와주세요</option>
	                                                <option value="category03">이런건어때요</option>
	                                                 -->
                                            	</select>
                                            </div>
                                        </div>
                                    </div>
                                    

                          		    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>

                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">내용</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalIssueDetail" name="textareaModalIssueDetail"
                                         onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                    </div>
	                                
                                    <div class="hr-line-dashed"></div>
                                    <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(1);" id="buttonModalSubmit">임시저장</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(2);" id="buttonModalSubmitShare">제출</button>
                                    </p>
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
                                    <input type="hidden" name="hiddenModalSalesId" id="hiddenModalSalesId"/>
                                    <input type="hidden" name="hiddenModalSolveOwnerId" id="hiddenModalSolveOwnerId"/>
                                    <input type="hidden" name="hiddenModalIssueConfirmId" id="hiddenModalIssueConfirmId"/>
                                    <input type="hidden" name="hiddenModalContactId" 		id="hiddenModalContactId"/>
                                    <input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}"/>
                        			<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}"/>
                        			
                        			<!-- 고객 만족도 -->
		                        	 <input type="hidden" name="hiddenCsatDetailId" id="hiddenCsatDetailId" value="${param.hiddenCsatDetailId}"/> 
		                        	 <input type="hidden" name="hiddenCsatDetailCompanyName" id="hiddenCsatDetailCompanyName" value="${param.hiddenCsatDetailCompanyName}"/> 
		                        	 <input type="hidden" name="hiddenCsatDetailCompanyId" id="hiddenCsatDetailCompanyId" value="${param.hiddenCsatDetailCompanyId}"/> 
		                        	 <input type="hidden" name="hiddenCsatDetailSubject" id="hiddenCsatDetailSubject" value="${param.hiddenCsatDetailSubject}"/> 
		                        	 <input type="hidden" name="hiddenCsatDetailCustomerName" id="hiddenCsatDetailCustomerName" value="${param.hiddenCsatDetailCustomerName}"/>
		                        	 <input type="hidden" name="hiddenCsatDetailCustomerRank" id="hiddenCsatDetailCustomerRank" value="${param.hiddenCsatDetailCustomerRank}"/> 
		                        	 <input type="hidden" name="hiddenCsatDetailCustomerId" id="hiddenCsatDetailCustomerId" value="${param.hiddenCsatDetailCustomerId}"/>
		                        	 <input type="hidden" name="hiddenSelectIssueId" id="hiddenSelectIssueId" value="${param.csat_id}"/> 
		                        	 <input type="hidden" name="hiddenSelectIssueStatus" id="hiddenSelectIssueStatus" value="${param.issue_status}"/> 
		                        	 
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
		modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
			commonSearch.member($('#formModalData #textModalSalesRepresentive'), $('#formModalData #hiddenModalSalesId'));
			commonSearch.member($('#formModalData #textModalSolveOwner'), $('#formModalData #hiddenModalSolveOwnerId'));
			commonSearch.member($('#formModalData #textModalIssueConfirmId'), $('#formModalData #hiddenModalIssueConfirmId'));
			
			if($("#hiddenCsatDetailId").val() != '' && $("#hiddenCsatDetailId").val() != null){
				modal.reset();
				$("#textCommonSearchCompany").val($("#hiddenCsatDetailCompanyName").val());
				$("#textCommonSearchCompanyId").val($("#hiddenCsatDetailCompanyId").val());
				$("#textModalSubject").val($("#hiddenCsatDetailSubject").val());
				$("#textModalCustomerName").val($("#hiddenCsatDetailCustomerName").val());
				$("#textModalIssueCreator").val($("#hiddenCsatDetailCustomerName").val());
				$("#textModalCustomerRank").val($("#hiddenCsatDetailCustomerRank").val());
				$("#hiddenModalCustomerId").val($("#hiddenCsatDetailCustomerId").val());
			}
			
			
			//유효성 검사
			$("#textCommonSearchCompany, #textModalCustomerName, #textModalSalesRepresentive, #textModalSolveOwner, #textModalSubject, #selectModalIssueCategory, #textModalIssueDate, #textModalDueDate").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData").find("#hiddenModalCustomerId").valid();
						break;
					case "textModalSalesRepresentive":
						$("#formModalData").find("#hiddenModalSalesId").valid();
						break;
					case "textModalSolveOwner":
						$("#formModalData").find("#hiddenModalSolveOwnerId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
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
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			//$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			//$("#textModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			$("#hiddenModalPK, #hiddenModalCompanyId, #hiddenModalCustomerId, #hiddenModalSalesId, #hiddenModalContactId, #hiddenModalSolveOwnerId").val("");
			$('[name="divRelation"]').hide();
			$("#buttonModalDelete").hide();
			
			//파일
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("고도리 신규 등록");
			$("small.font-bold").css('display','none');
			
			//modal.drawIssueSolvePlan();
			
			$("div.custom-company-pop.off").hide(); //메일공유 직원검색 팝업숨김
			$("#textModalIssueDate").val(moment(new Date()).format("YYYY-MM-DD"));//이슈발생일 default 오늘
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: "", 
					rules : {
						textModalSubject : {
							required : true,
							maxlength : 100
						},
						/* 
						hiddenModalCompanyId : {
							required : true
						},
						hiddenModalCustomerId : {
							required : true,
							maxlength : 10
						},
						 */
						textModalIssueCreator : {
							required : true,
							maxlength : 10
						},
						selectModalIssueCategory : {
							required : true
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						/* 
						textModalIssueDate : {
							required : true
						},
						textModalDueDate : {
							required : true
						},
						 */
						textareaModalIssueDetail : {
							minlength : 1,
							maxlength : 2000
						},
						/* 
						hiddenModalSolveOwnerId : {
							required : true,
							maxlength : 10
						},
						 */
						/* textModalIssueCloseDate : {
							required : true
						}, */
						/* 
						textareaModalSolvePlan : {
							minlength : 1,
							maxlength : 2000
						},
						selectModalSolveEvidenceYN : {
							required : true
						},
						hiddenModalSalesId : {
							required : true
						},
						textareaSolveEvidenceDetail : {
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
						textModalSubject : {
							required : "제목을 입력하세요.",
							maxlength:"100글자 이하여야 합니다" 
						},
						/* 
						hiddenModalCompanyId : {
							required : "고객사를 선택하세요."
						},
						hiddenModalCustomerId : {
							required : "고객명을 입력하세요.",
							maxlength:"10글자 이하여야 합니다"
						},
						textModalIssueCreator : {
							required : "이슈제기자를 입력하세요.",
							maxlength:"10글자 이하여야 합니다"
						},
						 */
						selectModalIssueCategory : {
							required : "고도리영역을 선택하세요."
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						/* 
						textModalIssueDate : {
							required : "이슈발생일를 선택하세요."
						},
						textModalDueDate : {
							required : "해결목표일을 선택하세요."
						},
						 */
						textareaModalIssueDetail : {
							minlength : 1,
							maxlength : 2000
						},
						/* 
						hiddenModalSolveOwnerId : {
							required : "이슈해결책임자를 입력하세요.",
							maxlength:"10글자 이하여야 합니다"
						},
						 */
						/* textModalIssueCloseDate : {
							required : "이슈해결일를 선택하세요."
						}, */
						/* 
						textareaModalSolvePlan : {
							minlength : 1,
							maxlength : 2000
						},
						selectModalSolveEvidenceYN : {
							required : "이슈해결 증빙여부를 선택하세요."
						},
						 */
						/* 
						hiddenModalSalesId : {
							required : "영업대표를 입력하세요."
						},
						
						 */
						 textareaSolveEvidenceDetail : {
							minlength : 1,
							maxlength : 2000
						}
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "hiddenModalCompanyId") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else if($(element).prop("id") == "hiddenModalCustomerId") {
					        $("#textModalCustomerName").after(error);
					        location.href = "#textModalCustomerName";
					    }else if($(element).prop("id") == "hiddenModalSalesId") {
					        $("#textModalSalesRepresentive").after(error);
					        location.href = "#textModalSalesRepresentive";
					    }else if($(element).prop("id") == "hiddenModalSolveOwnerId") {
					        $("#textModalSolveOwner").after(error);
					        location.href = "#textModalSolveOwner";
					    }else {
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		submit : function(shareFlag){
				
				if(!isEmpty(lastEdit)){
					$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
				}
				var url;
				(modalFlag == "ins") ? url = "/etc/insertClientGodory.do" : url = "/clientSatisfaction/updateClientIssue.do";
				 $('#formModalData').ajaxForm({
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
		    			}
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
		                	alert("저장하였습니다.");
		                	
		                	compareFlag = false;
		                	compare_before = $("#formModalData").serialize();
		                	issueList.reset();
							issueList.get();
		                	if(modalFlag == "ins"){ //신규등록
			            		$('#myModal1').modal("hide");
			            	}else if(modalFlag == "upd"){ //업데이트
			                	issueList.completeReload();
			            		$('#myModal1').modal("hide");
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
					hiddenModalPK : $("#hiddenModalPK").val()
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
		
}
</script>