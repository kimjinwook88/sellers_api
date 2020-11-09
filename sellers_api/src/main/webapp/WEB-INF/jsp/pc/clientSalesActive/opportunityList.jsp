<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<div class="row wrapper border-bottom white-bg page-heading">
    <!-- div class="col-sm-6">
        <h2>영업기회</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객영업활동</a>
            </li>
            <li class="active">
                <strong>영업기회</strong>
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
                    		
                    		<!-- 탭 -->
                    		<div class="mg-b20">
	               				<ul class="nav nav-tabs">
	               					<li class="active"><a href="javascript:void(0);" onclick="oppList.tabClick(1, 1);">중요(<i class="fa fa-star" style="color: orange; margin-right: 0px;"></i>)</a></li>
	                				<li><a href="javascript:void(0);" onclick="oppList.tabClick(2, 1);">진행중</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="oppList.tabClick(3, 2);">완료</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="oppList.tabClick(4, 3);">스플릿</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="oppList.tabClick(5, 4);">리베이트</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="oppList.tabClick(6, 5);">No-Bid</a></li>
	             	        	</ul>
	                 		</div> 
                   			<!-- 탭end -->
                   			
                    	<div class="pos-rel">
                           		
								<div class="func-top-left fl_l">
										<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
		                                    <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                   	 	<div class="table-menu" style="z-index:1000;display:none;">
		                                        <ul>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cell_OPPORTUNITY" 	checked="checked"> <label for="toggle-col-1">영업기회</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cell_EXEC_NAME" 		checked="checked"> <label for="toggle-col-2">OO,IO</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cell_CHECKLIST" 		checked="checked"> <label for="toggle-col-3">승리계획</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cell_FORECAST" 		checked="checked"> <label for="toggle-col-4">FC</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cell_SALES_CYCLE" 	checked="checked"> <label for="toggle-col-5">SC</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cell_MILESTONES" 	checked="checked"> <label for="toggle-col-6">마일스톤</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cell_CONTRACT_DATE" 	checked="checked"> <label for="toggle-col-7">계약일</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cell_CONTRACT_AMOUNT" checked="checked"> <label for="toggle-col-8">예상계약금액</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cell_REV" 	checked="checked"> <label for="toggle-col-9">REV</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-10" value="cell_GP" 	checked="checked"> <label for="toggle-col-10">GP</label></li>
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
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompany" name="textSearchCompany" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get(1);}"></div>
					                        </div>
					                        
						                    <%-- <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">영업부서</label>
												<select class="form-control" name="selectModalSearchDivision" id="selectModalSearchDivision">
												<c:choose>
													<c:when test="${fn:length(searchDetailGroup.division_group) > 0}">
														<c:forEach items="${searchDetailGroup.division_group}" var="searchDetailGroup">
															<option value="${searchDetailGroup.DIVISION_NO}">${searchDetailGroup.DIVISION_NAME}</option>
														</c:forEach>
													</c:when>
												</c:choose> 
												</select> 
					                        </div> --%>
					                        
					                        
						                    <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">제목</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="제목을 입력해주세요." class="input form-control" id="textSearchTitle" name="textSearchTitle" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get(1);}"></div>
					                        </div>
					                        
						                    <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">영업대표</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="영업대표를 입력해주세요." class="input form-control" id="textSearchSalesMan" name="textSearchSalesMan" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get(1);}"></div>
					                        </div>
					                        
					                        <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">프로젝트코드</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="프로젝트코드를 입력해주세요." class="input form-control" id="textSearchProjectCd" name="textSearchProjectCd" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get(1);}"></div>
					                        </div>
					                        
					                        <div class="col-sm-12 m-b">                                    
					                            <label class="control-label" for="date_modified">등록일</label>
					                            <div class="data_1">
					                                <div class="input-group date">
					                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control search" id="textSearchContractStartDate" name="textSearchContractStartDate">
					                                </div>
					                            </div>
					                            <div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
					                            <div class="data_1">
					                                <div class="input-group date">
					                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control search" id="textSearchContractEndDate" name="textSearchContractEndDate">
					                                </div>
					                            </div>
					                        </div>
					                        
						                    <!-- <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">Opportunity Owner</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="Owner를 입력해주세요" class="input form-control" id="textSearchOwner" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
					                        </div> -->
					                        
						                  <!--   <div class="col-sm-12 m-b">
					                            <label class="control-label" for="date_modified">예상계약금액 (입력 금액 이상 검색)</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="예상계약금액을 입력해주세요." class="input form-control" id="textContractAmount" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
					                        </div> -->
					                        
					                        <div class="col-sm-12 m-b">
						                        <div class="form-group">
						                        	<label>Forecast</label>
						                         	<select class="form-control" id="selectSearchForecast" name="selectSearchForecast">
							                             <option value="">=== 선택 ===</option>
							                             <option value="In">In</option>
							                       		 <option value="Out">Out</option>
						                         </select>
						                        </div>
							               </div>
							               
					                        <!-- <div class="col-sm-12 m-b">
						                         <div class="form-group">
						                         	 <label>Sales Cycle</label>
							                         <select class="form-control" id="selectSearchSalesCycle">
														<option value="">=== 선택 ===</option>
														<option value="1">Identify</option>
														<option value="2">Qualification</option>
														<option value="3">Close</option>
							                         </select>
						                         </div>
						                    </div> -->
					                        
					                        <!-- <div class="col-sm-12 m-b">                                    
					                            <label class="control-label" for="date_modified">계약일</label>
					                            <div class="data_1">
					                            
					                                <div class="input-group date">
					                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textSearchContractStartDate">
					                                </div>
					                            </div>
					                            <div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
					                            <div class="data_1">
					                                <div class="input-group date">
					                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textSearchContractEndDate">
					                                </div>
					                            </div>
					                        </div> -->
					                                
					                        <div class="col-sm-12 ag_r">
					                            <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
					                            <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="oppList.reset();oppList.get(1);"><i class="fa fa-search"></i> 검색</button>
					                        </div>
				                        	</form>
					                    </div>
					                </div>
					            </div>
					            
					            <div class="func-top-left fl_l">
		                            <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
						            	<div class="selgrid">
	                                        <div class="fl_l mg-r10">
	                                            <button class="btn btn-white btn-move" onclick="oppList.naviPrevDate();"><i class="fa fa-arrow-left"></i></button>
	                                            <strong class="term-txt" id="strongDate">2018년 4분기</strong>
	                                            <button class="btn btn-white btn-move" onclick="oppList.naviNextDate();"><i class="fa fa-arrow-right"></i></button>
	                                        </div>
	                                        
	                                        <div class="fl_l pd-t3">
	                                            <label for="term1" class="mg-r10">
	                                                <input type="radio" id="term1" name="radioViewType" value="m"  class=""> <span class="">월</span>
	                                            </label>
	                                            <label for="term2" class="mg-r10">
	                                                <input type="radio" id="term2" name="radioViewType" value="q"  checked="true" class=""> <span class="">분기</span>
	                                            </label>
	                                            <label for="term3">
	                                                <input type="radio" id="term3" name="radioViewType" value="y"  class=""> <span class="">년도</span>
	                                            </label>
	                                        </div>
	                                    </div>
						            </div>
					            </div>
					            
							            
								<div class="func-top-right fl_r pd-b20">
									<div class="fl_l mg-r10">
										<a href="/clientSalesActive/viewOpportunityDashBoard.do" class="btn btn-outline btn-seller-outline">
											<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
										</a>
									</div>
	                            	<!-- <div class="fl_l template-doc">
	                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
	                                    <ul class="template-list off">
	                                       <li><a href="#" onclick="selectSampleFile(this);">영업기회관리(WinPlan).xlsx</a></li>
										   <li><a href="#" onclick="selectSampleFile(this);">영업기회관리(체크리스트_영업기회점검).xlsx</a></li>
	                                    </ul>
	                                </div> -->
	                                <div class="fl_l">
	                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
	                                </div>
								</div>                                    
	                            
                     			<p class="cboth ag_r" >금액단위 : 백만원</p>
	                            <table id="tech-companies" class="table table-bordered">
							  		<colgroup>
                                       <%-- <col width="40px"/> --%>
                                        <col class="basicView"  width="*"/>
										<col class="basicView"  width="*"/>
										<col class="basicView"  width="1%"/>
										<col class="basicView"  width="1%"/>
										<col class="basicView"  width="1%"/>
										<col class="basicView"  width="1%"/>
										<col class="basicView"  width="3%"/>
										<col class="basicView"  width="3%"/>
										<col class="basicView"  width="5%"/>
										<col class="basicView"  width="9%"/>
										<col class="basicView"  width="*"/>
										<col class="basicView"  width="*"/>
										<col class="basicView"  width="*"/>
                                   </colgroup>
	                              <thead>
	                              <tr id="trCellCount">
	                                  <!-- <th rowspan="2">ID</th> -->
	                                  <th rowspan="2" name="cell_OPPORTUNITY"><a href="#" class="sortLink" data-sort="OL.SUBJECT" data-method="">영업기회 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_EXEC_NAME" >OO<br />IO</th>
									  <th colspan="4"  name="cell_CHECKLIST">승리계획</th>
	                                  <th rowspan="2" name="cell_FORECAST"><a href="#" class="sortLink" data-sort="OL.FORECAST_YN" data-method=""><span class="mark-ti r2">FC</span> <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_SALES_CYCLE"><a href="#" class="sortLink" data-sort="OL.SALES_CYCLE" data-method=""><span class="mark-ti r2">SC</span> <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_MILESTONES">마일스톤</th>
	                                  <th rowspan="2" name="cell_CONTRACT_DATE"><a href="#" class="sortLink" data-sort="OL.CONTRACT_DATE" data-method="">계약일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_CONTRACT_AMOUNT"><a href="#" class="sortLink" data-sort="OL.CONTRACT_AMOUNT" data-method="">예상<br />계약금액 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_REV"><a href="#" class="sortLink" data-sort="SALES_PLAN.REV" data-method="">REV <br/>(매출) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                                  <th rowspan="2" name="cell_GP"><a href="#" class="sortLink" data-sort="SALES_PLAN.GP" data-method="">GP <br/>(총 이익) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
	                              </tr>
	                              <tr>
	                                  <th name="cell_CHECKLIST">일정</th>
	                                  <th name="cell_CHECKLIST">경쟁</th>
	                                  <th name="cell_CHECKLIST">솔루션</th>
	                                  <th name="cell_CHECKLIST">계약</th>
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

