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
                                  			<span class="label orange_count_bg" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView"><a onclick="coachingTalk.view('ISSUE');"><i class="fa fa-comments-o" style="color: white;"></i> <span style="color: white;" id="spanCtCount"></span></a></span>
                                    		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
	                                    </div>
                                	
	                                	<div id="divModalCoachingTalk" style="display: none;">
	                               			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
	                               		</div>
                                
                          		    </div>
                          		    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 이슈 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
                                    <!-- <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성자</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="홍길동" class="form-control" id="textModalTextName" ></div>
                                    </div>
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">작성일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalCreateDate"></div>
                                    </div> -->
                                   <!--  <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">최종변경일</label>
                                        <div class="col-sm-10"><input type="text" disabled="" placeholder="" class="form-control" id="textModalUpdateDate"></div>
                                    </div> -->
                                   <%--  <div class="hr-line-dashed"></div>
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
                                    </div> --%>
                                   <!-- <div class="hr-line-dashed"></div>
								   <div class="form-group">
								   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
	                                     <div class="col-sm-4 pos-rel">
	                                         <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
	                                     </div>
	                                     <label class="col-sm-2 control-label">고객사ID</label>
	                                     <div class="col-sm-4 pos-rel">
                                         	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                         </div>
	                               </div> -->
                                    
                                    <div class="hr-line-dashed"></div>
								   <div class="form-group">
                                   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i>고객명</label>
	                                     <div class="col-md-9 col-lg-10">
                                              <ul id="ulMultipleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liMultipleClient" name="liMultipleClient">
                                                      <input type="text" class="form-control" id="textMultipleClient" name="textMultipleClient" placeholder="고객명을 검색해 주세요." autocomplete="off"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                   </div>
                                      
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   <!-- <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
	                                     <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명을 검색해 주세요." autocomplete="off"/></div> -->
                                   <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업대표</label>
                                       <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalSalesRepresentive" name="textModalSalesRepresentive" placeholder="영업대표를 검색해 주세요." autocomplete="off"/></div>
                                   <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 이슈해결책임자</label>
                                       <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalSolveOwner" name="textModalSolveOwner" placeholder="이슈해결책임자를 검색해 주세요." autocomplete="off"/></div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                    <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 이슈영역</label>
                                        <div class="col-sm-4">
                                            <div class="select-com"><!-- <label>항목선택</label> --> 
                                                <select class="form-control"  id="selectModalIssueCategory" name="selectModalIssueCategory">
	                                                <option value="">== 선택 ==</option>
	                                                <option value="제품">제품</option>
	                                                <option value="서비스">서비스</option>
	                                                <option value="지원">지원</option>
                                            	</select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">이슈내용</label>
                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalIssueDetail" name="textareaModalIssueDetail"
                                         onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>                                                
                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 이슈발생일</label>
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalIssueDate" name="textModalIssueDate" autocomplete="off">
                                                </div>
                                            </div>
                                        </div>
                                    	<label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 해결목표일</label>
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalDueDate" name="textModalDueDate" autocomplete="off">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">이슈해결일</label>
	                                     <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalIssueCloseDate" name="textModalIssueCloseDate">
                                                </div>
                                            </div>
                                        </div>
                                        <label class="col-sm-2 control-label">이슈해결확인자</label>
                                        <div class="col-sm-4 pos-rel">
                                        	<input type="text" class="form-control" id="textModalIssueConfirmId" name="textModalIssueConfirmId" placeholder="이슈해결확인자를 검색해 주세요." autocomplete="off"/>
                                        </div>
                                   </div>
                                    
                                    <div class="hr-line-dashed" name="divRelation"></div>
                                    <div class="form-group">
                                    	<label class="col-sm-2 control-label" name="divRelation">연관<br />고객컨택내용</label>
	                                     <div class="col-sm-4 pd-t7" id="relationContact" name="divRelation">
                                         </div>
                                    </div>     
                                                                                                                   
                                    <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">이슈해결계획</label>
                                       <div class="col-sm-10">
                                       		<jsp:include page="/WEB-INF/jsp/pc/common/issueSolvePlan.jsp" flush="false">
								            	<jsp:param name="fuaCategory" value="1"/>
								            </jsp:include>
                                       		<!-- <table id="issueSolvePlanGrid"></table>
                                       		<p class="text-center pd-t10">
												<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal.addRow();">+ 이슈해결계획 추가</a>
								            </p> -->
                                       	</div>
                                   </div>
                                   
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">메일공유</label>
	                                     <div class="col-md-9 col-lg-10">
                                              <ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
                                                      <input type="text" class="form-control" id="textMultipleMailShareMember" name="textMultipleMailShareMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                   </div>
                                   
                                    <!-- <div class="hr-line-dashed"></div>
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
	                                                    <div class="company-search-after mg-b5">검색
	                                                        <input type="text" placeholder="직원 검색" class="form-control fl_l mg-r5" id="textCommonSearchMember">
	                                                        <button type="button" class="btn btn-gray btn-file" onClick="commonSearch.multipleMemberPop();">검색</button>
	                                                    </div>
	                                                </div>
	                                                <div class="col-sm-12 company-result mg-b10 ">검색 결과 노출시 "off" 삭제
	                                                    <strong>[직원 검색 결과]</strong>
	                                                    <ul class="company-list">
	                                                    </ul>
	                                                </div>
	                                            </div>
	                                            <div class="ta-c">
	                                                <button type="button" class="btn btn-gray btn-file">추가하기</button>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    
	                                </div> -->
	                                
                                    <div class="hr-line-dashed"></div>
                                    <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(1);" id="buttonModalSubmit">저장하기</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(2);" id="buttonModalSubmitShare">저장하기 및 공유하기</button>
                                    </p>
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
                                    <input type="hidden" name="hiddenModalSalesId" id="hiddenModalSalesId"/>
                                    <input type="hidden" name="hiddenModalSolveOwnerId" id="hiddenModalSolveOwnerId"/>
                                    <input type="hidden" name="hiddenModalIssueConfirmId" id="hiddenModalIssueConfirmId"/>
                                    <input type="hidden" name="hiddenModalContactId" 		id="hiddenModalContactId"/>
                                    <input type="hidden" name="hiddenModalMemberList"	id="hiddenModalMemberList"/>
                                    <input type="hidden" 	name="hiddenModalCcList"	id="hiddenModalCcList"/>
                                    
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

