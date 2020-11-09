<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-6">
        <h2>고도리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <!-- 
            <li>
                <a>고객만족</a>
            </li>
             -->
            <li class="active">
                <strong>고도리</strong>
            </li>
        </ol>
    </div>
    <div class="col-sm-6">
        <div class="time-update">
            <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
        </div>
        
        <div class="search-common">
                <div class="input-default  fl_l" style="margin:0;">
                    <span class="input-group-btn">
                            <a href="javascript:void(0);" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
                    </span>
					
						<div class="search-detail" style="display:none;">
                                
							  <div class="col-sm-12 m-b">
                                  <label class="control-label" for="date_modified">고객사</label>
                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompanyName" onkeydown="if(event.keyCode == 13){issueList.reset();issueList.get();}"></div>
                              </div>
                              
                              <div class="col-sm-12 m-b">
                                  <label class="control-label" for="date_modified">해결상태</label>
                                  <div class="input-group" style="width:100%;">
                                  	<select class="form-control" name="actionStatus" id="actionStatus">
										<option value="">==== 선택 ====</option>
										<option value="actionStatusY">완료</option>
										<option value="actionStatusN">진행중</option>
										<option value="actionStatusX">지연</option>
									</select>
                                  </div>
                              </div>
                              
                              <div class="col-sm-12 m-b">
                                  <label class="control-label" for="date_modified">상태</label>
                                  <div class="input-group" style="width:100%;">
                                  <select class="form-control" name="status" id="status">
									<option value="">==== 선택 ====</option>
									<option value="statusY">완료</option>
									<option value="statusN">진행중</option>
									<option value="statusX">지연</option>
									</select>
                                  </div>
                              </div>
                              
                              
                              
                              
                               <div class="col-sm-12 ag_r">
                                   <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
                                   <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="issueList.reset();issueList.get();"><i class="fa fa-search"></i>검색</button>
                               </div>
                       </div>
                    
                </div>
            </div>
  
  
    </div>
</div>


