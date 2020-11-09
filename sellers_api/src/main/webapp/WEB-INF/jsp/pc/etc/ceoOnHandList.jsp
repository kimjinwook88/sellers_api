<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-6">
        <h2>CEO Check List</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li class="active">
                <strong>CEO Check List</strong>
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
                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompany" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
                        </div>
                        
	                    <div class="col-sm-12 m-b">
                            <label class="control-label" for="date_modified">Opportunity Owner</label>
                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="Owner를 입력해주세요" class="input form-control" id="textSearchOwner" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
                        </div>
                        
	                    <div class="col-sm-12 m-b">
                            <label class="control-label" for="date_modified">예상계약금액 (입력 금액 이상 검색)</label>
                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="예상계약금액을 입력해주세요." class="input form-control" id="textContractAmount" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
                        </div>
                        
                        <div class="col-sm-12 m-b">
	                        <div class="form-group">
	                        	<label>Forecast</label>
	                         	<select class="form-control" id="selectSearchForecast">
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
                        
                        <div class="col-sm-12 m-b">                                    
                            <label class="control-label" for="date_modified">예상계약일</label>
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
                        </div>
                                
                        <div class="col-sm-12 ag_r">
                            <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
                            <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="oppList.reset();oppList.get();"><i class="fa fa-search"></i> 검색</button>
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
                    		<!-- <div class="mg-b20">
                               <ul class="nav nav-tabs pgtop-tabs">
                                   <li class="active"><a href="#" data-toggle="tab">영업기회</a></li>
                                   <li class=""><a href="/clientSalesActive/listHiddenOpportunity.do">잠재영업기회</a></li>
                               </ul>
                           </div> -->
                           
                            	<div class="func-top-left fl_l">
	                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
	                                    <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                    <div class="table-menu" style="z-index:1000;display:none;">
	                                        <ul>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_SOLVE_OWNER" 	checked="checked"> <label for="toggle-col-1">담당자</label></li>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_DIVISION" 		checked="checked"> <label for="toggle-col-2">부서</label></li>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_SUBJECT" 			checked="checked"> <label for="toggle-col-3">제목</label></li>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_MILESTONE" 			checked="checked"> <label for="toggle-col-4">마일스톤</label></li>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_DUE_DATE" 		checked="checked"> <label for="toggle-col-5">예상완료일</label></li>
	                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_STATUS_TEXT" 		checked="checked"> <label for="toggle-col-6">해결상태</label></li>
	                                        </ul>
	                                    </div>
	                            	</div>
	                                
	                             	<%-- <div class="selgrid selgrid1 mg-r5">
	                                   <select class="form-control m-b" id="selectSearchDivision" onclick="searchDivision=$('#selectSearchDivision').val();">
	                                   	<option value="">== 부서선택 ==</option>
		                                    <c:choose>
												<c:when test="${fn:length(searchDetailGroup.member_division) > 0}">
													<c:forEach items="${searchDetailGroup.member_division}" var="searchDetailGroup">
					                                    <option value="${searchDetailGroup.MEMBER_DIVISION}">${searchDetailGroup.DIVISION_NAME}</option>
		                                    		</c:forEach>
		                                    	</c:when>
		                                    </c:choose>
		                               	</select>
		                             </div> --%>
	                               	
		                        	<div class="fl_l" style="padding:8px 0 0 10px; display:none;" id="divSum"></div>
		                        	
		                         </div>
								
								<div class="func-top-right fl_r pd-b20">
									<!-- 
									<div class="fl_l mg-r10">
										<a href="/clientSalesActive/viewOpportunityDashBoard.do" class="btn btn-outline btn-seller-outline">
											<img src="../images/pc/icon_arrow_left_sellers.png" class="mg-r5">대시보드
										</a>
									</div>
									 -->
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
	                            
                     			  <!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->
	                            <table id="tech-companies" class="table table-bordered">
							  		<colgroup>
                                       <%-- <col width="40px"/> --%>
                                        <col width="5%"/>
								        <col width="10%" name="cols_SOLVE_OWNER"/>
								        <col width="10%" name="cols_DIVISION"/>
								        <col width="20%" name="cols_SUBJECT"/>
								        <col width="20%" name="cols_MILESTONE"/>
								        <col width="10%" name="cols_DUE_DATE"/>
								        <col width="5%" name="cols_STATUS_TEXT"/>
                                   </colgroup>
	                              <thead>
	                              <tr id="trCellCount">
	                                  	<th>No</th>
	                                  	<th name="cols_SOLVE_OWNER">담당자</th>
								        <th name="cols_DIVISION">부서</th>
								        <th name="cols_SUBJECT">제목</th>
								        <th name="cols_MILESTONE">마일스톤</th>
								        <th name="cols_DUE_DATE">예상완료일</th>
								        <th name="cols_STATUS_TEXT">해결상태</th>
	                              </tr>
	                              
	                              </thead>
								  <tbody id="row">
								    
			    				  </tbody>
							</table>
						
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
    <span class="mark-ti r2 mg-l10">T</span> 계약조건 
    <span class="mark-ti r2 mg-l10">FC</span> Forecast
    <span class="mark-ti r2 mg-l10">SC</span> Sales Cycle(1-Identify, 2-Qualification, 3-Close) -->