var modalEvent = {
		on : function(){
			// 직원 검색
			$('#textCommonSearchMember').on('keydown', modalEvent.keydownSearchMember);
		},
		
		off : function(){
			// 직원 검색
			$('#textCommonSearchMember').off('keydown', modalEvent.keydownSearchMember);
			
		},
		
		keydownSearchMember : function() {
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				commonSearch.multipleMemberPop();
		    }
		}
}

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			//자동완성 검색
			commonSearch.multipleMultipleClient($("#formModalData #textMultipleClient"), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #liMultipleClient'));
			commonSearch.member($('#formModalData #textModalSalesRepresentive'), $('#formModalData #hiddenModalSalesId'));
			commonSearch.member($('#formModalData #textModalSolveOwner'), $('#formModalData #hiddenModalSolveOwnerId'));
			commonSearch.member($('#formModalData #textModalIssueConfirmId'), $('#formModalData #hiddenModalIssueConfirmId'));
			commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
			
			
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
			
			/* //직원 검색
			$('#textCommonSearchMember').on('keydown',function(key){
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					commonSearch.multipleMemberPop();
			     }
			}); */
			
			//유효성 검사
			/* $("#textMultipleClient, #textModalSalesRepresentive, #textModalSolveOwner, #textModalSubject, #selectModalIssueCategory, #textModalIssueDate, #textModalDueDate").on("blur",function(e){
				switch (e.target.id) {
					case "textMultipleClient":
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
			}); */
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
			
			//EVENT ON
			modalEvent.on();
			
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//코칭톡 버튼 제거, 창 hide
			$("#buttonModalCoachingTalkView").hide();
			$("#divModalCoachingTalk").hide();
			
			$("#formModalData #hiddenModalCcList").val("");
			$("#formModalData #hiddenModalMemberList").val("");
			commonSearch.multipleMailShareMemberArray = [];
			commonSearch.multipleMultipleClientArray = [];
			$("ul.flexdatalist-multiple li.value").remove();
			
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			$("#hiddenModalPK, #hiddenModalCompanyId, #hiddenModalCustomerId, #hiddenModalSalesId, #hiddenModalContactId, #hiddenModalSolveOwnerId").val("");
			$('[name="divRelation"]').hide();
			$("#buttonModalDelete").hide();
			
			//파일
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("고객이슈 신규 등록");
			$("small.font-bold").css('display','none');
			
			//modal.drawIssueSolvePlan();
			//이슈해결계획
			fuaReset();
			fuaAdd();
			
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
							maxlength : 50
						},
						hiddenModalCustomerId : {
							required : true
						},
						textModalIssueCreator : {
							required : true,
							maxlength : 10
						},
						selectModalIssueCategory : {
							required : true
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						textModalIssueDate : {
							required : true
						},
						textModalDueDate : {
							required : true
						},
						textareaModalIssueDetail : {
							minlength : 1,
							maxlength : 2000
						},
						hiddenModalSolveOwnerId : {
							required : true,
							maxlength : 10
						},
						/* textModalIssueCloseDate : {
							required : true
						}, */
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
							maxlength: $.validator.format('{0}자 내로 입력하세요.') 
						},
						hiddenModalCustomerId : {
							required : "고객명을 검색해 주세요."
						},
						textModalIssueCreator : {
							required : "이슈제기자를 입력하세요.",
							maxlength: $.validator.format('{0}자 내로 입력하세요.') 
						},
						selectModalIssueCategory : {
							required : "이슈영역를 선택하세요."
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						textModalIssueDate : {
							required : "이슈발생일를 선택하세요."
						},
						textModalDueDate : {
							required : "해결목표일을 선택하세요."
						},
						textareaModalIssueDetail : {
							minlength : 1,
							maxlength: $.validator.format('{0}자 내로 입력하세요.') 
						},
						hiddenModalSolveOwnerId : {
							required : "이슈해결책임자를 입력하세요.",
							maxlength: $.validator.format('{0}자 내로 입력하세요.') 
						},
						/* textModalIssueCloseDate : {
							required : "이슈해결일를 선택하세요."
						}, */
						textareaModalSolvePlan : {
							minlength : 1,
							maxlength : 2000
						},
						selectModalSolveEvidenceYN : {
							required : "이슈해결 증빙여부를 선택하세요."
						},
						hiddenModalSalesId : {
							required : "영업대표를 입력하세요."
						},
						textareaSolveEvidenceDetail : {
							minlength : 1,
							maxlength : 2000
						}
					},
					errorPlacement : function(error, element) {
						if($(element).prop("id") == "hiddenModalCustomerId") {
						   $("#ulMultipleClient").after(error);
						   location.href = "#ulMultipleClient";
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
				/* if(!isEmpty(lastEdit)){
					$("#issueSolvePlanGrid").jqGrid('saveRow', lastEdit);
				} */
				var url;
				(modalFlag == "ins") ? url = "/clientSatisfaction/insertClientIssue.do" : url = "/clientSatisfaction/updateClientIssue.do";
				
				if(!isEmpty($("#hiddenModalCustomerId").val())){
					var ccList = '';
					$('ul#ulMultipleClient li').each(function(idx, val){
						if(idx>0 && idx<$('ul#ulMultipleClient li').length-1) ccList = ccList + ', ';
						if(idx<$('ul#ulMultipleClient li').length-1 && !isEmpty($('ul#ulMultipleClient li').eq(idx)["0"].innerText)) ccList += $('ul#ulMultipleClient li').eq(idx)["0"].innerText;
					});
					$("#hiddenModalCcList").val(ccList);
				}
				
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			issueSolvePlan : JSON.stringify(fuaSubmitList()),
		    			shareFlag : function(){
		    				if(shareFlag == 1){
		    					return false;
		    				}else{
		    					return true;
		    				}
		    			},
		    			fileData : JSON.stringify(commonFile.fileArray)
		    		},
		            beforeSubmit: function (data,form,option) {
		            	if(!fuaValid) return false;
						if($('#textModalIssueDate').val()>$('#textModalDueDate').val()) {
		            		alert("이슈발생일이 해결목표일보다 이전입니다."); return false;
		            	}else if($('#textModalIssueDate').val()>$('#textModalIssueCloseDate').val() && $('#textModalIssueCloseDate').val()!=''){
		            		alert("이슈발생일이 이슈해결일보다 이전입니다."); return false;
		            	}
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
		                	
		                	/* if(compareFlag){ //변경 내용 저장
			            		compare_before = null;
			            		compare_after = null;
			            	}else  */if(modalFlag == "ins"){ //신규등록
			            		issueList.searchReset(); //등록/수정 시 검색,페이징 초기화
								/* issueList.reset();
								issueList.get(); */
			            	}else if(modalFlag == "upd"){ //업데이트
			            		//compare_before = $("#formModalData").serialize();
			                	/* issueList.completeReload(); */
			            	}
			            	issueList.get(1);
			            	$('#myModal1').modal("hide");
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
		
		drawIssueSolvePlan : function(){
			$("#issueSolvePlanGrid").jqGrid('clearGridData');
			$("#issueSolvePlanGrid").jqGrid({
				url : "/clientSatisfaction/selectSolvePlanIssue.do?pkNo="+$("#hiddenModalPK").val(),
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
					width : 80,
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
			$("#issueSolvePlanGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/selectSolvePlanIssue.do?pkNo="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
		},
		
		goSalesAct : function(pk,code) {
			var openNewWindow = window.open("about:blank");
			switch (code) {
			case "고객컨택":
				menuCookieSet("고객컨택"); //메뉴 활성화
				openNewWindow.location.href = "/clientSalesActive/viewClientContactList.do?event_id="+pk;
				break;
			}
		}
		
}
</script>