<div class="legend-tx"> 
    <!-- <span class="mark-ti r2">EO</span> Exec Owner
    <span class="mark-ti r2 mg-l10">OO</span> Opportunity Owner
    <span class="mark-ti r2 mg-l10">B</span> 일정/예산
    <span class="mark-ti r2 mg-l10">C</span> 경쟁상황
    <span class="mark-ti r2 mg-l10">S</span> 솔루션
    <span class="mark-ti r2 mg-l10">T</span> 계약조건 -->
    <span class="mark-ti r2 mg-l10">FC</span> Forecast
    <span class="mark-ti r2 mg-l10">SC</span> 영업단계(1-Identify, 2-Qualification, 3-Negotiation, 4-Close) 
</div>
            
</div>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/opportunityModal.jsp"/>

</body>

<script type="text/javascript">
$(document).ready(function(){
	oppList.init();
});
	
var sortCategory;
var columnCount;

var compare_flag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";

/* var page = {
		start : 0,			   // 0부터 ~
		rowCount : 20,    //10개씩
		totalCount : null  //총 리스트 갯수
} */

var opportunity_id = "${param.opportunity_id}";
var returnOpportunityhiddenId = "${param.returnOpportunityhiddenId}";
var returnCompanyId = "${param.returnCompanyId}";
var returnCompanyName = "${param.returnCompanyName}";
var returnCustomerId = "${param.returnCustomerId}";
var returnCustomerName = "${param.returnCustomerName}";
//var returnCustomerRank = "${param.returnCustomerRank}";
var returnSalesManId = "${param.returnSalesManId}";
var returnSalesManName = "${param.returnSalesManName}";
var returnSalesManPosition = "${param.returnSalesManPosition}";