</div>
            
</div>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/etc/ceoOnHandModal.jsp"/>
</body>

<script type="text/javascript">
$(document).ready(function(){
	if(!isEmpty(searchForecast)){
		$("#selectSearchForecast").val(searchForecast);
	}
	
	oppList.init();
	oppList.get();
	
	if(modalReset) {
		modal.reset();
	}
});

var sortCategory;
var columnCount;
var sumFlag = true;
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
var page = {
		start : 0,			   // 0부터 ~
		rowCount : 20,    //10개씩
		totalCount : null  //총 리스트 갯수
}

var opportunity_id = "${param.opportunity_id}";
var returnOpportunityhiddenId = "${param.returnOpportunityhiddenId}";
var returnCompanyId = "${param.returnCompanyId}";
var returnCompanyName = "${param.returnCompanyName}";
var returnCustomerId = "${param.returnCustomerId}";
var returnCustomerName = "${param.returnCustomerName}";
var returnCustomerRank = "${param.returnCustomerRank}";
var returnSubject = "${param.returnSubject}";
var returnOpportunityamount = "${param.returnOpportunityamount}";

var searchDivision = "${param.hiddenDashBoardDivision}";
var searchTeam = "${param.hiddenDashBoardTeam}";
var searchMember = "${param.hiddenDashBoardMember}";
var searchForecast = "${param.hiddenDashBoardForecast}";
var searchCompanyId = "${param.hiddenDashBoardCompanyId}";
var searchDate = "${param.hiddenDashBoardDate}";
var modalReset = "${param.hiddenModalReset}";

var coaching_talk = "${param.coaching_talk}";
var searchSalesCycle;

//sort 기능
$('#tech-companies').on('click','a[name="sortLink"]',function(event){
	event.preventDefault();
	sortCategory = $(this).attr("data-sort")+ " " +$(this).attr("data-method");
	oppList.reset();
	oppList.get();
	if($(this).attr("data-method") == "ASC"){
		$(this).find('img').attr('src','../images/icon_sort_up.png');
		$(this).attr("data-method","DESC");
	}else{
		$(this).find('img').attr('src','../images/icon_sort_down.png');
		$(this).attr("data-method","ASC");
	}
});

