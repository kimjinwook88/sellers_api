<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-6">
        <h2>고객이슈</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>고객이슈</strong>
            </li>
        </ol>
    </div> -->
    <div class="col-sm-6">
        <div class="time-update">
            <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
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
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_COMPANY_NAME" checked="checked"> <label for="toggle-col-1">고객사</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_CUSTOMER_NAME" checked="checked"> <label for="toggle-col-2">고객명</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_SALES_REPRESENTIVE_NAME" checked="checked"> <label for="toggle-col-3">영업대표</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_ISSUE_SUBJECT" checked="checked"> <label for="toggle-col-4">이슈제목</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_ISSUE_CATEGORY" checked="checked"> <label for="toggle-col-5">이슈종류</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_SOLVE_OWNER" checked="checked"> <label for="toggle-col-6">해결책임자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_ISSUE_DATE" checked="checked"> <label for="toggle-col-7">발생일</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cols_DUE_DATE" checked="checked"> <label for="toggle-col-8">해결목표일</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_SOLVE_DATE" checked="checked"> <label for="toggle-col-9">이슈해결일자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-10" value="cols_CONFIRM_NAME" checked="checked"> <label for="toggle-col-10">이슈해결확인자</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-13" value="cols_ISSUE_ACTION_STATUS_TEXT" checked="checked"> <label for="toggle-col-13">해결계획상태</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-11" value="cols_ISSUE_STATUS_TEXT" checked="checked"> <label for="toggle-col-11">이슈상태</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-12" value="cols_FILE_COUNT" checked="checked"> <label for="toggle-col-12">파일</label></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="search-common">
					                <div class="input-default  fl_l" style="margin:0;">
					                    <span class="input-group-btn">
					                            <a href="javascript:void(0);" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
					                            <a href="javascript:void(0);" class="btn btn-reset-option">검색초기화</a>
					                    </span>
										
											<div class="search-detail" style="display:none;">
				                                <form id="formSearchDetail">
												  <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">고객사</label>
					                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompanyName" name="textSearchCompanyName" onkeydown="if(event.keyCode == 13){issueList.reset();issueList.get(1);}"></div>
					                              </div>
					                              
					                              <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">고객명</label>
					                                  <div class="input-group" style="width:100%;"><input type="text" placeholder="고객명을 입력해주세요" class="input form-control" id="textSearchCustomerName" name="textSearchCustomerName" onkeydown="if(event.keyCode == 13){issueList.reset();issueList.get(1);}"/></div>
					                              </div>
					                              
					                              <!-- <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">해결상태</label>
					                                  <div class="input-group" style="width:100%;">
					                                  	<select class="form-control" name="actionStatus" id="actionStatus">
															<option value="">==== 선택 ====</option>
															<option value="G">완료</option>
															<option value="Y">진행중</option>
															<option value="R">지연</option>
														</select>
					                                  </div>
					                              </div> -->
					                              
					                              <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">이슈상태</label>
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
					                                   <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="issueList.reset();issueList.get(1);"><i class="fa fa-search"></i>검색</button>
					                               </div>
				                               </form>
					                       </div>
					                    
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
                            	<div class="fl_l mg-r10">
									<a href="/clientSatisfaction/viewClientIssueDashBoard.do" class="btn btn-outline btn-seller-outline">
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
						        <%-- <col width=""/> --%>
						        <col width="" name="cols_COMPANY_NAME"/>
						        <col width="" name="cols_CUSTOMER_NAME"/>
						        <col width="" name="cols_SALES_REPRESENTIVE_NAME"/>
						        <col width="" name="cols_ISSUE_SUBJECT"/>
						        <col width="" name="cols_ISSUE_CATEGORY"/>
						        <col width="" name="cols_SOLVE_OWNER"/>
						        <col width="" name="cols_ISSUE_DATE"/>
						        <col width="" name="cols_DUE_DATE"/>
						        <col width="" name="cols_SOLVE_DATE"/>
						        <col width="" name="cols_CONFIRM_NAME"/>
						        <col width="" name="cols_ISSUE_ACTION_STATUS_TEXT"/>
						        <col width="" name="cols_ISSUE_STATUS_TEXT"/>
						        <col width="" name="cols_FILE_COUNT"/>
						    </colgroup>
						    <thead>
						    <tr>
						        <!-- <th>No</th> -->
						        <th name="cols_COMPANY_NAME"><a href="#" class="sortLink" data-sort="TB.COMPANY_NAME" data-method="">고객사 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_CUSTOMER_NAME"><a href="#" class="sortLink" data-sort="TB.CUSTOMER_NAME" data-method="">고객명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_SALES_REPRESENTIVE_NAME"><a href="#" class="sortLink" data-sort="TB.SALES_REPRESENTIVE_NAME" data-method="">영업대표 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_ISSUE_SUBJECT"><a href="#" class="sortLink" data-sort="TB.ISSUE_SUBJECT" data-method="">이슈제목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_ISSUE_CATEGORY"><a href="#" class="sortLink" data-sort="TB.ISSUE_CATEGORY" data-method="">이슈종류 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_SOLVE_OWNER"><a href="#" class="sortLink" data-sort="TB.SOLVE_OWNER_NAME" data-method="">해결책임자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_ISSUE_DATE"><a href="#" class="sortLink" data-sort="TB.ISSUE_DATE" data-method="">발생일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_DUE_DATE"><a href="#" class="sortLink" data-sort="TB.DUE_DATE" data-method="">해결목표일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_SOLVE_DATE"><a href="#" class="sortLink" data-sort="TB.ISSUE_CLOSE_DATE" data-method="">이슈해결일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_CONFIRM_NAME"><a href="#" class="sortLink" data-sort="TB.CONFIRM_NAME" data-method="">이슈해결<br />확인자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_ISSUE_ACTION_STATUS_TEXT"><a href="#" class="sortLink" data-sort="TB.ISSUE_ACTION_STATUS_TEXT" data-method="">해결계획<br />상태 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_ISSUE_STATUS_TEXT"><a href="#" class="sortLink" data-sort="TB.ISSUE_STATUS_TEXT" data-method="">이슈상태 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_FILE_COUNT"><a href="#" class="sortLink" data-sort="TB.FILE_COUNT" data-method="">파일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						    </tr>
						    </thead>
							    <tbody id="row">
							    
		    					</tbody>
							</table>
							
							<div class="btn-group pull-right pd-t10">
							</div>
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

<jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/clientIssueModal.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</body>

<script type="text/javascript">

var notice_event_id = "${param.notice_event_id}";

$(document).ready(function(){
	issueList.init();

	if(modalReset) {
		modal.reset();
	}
	
	//스크롤 끝 이벤트	
	/* $(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 20;
	        if(page.start < page.totalCount){
	        	issueList.get();
	        }
	    }
	}); */
	
	//모달 닫기 이벤트
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
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
		//EVENT off
		modalEvent.off();
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
/* var page = {
		start : 0,			   // 0부터 ~
		rowCount : 20,    //20개씩
		totalCount : null  //총 리스트 갯수
} */

var issueList = {
		sortCategory : null,
		
		init : function(){
			initPaing(4); //페이징 초기화
			
			//Tracking 랜딩 링크
			if(!isEmpty("${param.issueId}")){
				
				issueList.goDetail("${param.issueId}");
			}
			
			if(notice_event_id){
				issueList.goDetail(notice_event_id);
			}
			
			issueList.get(1);
			
			//고객컨택
			if(issue_id){
				issueList.goDetail(issue_id);
			}
			//고객컨택 연동
			if(!isEmpty(contactPK)){
				modal.reset();
				/* $("#formModalData #textCommonSearchCompany").val("${param.returnCompanyName}");
				$("#formModalData #hiddenModalCompanyId, #formModalData #textCommonSearchCompanyId").val("${param.returnCompanyId}");
				$("#formModalData #textModalCustomerName").val("${param.returnCustomerName}");
				$("#formModalData #hiddenModalCustomerId").val("${param.returnCustomerId}");
				$("#formModalData #textModalCustomerRank").val("${param.returnCustomerRank}"); */
				$("#formModalData #hiddenModalContactId").val(contactPK);
			}
			
			//고객만족
			if(!isEmpty(returnCsatDetailId)){
				$("#textCommonSearchCompany").val(returnCsatDetailCompanyName);
				$("#textCommonSearchCompanyId").val(returnCsatDetailCompanyId);
				$("#textModalSubject").val(returnhiddenCsatDetailSubject);
				$("#textModalIssueCreator").val(returnCsatDetailCustomerName);
				$("#hiddenModalCompanyId").val(returnCsatDetailCompanyId);
			}
			
			$("#selectSortCategory").change(function(){
				issueList.reset();
				issueList.get(1);
			});
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					if($(this).attr("data-sort") == "TB.ISSUE_STATUS_TEXT" || $(this).attr("data-sort") == "TB.ISSUE_ACTION_STATUS_TEXT"){ //이슈 색상 정렬 예외
						issueList.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#1ab394','#ffc000','#f20056',null)"
					}else{
						issueList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					if($(this).attr("data-sort") == "TB.ISSUE_STATUS_TEXT" || $(this).attr("data-sort") == "TB.ISSUE_ACTION_STATUS_TEXT"){ //이슈 색상 정렬 예외
						issueList.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#f20056','#ffc000','#1ab394',null)"
					}else{
						issueList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					issueList.sortCategory = "";
				}
				
				issueList.reset();
				issueList.get();
			});
			
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
			issueList.goDetail($("#hiddenModalPK").val());
			issueList.get(1);
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				params = {
									pageStart : page.start,
									pageEnd : page.end,
									numberPagingUseYn : 'Y',
									latelyUpdateTable : "CLIENT_ISSUE_LOG",
									//sortCategory : $("#selectSortCategory").val(),
									searchDivision : "${param.hiddenDashBoardDivision}",
									searchTeam : "${param.hiddenDashBoardTeam}",
									searchMember : "${param.hiddenDashBoardMember}",
									searchCategory : "${param.hiddenDashBoardCategory}",
									searchStatus : "${param.hiddenDashBoardStatus}",
									searchQuarter : "${param.hiddenDashBoardQuarter}",
									searchYear : "${param.hiddenDashBoardYear}",
									searchCompanyName : $("#textSearchCompanyName").val(),
									searchCustomerName : $("#textSearchCustomerName").val(),
									searchClientCompanyID : "${param.hiddenDashBoardCompanyID}",
									searchSegmentCode : "${param.hiddenDashBoardSegmentCode}",
									
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
									sortCategory : issueList.sortCategory
								};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSatisfaction/selectIssueListCount.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : $.param(params) + "&" + $.param(page) + "&" + $.param(pagingParams),
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
						
						//테이블 하단 페이징 처리 및 디자인 생성
						params.pageStart = data.listPaging.pageStart;
						params.pageEnd = data.listPaging.endPage;
						data.fncName = 'issueList.get';
						pageCreateNavi(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				//리스트
				$.ajax({
					url : "/clientSatisfaction/selectClientIssueList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
					data : $.param(params) + "&" + $.param(page) + "&" + $.param(pagingParams),
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('tbody#row').html(data);
					},
					complete : function(){
						//항목숨기기 유지
						$(".table-menu-wrapper2 input[name='toggle-cols']").each(function(){
							if(!$(this).is(":checked")){
								$('[name="'+$(this).val()+'"]').hide();
							}
						});
					}
				});
		},
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/clientSatisfaction/selectClientIssueDetail.do",
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
					//초기화
					$("#formModalData").validate().resetForm();
					
					modalFlag = "upd"; //업데이트
					
					//EVENT ON
					modalEvent.on();
					
					$("#formModalData #hiddenModalMemberList").val("");
					commonSearch.multipleMultipleClientArray = [];
					commonSearch.multipleMailShareMemberArray = [];
					$("ul.flexdatalist-multiple li.value").remove();
					
					$("#hiddenModalPK").val(rowData.ISSUE_ID);
					
					$("#textModalSubject").val(rowData.ISSUE_SUBJECT);
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+" / 작성일 : "+rowData.SYS_REGISTER_DATE);
					
					//코칭톡 버튼 show, 창 hide
					$("#divModalCoachingTalk").hide();
					$("#buttonModalCoachingTalkView").show();
					$('span#spanCtCount').html("("+rowData.COACHING_TALK_COUNT+")");
					
					$("#textModalUpdateDate").val(rowData.SYS_UPDATE_DATE);
					$("#textModalIssueCreator").val(rowData.ISSUE_CREATOR);
					$("#selectModalIssueCategory").val(rowData.ISSUE_CATEGORY);
					$("#textModalSalesRepresentive").val(rowData.SALES_REPRESENTIVE_NAME);
					$("#hiddenModalSalesId").val(rowData.SALES_REPRESENTIVE_ID);
					$("#textModalIssueDate").val(rowData.ISSUE_DATE);
					$("#textModalDueDate").val(rowData.DUE_DATE);
					$("#textareaModalIssueDetail").val(rowData.ISSUE_DETAIL);	//이슈내용
					$("#textModalSolveOwner").val(rowData.SOLVE_OWNER_NAME);
					$("#hiddenModalSolveOwnerId").val(rowData.SOLVE_OWNER);
					$("#textModalIssueCloseDate").val(rowData.ISSUE_CLOSE_DATE);
					$("#textareaModalSolvePlan").val(rowData.SOLVE_PLAN);
					$("#selectModalIssueStatus").val(rowData.ISSUE_STATUS);
					$("#selectModalSolveEvidenceYN").val(rowData.SOLVE_EVIDENCE_YN);
					$("#textareaSolveEvidenceDetail").val(rowData.SOLVE_EVIDENCE_DETAIL);
					$("#textModalIssueConfirmId").val(rowData.CONFIRM_NAME);
					$("#hiddenModalIssueConfirmId").val(rowData.ISSUE_CONFIRM_ID);
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalIssueDetail"));
					
					$('[name="divRelation"]').show();
					
					$("#buttonModalDelete").show();
					
					if(!isEmpty(rowData.CUSTOMER_ID)){
						var customerIdArr = rowData.CUSTOMER_ID.split(",");
						var customerNameArr = rowData.CUSTOMER_NAME.split(",");
						var companyNameArr = rowData.COMPANY_NAME.split(",");
						var ccList = '';
						$("#hiddenModalCustomerId").val(customerIdArr);
						for(var i=0; i<customerNameArr.length; i++){
							commonSearch.addMultipleClient($('#formModalData #hiddenModalCustomerId'), $('#formModalData #liMultipleClient'), customerIdArr[i], customerNameArr[i], companyNameArr[i]);
							if(i>0) ccList = ccList + ', ';
							ccList = ccList + customerNameArr[i] + '[' + companyNameArr[i] + ']';
						}
						$("#hiddenModalCcList").val(ccList);
					}
					
					//고객컨택 연동
					$("#relationContact").html("");
					if(!isEmpty(rowData.EVENT_ID)){
						$("#relationContact").html('<a href="#" onClick="modal.goSalesAct('+rowData.EVENT_ID+',\'고객컨택\')" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					}else{
						$("#relationContact").html('-');
					}
					
					//파일
					commonFile.reset();
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
					$("#buttonModalSubmit").html("저장하기");
					
					// 이슈해결계획
					$("label#fuaTable-error").remove();
					fuaGetList("/clientSatisfaction/selectSolvePlanIssue.do", rowData.ISSUE_ID);
					
					/* modal.drawIssueSolvePlan();
					modal.solvePlanReload(); */
					
					$("#divModalCoachingTalk").hide(); //코톡 숨기기
					
					$("#myModal1").modal();
					
					setTimeout(function(){
						compare_before = $("#formModalData").serialize();
					}, 400);
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정 후 코톡창 바로보기 여부 N처리.
					if(coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
						coaching_talk = 'N';
					}
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
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>