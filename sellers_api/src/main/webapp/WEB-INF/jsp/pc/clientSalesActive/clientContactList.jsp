<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-6">
        <h2>고객컨택내용</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객영엽활동</a>
            </li>
            <li class="active">
                <strong>고객컨택내용</strong>
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
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_EVENT_CATEGORY" checked="checked"> <label for="toggle-col-1">컨택방법</label></li>
	                                        <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_COMPANY_NAME" checked="checked"> <label for="toggle-col-2">고객사</label></li> -->
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_CUSTOMER_NAME" checked="checked"> <label for="toggle-col-3">고객명</label></li>
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_EVENT_SUBJECT" checked="checked"> <label for="toggle-col-4">컨택목적</label></li>
	                                        <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_MEMBER_DIVISION" checked="checked"> <label for="toggle-col-5">소속본부</label></li> -->
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_HAN_NAME" checked="checked"> <label for="toggle-col-6">보고자</label></li>
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_EVENT_DATE" checked="checked"> <label for="toggle-col-7">컨택일</label></li>
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_FOLLOW_UP_ACTION_STATUS" checked="checked"> <label for="toggle-col-9">액션상태</label></li>
	                                        <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cols_FILE_COUNT" checked="checked"> <label for="toggle-col-8">파일</label></li>
	                                    </ul>
	                                </div>
	                            </div>
	                        </div>   
	                        
	                        <div class="search-common">
				                		<div class="input-default" style="margin:0;">
				                    	<span class="input-group-btn">
		                            <a href="javascript:void(0);" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
		                            <a href="javascript:void(0);" class="btn btn-reset-option">검색초기화</a>
				                    	</span>
															<div class="search-detail" style="display:none;">
																<form id="formSearchDetail">
				                              <div class="col-sm-12 m-b">
				                                  <label class="control-label" for="date_modified">고객사</label>
				                                  <div class="input-group" style="width:100%;"><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompanyName" /></div>
				                              </div>
				                              
				                              <div class="col-sm-12 m-b">
				                                  <label class="control-label" for="date_modified">고객명</label>
				                                  <div class="input-group" style="width:100%;"><input type="text" placeholder="고객명을 입력해주세요" class="input form-control" id="textSearchCustomerName" name="textSearchCustomerName"/></div>
				                              </div>
				                              
				                              <div class="col-sm-12 m-b">                                    
					                            	<label class="control-label" for="date_modified">컨택일자</label>
					                            	<div class="data_1">
					                                <div class="input-group date">
				                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				                                    <input type="text" class="form-control" id="textSearchContactStartDate" name="textSearchContactStartDate"/>
					                                </div>
					                            	</div>
					                            	<div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
					                            	<div class="data_1">
					                                <div class="input-group date">
				                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				                                    <input type="text" class="form-control" id="textSearchContactEndDate" name="textSearchContactEndDate"/>
					                                </div>
					                            	</div>
					                        		</div>
					                        
					                        <!-- <div class="col-sm-12 m-b">
								                       	<div class="form-group">
								                        	<label>액션상태</label>
								                         	<select class="form-control" id="selectSearchActionStatus">
									                             <option value="">=== 선택 ===</option>
									                             <option value="G">완료</option>
									                       		 <option value="Y">진행중</option>
									                       		 <option value="R">지연</option>
								                         </select>
								                       	</div>
												               </div> -->
				                              
		                              <div class="col-sm-12 ag_r">
	                                  <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
	                                  <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="list.reset();list.get(1);"><i class="fa fa-search"></i> 검색</button>
		                              </div>
			                          </form>
										</div>
				                    
				                </div>
				            </div> 
				
	                        <div class="fl_r pd-b20">
	                            <div class="fl_l">
	                            	<div class="fl_l mg-r10">
										<a href="/clientSalesActive/viewClientContactDashboard.do" class="btn btn-outline btn-seller-outline">
											<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
										</a>
									</div>
	                                <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
	                            </div>
	                        </div>
	                       
	                       
	                       <table id="tech-companies" class="table table-bordered">
						  	<colgroup>
						        <%-- <col width=""/> --%>
						        <col width="10%" name="cols_EVENT_CATEGORY"/>
						        <%-- <col width="" name="cols_COMPANY_NAME"/> --%>
						        <col width="12%" name="cols_CUSTOMER_NAME"/>
						        <col width="" name="cols_EVENT_SUBJECT"/>
						        <%-- <col width="" name="cols_MEMBER_DIVISION"/> --%>
						        <col width="10%" name="cols_HAN_NAME"/>
						        <col width="10%" name="cols_EVENT_DATE"/>
						        <col width="5%" name="cols_FOLLOW_UP_ACTION_STATUS"/>
						        <col width="10%" name="cols_FILE_COUNT"/>
						    </colgroup>
					    	<thead>
							    <tr>
							        <!-- <th>No</th> -->
							        <th name="cols_EVENT_CATEGORY"><a href="#" class="sortLink" data-sort="CONTACT.EVENT_CATEGORY" data-method="">컨택방법 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
							        <!-- <th name="cols_COMPANY_NAME">고객사</th> -->
							        <th name="cols_CUSTOMER_NAME"><a href="#" class="sortLink" data-sort="CONTACT.CUSTOMER_NAME" data-method="">고객명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
							        <th name="cols_EVENT_SUBJECT"><a href="#" class="sortLink" data-sort="CONTACT.EVENT_SUBJECT" data-method="">컨택목적 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
				        			<!-- <th name="cols_MEMBER_DIVISION">소속본부</th> -->
							        <th name="cols_HAN_NAME"><a href="#" class="sortLink" data-sort="CONTACT.HAN_NAME" data-method="">보고자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
							        <th name="cols_EVENT_DATE"><a href="#" class="sortLink" data-sort="CONTACT.EVENT_DATE" data-method="">컨택일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
							        <th name="cols_FOLLOW_UP_ACTION_STATUS">액션<br />상태</th>
							        <th name="cols_FILE_COUNT"><a href="#" class="sortLink" data-sort="CONTACT.FILE_COUNT" data-method="">파일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
							    </tr>
						    </thead>
							    <tbody id="row">
							    
		    					</tbody>
							</table>
							
							<div class="btn-group pull-right pd-t10">
							</div>
	                   </div>
	               </div>
	           </div>
	       </div>
	   </div>
	</div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/clientContactModal.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