<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-content border_n">
                    <div class="clear">
                    
                        <div class="pos-rel">
                            <div class="func-top-left fl_l">
                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                    <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
                                    <div class="table-menu" style="z-index:1000;display:none;">
                                        <ul>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_GODORY_TERRITORY" checked="checked"> <label for="toggle-col-1">고도리영역</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_GODORY_SUBJECT" checked="checked"> <label for="toggle-col-2">제목</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_SOLVE_OWNER" checked="checked"> <label for="toggle-col-3">제안자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_ISSUE_DATE" checked="checked"> <label for="toggle-col-4">제안일자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_DUE_DATE" checked="checked"> <label for="toggle-col-5">목표일자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_SOLVE_DATE" checked="checked"> <label for="toggle-col-6">완료일자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_APPROVAL_STATUS" checked="checked"> <label for="toggle-col-7">채택상태</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_GODORY_ACTION_STATUS_TEXT" checked="checked"> <label for="toggle-col-7">현재상태</label></li>
                                        </ul>
                                    </div>
                                </div>
                                <%-- 
                                <div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachYear">
									<select class="form-control m-b" name="selectFaceYear"
										id="selectFaceYear">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceYear) > 0}">
												<c:forEach items="${searchDetailGroup.faceYear}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.FACE_YEAR}">${searchDetailGroup.FACE_YEAR}년</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">== 년도 ==</option>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
								 --%>
								
                                
                                <div class="table-sel-view fl_l">
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachMonth">
									<select class="form-control m-b" name="selectGodoryTerritory"
										id="selectGodoryTerritory">
										<%-- <spring:eval expression="@config['code.clientGodoryCategory']" /> --%>
										
										<option value=''>=고도리 분류선택=</option>
										<option value="1">고쳐주세요</option>
										<option value="2">도와주세요</option>
										<option value="3">이런건어때요</option>
										
									</select>
								</div>
							</div>
                                
                                <!-- <div class="table-sel-view fl_l">
                                    <div class="selgrid selgrid1 mg-r5">
                                        <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
                                            <option value="">== 정렬 기준 ==</option>
                                            <option value="COMPANY_NAME">고객사</option>
                                            <option value="ISSUE_CATEGORY">이슈종류</option>
                                            <option value="SOLVE_OWNER">해결책임자</option>
                                            <option value="ISSUE_DATE">발생일</option>
                                            <option value="DUE_DATE">해결목표일</option>
                                            <option value="ISSUE_CLOSE_DATE">해결일</option>
                                            <option value="ISSUE_STATUS_TEXT">이슈상태</option>
                                        </select>
                                    </div>
                                </div> -->
                                
                            </div>
                            
                            <div class="fl_r pd-b20">
                            <c:if test="${fn:contains(auth, 'ROLE_ADMIN')}">
                            	<div class="fl_l mg-r10">
                            		<button type="button" class="btn btn-w-m btn-seller" onclick="godoryPopup.setting();">고도리 담당자 설정</button>
                            		<div class="myinfo-godory-modal" id="godoryPop" style="display: none;">
	                    <div class="pop-header">
	                        <strong class="pop-title">고도리 담당자 설정</strong>
	                    </div>
	                    <div class="col-sm-12 cont">
	                        <div class="ibox-content border_n">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b pos-rel">
	                                        고쳐주세요 현재 담당자 : 
	                                        <input type="text" placeholder="직원 명을 검색하세요." class="form-control" maxlength="30" id="textChangeGoMemberName" name="textChangeGoMemberName">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenChangeGoMemberId" name="hiddenChangeGoMemberId">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenCurrentGoMemberId" name="hiddenCurrentGoMemberId">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b pos-rel">
	                                        도와주세요 현재 담당자 : 
	                                        <input type="text" placeholder="직원 명을 검색하세요." class="form-control" maxlength="30" id="textChangeDoMemberName" name="textChangeDoMemberName">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenChangeDoMemberId" name="hiddenChangeDoMemberId">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenCurrentDoMemberId" name="hiddenCurrentDoMemberId">
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12 pos-rel">
	                                        이런건어때요 현재 담당자 : 
	                                        <input type="text" placeholder="직원 명을 검색하세요." class="form-control" maxlength="30" id="textChangeRyMemberName" name="textChangeRyMemberName">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenChangeRyMemberId" name="hiddenChangeRyMemberId">
	                                        <input type="text" class="form-control" maxlength="30" id="hiddenCurrentRyMemberId" name="hiddenCurrentRyMemberId">
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	
	                        <div class="col-sm-12 ta-c">
	                            <button type="button" class="btn btn-outline btn-seller-outline mg-r10 btn-cancle" onclick="$('.myinfo-godory-modal').hide();">취소</button>
	                            <button type="button" class="btn btn-seller" onclick="godoryPopup.updatePassword()">변경</button>
	                        </div>
	                    </div>
	                </div>
								</div>
							</c:if>
                            
                            	<div class="fl_l mg-r10">
									<a href="/etc/viewClientGodoryDashBoard.do" class="btn btn-outline btn-seller-outline">
										<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
									</a>
								</div>
                            	<!-- 
                            	<div class="fl_l template-doc">
                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
                                    <ul class="template-list off">
                                      <li><a href="#" onclick="selectSampleFile(this);">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li>
                                    </ul>
                                </div> 
                                -->
                                <div class="fl_l">
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div> 
                            </div>
                            <!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->
                            
                            <table id="tech-companies" class="table table-bordered">
						  	<colgroup>
						        <col width="5%"/>
						        <col width="20%" name="cols_GODORY_SUBJECT"/>
						        <col width="15%" name="cols_GODORY_TERRITORY"/>
						        <col width="10%" name="cols_SOLVE_OWNER"/>
						        <col width="10%" name="cols_ISSUE_DATE"/>
						        <col width="10%" name="cols_DUE_DATE"/>
						        <col width="10%" name="cols_SOLVE_DATE"/>
						        <%-- <col width="5%" name="cols_GODORY_STATUS_TEXT"/> --%>
						        <col width="5%" name="cols_APPROVAL_STATUS"/>
						        <col width="5%" name="cols_GODORY_ACTION_STATUS_TEXT"/>
						    </colgroup>
						    <thead>
						    <tr>
						        <th>No</th>
						        <th name="cols_ISSUE_SUBJECT">제목</th>
						        <th name="cols_GODORY_TERRITORY">고도리영역</th>
						        <th name="cols_SOLVE_OWNER">제안자</th>
						        <th name="cols_ISSUE_DATE">제안일자</th>
						        <th name="cols_DUE_DATE">목표일자</th>
						        <th name="cols_SOLVE_DATE">완료일자</th>
						        <!-- <th name="cols_GODORY_STATUS_TEXT">이슈해결<br />상태</th> -->
						        <th name="cols_APPROVAL_STATUS">채택상태</th>
						        <th name="cols_ISSUE_ACTION_STATUS_TEXT">현재상태</th>
						    </tr>
						    </thead>
							    <tbody id="row">
							    
		    					</tbody>
							</table>
							
                        </div>
                        <!-- 
                        <p class="text-right">
                            <button type="button" class="btn btn-outline btn-primary btn-seller-outline">선택 삭제</button>
                            <button type="button" class="btn btn-w-m btn-primary btn-seller">신듀등록</button>
                        </p> -->
                        <!-- <button class="btn btn-block btn-seller"><i class="fa fa-arrow-down"></i> 더 보기</button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/etc/clientGodoryModal.jsp"/>
<jsp:include page="/WEB-INF/jsp/pc/etc/clientGodoryModalDetail.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</body>

