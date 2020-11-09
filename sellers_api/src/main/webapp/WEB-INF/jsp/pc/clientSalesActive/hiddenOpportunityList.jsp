<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-4">
        <h2>잠재영업기회</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객영업활동</a>
            </li>
            <li class="active">
                <strong>잠재영업기회</strong>
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
                        	<!-- <div class="mg-b20">
                               <ul class="nav nav-tabs pgtop-tabs">
                                   <li class=""><a href="/clientSalesActive/viewOpportunityList.do">영업기회</a></li>
                                   <li class="active"><a href="#" data-toggle="tab">잠재영업기회</a></li>
                               </ul>
                           </div> -->
                           
                            <div class="func-top-left fl_l">
                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                    <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
                                    <div class="table-menu" style="z-index:1000;display:none;">
                                        <ul>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_OPPORTUNITY_HIDDEN_ID" checked="checked"> <label for="toggle-col-1">ID</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_COMPANY_NAME" checked="checked"> <label for="toggle-col-2">매출처</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_CUSTOMER_NAME" checked="checked"> <label for="toggle-col-3">End User</label></li>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_SALESMAN_DIVISION" checked="checked"> <label for="toggle-col-4">본부</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_SUBJECT" checked="checked"> <label for="toggle-col-7">제목</label></li>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_CATEGORY" checked="checked"> <label for="toggle-col-6">기회 항목</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cols_OPPORTUNITY_AMOUNT" checked="checked"> <label for="toggle-col-8">예상규모</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_SALESMAN_NAME" checked="checked"> <label for="toggle-col-5">영업대표</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_SALES_CHANGE_DATE" checked="checked"> <label for="toggle-col-9">영업기회 전환시점</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-11" value="cols_ACTION_STATUS" checked="checked"> <label for="toggle-col-11">해결계획 상태</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-10" value="cols_STATUS" checked="checked"> <label for="toggle-col-10">Status</label></li>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-11" value="cols_RETURN_OPPORTUNITY" checked="checked"> <label for="toggle-col-11">영업기회 전환결과</label></li> -->
                                        </ul>
                                    </div>
                                </div>
                                
                                <!-- <div class="table-sel-view fl_l">
                                    <div class="selgrid selgrid1 mg-r5">
                                        <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
                                            <option value="">== 정렬 기준 ==</option>
                                            <option value="COMPANY_NAME">고객사</option>
                                            <option value="CUSTOMER_NAME">고객명</option>
                                            <option value="SALESMAN_DIVISION"> 본부</option>
                                            <option value="SALESMAN_NAME"> 영업대표</option>
                                            <option value="CATEGORY">사업영역</option>
                                            <option value="OPPORTUNITY_AMOUNT">예상규모</option>
                                            <option value="SALES_CHANGE_DATE">영업전환시점</option>
                                            <option value="SALES_RESULT">결과</option>
                                        </select>
                                    </div>
                                    <input type="button" value="오름차순" id="buttonSortMethod" onClick="list.sortMethod();"/>
                                </div> -->
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
				                                  <label class="control-label" for="date_modified">매출처</label>
				                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="매출처를 입력해주세요" class="input form-control" id="textSearchCompanyName" name="textSearchCompanyName"></div>
				                              </div>
				                              
				                              <div class="col-sm-12 m-b">
				                                  <label class="control-label" for="date_modified">End User</label>
				                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="End User를 입력해주세요" class="input form-control" id="textSearchCustomerName" name="textSearchCustomerName"></div>
				                              </div>
				                              
				                              <!-- <div class="col-sm-12 m-b">
							                        <div class="form-group">
							                        	<label>계획상태</label>
							                         	<select class="form-control" id="selectSearchActionStatus">
								                             <option value="">=== 선택 ===</option>
								                             <option value="G">완료</option>
								                       		 <option value="Y">진행중</option>
								                       		 <option value="R">지연</option>
							                         </select>
							                        </div>
								               </div> -->
								               
				                               <div class="col-sm-12 m-b">
							                        <div class="form-group">
							                        	<label>status</label>
							                         	<select class="form-control" id="selectSearchStatus" name="selectSearchStatus">
								                             <option value="">=== 선택 ===</option>
								                             <option value="G">완료</option>
								                       		 <option value="Y">진행중</option>
								                       		 <option value="R">지연</option>
							                         </select>
							                        </div>
								               </div>
								               
								               
				                              <div class="col-sm-12 ag_r">
				                                  <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
				                                  <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="list.reset();list.get(1);"><i class="fa fa-search"></i> 검색</button>
				                              </div>
			                              </form>
										</div>
				                    
				                </div>
				            </div>
							
                            <div class="fl_r pd-b20">
                            	<div class="fl_l mg-r10">
									<a href="/clientSalesActive/viewHiddenOpportunityDashBoard.do" class="btn btn-outline btn-seller-outline">
										<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
									</a>
								</div>
                            	<!-- <div class="fl_l template-doc">
                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
                                    <ul class="template-list off">
                                      <li><a href="#" onclick="selectSampleFile(this);">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li>
                                    </ul>
                                </div> -->
                                <div class="fl_l">
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div>
                            </div>
                            <!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->
                            
                            
                            <table id="tech-companies" class="table table-bordered">
						  	<colgroup>
						        <col width="10%" name="cols_CUSTOMER_NAME"/>
						        <col width="15%" name="cols_COMPANY_NAME"/>
						        <col width="*" name="cols_SUBJECT"/>
						        <col width="10%" name="cols_OPPORTUNITY_AMOUNT"/>
						        <col width="10%" name="cols_SALESMAN_NAME"/>
						        <col width="10%" name="cols_SALES_CHANGE_DATE"/>
						        <col width="10%" name="cols_ACTION_STATUS"/>
						        <col width="5%" name="cols_STATUS"/>
						    </colgroup>
						    <thead>
						    <tr id="tech-companies-tr">
						    	<th name="cols_CUSTOMER_NAME"><a href="#" class="sortLink" name="sortLink" data-sort="HOPP.CUSTOMER_NAME" data-method="">End User <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th name="cols_COMPANY_NAME"><a href="#" class="sortLink" data-sort="HOPP.COMPANY_NAME" data-method="">매출처 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /> </a></th>
						        <th name="cols_SUBJECT"><a href="#" class="sortLink" data-sort="HOPP.SUBJECT" data-method="">제목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th name="cols_OPPORTUNITY_AMOUNT"><a href="#" class="sortLink" data-sort="HOPP.OPPORTUNITY_AMOUNT" data-method="">예상규모 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th name="cols_SALESMAN_NAME"><a href="#" class="sortLink" data-sort="HOPP.SALESMAN_NAME" data-method="">영업대표 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th name="cols_SALES_CHANGE_DATE"><a href="#" class="sortLink" data-sort="HOPP.SALES_CHANGE_DATE" data-method="">영업기회<br />전환시점 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th name="cols_ACTION_STATUS"><a href="#" class="sortLink" data-sort="HOPP.HIDDEN_OPPORTINITY_ACTION_STATUS" data-method="">해결계획<br />상태 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
						        <th style="width: 1%;" name="cols_STATUS"><a href="#" class="sortLink" data-sort="HOPP.STATUS" data-method="">Status <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a> </th>
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

<jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/hiddenOpportunityModal.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

<form id="formRedirectOpportunity" name="formRedirectOpportunity" method="post">
	<input type="hidden" name="returnOpportunityhiddenId" id="returnOpportunityhiddenId"/>
	<input type="hidden" name="opportunity_id" id="opportunity_id"/>
	<input type="hidden" name="returnCompanyId" id="returnCompanyId"/>
	<input type="hidden" name="returnCompanyName" id="returnCompanyName"/>
	<input type="hidden" name="returnCustomerName" id="returnCustomerName"/>
	<input type="hidden" name="returnCustomerId" id="returnCustomerId"/>
	<input type="hidden" name="returnCustomerRank" id="returnCustomerRank"/>
	<input type="hidden" name="returnSubject" id="returnSubject"/>
	<input type="hidden" name="returnOpportunityamount" id="returnOpportunityamount"/>
	<input type="hidden" name="returnSalesManId" id="returnSalesManId"/>
	<input type="hidden" name="returnSalesManName" id="returnSalesManName"/>
	<input type="hidden" name="returnSalesManPosition" id="returnSalesManPosition"/>
</form>

<form name="formFollow" id="formFollow" method="post" action="">
	<input type="hidden" name="contactPK" id="contactPK"/>
	<input type="hidden" name="punchingFlag" id="punchingFlag"/>
	<input type="hidden" name="returnCompanyId" id="returnCompanyId"/>
	<input type="hidden" name="returnCompanyName" id="returnCompanyName"/>
	<input type="hidden" name="returnCustomerName" id="returnCustomerName"/>
	<input type="hidden" name="returnCustomerId" id="returnCustomerId"/>
	<input type="hidden" name="returnCustomerRank" id="returnCustomerRank"/>