<form name="formFollow" id="formFollow" method="post" action="">
	<input type="hidden" name="contactPK" id="contactPK"/>
	<input type="hidden" name="issueFlag" id="issueFlag"/>
	<input type="hidden" name="oppFlag" id="oppFlag"/>
	<input type="hidden" name="returnCompanyId" id="returnCompanyId"/>
	<input type="hidden" name="returnCompanyName" id="returnCompanyName"/>
	<input type="hidden" name="returnCustomerName" id="returnCustomerName"/>
	<input type="hidden" name="returnCustomerId" id="returnCustomerId"/>
	<input type="hidden" name="returnCustomerRank" id="returnCustomerRank"/>
</form>

</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	list.init();
});

//var params;
/* var modalReset = "${param.hiddenModalReset}";
var event_id = "${param.event_id}";
var customer_name = "${param.customer_name}"; */
//var modalFlag = "ins/upd";
/* var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = ""; */

var list = {
		event_id : "${param.event_id}", 			
		modalReset : "${param.hiddenModalReset}",
		customer_name : "${param.customer_name}",
		modalFlag : "ins/upd",
		searchPKArray : null,
		compareFlag : false, //모달 닫힐때 수정됐는지 비교
		compare_after : null, //모달 닫힐때 수정됐는지 비교
		compare_before : null, //모달 닫힐때 수정됐는지 비교
		sortCategory : null,
		coaching_talk : "${param.coaching_talk}",
		
		init : function(){
			//모달 닫기 이벤트
			$('#myModal1').on('hide.bs.modal', function () {
				list.compare_after = $("#formModalData").serialize();
				if(list.modalFlag == "upd"){
					if(list.compare_before != list.compare_after){
						if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
							list.compareFlag = true;
							$("#buttonModalSubmit").trigger("click");
						}
					}
				}else{ //신규등록이면
					if(list.compare_before != list.compare_after){
						if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
							$("#divModalFile p").hide();
						}else{
							return false;
						}
					}
				}
			});
			
			initPaing(1); //페이징 초기화
			
			//검색
			$("#textSearchCompanyName, #textSearchCustomerName").keydown(function (key) {
		   		if(key.keyCode == 13){
		   			list.reset();
		   			list.get(1);
			     }
			 });
			
			if(!isEmpty(list.event_id)){
				$("#textSearchCustomerName").val(list.customer_name);
				list.goDetail(list.event_id);
				list.event_id = null;
			}
			
			if(list.modalReset) {
				modal.reset();
			}
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					if($(this).attr("data-sort") == "CONTACT.ACTION_PLAN_STATUS"){ //색상정렬 예외
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#1ab394','#ffc000','#f20056','-')"
					}else{
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					if($(this).attr("data-sort") == "CONTACT.ACTION_PLAN_STATUS"){
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#f20056','#ffc000','#1ab394','-')"
					}else{
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					list.sortCategory = "";
				}
				
				list.reset();
				list.get();
			});
			
			list.get(1);
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
		
		//리스트 가져오기
		get : function(pn, ep){
				if(!isEmpty(pn) && !isEmpty(ep)) { 
					page.start = pn;
					page.end = ep;
				}
				var listParams = $.param({
					datatype : 'html',
					jsp : '/clientSalesActive/clientContactListAjax'
				});
				var countParams = $.param({
					datatype : 'json'
				});
				var params = {
									pageStart : page.start,
									pageEnd : page.end,
									latelyUpdateTable : "CLIENT_EVENT_LOG",
									searchPKArray : list.searchPKArray,
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
									//검색조건
									searchCompanyName : $("#textSearchCompanyName").val(),
									searchCustomerName : $("#textSearchCustomerName").val(),
									searchCategory : $("#selectSearchCategory").val(),
									searchContactStartDate : $("#textSearchContactStartDate").val(),
									searchContactEndDate : $("#textSearchContactEndDate").val(),
									searchActionStatus : $("#selectSearchActionStatus").val(),
									searchDivision : "${param.hiddenDashBoardDivision}",
									searchTeam : "${param.hiddenDashBoardTeam}",
									searchMember : "${param.hiddenDashBoardMember}",
									searchCategory : "${param.hiddenDashBoardCategory}",
									searchRelate : "${param.hiddenDashBoardRelate}",
									searchCompany : "${param.hiddenDashBoardCompany}",
									searchCompanyCategory : "${param.hiddenDashBoardCompanyCateogry}",
									searchQuarter : "${param.hiddenDashBoardQuarter}",
									searchYear : "${param.hiddenDashBoardYear}",
									sortCategory : list.sortCategory
							};		
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSalesActive/selectClientContactCount.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : $.param(params) + "&" + countParams + "&" + $.param(page) + "&" + $.param(pagingParams),
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
						list.searchPKArray = data.searchPKArray;
						
						//테이블 하단 페이징 처리 및 디자인 생성
						params.pageStart = data.listPaging.pageStart;
						params.pageEnd = data.listPaging.endPage;
						data.fncName = 'list.get';
						pageCreateNavi(data);
						
						//검색모달 숨기기
						$('.search-detail').css('display', 'none');
					},
					complete : function(){
					}
				});
				//리스트
				$.ajax({
					url : "/clientSalesActive/selectClientContactList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : $.param(params) + "&" + listParams + "&" + $.param(page) + "&" + $.param(pagingParams),
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
				url : "/clientSalesActive/selectContactDetail.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
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
					
					list.modalFlag = "upd"; //업데이트
					
					$("#formModalData #hiddenModalMemberList").val("");
					commonSearch.multipleMultipleClientArray = [];
					commonSearch.multipleMailShareMemberArray = [];
					$("ul.flexdatalist-multiple li.value").remove();
					
					//코칭톡 버튼 show, 창 hide
					$("#divModalCoachingTalk").hide();
					$("#buttonModalCoachingTalkView").show();
					$('span#spanCtCount').html("("+rowData.COACHING_TALK_COUNT+")");
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("보고자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					$("#hiddenModalPK").val(rowData.EVENT_ID);
					$("#textModalSubject").val(rowData.EVENT_SUBJECT);
					$("#textModalEventDate").val(rowData.EVENT_DATE);
					$("#selectModalStartDateTime").val(rowData.EVENT_START_TIME);
					$("#selectModalEndDateTime").val(rowData.EVENT_END_TIME);
					$("#selectModalCategory").val(rowData.EVENT_CATEGORY);
					$("#textareaModalEventContents").val(rowData.EVENT_CONTENTS);	//상세내용
					$("#hiddenModalCreatorId").val(rowData.CREATOR_ID);
					$("#hiddenModalCalendarEventId").val(rowData.CALENDAR_EVENT_ID);
					$("#hiddenModalBeforeEventDate").val(rowData.EVENT_DATE);
					
					modal.timeDifference("#hiddenModalBeforeAnalEventTime");
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalEventContents"));
					
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
					
					$("[name='divRelation']").show();
					$("[name='checkOppIssue']").hide();
					
					if(rowData.CHECK_INFORMATION == "Y"){
						$("input[name='checkInformation']").prop("checked",true);
						$("input[name='checkInformation']").val("Y");
					}else{
						$("input[name='checkInformation']").prop("checked",false);
						$("input[name='checkInformation']").val("");
					}
					
					if(rowData.CHECK_SALESOPP == "Y"){
						$("input[name='checkSalesOpp']").prop("checked",true);
						$("input[name='checkSalesOpp']").val("Y");
					}else{
						$("input[name='checkSalesOpp']").prop("checked",false);
						$("input[name='checkSalesOpp']").val("");
					}
					
					if(rowData.CHECK_ISSUE == "Y"){
						$("input[name='checkIssue']").prop("checked",true);
						$("input[name='checkIssue']").val("Y");
					}else{
						$("input[name='checkIssue']").prop("checked",false);
						$("input[name='checkIssue']").val("N");
					}
					
					//follow-up-action
					$("label#fuaTable-error").remove();
					fuaGetList("/clientSalesActive/gridActionPlanContact.do",rowData.EVENT_ID);
					
					//잠재영업기회 연동
					$("#relationHiddenOpp").html("");
					if(!isEmpty(rowData.OPPORTUNITY_HIDDEN_ID)){
						$("#relationHiddenOpp").html('<a href="#" onClick="modal.goSalesAct('+rowData.OPPORTUNITY_HIDDEN_ID+',\'잠재영업기회\')" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					}else{
						$("#relationHiddenOpp").html('-');
					}
					
					//이슈 연동
					$("#relationClientIssue").html("");
					if(!isEmpty(rowData.ISSUE_ID)){
						$("#relationClientIssue").html('<a href="#" onClick="modal.goSalesAct('+rowData.ISSUE_ID+',\'고객이슈\')" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					}else{
						$("#relationClientIssue").html('-');
					}
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=3"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("h4.modal-title").html(rowData.EVENT_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					/* modal.drawContactActionPlan();
					modal.actionPlanReload(); */
					
					$("#myModal1").modal();
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정 후 코톡창 바로보기 여부 N처리.
					if(list.coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
						coaching_talk = 'N';
					}
					
					setTimeout(function(){
						list.compare_before = $("#formModalData").serialize();
					}, 400);
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