<script type="text/javascript">

var notice_event_id = "${param.notice_event_id}";

var selectGodoryTerritory = "${param.selectGodoryTerritory}";

$(document).ready(function(){
	
	issueList.getGodoryManager();
	issueList.init();

	if(modalReset) {
		modal.reset();
	}
	
	//스크롤 끝 이벤트	
	$(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 20;
	        if(page.start < page.totalCount){
	        	issueList.get();
	        }
	    }
	});
	
	//모달 닫기 이벤트
	$('#myModal2').on('hide.bs.modal', function () {
		compare_after = $("#formModalData2").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit2").trigger("click");
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
				}
			}
		}
	});
	
});

var params;

var returnCsatDetailId = "${param.hiddenCsatDetailId}";
var returnCsatDetailCompanyName = "${param.hiddenCsatDetailCompanyName}";
var returnCsatDetailCompanyId = "${param.hiddenCsatDetailCompanyId}";
var returnhiddenCsatDetailSubject = "${param.hiddenCsatDetailSubject}";
var returnCsatDetailCustomerName= "${param.hiddenCsatDetailCustomerName}";

var issue_id = "${param.issue_id}";
var contactPK= "${param.contactPK}";

var modalReset = "${param.hiddenModalReset}";

var coaching_talk = "${param.coaching_talk}";



var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
var page = {
		start : 0,			   // 0부터 ~
		rowCount : 20,    //20개씩
		totalCount : null  //총 리스트 갯수
}