</form>

</body>

<script type="text/javascript">
$(document).ready(function(){
	list.init();
});

var list = {
		opportunity_hidden_id : "${param.opportunity_hidden_id}",
		modalReset : "${param.hiddenModalReset}",
		contactPK : "${param.contactPK}",
		issueFlag : "${param.issueFlag}",
		modalFlag : "ins/upd",
		searchPKArray : null,
		compareFlag : false, //모달 닫힐때 수정됐는지 비교
		compare_after : null, //모달 닫힐때 수정됐는지 비교
		compare_before : null, //모달 닫힐때 수정됐는지 비교
		sortCategory : null,
		coaching_talk : "${param.coaching_talk}",
		
		init : function(){
			if(list.modalReset) {
				modal.reset();
			}
			
			//스크롤 끝 이벤트	
			/* $(window).scroll(function() {
			    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
			    	page.start += 30;
			        if(page.start < page.totalCount){
			        	list.get();
			        }
			    }
			}); */
			
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
			
			initPaing(3); //페이징 초기화
			
			//검색
			$("#textSearchCompanyName, #textSearchCustomerName").keydown(function (key) {
		   		if(key.keyCode == 13){
		   			list.reset();
		   			list.get(1);
			     }
			 });
			
			if(!isEmpty(list.opportunity_hidden_id)){
				list.goDetail(list.opportunity_hidden_id);
				list.opportunity_hidden_id = null;
			}
			
			if(!isEmpty(list.contactPK)){
				modal.reset();
				//$("#formModalData #textCommonSearchCompany").val("${param.returnCompanyName}");
				//$("#formModalData #hiddenModalCompanyId, #formModalData #textCommonSearchCompanyId").val("${param.returnCompanyId}");
				//$("#formModalData #textModalCustomerName").val("${param.returnCustomerName}");
				//$("#formModalData #hiddenModalCustomerId").val("${param.returnCustomerId}");
				//$("#formModalData #textModalCustomerRank").val("${param.returnCustomerRank}");
				$("#formModalData #hiddenModalContactId").val(list.contactPK);
			}
			
			list.get(1);
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					if($(this).attr("data-sort") == "HOPP.HIDDEN_OPPORTINITY_ACTION_STATUS" || $(this).attr("data-sort") == "HOPP.STATUS"){
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#1ab394','#ffc000','#f20056','-')"
					}else{
						list.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					if($(this).attr("data-sort") == "HOPP.HIDDEN_OPPORTINITY_ACTION_STATUS" || $(this).attr("data-sort") == "HOPP.STATUS"){
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
			list.goDetail($("#hiddenModalPK").val());
			list.get(1);
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				if(!isEmpty(pn) && !isEmpty(ep)) { 
					page.start = pn;
					page.end = ep;
				}
				
				var listParams = $.param({
					datatype : 'html',
					jsp : '/clientSalesActive/hiddenOpportunityListAjax'
				});
				var countParams = $.param({
					datatype : 'json'
				});
				var params = {
									pageStart : page.start,
									pageEnd : page.end,
									latelyUpdateTable : "OPPORTUNITY_HIDDEN_LOG",
									searchPKArray : list.searchPKArray,
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
				
									//검색조건
									searchDivision : "${param.hiddenDashBoardDivision}",
									searchTeam : "${param.hiddenDashBoardTeam}",
									searchMember : "${param.hiddenDashBoardMember}",
									searchEtc : "${param.hiddenDashBoardEtc}", 
									searchStatus : $("#selectSearchStatus").val(),
									searchActionStatus : $("#selectSearchActionStatus").val(),
									searchCompanyName :function(){
										if(!isEmpty($("#textSearchCompanyName").val())){
											return $("#textSearchCompanyName").val();
										}else{
											return "${param.hiddenDashBoardCompany}";
										}
									},
									searchCustomerName : $("#textSearchCustomerName").val(),
									searchCompany : "${param.hiddenDashBoardCompany}",
									searchCompanyCategory : "${param.hiddenDashBoardCompanyCateogry}",
									searchQuarter : "${param.hiddenDashBoardQuarter}",
									searchYear : "${param.hiddenDashBoardYear}",
									
									sortCategory : list.sortCategory
								};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSalesActive/selectHiddenOpportunityCount.do",
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
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				//리스트
				$.ajax({
					url : "/clientSalesActive/selectHiddenOpportunity.do",
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
		
		goDetail : function(pkNo,obj){
			//상세보기로 gogo.
			$.ajax({
				url : "/clientSalesActive/selectHiddenOpportunityDetail.do",
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
					
					list.modalFlag = "upd"; //업데이트
					//초기화
					$("#formModalData").validate().resetForm();
					$("#formModalData #hiddenModalMemberList").val("");
					$("ul.flexdatalist-multiple li.value").remove();
					commonSearch.multipleMailShareMemberArray = [];
					
					$("#hiddenModalPK").val(rowData.OPPORTUNITY_HIDDEN_ID);
					
					$("#textModalSubject").val(rowData.SUBJECT);
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					
					//코칭톡 버튼 show, 창 hide
					$("#divModalCoachingTalk").hide();
					$("#buttonModalCoachingTalkView").show();
					$('span#spanCtCount').html("("+rowData.COACHING_TALK_COUNT+")");
					
					$("#textCommonSearchCompany").val(rowData.COMPANY_NAME);
					$("#textCommonSearchCompanyId").val(rowData.COMPANY_ID);
					$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
					$("#textModalCustomerName").val(rowData.CUSTOMER_NAME);
					$("#textModalCustomerRank").val(rowData.CUSTOMER_POSITION);
					$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
					
					//매출처
	             	$("a[name='aMoveSingleCompany']").remove();
	             	$("#textModalSingleCompany").hide();
	             	$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
	             	$('#liModalSingleCompany').before(
	             			'<li class="value">' +
							'<span class="txt" id="'+rowData.COMPANY_ID+'">'+rowData.COMPANY_NAME+'</span>' +
							'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
							'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+rowData.COMPANY_ID+'&searchDetail='+encodeURI(rowData.COMPANY_NAME)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
					);
	             	
	            	//End User
	            	$("#textModalSingleClient").hide();
	             	$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
	             	$('#liModalSingleClient').before(
	             			'<li class="value">' +
							'<span class="txt" id="'+rowData.CUSTOMER_ID+'">'+rowData.CUSTOMER_NAME+'</span>' +
							'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
							'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+rowData.CUSTOMER_ID+'&searchDetail='+encodeURI(rowData.CUSTOMER_NAME)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
					);
					
	             	//영업대표
					$("#textModalOppOwner").hide();
					$("#hiddenModalSalesId").val(rowData.SALESMAN_ID);
					$("#hiddenModalOppOwnerName").val(rowData.SALESMAN_NAME + (rowData.SALESMAN_POSITION != null ? ' '+ rowData.SALESMAN_POSITION : ''));
	             	$('#liModalSingleIdentifier').before(
	             			'<li class="value">' +
							'<span class="txt" id="'+rowData.SALESMAN_ID+'">'+rowData.SALESMAN_NAME+' ['+ rowData.SALESMAN_POSITION +']</span>' +
							'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOppOwner\',\'liModalSingleIdentifier\',\'hiddenModalSalesId\');"><i class="fa fa-times-circle"></i></a>'
					);
	             	
					$("#selectModalCategory").val(rowData.CATEGORY);
					$("#hiddenModalContactId").val(rowData.EVENT_ID);
					$("#textModalAmount").val(String(rowData.OPPORTUNITY_AMOUNT).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					$("#textModalSalesChangeDate").val(rowData.SALES_CHANGE_DATE);
					$('[name="divRelation"]').show();
					$('#divModalResult').html('');
					
					if(!isEmpty(rowData.OPPORTUNITY_ID)){
						$('#divModalResult').append('<a href="javascript:void(0);" class="oppStatusColor oppStatusColor-complete" onClick="list.goOpportunity('+rowData.OPPORTUNITY_HIDDEN_ID+','+rowData.OPPORTUNITY_ID+');">전환완료</a>');
						$('#hiddenRelationOpportunityId').val(rowData.OPPORTUNITY_ID);
					}else{
						$('#divModalResult').append('<a href="javascript:void(0);" class="oppStatusColor oppStatusColor" onClick="list.goOpportunity('+rowData.OPPORTUNITY_HIDDEN_ID+',\'\');">전환하기</a>');
						$('#hiddenRelationOpportunityId').val(null);
					}
					
					//고객컨택 연동
					$("#relationContact").html("");
					if(!isEmpty(rowData.EVENT_ID)){
						$("#relationContact").html('<a href="#" onClick="modal.goSalesAct('+rowData.EVENT_ID+',\'고객컨택\')" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					}else{
						$("#relationContact").html('-');
					}
					
					$("#textareaModalDetail").val(rowData.DETAIL_CONENTS);	//내용
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalDetail"));
					
					$("#buttonModalDelete").show();
					
					$("h4.modal-title").html(rowData.SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					// Action Plan
					$("label#fuaTable-error").remove();
					fuaGetList("/clientSalesActive/gridActionPlanHiddenOpportunity.do", rowData.OPPORTUNITY_HIDDEN_ID);
					
					/* modal.drawHiddenActionPlan();
					modal.actionPlanReload(); */
					
					$("#divModalCoachingTalk").hide(); //코톡 숨기기
					
					$("div.custom-company-pop.off").hide(); //메일공유 직원검색 팝업숨김
					
					$("#myModal1").modal();
					
					setTimeout(function(){
						list.compare_before = $("#formModalData").serialize();
					}, 400);
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정 후 코톡창 바로보기 여부 N처리.
					if(list.coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
						coaching_talk = 'N';
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goOpportunity : function(pkNo,opportunity_id){
			if(!isEmpty(opportunity_id)){
				$("#formRedirectOpportunity #opportunity_id").val(opportunity_id);
			}else{
				//상세보기로 gogo.
				$.ajax({
					url : "/clientSalesActive/selectHiddenOpportunityDetail.do",
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
						
						$("#formRedirectOpportunity #returnOpportunityhiddenId").val(rowData.OPPORTUNITY_HIDDEN_ID);
						$("#formRedirectOpportunity #returnCompanyId").val(rowData.COMPANY_ID);
						$("#formRedirectOpportunity #returnCompanyName").val(rowData.COMPANY_NAME);
						$("#formRedirectOpportunity #returnCustomerName").val(rowData.CUSTOMER_NAME);
						$("#formRedirectOpportunity #returnCustomerId").val(rowData.CUSTOMER_ID);
						$("#formRedirectOpportunity #returnCustomerRank").val(rowData.CUSTOMER_POSITION);
						$("#formRedirectOpportunity #returnSubject").val(rowData.SUBJECT);
						$("#formRedirectOpportunity #returnSalesManId").val(rowData.SALESMAN_ID);
						$("#formRedirectOpportunity #returnSalesManName").val(rowData.SALESMAN_NAME);
						$("#formRedirectOpportunity #returnSalesManPosition").val(rowData.SALESMAN_POSITION);
						$("#formRedirectOpportunity #returnOpportunityamount").val(String(rowData.OPPORTUNITY_AMOUNT).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
			menuCookieSet("영업기회"); //메뉴 활성화
			var frm = document.formRedirectOpportunity; 
			frm.target  = "_new"; 
			frm.action  = "/clientSalesActive/viewOpportunityList.do"; 
			frm.submit();   
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