var oppList = {
		init : function(){
			//스크롤 끝 이벤트	
			$(window).scroll(function() {
				  if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
				      //페이징 관련 수정 해야함..
					  page.rowCount += 20;
				        if(page.rowCount < page.totalCount+10){
				        	oppList.get();
				        }
				  }
			});
			
			//모달 닫기 이벤트
			$('#myModal1').on('hide.bs.modal', function () {
				compare_after = $("#formModalData").serialize();
				if(modalFlag == "upd" && $('#hiddenModalSalesCycle').val() != '4' ){
					if(compare_before != compare_after){
						if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
							compareFlag = true;
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
			});
			
			//부서선택
			$("#selectSearchDivision").change(function(){
				if(isEmpty($(this).val())){
					oppList.reset();
					oppList.get();
				}else{
					oppList.reset();
					oppList.get();
				}
			});
			
			//잠재영업기회
			if(!isEmpty(returnOpportunityhiddenId)){
				modal.reset();
				$("#formModalData #textCommonSearchCompany").val(returnCompanyName);
				$("#formModalData #textCommonSearchCompanyId").val(returnCompanyId);
				$("#formModalData #textModalCustomerName").val(returnCustomerName);
				$("#formModalData #textModalCustomerRank").val(returnCustomerRank);
				$("#formModalData #textModalSubject").val(returnSubject);
				$("#formModalData #textModalContractAmount").val(returnOpportunityamount);
				$("#formModalData #hiddenModalCompanyId").val(returnCompanyId);
				$("#formModalData #hiddenModalCustomerId").val(returnCustomerId);
				$("#formModalData #hiddenModalOpportunityhiddenId").val(returnOpportunityhiddenId);
			}
			if(!isEmpty(opportunity_id)){
				oppList.goDetail(opportunity_id);
			}
			
			//매출계획 년,분기 초기
			$('#spanListYear').text(commonDate.year);
			$('#spanListQuarter').text(commonDate.quarter);
			
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		//공통 파라미터
		getParams : function(cFlag){
			var params = $.param({
				pageStart : page.start,
				rowCount : page.rowCount,
				sortCategory : sortCategory,
				latelyUpdateTable : "OPPORTUNITY_LOG",
				searchDivision : searchDivision,
				searchTeam : searchTeam,
				searchMember : searchMember,
				searchSumYear : $('#spanListYear').text(),
				searchSumQuarter : $('#spanListQuarter').text(),
				//검색 start
				searchCompany : function(){
					if(!isEmpty($("#textSearchCompany").val())){
						return $("#textSearchCompany").val();
					}else{
						return "${param.hiddenDashBoardCompany}";
					}
				},
				searchCompanyCategory : "${param.hiddenDashBoardCompanyCateogry}",
				searchProduct : "${param.hiddenDashBoardProduct}",
				
				searchOwner : $("#textSearchOwner").val(),
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
				}
			});
			return params;
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start=0;
			//oppList.goDetail($("#hiddenModalPK").val());
			oppList.get();
        	page.start = tmpData;
		},
		
		//리스트 가져오기
		get : function(){
				var listParams = $.param({
					datatype : 'html',
					jsp : '/etc/ceoOnHandListAjax'
				});
				var countParams = $.param({
					datatype : 'json'
				});
				//카운트, 최근업데이트,결과내 검색
				$.ajax({
					url : "/clientSalesActive/selectOpportunityCount.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : oppList.getParams() + "&" + countParams,
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
					}
				});
				
				//리스트
				$.ajax({
					url : "/etc/selectCeoOnHandList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
					data : oppList.getParams() + "&" + listParams,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('tbody#row').html(data);
						$('#spanListYear2').text($('#spanListYear').text());
						$('#spanListQuarter2').text($('#spanListQuarter').text());
						if(sumFlag){
							$('[name="cell_division_sum"]').hide();
						}
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
					}
				});
		},
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/etc/selectCeoOnHandDetail.do",
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
					// gridClientIndividualInfo << 이거랑 같이 쓰고 있는거 같아서 일단 안바꾸고 위의 URL로 가져왔습니다.
					var rowData = data.detail;
					var fileList = data.fileList;
					modalFlag = "upd"; //업데이트
					
					//초기화
					$("#formModalData").validate().resetForm();
					
					$("#hiddenModalPK").val(rowData.OPPORTUNITY_ID);
					$("#textModalSubject").val(rowData.SUBJECT);
					$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					
					//코칭톡 버튼 show
					$("#buttonModalCoachingTalkView").show();
					
					
					//담당자(경농)
					$("#textCommonSearchCompany").val(rowData.EXEC_NAME);
					$("#hiddenModalCompanyId").val(rowData.EXEC_ID);
					
					//예상해결일(경농)
					$("#textModalContractDate").val(rowData.CONTRACT_DATE);
					
					//부서(경농)
					$("#textModalErpProjectCode").val(rowData.ROUTE);
					
					//직급(경농)
					$("#textModalCustomerName").val(rowData.FORECAST_YN);
					
					$("#textareaModalDetailConents").val(rowData.DETAIL_CONENTS);
					$("#textareaModalDiscriminateValue").val(rowData.DISCRIMINATE_VALUE);
					
					$("ul.company-list").html("");
					$("#textCommonSearchPartner").val("");
					commonSearch.partnerArray = [];
					commonSearch.partnerSelect(rowData.SALES_PARTNER);
					
					
					$("h4.modal-title").html(rowData.SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					//tab 초기화
					$("ul.tabmenu-type li a:first").trigger('click.modalTab');
				
					oppMilestone.clear();
					oppMilestone.draw(); //마일스톤
					oppMilestone.reload(); //마일스톤
					
					$('div[name="insertAfterMsg"]').hide();
					
					$("#divModalCoachingTalk").hide(); //코톡 숨기기
					
					$("#myModal1").modal();
				
					//값 비교를 위한.
					compare_before = $("#formModalData").serialize();
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정.
					if(coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
					}
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getSum : function(s){
			var year 		= parseInt($('#spanListYear').text());
			var quarter 	= parseInt($('#spanListQuarter').text());
			
			if(s == "p"){ //다음분기
				if((quarter + 1) > 4){
					year++;
					quarter = 1;
				}else{
					quarter ++;
				}
			}else{ //이전분기
				if((quarter -1) < 1){
					year--;
					quarter = 4;
				}else{
					quarter--;
				}
			}
			$('#spanListYear').text(year);
			$('#spanListQuarter').text(quarter);
			oppList.reset();
			oppList.get(true); //이전, 다음분기 클릭시에
		},
		
		showDivisionSales : function(obj){
			if(sumFlag){
				sumFlag = false;
				$(obj).text("전체 매출");
				
				$('.divisionView').hide();
				$('.basicView').show();
				//체크리스트,마일스톤 보이기
				$('#toggle-col-2,#toggle-col-3,#toggle-col-6').trigger('click'); 
				$('[name="cell_division_sum"]').show();	
			}else{
				sumFlag = true;
				$(obj).text("부서별 매출");
				//체크리스트,마일스톤 숨기기
				
				$('.basicView').hide();
				$('.divisionView').show();
				$('#toggle-col-2,#toggle-col-3,#toggle-col-6').trigger('click'); 
				$('[name="cell_division_sum"]').hide();
			}
		},
		
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