var issueList = {
		init : function(){
			
			//Tracking 랜딩 링크
			if(!isEmpty("${param.issueId}")){
				
				issueList.goDetail("${param.issueId}");
			}
			
			if(notice_event_id){
				issueList.goDetail(notice_event_id);
			}
			
			issueList.get();
			
			$("#selectSortCategory").change(function(){
				issueList.reset();
				issueList.get();
			});
			
			commonSearch.member($('#textChangeGoMemberName'), $('#hiddenChangeGoMemberId'));
			commonSearch.member($('#textChangeDoMemberName'), $('#hiddenChangeDoMemberId'));
			commonSearch.member($('#textChangeRyMemberName'), $('#hiddenChangeRyMemberId'));
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
			$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start=0;
			issueList.goDetail($("#hiddenModalPK1").val());
			issueList.get();
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(searchFlag){
				params = $.param({
									pageStart : page.start,
									rowCount : page.rowCount,
									latelyUpdateTable : "CLIENT_ISSUE_LOG",
									sortCategory : $("#selectSortCategory").val(),
									searchDivision : "${param.hiddenDashBoardDivision}",
									searchTeam : "${param.hiddenDashBoardTeam}",
									searchMember : "${param.hiddenDashBoardMember}",
									searchCategory : "${param.hiddenDashBoardCategory}",
									searchStatus : "${param.hiddenDashBoardStatus}",
									searchQuarter : "${param.hiddenDashBoardQuarter}",
									searchYear : "${param.hiddenDashBoardYear}",
									searchCompanyName : $("#textSearchCompanyName").val(),
									searchClientCompanyID : "${param.hiddenDashBoardCompanyID}",
									
									searchSegmentCode : "${param.hiddenDashBoardSegmentCode}",
									
									selectGodoryTerritory : "${param.selectGodoryTerritory}",
									
									//검색
									searchActionStatus : $("#actionStatus option:selected").val(),
									detailSearchStatus : $("#status option:selected").val(),
									
									searchAll : $("#textSearchDetail").val(),
									searchPKArray : searchPKArray,
									searchCSatId : "${param.csat_id}",
									searchCSatIssueStatus : "${param.issue_status}",
									
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
									
									jsp : "/etc/clientGodoryListAjax",
									datatype : 'html'
								});
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/etc/selectGodoryListCount.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : params,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						//page count
						page.totalCount = data.listCount;
						//최근 업데이트
						if(!isEmpty(data.latelyUpdate)){
							$("#LATELY_UPDATE_DATE").html(data.latelyUpdate);
						}
						//결과내 검색
						searchPKArray = data.searchPKArray;
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				//리스트
				$.ajax({
					url : "/etc/selectGodoryList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
					data : params,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('tbody#row').append(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
		},
		
		//고도리 담당자 검색
		getGodoryManager : function(){
			$.ajax({
				url : "/etc/selectGodoryManager.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
				data : {
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					var list = data.rows;
					for(var i=0; i<list.length; i++){
						console.log(list[i]);
						if(list[i].AUTHORITY_NAME == 'GODORY_GO'){
							
						}else if(list[i].AUTHORITY_NAME == 'GODORY_DO'){
							
						}else if(list[i].AUTHORITY_NAME == 'GODORY_RY'){
							
						}
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/etc/selectGodoryDetail.do",
				async : false,
	 			datatype : 'json',
				mtype: 'POST',
				data : {
					pkNo : pkNo
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var rowData = data.detail;
					var fileList = data.fileList;

					modalFlag = "upd"; //업데이트
					$("#hiddenModalPK1").val(rowData.ISSUE_ID);
					
					$("#textModalSubject1").val(rowData.ISSUE_SUBJECT);
					$("#divModalNameAndCreateDate1").html("작성자 : "+rowData.HAN_NAME+" / 작성일 : "+rowData.SYS_REGISTER_DATE);
					
					//코칭톡 버튼 show
					//$("#buttonModalCoachingTalkView").show();

					$("#textModalUpdateDate1").val(rowData.SYS_UPDATE_DATE);
					$("#textModalIssueCreator1").val(rowData.ISSUE_CREATOR);
					
					$("#selectGodoryTerritory1").val(rowData.ISSUE_CATEGORY);
					
					$("#textModalIssueDate1").val(rowData.ISSUE_DATE);

					$("#textModalDueDate1").val(rowData.DUE_DATE);
					
					$("#textareaModalIssueDetail1").val(rowData.ISSUE_DETAIL);
					
					$("#textModalSolveOwner1").val(rowData.SOLVE_OWNER_NAME);
					$("#hiddenModalSolveOwnerId1").val(rowData.SOLVE_OWNER);
					$("#textModalIssueCloseDate1").val(rowData.ISSUE_CLOSE_DATE);
					$("#textareaModalSolvePlan1").val(rowData.SOLVE_PLAN);
					$("#selectModalIssueStatus1").val(rowData.ISSUE_STATUS);
					$("#selectModalSolveEvidenceYN1").val(rowData.SOLVE_EVIDENCE_YN);
					$("#textareaSolveEvidenceDetail1").val(rowData.SOLVE_EVIDENCE_DETAIL);

					
					
					$('[name="divRelation"]').show();
					
					$("#buttonModalDelete").show();
					/* 
					//고객컨택 연동
					$("#relationContact").html("");
					if(!isEmpty(rowData.EVENT_ID)){
						$("#relationContact").html('<a href="/clientSalesActive/viewClientContactList.do?event_id='+rowData.EVENT_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					}else{
						$("#relationContact").html('-');
					}
					 */
					
					 //승인여부에 따라 상세내용 보여짐
					 $("#selectApprovalYN").val(rowData.APPROVAL_YN);
					/* 
					$(".detail_if_y_view").hide();
					$(".detail_if_y_view2").hide();
					if(rowData.APPROVAL_YN == '1')
					{
						$(".detail_if_y_view").show();
						$(".detail_if_y_view2").show();
					}
					 */
					 
					//파일
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=4"><i class="fa fa-file-'+checkExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("h4.modal-title").html(rowData.ISSUE_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit2").html("저장하기");
					
					modal2.drawIssueSolvePlan();
					modal2.solvePlanReload();
					
					$("#divModalCoachingTalk").hide(); //코톡 숨기기
					
					$("div.custom-company-pop.off").hide(); //메일공유 직원검색 팝업숨김
					
					$("#myModal2").modal();
					
					compare_before = $("#formModalData2").serialize();
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정.
					/* 
					if(coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
					}
					 */
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

var checkExtension = function(fileExtension){
	if($.inArray(fileExtension, ['.jpg','.png','.gif','.jpeg']) != -1){
		return 'image';
	}else if($.inArray(fileExtension, ['.xls','.xlsx']) != -1){
		return 'excel';
	}else if($.inArray(fileExtension, ['.pdf']) != -1){
		return 'pdf';
	}else if($.inArray(fileExtension, ['.ppt','.pptx']) != -1){
		return 'powerpoint';
	}else if($.inArray(fileExtension, ['.doc','.docx','.hwp','.txt']) != -1){
		return  'word';
	}
}
/* 
var selectSampleFile = function(file) {
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
	$("#formSampleFile").attr("action","/common/sampleDownloadFile.do");
	$("#formSampleFile").submit();
}
 */
 
//조건 검색 
 $("#selectGodoryTerritory").change(function(){
  var params = $.param({
 		//viewType : $("input:radio[name='radioViewType']:checked").val(),
 		//selectFaceYear : $("#selectFaceYear").val(),
 		selectGodoryTerritory : $("#selectGodoryTerritory").val()
 		//selectFaceQuarter : $("#selectFaceQuarter").val(),
 		//selectFacePost : $("#selectFacePost").val(),
 	});
 	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
 	 location.href="/etc/viewGodoryList.do?"+params;
 });

//고도리 당당자 설정 팝업
var godoryPopup = {
		setting : function() {
			if($('.myinfo-godory-modal').css('display') == 'none') {
				$('.myinfo-godory-modal').show();
			}else {
				$('.myinfo-godory-modal').hide();
			}
		}
	
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>