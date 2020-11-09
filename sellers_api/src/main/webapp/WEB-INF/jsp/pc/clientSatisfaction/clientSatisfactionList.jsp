<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%
	String returnCSatId = request.getParameter("csat_id");
%>

<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-4">
        <h2>고객만족도</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>고객만족도</strong>
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
                        
                       		<div class="tabs-container mg-b20">
                                <ul class="nav nav-tabs mg-b20">
                                    <li class="active"><a data-toggle="tab" href="#tab1-1" onClick="clientSatisfactionList.categoryTab(1,this);">만족도조사(Master)</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab1-2" onClick="clientSatisfactionList.categoryTab(2,this);">조사결과(Detail)</a></li>
                                </ul>
                                
                        <div class="func-area">
                            <div class="func-top-left fl_l">
                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                     <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                 <div class="table-menu" style="z-index:1000;display:none;">
                                        <ul>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" 	value="cols_COMPANY_NAME" 			checked="checked"> <label for="toggle-col-1">고객사</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" 	value="cols_PROJECT_NAME" 	checked="checked"> <label for="toggle-col-1">제목</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" 	value="cols_CSAT_SURVEY" 			checked="checked"> <label for="toggle-col-2">조사실행</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" 	value="cols_CSAT_SURVEY_DATE" 			checked="checked"> <label for="toggle-col-3">조사일</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" 	value="cols_COUNT" 			checked="checked"> <label for="toggle-col-4">조사결과</label></li>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" 	value="cols_ISSUE" 			checked="checked"> <label for="toggle-col-5">관련이슈</label></li> -->
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" 	value="cols_SALES_OWNER" 	checked="checked"> <label for="toggle-col-3">영업대표</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" 	value="cols_TOTAL" 					checked="checked"> <label for="toggle-col-4">총건수</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" 	value="cols_G" 						checked="checked"> <label for="toggle-col-5">완료</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" 	value="cols_Y" 							checked="checked"> <label for="toggle-col-6">진행중</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" 	value="cols_R" 							checked="checked"> <label for="toggle-col-7">미결</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" 	value="cols_MILESTONES" 		checked="checked"> <label for="toggle-col-8">수행단계</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" 	value="cols_PROGRESS" 			checked="checked"> <label for="toggle-col-9">진행률</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-10" 	value="cols_ISSUE_STATUS" 		checked="checked"> <label for="toggle-col-10">Status</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-11" 	value="cols_FILE_COUNT" 		checked="checked"> <label for="toggle-col-11">첨부</label></li> -->
                                        </ul>
                                    </div>
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
					                           <div class="form-group">
					                            <label>분류</label> 
					                            <select class="form-control m-b" name="account" id="selectSearchDetailCategory">
					                             <option value="">==== 선택 ====</option>
					                             <option value="고객만족">고객만족</option>
					                             <option value="파트너만족">파트너만족</option>
					                         </select>
					                           </div>
					                       </div>
						                    
						                    <div class="col-sm-12 m-b">
						                        <label class="control-label" for="date_modified">전체</label>
						                        <div class="input-group" style="width:100%;" ><input type="text" placeholder="검색어를 입력해주세요" class="input form-control" id="textSearchDetail" name="textSearchDetail"></div>
						                    </div>
						                    <div class="col-sm-12 ag_r">
						                        <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
						                        <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="clientSatisfactionList.reset();clientSatisfactionList.searchTypeCheck();"><i class="fa fa-search"></i> 상세검색</button>
						                    </div>
					                    </form>
					                </div>
					                    
				                </div>
				            </div>
					            
					        <div class="func-top-left fl_l">
							<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
						        <div class="table-sel-view fl_l">
	                                 <div class="selgrid selgrid1 mg-r5">
	                                     <select class="form-control m-b" name="selectSatisfactionCategory" id="selectSatisfactionCategory">
	                                         <option value="고객만족">고객만족</option>
	                                         <option value="파트너만족">파트너만족</option>
	                                     </select>
	                                 </div>
	                             </div>
	                             
	                             <div class="table-sel-view fl_l">
	                                 <div class="selgrid selgrid1 mg-r5">
	                                     <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
	                                         <option value="">== 정렬 기준 ==</option>
	                                         <option value="COMPANY_ID">고객사</option>
	                                         <option value="CSAT_SURVEY_NAME">책임자</option>
	                                         <option value="CSAT_SURVEY_POST">조사본부</option>
	                                         <option value="CSAT_METHOD">조사 방법</option>
	                                         <option value="CSAT_VALUE">조사 결과</option>
	                                     </select>
	                                 </div>
	                             </div>
	                        </div>
	                        </div>
                                 
                            <div class="fl_r pd-b20">
                            	<!-- <div class="fl_l template-doc">
                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
                                    <ul class="template-list off">
                                      <li><a href="#" onclick="selectSampleFile(this);">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li>
                                    </ul>
                                </div> -->
                                <div class="fl_l mg-r10">
									<a href="/clientSatisfaction/viewClientSatisfactionDashBoard.do" class="btn btn-outline btn-seller-outline">
										<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
									</a>
								</div>
                                <div class="fl_l">
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div>
                                </div>
                            </div>
                            <!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->
                            
                            <div class="tab-content">
	               				<div id="tab1-1" class="tab-pane active">
	                            	<table id="tech-companies1" class="table table-bordered">
									  	<colgroup>
									        <%-- <col width=""	/> --%>
									        <%-- <col width=""	name="cols_COMPANY" 		/> --%>
									        <col width=""	name="cols_PROJECT_NAME" 	/>
									        <col width=""	name="cols_SALES_OWNER" 	/>
									        <col width=""	name="cols_TOTAL" 			/>
									        <col width=""	name="cols_G" 				/>
									        <col width=""	name="cols_Y" 				/>
									        <col width=""	name="cols_R" 				/>
									        <col width=""	name="cols_MILESTONES" 	/>
									        <col width=""	name="cols_PROGRESS" 		/>
									        <col width=""	name="cols_ISSUE_STATUS" 	/>
									        <col width=""	name="cols_FILE_COUNT" 	/>
									        
									    </colgroup>
							    		<thead>
											<tr>
											   <!-- <th rowspan="2">No</th> -->
											   <!-- <th rowspan="2" name="">C-Sat</th> -->
									           <th rowspan="2" name="cols_PROJECT_NAME"><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SUBJECT" data-method="">제 목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
									           <th colspan="2" name="cols_CSAT_SURVEY">조사실행</th>
									           <th rowspan="2" name="cols_CSAT_SURVEY_DATE"><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SURVEY_DATE" data-method="">조사일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
									           <th colspan="7" name="cols_COUNT">조사결과 Summary</th>
									           <!-- <th colspan="4" name="cols_ISSUE">관련이슈 Summary(건수)</th> -->
									           <th rowspan="2" name="cols_FILE_COUNT">첨부</th>
									       </tr>
											<tr>
									           <!-- <th name="cols_COMPANY">고객사</th> -->
									           <th name="cols_CSAT_SURVEY"><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SURVEY_POST" data-method="">본부 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
									           <th name="cols_CSAT_SURVEY"><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SURVEY_NAME" data-method="">책임자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											   <th name="cols_COUNT">평 균</th>
											   <th name="cols_COUNT">건 수</th>
											   <th name="cols_COUNT">5</th>
											   <th name="cols_COUNT">4</th>
											   <th name="cols_COUNT">3</th>
											   <th name="cols_COUNT">2</th>
											   <th name="cols_COUNT">1</th>
											   <!-- <th name="cols_ISSUE">발생</th>
											   <th name="cols_ISSUE">진행중</th>
											   <th name="cols_ISSUE">완료</th>
											   <th name="cols_ISSUE">총 계</th> -->
											</tr>
										</thead>
									    <tbody id="row">
									    
				    					</tbody>
									</table>
								</div>
								
								<div id="tab1-2" class="tab-pane">
									<table id="tech-companies2" class="table table-bordered">
									  	<colgroup>
									        <%-- <col width=""	/> --%>
									        <%-- <col width=""	name="cols_COMPANY" 		/> --%>
									        <col width=""	name="cols_PROJECT_NAME" 	/>
									        <col width=""	name="cols_SALES_OWNER" 	/>
									        <col width=""	name="cols_TOTAL" 			/>
									        <col width=""	name="cols_G" 				/>
									        <col width=""	name="cols_Y" 				/>
									        <col width=""	name="cols_R" 				/>
									        <col width=""	name="cols_MILESTONES" 	/>
									        <col width=""	name="cols_PROGRESS" 		/>
									        <col width=""	name="cols_ISSUE_STATUS" 	/>
									        <col width=""	name="cols_FILE_COUNT" 	/>
									        
									    </colgroup>
							    		<thead>
											<tr>
											   <!-- <th rowspan="2">No</th> -->
											   <!-- <th name="cols_COMPANY">고객사</th> -->
									           <th rowspan="2" name="cols_PROJECT_NAME"><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SUBJECT" data-method="">제 목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
									           <th colspan="2" name="">고 객</th>
									           <th colspan="4" name="">만족도 조사</th>
									           <th rowspan="2" name="cols_FILE_COUNT">첨부</th>
									       </tr>
											<tr>
									           <!-- <th name="cols_COMPANY">고객사</th> -->
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.COMPANY_NAME" data-method="">고객사 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.RESP_CUSTOMER_NAME" data-method="">응답자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SURVEY_NAME" data-method="">조사자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_SURVEY_DATE" data-method="">조사일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_METHOD" data-method="">조사방법 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											    <th name=""><a href="#" class="sortLink" data-sort="TMP_TABLE.CSAT_VALUE" data-method="">결 과 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
											</tr>
										</thead>
									    <tbody id="row">
									    
				    					</tbody>
									</table>
								</div>
								
								<div class="btn-group pull-right pd-t10">
								</div>
							
								</div>
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

<jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/clientSatisfactionModal.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</body>

<script type="text/javascript">
$(document).ready(function(){
	clientSatisfactionList.init();
	clientSatisfactionList.getMaster();
	
	if(modalReset) {
		modal.reset();
	}
	
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

var returnCSatId = "<%=returnCSatId%>";
var notice_event_id = "${param.notice_event_id}";
var modalReset = "${param.hiddenModalReset}";

var searchCategory = "만족도조사(Master)";
var pageFlag = "master";

var params;
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";

var clientSatisfactionList = {
		sortCategory : null,
		
		init : function(){
			initPaing(5); //페이징 초기화
			
			if(notice_event_id){
				clientSatisfactionList.goDetail(notice_event_id);
			}
			
			//고객만족도 대시보드 옴
			if(returnCSatId != "null" && returnCSatId != null && returnCSatId != ""){
				clientSatisfactionList.goDetail(returnCSatId);
			}
			
			$("#selectSortCategory").change(function(){
				clientSatisfactionList.reset();
				if(pageFlag=='master') clientSatisfactionList.getMaster(1);
				else clientSatisfactionList.get(1);
			});
			$("#selectSatisfactionCategory").change(function(){
				clientSatisfactionList.reset();
				if(pageFlag=='master') clientSatisfactionList.getMaster(1);
				else clientSatisfactionList.get(1);
			});
			
			
			//sort 기능 master
			$('#tech-companies1').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					
					clientSatisfactionList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					
					clientSatisfactionList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					clientSatisfactionList.sortCategory = "";
				}
				
				clientSatisfactionList.reset();
				clientSatisfactionList.getMaster(1);
			});
			
			//sort 기능 Detail
			$('#tech-companies2').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					
					clientSatisfactionList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					
					clientSatisfactionList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					clientSatisfactionList.sortCategory = "";
				}
				
				clientSatisfactionList.reset();
				clientSatisfactionList.get(1);
			});
			
			
		},
		
		categoryTab : function(val,obj){
			searchPKArray = ""; //탭 이동 시 검색 초기화
			//clientSatisfactionList.searchReset(); //등록/수정 시 검색 초기화
			$("ul.nav.nav-tabs li").removeClass();
			$(obj).parent('li').addClass('active');
			
			$('a.sortLink').attr("data-method","");
			$('a.sortLink').find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
			clientSatisfactionList.sortCategory = "";
			
			if(val==1){
				searchCategory = "만족도조사(Master)";
				pageFlag = "master";
				$("#tab1-1").addClass("active");
				$("#tab1-2").removeClass("active");
				
				$("#selectSatisfactionCategory option:first").prop("selected",true);
				clientSatisfactionList.reset();
				clientSatisfactionList.getMaster(1);
			}else if(val==2){
				searchCategory = "조사결과(Detail)";
				pageFlag = "detail";
				$("#tab1-1").removeClass("active");
				$("#tab1-2").addClass("active");
				
				$("#selectSatisfactionCategory option:first").prop("selected",true);
				clientSatisfactionList.reset();
				clientSatisfactionList.get(1);
			}
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
			//$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		searchTypeCheck : function(){
			if(searchCategory == '조사결과(Detail)'){
				clientSatisfactionList.get(1);
			}else{
				clientSatisfactionList.getMaster(1);
			}
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start=0;
			//clientSatisfactionList.goDetail($("#hiddenModalPK").val());
			if(pageFlag=='master') clientSatisfactionList.getMaster(1);
			else clientSatisfactionList.get(1);
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//master 리스트 가져오기
		getMaster : function(pn, ep){
			params = {
					pageStart : page.start, //0
					pageEnd : page.end,
					latelyUpdateTable : "CLIENT_SAT_LOG",
					sortCategory : clientSatisfactionList.sortCategory,
					satisfactionCategory : $("#selectSatisfactionCategory").val(),
					searchCategory : searchCategory,
					searchAll : $("#textSearchDetail").val(),
					searchPKArray : searchPKArray,
					resultInSearch : function(){
						if($("#result-in-search").is(":checked")){
							return "Y";
						}else{
							return "N";
						}
					}
				};
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSatisfaction/selectClientSatisfactionMasterListCount.do",
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
						data.fncName = 'clientSatisfactionList.getMaster';
						pageCreateNavi(data);
					},
					complete : function(){
					}
				});
				//마스터리스트
				$.ajax({
					url : "/clientSatisfaction/selectClientSatisfactionMasterList.do",
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
					}
				});
		},
		
		//detail 리스트 가져오기
		get : function(pn, ep){
			params = {
					pageStart : page.start, //0
					pageEnd : page.end,
					latelyUpdateTable : "CLIENT_SAT_LOG",
					sortCategory : clientSatisfactionList.sortCategory,
					satisfactionCategory : $("#selectSatisfactionCategory").val(),
					searchCategory : searchCategory,
					searchAll : $("#textSearchDetail").val(),
					searchPKArray : searchPKArray,
					resultInSearch : function(){
						if($("#result-in-search").is(":checked")){
							return "Y";
						}else{
							return "N";
						}
					}
				};
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSatisfaction/selectClientSatisfactionListCount.do",
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
						data.fncName = 'clientSatisfactionList.get';
						pageCreateNavi(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				//리스트
				$.ajax({
					url : "/clientSatisfaction/selectClientSatisfactionList.do",
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
						$.ajaxLoadingHide();
					}
				});
		},
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/clientSatisfaction/selectClientSatisfactionDetail.do",
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
					
					//EVENT ON
					modalEvent.on();
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					$("#textModalSubject").val(rowData.CSAT_SUBJECT);
					$("#textModalTextName").val(rowData.HAN_NAME);
					$("#textModalCreateDate").val(rowData.SYS_REGISTER_DATE);
					$("#selectModalCategory").val(rowData.CSAT_CATEGORY);
					/* $("#textModalSatName").val(rowData.CSAT_SURVEY_NAME);
					$("#textModalSatDate").val(rowData.CSAT_SURVEY_DATE); */
					$("#hiddenModalPK").val(rowData.CSAT_ID);
					$("#textareaModalContents").val(rowData.CSAT_DETAIL);	//고객만족 Master 상세내용
					$("#textModalCsatSurveyName").val(rowData.CSAT_SURVEY_NAME);
					$("#textModalCsatSurveyId").val(rowData.CSAT_SURVEY_ID);
					$("#textModalCsatDate").val(rowData.CSAT_SURVEY_DATE);
					$("#textModalCsatDetailAVG").val(rowData.CSAT_AVG_VALUE);
					$("#textModalCsatDetailCount").val(rowData.CSAT_TOTAL_COUNT);
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalContents"));
					
					$("#buttonModalDelete").show();
					$("#divModalFile").show();
					$("#divFileUploadArea .fileModalUploadFile").remove();
					$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
					$("#divModalFile p[name='modalFile"+rowData.CSAT_ID+"']").show();
					
					$("h4.modal-title").html(rowData.CSAT_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
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
					$("#buttonModalModifiedDelete").hide();
					modalDetail.gotoDetail('1');
					
					modal.drawIssueSolvePlan();
					modal.solvePlanReload();
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=5"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("#hiddenModalCompanyId").val(rowData.CLIENT_COMPANY_ID);					//고객사ID
					
					$("h4.modal-title").html(rowData.PROJECT_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					//mileOpper.select();
					//projectIssue.reset();
					//projectIssue.drawQualification();
					/* 상세보기창이 열린다 */
					$("#myModal1").modal();
					//신규등록, 상세보기 div 접기 펴기
					//toggleDiv(modalFlag);
					//값 비교를 위한.
					compare_before = $("#formModalData").serialize();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
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