var returnSubject = "${param.returnSubject}";
var returnOpportunityamount = "${param.returnOpportunityamount}";

var searchDivision = "${param.hiddenDashBoardDivision}";
var searchTeam = "${param.hiddenDashBoardTeam}";
var searchMember = "${param.hiddenDashBoardMember}";
var searchForecast = "${param.hiddenDashBoardForecast}";
var searchCompanyId = "${param.hiddenDashBoardCompanyId}";
var searchDateCategory = "${param.hiddenDashBoardDateCategory}";
var searchStartDate = "${param.hiddenDashBoardStartDate}";
var searchEndDate = "${param.hiddenDashBoardEndDate}";

var modalReset = "${param.hiddenModalReset}";

var coaching_talk = "${param.coaching_talk}";
var searchSalesCycle = 1;
var searchKeyDeal = 'Y';

var oppList = {
		init : function(){
			initPaing(2); //페이징 초기화
			
			// 모달 닫기 이벤트
			$('#myModal1').on('hide.bs.modal', function () {
				compare_after = $("#formModalData").serialize();
				if(modalFlag == "upd" && $('#hiddenModalSalesCycleSave').val() != '5' ){
					if(compare_before != compare_after){
						if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
							compare_flag = true;
							$("#buttonModalSubmit").trigger("click");
						}
					}
				}else if(modalFlag == "ins"){ //신규등록이면
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
				winPlanEvent.off();
				milestonesEvent.off();
				oppProductEvent.off();
				oppSalesPlanEvent.off();
				compare_before = "";
				compare_after = "";
			});
			
			// 잠재영업기회에서 넘어온 경우
			if(!isEmpty(returnOpportunityhiddenId)){
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
					sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					sortCategory = "";
				}
				
				oppList.reset();
				oppList.get(1);
			});
			
			//년, 월, 분기 네비게이션~
			$("input[name='radioViewType']").on('change',function(){
				if(isEmpty(searchStartDate)) searchStartDate = moment().format('YYYY-MM-DD')
				dateMap = commonDate.naviDate($(this).val(), searchStartDate, 0);
				searchDateCategory = $(this).val();
				oppList.naviSetDate(dateMap); //ajax list 불러옴@@@@@@@@@@@@@@@@@
			});
			
			if(modalReset) {
				modal.reset();
			}
			
			if(!isEmpty(searchDateCategory)){
				$("input[name='radioViewType'][value="+searchDateCategory+"]").prop("checked",true);
				$("input[name='radioViewType'][value="+searchDateCategory+"]").trigger('change');
			}else{
				//기본 분기로!
				$("input[name='radioViewType']").eq(1).prop("checked",true);
				$("input[name='radioViewType']").eq(1).trigger("change");
			}
			
			if(!isEmpty(opportunity_id)){
				oppList.goDetail(opportunity_id);
			}
		},
		
		naviSetDate : function(dateMap){
			searchStartDate = dateMap.startDate; 
			searchEndDate = dateMap.endDate;
			$("strong#strongDate").html(dateMap.showDate);
			
			var searchDivision = "${param.hiddenDashBoardDivision}";
			var searchTeam = "${param.hiddenDashBoardTeam}";
			var searchMember = "${param.hiddenDashBoardMember}";
			var searchForecast = "${param.hiddenDashBoardForecast}";
			
			oppList.get(1);
			//리스트 호출
			/* if(!isEmpty(searchDivision) || !isEmpty(searchTeam) || !isEmpty(searchMember) || !isEmpty(searchForecast)){ //대시보드 클릭해서 넘어올 경우 진행중 탭으로~
				$("#selectSearchForecast").val(searchForecast);
				oppList.tabClick(2, 1);
			}else{
								
			} */
			
		},
		
		//분기 이전 버튼
		naviPrevDate : function() {
			var dateMap = commonDate.naviDate(searchDateCategory, searchEndDate, -1);
			oppList.naviSetDate(dateMap);
		},
		
		//분기 다음 버튼
		naviNextDate : function() {
			var dateMap = commonDate.naviDate(searchDateCategory, searchEndDate, 1);
			oppList.naviSetDate(dateMap);
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("");
			$("#result-in-search").prop("checked",false);
		},
		
		//공통 파라미터
		getParams : function(cFlag){
			var params = $.param({
				sortCategory : sortCategory,
				latelyUpdateTable : "OPPORTUNITY_LOG",
				
				//검색 start
				searchCompany : function(){
					if(!isEmpty($("#textSearchCompany").val())){
						return $("#textSearchCompany").val();
					}else{
						return "${param.hiddenDashBoardCompany}";
					}
				},
				searchDateCategory : searchDateCategory,
				searchStartDate : searchStartDate,
				searchEndDate : searchEndDate,
				
				searchDivision : searchDivision,
				searchTeam : searchTeam,
				searchMember : searchMember,
				searchCompanyCategory : "${param.hiddenDashBoardCompanyCateogry}",
				//searchProduct : "${param.hiddenDashBoardProduct}",
				searchOwner : $("#textSearchOwner").val(),
				searchModalDivision : $("#textSearchModalDivision").val(),
				searchTitle : $("#textSearchTitle").val(),
				searchSalesMan : $("#textSearchSalesMan").val(),
				searchProjectCd : $("#textSearchProjectCd").val(),
				searchForecast : $("#selectSearchForecast").val(),
				searchSalesCycle : searchSalesCycle,
				searchContractAmount : $("#textContractAmount").val(),
				searchContractStartDate : $("#textSearchContractStartDate").val(),
				searchContractEndDate : $("#textSearchContractEndDate").val(),
				//검색 end
				searchPKArray : searchPKArray,
				resultInSearch : function(){
					if($("#result-in-search").is(":checked")){
						return "Y";
					}else{
						return "N";
					}
				},
				searchKeyDeal : searchKeyDeal
			});
			return params;
		},
		
		completeReload : function(pkNo){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
            commonFile.fileArray = [];
        	commonFile.reloadFile(pkNo, '6');

			var tmpData = page.start;
			page.start=0;
			if(!compare_flag) oppList.goDetail(pkNo);
			oppList.get(1);
        	page.start = tmpData;
		},
		
		//상단(진행중, 완료 탭 클릭)
		tabClick : function(no, sc){
			//검색 초기화
			//oppList.searchReset();
			
			//진행중
			$("ul.nav.nav-tabs li").removeClass();
			$("ul.nav.nav-tabs li").eq(no-1).addClass("active");
			searchSalesCycle = sc;
			if(no == '1'){
				searchKeyDeal = 'Y';
			}else{
				
				searchKeyDeal = '';
			}
			
			oppList.get(1);
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				var listParams = $.param({
					datatype : 'html',
					jsp : '/clientSalesActive/opportunityListAjax'
				});
				var countParams = $.param({
					datatype : 'json'
				});
				var pageParams = {
					pageStart : page.start,
					pageEnd : page.end,
					numberPagingUseYn : 'Y'
				}
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색, 리스트 sum
				$.ajax({
					url : "/clientSalesActive/selectOpportunityCount.do",
		 			datatype : 'json',
		 			method: 'POST',
					data : oppList.getParams() + "&" + countParams + "&" + $.param(pageParams) + "&" + $.param(page) + "&" + $.param(pagingParams),
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
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
						pageParams.pageStart = data.listPaging.pageStart;
						pageParams.pageEnd = data.listPaging.endPage;
						data.fncName = 'oppList.get';
						pageCreateNavi(data);
					},
					complete : function(){
					}
				}).done(function(sum){ //카운트 끝나고~
					//리스트
					$.ajax({
						url : "/clientSalesActive/selectOpportunity.do",
			 			datatype : 'html',
			 			method: 'POST',
						data : oppList.getParams() + "&" + listParams + "&" + $.param(pageParams) + "&" + $.param(page) + "&" + $.param(pagingParams),
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
						},
						success : function(data){
							$('tbody#row').html(data);
							
							//항목 숨기기
							if(!isEmpty(columnCount)){
								$('tr.total td.title').attr('colspan',columnCount);	
							}
							//항목숨기기 유지
							$(".table-menu-wrapper2 input[name='toggle-cols']").each(function(){
								if(!$(this).is(":checked")){
						   			$('[name="'+$(this).val()+'"]').hide();
						   		}
							});
						},
						complete : function(){
							//리스트 합계
							$('tbody#row').find('#sum_contract_amount').html(sum.sumMap.SUM_CONTRACT_AMOUNT);
							$('tbody#row').find('#total_rev').html(sum.sumMap.SUM_REV);
							$('tbody#row').find('#total_gp').html(sum.sumMap.SUM_GP);
							
							$.ajaxLoadingHide();
						}
					});
					
				});
		},
		
		setDetail : function(data, callback){
			// gridClientIndividualInfo << 이거랑 같이 쓰고 있는거 같아서 일단 안바꾸고 위의 URL로 가져왔습니다.
			var rowData = data.detail;
			var fileList = data.fileList;
			var scCheckList = data.scCheckList;
			var winPlanList = data.winPlanList;
			var milestonesList = data.milestonesList;
			var productSalesList = data.productSalesList;
			var productPsList = data.productPsList;
			var salesPlanList = data.salesPlanList;
			var salesSplitList = data.salesSplitList;
			
			modalFlag = "upd"; //업데이트
			compare_flag = false;
			
			//EVENT ON
			modalEvent.on();
			winPlanEvent.on();
			milestonesEvent.on();
			oppProductEvent.on();
			oppSalesPlanEvent.on();
			
			//초기화
			$("div.autocomplete-suggestions").hide();
			$("#formModalData").validate().resetForm();
			$("ul.flexdatalist-multiple li.value").remove();
			$("small.font-bold").css('display','');
			$("#buttonModalSubmit").html("저장하기");
			$("#buttonTempSelect").hide();
			$("#hiddenModalTempPK").val("");
			if(rowData.TEMP_FLAG == "Y"){
				$('#buttonTempSubmit').show();
			}else{
				$('#buttonTempSubmit').hide();
			}
			
			
			//tab 초기화
			$("ul.tabmenu-type li a:first").trigger('click.modalTab');
			
			//코칭톡 버튼 show
			if(rowData.SALES_CYCLE == '5'){
				$("#buttonModalCoachingTalkView").hide();
			}else{
				$("#buttonModalCoachingTalkView").show();
				$('span#spanCtCount').html("("+rowData.COACHING_TALK_COUNT+")");
			}
			
			//키딜 버튼 show, 데이터 세팅
			$("div.modal-header").children().last().show();
			$("hiddenModalKeyDealYN").val(rowData.KEY_DEAL_YN);
			if(rowData.KEY_DEAL_YN == 'Y') {
				$("div.modal-header").children().last().children().eq(0).attr('class', 'fa fa-star fa-2x');
			}else {
				$("div.modal-header").children().last().children().eq(0).attr('class', 'fa fa-star-o fa-2x');
			}
			
			//rebate 전환하기 버튼 sales_cycle이 종료되지 않읂것만
			/* if(rowData.SALES_CYCLE != "5"){
				$('div[name="rebateDiv"]').show();	
			}else{
				$('div[name="rebateDiv"]').hide();
			} */
			
			//기본정보
			$("#hiddenModalPK").val(rowData.OPPORTUNITY_ID);
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
			
			$("#textModalSubject").val(rowData.SUBJECT); //제목
			$("h4.modal-title").html(rowData.SUBJECT); //제목
			
			//매출처
			if(rowData.COMPANY_ID){
	         	$("a[name='aMoveSingleCompany']").remove();
	         	$("#textModalSingleCompany").hide();
	         	$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
	         	$('#liModalSingleCompany').before(
	         			'<li class="value">' +
						'<span class="txt" id="'+rowData.COMPANY_ID+'">'+rowData.COMPANY_NAME+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
						'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+rowData.COMPANY_ID+'&searchDetail='+encodeURI(rowData.COMPANY_NAME)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
			}else{
				$("#textModalSingleCompany").show();				
			}
         	
        	//End User
        	if(rowData.CUSTOMER_ID){
	        	$("#textModalSingleClient").hide();
	         	$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
	         	$('#liModalSingleClient').before(
	         			'<li class="value">' +
						'<span class="txt" id="'+rowData.CUSTOMER_ID+'">'+rowData.CUSTOMER_NAME+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
						'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+rowData.CUSTOMER_ID+'&searchDetail='+encodeURI(rowData.CUSTOMER_NAME)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
        	}else{
        		$("#textModalSingleClient").show();
        	}
         	
			//예상계약금액
			if(!isEmpty(rowData.CONTRACT_AMOUNT)){
				$("#textModalContractAmount").val(add_comma((rowData.CONTRACT_AMOUNT).toString()));
			}else{
				$("#textModalContractAmount").val(0);
			}
			$("#textModalContractDate").val(rowData.CONTRACT_DATE); //계약일
			$("#textModalContractStDate").val(rowData.CONTRACT_ST_DATE); //계약 시작일
			$("#textModalContractEdDate").val(rowData.CONTRACT_ED_DATE); //계약 종료일
			$("#textModalErpOppCode").val(rowData.ERP_OPP_CD); //ERP 영업기회 코드
			$("#textModalErpProjectCode").val(rowData.ERP_PROJECT_CODE); //ERP 프로젝트 코드
			
			//Forecast
			if(isEmpty(rowData.FORECAST_YN)){
				$("input:checkbox[name='checkModalForecastYN']").prop("checked",false);
			}else{
				$("input:checkbox[name='checkModalForecastYN']:checkbox[value='"+rowData.FORECAST_YN+"']").prop("checked",true);	
			}
			
			//ERP 전환
			if(isEmpty(rowData.ERP_OPP_CD) && rowData.SALES_CYCLE != "5"){
				$('[name="erpTag"]').show();
			}else{
				$('[name="erpTag"]').hide();	
			}
			
			//실행임원
			if(rowData.EXEC_ID){
				$("#textModalExecOwner").hide();
				$("#hiddenModalExecId").val(rowData.EXEC_ID);
             	$('#liModalSingleExecOwner').before(
             			'<li class="value">' +
						'<span class="txt" id="'+rowData.EXEC_ID+'">'+rowData.EXEC_NAME+' ['+ rowData.EXEC_POSITION +']</span>' +
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalExecOwner\',\'liModalSingleExecOwner\',\'hiddenModalExecId\');"><i class="fa fa-times-circle"></i></a></li>'
				);	
			}else{
				$("#textModalExecOwner").show();
			}
			
			//Owner
			$("#textModalOpportunityOwner").hide();
			$("#hiddenModalOwnerId").val(rowData.OWNER_ID);
         	$('#liModalSingleOwner').before(
         			'<li class="value">' +
					'<span class="txt" id="'+rowData.OWNER_ID+'">'+rowData.OWNER_NAME+' ['+ rowData.OWNER_POSITION +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityOwner\',\'liModalSingleOwner\',\'hiddenModalOwnerId\');"><i class="fa fa-times-circle"></i></a>'
			);
         	
			//영업대표
			$("#textModalOpportunityIdentifier").hide();
			$("#hiddenModalIdentifierId").val(rowData.IDENTIFIER_ID);
         	$('#liModalSingleIdentifier').before(
         			'<li class="value">' +
					'<span class="txt" id="'+rowData.IDENTIFIER_ID+'">'+rowData.IDENTIFIER_NAME+' ['+ rowData.IDENTIFIER_POSITION +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityIdentifier\',\'liModalSingleIdentifier\',\'hiddenModalIdentifierId\');"><i class="fa fa-times-circle"></i></a>'
			);
			
         	$("#selectModalCategoryCd").val(rowData.CATEGORY_CD); //영업구분
         	$("#selectModalTypeCd").val(rowData.TYPE_CD); //영업유형
         	$("#selectModalProjectForm").val(rowData.PROJECT_FORM_CD); //프로젝트 형태
         	$("#selectModalClientCategoryCd").val(rowData.ERP_CLIENT_CATEGORY_CD); //고객구분
			
         	//고객담당자
         	$("#hiddenModalClientMasterErpCode").val("");
         	$("#divSingleClientMasterErr").hide();
         	$("#aMoveSingleClientMaster").remove();
         	if(rowData.ERP_CLIENT_CD){
				$("#textModalSingleClientMaster").hide();
				$("#hiddenModalClientMaster").val(rowData.ERP_CLIENT_CD);
				$("#hiddenModalClientMasterErpCode").val(rowData.ERP_CLIENT_CODE);
             	$('#liModalSingleClientMaster').before(
             			'<li class="value">' +
						'<span class="txt" id="'+rowData.ERP_CLIENT_CD+'">'+rowData.ERP_CLIENT_NAME+' ['+ rowData.ERP_CLIENT_COMPANY_NAME +']</span>' +
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalSingleClientMaster\',\'liModalSingleClientMaster\',\'hiddenModalClientMaster\',\'hiddenModalClientMasterErpCode\');"><i class="fa fa-times-circle"></i></a></li>' +
						'<a href="/clientManagement/viewClientIndividualInfoDetail.do?customer_id='+rowData.ERP_CLIENT_CD+'&search_detail='+encodeURI(rowData.ERP_CLIENT_NAME)+'" target="_blank" id="aMoveSingleClientMaster" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
         	}else{
         		$("#textModalSingleClientMaster").show();
				$("#hiddenModalClientMaster").val("");
				$("#hiddenModalClientMasterErpCode").val("");
         	}
         	
         	//고객결정권자
         	if(rowData.ERP_CLIENT_DECISION_CD){
				$("#textModalSingleClientDecision").hide();
				$("#hiddenModalClientDecision").val(rowData.ERP_CLIENT_CD);
             	$('#liModalSingleClientDecision').before(
             			'<li class="value">' +
						'<span class="txt" id="'+rowData.ERP_CLIENT_DECISION_CD+'">'+rowData.ERP_CLIENT_DECISION_NAME+' ['+ rowData.ERP_CLIENT_DECISION_COMPANY_NAME +']</span>' +
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalSingleClientDecision\',\'liModalSingleClientDecision\',\'hiddenModalClientDecision\');"><i class="fa fa-times-circle"></i></a></li>'
				);
         	}else{
         		$("#textModalSingleClientDecision").show();
         		$("#hiddenModalClientDecision").val("");
         	}
         	
         	$("#selectModalBuyCd").val(rowData.BUY_CD); //구매방법
         	$("#textareaModalDetailConents").val(rowData.DETAIL_CONENTS); //사업내용
         	$("#textareaModalDiscriminateValue").val(rowData.DISCRIMINATE_VALUE); //차별화가치
         	$("#textModalRoute").val(rowData.ROUTE); //ROUTE
         	
         	//파트너사
         	commonSearch.multiplePartnerArray = [];
			commonSearch.selectMultiplePartner(rowData.SALES_PARTNER, $("#formModalData #hiddenModalPartnerId"), $('#formModalData #ulMultiplePartner'));
         	$("#textModalPartnerRole").val(rowData.PARTNER_ROLE); //파트너사 역할
			
         	//textarea 높이 계산
			textAreaAutoSize($("#textareaModalDetailConents"));
			textAreaAutoSize($("#textareaModalDiscriminateValue"));
			textAreaAutoSize($("#textModalPartnerRole"));
         	
         	//매출 매입 초기화
         	oppProduct.init(false); //false는 reset안함
         	$("#spanSalesTotal").html(0);
			$("#spanPsTotal").html(0);
			$("tbody#tbodySales").find('tr').not('tr.total').remove();
			$("tbody#tbodyPs").find('tr').not('tr.total').remove();
			$("label#salesTable-error").remove();
			$("label#psTable-error").remove();
			$("#textPsAllCompanySeach").show();
			
			//매출품목
         	if(productSalesList.length > 0){
         		for(var i=0; i<productSalesList.length; i++){
         			var salesMap = productSalesList[i];
         			oppProduct.salesAdd();
         			oppProduct.salesSetData(salesMap);
        		}
         	}
         	
			//매입품목
         	if(productPsList.length > 0){
         		$("tbody#tbodyPs").find('tr').not('tr.total').remove();
         		for(var i=0; i<productPsList.length; i++){
         			var psMap = productPsList[i];
         			oppProduct.psAdd();
         			oppProduct.psSetData(psMap);
         		}
         	}
			
         	//매출계획
         	oppSalesPlan.reset();
         	if(salesPlanList.length > 0){
         		for(var i=0; i<salesPlanList.length; i++){
         			var salePlanMap = salesPlanList[i];
         			oppSalesPlan.add();
         			oppSalesPlan.setData(salePlanMap);
         		}
         	}else{
         		oppSalesPlan.add();
         	}
			
         	//매출계획 스플릿
         	oppSalesSplit.reset();
         	if(salesSplitList.length > 0){
         		for(var i=0; i<salesSplitList.length; i++){
         			var saleSplitMap = salesSplitList[i];
         			oppSalesSplit.add();
         			oppSalesSplit.setData(saleSplitMap);
         		}
         	}else{
         		oppSalesSplit.add();
         	}
         	
         	/* oppCheckList.clear();
			oppCheckList.draw(); //체크리스트
			oppCheckList.reload(); //체크리스트 */
			//selectOckList(rowData.OPPORTUNITY_ID);
			
			//oppMilestone.draw(); //마일스톤
			//oppMilestone.reload(); //마일스톤
			milestones.reset();
			milestones.draw(milestonesList);
			
			//영업단계 체크 항목
      		for(var i=0; i<scCheckList.length; i++){
      			var scCheckMap = scCheckList[i];
      			if(scCheckMap.CHECK_YN == "Y"){
      				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).prop("checked",true);	
      				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).val("Y");	
      			}else{
      				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).prop("checked",false);
      				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).val("N");
      			}
        	}
			
			//클로즈된 영업기회는 salesCycle 막고 저장하기 막는다.
			if(rowData.SALES_CYCLE == "5"){
				$("#divSalesCycleClose").show();
				$("#selectSalesCloseCategory").val(rowData.CLOSE_CATEGORY);
				$("#textareaSalesCloseDetail").val(rowData.CLOSE_DETAIL);
				
				$('#buttonModalSubmit').hide(); 
				$('#selectSalesCloseCategory, #textareaSalesCloseDetail').prop("disabled",true);
				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').prop("disabled",true);
				
				$('div.salescycle-step').find('ul li a').eq((rowData.SALES_CYCLE-2)).trigger('click');
				$("div.salescycle-step ul li a").off('click', modalEvent.clickSalesCycle);
				$("#hiddenModalSalesCycleSave").val("5");
			}else{
				
				$("#divSalesCycleClose").hide();
				$("#selectSalesCloseCategory option:first").prop("selected",true);
				$("#textareaSalesCloseDetail").val("");
				$("#textareaSalesCloseDetail").height(1).height(33);
				
				$('#buttonModalSubmit').show();
				$('#selectSalesCloseCategory, #textareaSalesCloseDetail').prop("disabled",false);
				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').prop("disabled",false);
				
				$("div.salescycle-step ul li a").on('click', modalEvent.clickSalesCycle);
				$('div.salescycle-step').find('ul li a').eq((rowData.SALES_CYCLE-1)).trigger('click');
				
				if(rowData.SALES_CYCLE == "4"){ //close일경우
					$("#divSalesCycleClose").show();
					$("#selectSalesCloseCategory").val(rowData.CLOSE_CATEGORY);
					$("#textareaSalesCloseDetail").val(rowData.CLOSE_DETAIL);
				}
				
			}
			//trigger로 안됨
			$("#hiddenModalSalesCycle").val(rowData.SALES_CYCLE);
			
			//승리계획
			selectWinList(winPlanList);
			
			//파일
			commonFile.reset();
			if(!isEmpty(fileList)){
				$("#divFileUploadList span").remove();
				for(var i=0; i<fileList.length; i++){
					$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=6"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
				}
			}else{
				$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
			}
			
			//메일공유 초기화
			$("#formModalData #hiddenModalPartnerId").val("");
			
			//코톡알림 바로가기시 코톡창 바로 보이게 설정 후 코톡창 바로보기 여부 N처리.
			$("#divModalCoachingTalk").hide(); //코톡 숨기기
			if(coaching_talk == 'Y'){
				$("#buttonModalCoachingTalkView").click();
				coaching_talk = 'N';
			}
			
			$("#myModal1").modal();
			
			callback();
		},
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/clientSalesActive/selectOpportunityDetail.do",
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
					oppList.setDetail(data, function(){
						$.ajaxLoadingHide();
						oppProduct.salesSum();
						oppProduct.psSum();
						oppSalesPlan.sum();
						compare_before = $("#formModalData").serialize();							
					});
				},
				complete : function(){
				}
			});
		}
		
}

if(!isEmpty("${param.sales_cycle}")){
	searchSalesCycle = "${param.sales_cycle}";
	//$("ul.nav.nav-tabs").children().eq(searchSalesCycle-1).attr("class", "");
	//$("ul.nav.nav-tabs").children().eq(searchSalesCycle-1).children().first().trigger('click');
	oppList.tabClick(searchSalesCycle, searchSalesCycle-1);
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