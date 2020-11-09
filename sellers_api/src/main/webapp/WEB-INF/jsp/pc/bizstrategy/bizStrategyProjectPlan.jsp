<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%@ include file="/WEB-INF/jsp/pc/poi/excelDataSampleFilePath.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-4">
        <h2>전략 프로젝트</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a href="#">사업전략</a>
            </li>
            <li class="active">
                <strong>전략 프로젝트</strong>
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
                    		<div class="mg-b20">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="projectList.categoryTab('1',this);">신규솔루션</a></li>
                                    <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="projectList.categoryTab('2',this);">선투자프로젝트</a></li>
                                    <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="projectList.categoryTab('3',this);">전략프로젝트</a></li>
                                </ul>
                            </div>
                            
                        <div class="pos-rel">
							
							<div class="func-top-left fl_l">
								<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
	                                  <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                  <div class="table-menu" style="z-index:1000;display:none;">
	                                      <ul>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" 	value="cols_SUBJECT" 				checked="checked"> <label for="toggle-col-1">프로젝트명</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" 	value="cols_MEMBER_TEAM" 			checked="checked"> <label for="toggle-col-2">본부</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-3"	value="cols_EXEC_OWNER" 			checked="checked"> <label for="toggle-col-3">책임리더</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" 	value="cols_KEY_MILESTONE" 			checked="checked"> <label for="toggle-col-4">마일스톤</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" 	value="cols_STATUS" 				checked="checked"> <label for="toggle-col-5">이슈</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" 	value="cols_PROJECT_DATE" 			checked="checked"> <label for="toggle-col-6">사업기간</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" 	value="cols_AMOUNT_BASIS" 			checked="checked"> <label for="toggle-col-7">매출계획</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" 	value="cols_INVEST_PLAN_BASIS" 		checked="checked"> <label for="toggle-col-8">투자계획</label></li>
	                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" 	value="cols_FILE_COUNT" 			checked="checked"> <label for="toggle-col-9">첨부</label></li>
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
						                            <label class="control-label" for="date_modified">사업기간</label>
						                            <div class="data_1">
						                                <div class="input-group date">
						                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textSearchStartDate" name="textSearchStartDate">
						                                </div>
						                            </div>
						                            <div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
						                            <div class="data_1">
						                                <div class="input-group date">
						                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textSearchEndDate" name="textSearchEndDate">
						                                </div>
						                            </div>
						                        </div>
						                        
						                        <div class="col-sm-12 m-b">
						                            <label class="control-label" for="date_modified">매출계획 (입력 금액 이상 검색)</label>
						                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="매출계획 금액을 입력해주세요" class="input form-control" name="textSearchSalesPlan" id="textSearchSalesPlan" onkeydown="if(event.keyCode == 13){projectList.reset();projectList.get(1);}"></div>
						                        </div>
						                        
						                        <div class="col-sm-12 m-b">
						                            <label class="control-label" for="date_modified">투자계획 (입력 금액 이상 검색)</label>
						                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="투자계획 금액을 입력해주세요" class="input form-control" name="textSearchInvestPlan" id="textSearchInvestPlan" onkeydown="if(event.keyCode == 13){projectList.reset();projectList.get(1);}"></div>
						                        </div>
						                        
						                        <div class="col-sm-12 ag_r">
						                            <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
						                            <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="projectList.reset();projectList.get(1);"><i class="fa fa-search"></i> 검색</button>
						                        </div>
					                        </form>
					                    </div>
					                </div>
					            </div>
  
							<div class="func-top-left fl_l">
                                 <div class="select-com fl_l"><!-- <label>항목선택</label> --> 
                                     <!-- <select class="form-control m-b" name="account" id="selectSearchDivision">
                                	</select> -->
                                 </div>
                                 
                                 <!-- <div class="select-com fl_l mg-l10"><label>항목선택</label> 
                                     <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
                                          <option value="">== 정렬 기준 ==</option>
	                                      <option value="COMPANY_NAME">고객사</option>
	                                      <option value="MEMBER_TEAM">본부</option>
	                                      <option value="EXEC_OWNER">책임리더</option>
	                                      <option value="SALES_OWNER">영업대표</option>
	                                      <option value="STATUS">Status</option>
	                                      <option value="START_DATE">사업시작일</option>
	                                      <option value="END_DATE">사업종료일</option>
	                                      <option value="AMOUNT_BASIS_TOTAL">매출계획</option>
	                                      <option value="INVEST_PLAN_BASIS_TOTAL">투자계획</option>
                                     </select>
                                 </div> -->
                                 
                                 <div class="sales_sum fl_l" style="padding:0px 0 0 10px;display:none;" id="divSum">
                                </div> 
                             </div>

                            <div class="func-top-right fl_r pd-b20">
                            	<div class="fl_l template-doc">
                                    <!-- <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button> -->
                                    <ul class="template-list off">
                                      <!-- <li><a href="#" onclick="selectSampleFile(this);">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li> -->
                                      <li><a href="javascript:void(0);" onclick="downFile.selectSampleFile(this, 'projectBizFile');">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li>
                                    </ul>
                                </div>
                                <div class="fl_l">
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div>
                            </div>
                            
                            
                            <table id="tech-companies" class="table table-bordered">
						  		<colgroup>
						        <%-- <col width="" 	/> --%>
						        <col width="" 	name="cols_SUBJECT" 						/>
						        <col width=""	name="cols_EXEC_OWNER" 				/>
						        <col width=""	name="cols_MEMBER_TEAM" 			/>
						        <col width=""	name="cols_KEY_MILESTONE" 		/>
						        <col width=""	name="cols_STATUS" 						/>
						        <col width=""	name="cols_PROJECT_DATE" 			/>
						        <col width=""	name="cols_AMOUNT_BASIS" 			/>
						        <col width=""	name="cols_INVEST_PLAN_BASIS" 	/>
						        <col width=""	name="cols_FILE_COUNT" 				/>
						    </colgroup>
						    <thead>
						    <tr>
						        <!-- <th>No</th> -->
						        <th name="cols_SUBJECT"><a href="#" class="sortLink" data-sort="TB.SUBJECT" data-method="">프로젝트명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_MEMBER_TEAM"><a href="#" class="sortLink" data-sort="TB.EXEC_DIVISION" data-method="">본부 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_EXEC_OWNER"><a href="#" class="sortLink" data-sort="TB.EXEC_OWNER" data-method="">책임리더 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_KEY_MILESTONE">마일스톤</th>
						        <th name="cols_STATUS">이슈</th>
						        <th name="cols_PROJECT_DATE"><a href="#" class="sortLink" data-sort="TB.START_DATE" data-method="">사업기간 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_AMOUNT_BASIS"><a href="#" class="sortLink" data-sort="TB.AMOUNT_BASIS_TOTAL" data-method="">매출계획(천원) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_INVEST_PLAN_BASIS"><a href="#" class="sortLink" data-sort="TB.INVEST_PLAN_BASIS_TOTAL" data-method="">투자계획(천원) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_FILE_COUNT"><a href="#" class="sortLink" data-sort="TB.FILE_COUNT" data-method="">첨부 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
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

<jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyProjectPlanModal.jsp"/>

</body>

<script type="text/javascript">
$(document).ready(function(){
	projectList.init();
	
	//스크롤 끝 이벤트	
	/* $(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 30;
	        if(page.start < page.totalCount){
	        	projectList.get();
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
					// 이슈 유효성 체크
	                if(!grid.gridValid) return false;
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
		bizPpOppEvent.off();
		milestonesEvent.off();
		compare_before = "";
		compare_after = "";
	});
	
});

var bizProjectId = "${param.bizProjectId}";
var category = "1"; //신규솔루션 기본 값
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
/* var page = {
		start : 0,			   
		rowCount : 30,    
		totalCount : null 
} */

var projectList = {
		sortCategory : null,
		
		init : function(){
			initPaing(10); //페이징 초기화
			//projectList.getDivision();
			projectList.get(1);
			
			if(!isEmpty(bizProjectId)){
				projectList.goDetail(bizProjectId);
			}
			
			/* $("#selectSearchDivision").change(function(){
				if(isEmpty($(this).val())){
					$("div#divSum").hide();
					projectList.reset();
					projectList.get(1);
				}else{
					$("div#divSum").show();
					projectList.reset();
					//projectList.getSum();
					projectList.get(1);
				}
			});
 			*/
 			
			/* $("#selectSortCategory").change(function(){
				if(page.totalCount > 0){
					projectList.reset();
					projectList.get(1);
				}
			}); */
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				//쿼리가 복잡해서..
				var statusFiled =  "CASE" + 
							            " WHEN CONCAT(IFNULL(TB.STATUS_PREV,''),IFNULL(TB.STATUS_ING,''),IFNULL(TB.STATUS_NEXT,'')) LIKE '%R%' THEN 'red' " +
							            " WHEN CONCAT(IFNULL(TB.STATUS_PREV,''),IFNULL(TB.STATUS_ING,''),IFNULL(TB.STATUS_NEXT,'')) LIKE '%Y%' THEN 'yellow' " +
							            " WHEN CONCAT(IFNULL(TB.STATUS_PREV,''),IFNULL(TB.STATUS_ING,''),IFNULL(TB.STATUS_NEXT,'')) LIKE '%G%' THEN 'green' " +
							            " ELSE NULL" +
							       " END";
						          
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					if($(this).attr("data-sort") == "TB.STATUS"){ //status 색상 정렬 예외
						projectList.sortCategory = statusFiled + " is null ASC," + "FIELD("+statusFiled+",'green','yellow','red',null)"
					}else{
						projectList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					if($(this).attr("data-sort") == "TB.STATUS"){ //status 색상 정렬 예외
						projectList.sortCategory = statusFiled + " is null ASC," + "FIELD("+statusFiled+",'red','yellow','green',null)"
					}else{
						projectList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					projectList.sortCategory = "";
				}
				
				projectList.reset();
				projectList.get();
			});
			
		},
		
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		categoryTab : function(val,obj){
			$('a.sortLink').attr("data-method","");
			$('a.sortLink').find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
			projectList.sortCategory = "";
			
			$("ul.nav.nav-tabs li").removeClass();
			$(obj).parent('li').addClass('active');
			$("div#divSum").hide();
			
			category = val;
			//1 신규솔루션
			//2 선투자프로젝트
			//3 전략프로젝트
			
			projectList.reset();
			//projectList.searchReset();
			//projectList.getDivision();
			projectList.get(1);
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start=0;
			//projectList.goDetail($("#hiddenModalPK").val());
			projectList.get(1);
        	page.start = tmpData;
		},
		
		//공통 파라미터
		/* getParams : function(){
			var params = {
				pageStart : page.start,
				pageEnd : page.end,
				latelyUpdateTable : "BIZ_PROJECT_PLAN",
				//sortCategory : $("#selectSortCategory").val(),
				searchCategory :category,
				searchDivision : $("#selectSearchDivision").val(),
				searchStartDate : $("#textSearchStartDate").val(),
				searchEndDate : $("#textSearchEndDate").val(),
				searchSalesPlan : $("#textSearchSalesPlan").val(),
				searchInvestPlan : $("#textSearchInvestPlan").val(),
				searchPKArray : searchPKArray,
				resultInSearch : function(){
					if($("#result-in-search").is(":checked")){
						return "Y";
					}else{
						return "N";
					}
				},
				sortCategory : projectList.sortCategory
			};
			return params;
		}, */
		
		//리스트 가져오기
		get : function(pn, ep){
				var paramsDatatype = $.param({
					datatype : 'json'
				});
				
				var params = {
						pageStart : page.start,
						pageEnd : page.end,
						latelyUpdateTable : "BIZ_PROJECT_PLAN",
						//sortCategory : $("#selectSortCategory").val(),
						searchCategory :category,
						//searchDivision : $("#selectSearchDivision").val(),
						searchStartDate : $("#textSearchStartDate").val(),
						searchEndDate : $("#textSearchEndDate").val(),
						searchSalesPlan : $("#textSearchSalesPlan").val(),
						searchInvestPlan : $("#textSearchInvestPlan").val(),
						searchPKArray : searchPKArray,
						resultInSearch : function(){
							if($("#result-in-search").is(":checked")){
								return "Y";
							}else{
								return "N";
							}
						},
						sortCategory : projectList.sortCategory
				};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/bizStrategy/selectProjectPlanCount.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : paramsDatatype + '&' + $.param(params) + "&" + $.param(page) + "&" + $.param(pagingParams),
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
						data.fncName = 'projectList.get';
						pageCreateNavi(data);
					},
					complete : function(){
					}
				});
				
				paramsDatatype = $.param({
					datatype : 'html',
					jsp : '/bizstrategy/bizStrategyProjectPlanAjax'
				});
				
				//리스트
				$.ajax({
					url : "/bizStrategy/selectProjectPlanList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
					data : paramsDatatype + '&' + $.param(params) + "&" + $.param(page) + "&" + $.param(pagingParams),
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
		
		getDivision : function(){
			var params = $.param({
				datatype : 'json',
				searchDivision : category
			});
			
			$.ajax({
				url : "/bizStrategy/selectProjectPlanDivision.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					//부서별 그룹
					/* if(!isEmpty(data.searchDetailGroup.division)){
						var divisionOp = data.searchDetailGroup.division;
						$("#selectSearchDivision").html('');
						$("#selectSearchDivision").append('<option value="">== 부서선택 ==</option>');
						for(var i=0; i<divisionOp.length; i++){
							$("#selectSearchDivision").append('<option value="'+divisionOp[i].DIVISION_NO+'">'+divisionOp[i].DIVISION_NAME+'</option>');
						}
					}else{
						$("#selectSearchDivision").html('');
						$("#selectSearchDivision").append('<option value="">== 부서선택 ==</option>');
					} */
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getSum : function(){
			var params = $.param({
				datatype : 'json',
				//searchDivision : $("#selectSearchDivision").val(),
				searchCategory :category
			});
			
			$.ajax({
				url : "/bizStrategy/selectProjectPlanSum.do",
				async : false,
				data : params,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					var sumMap = data.selectProjectPlanSum;
					$('div#divSum').html('<span>'+sumMap.MEMBER_TEAM+' 매출계획 합계 :</span> <strong> '+add_comma((sumMap.AMOUNT_BASIS_TOTAL).toString())+'원</strong><br /><span>'+sumMap.MEMBER_TEAM+' 투자계획 합계 : </span><strong>'+add_comma((sumMap.INVEST_PLAN_BASIS_TOTAL).toString())+'원</strong>');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goDetail : function(pkNo){
			var params = $.param({
				datatype : 'json',
				pkNo : pkNo
			});
			
			//상세보기로 gogo.
			$.ajax({
				url : "/bizStrategy/selectProjectPlanDetail.do",
				async : false,
	 			datatype : 'json',
				mtype: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					// gridClientIndividualInfo << 이거랑 같이 쓰고 있는거 같아서 일단 안바꾸고 위의 URL로 가져왔습니다.
					var rowData = data.detail;
					var fileList = data.fileList;
					var oppList = data.oppList;
					var milestonesList = data.milestonesList;
					
					//EVENT ON
					modalEvent.on();
					bizPpOppEvent.on();
					milestonesEvent.on();
					
					$("div.autocomplete-suggestions").hide();
					$("#formModalData").validate().resetForm();
					$("ul.flexdatalist-multiple li.value").remove();
					
					modalFlag = "upd"; //업데이트
					
					//고객사
					$("a[name='aMoveSingleCompany']").remove();
	             	$("#textCommonSearchCompany").hide();
	             	$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
	             	$('#liModalSingleCompany').before(
	             			'<li class="value">' +
							'<span class="txt" id="'+rowData.COMPANY_ID+'">'+rowData.COMPANY_NAME+'</span>' +
							'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
							'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+rowData.COMPANY_ID+'&searchDetail='+encodeURI(rowData.COMPANY_NAME)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
					);
	             	
	             	//책임리더
	             	$("#textModalExecutionOwner").hide();
	    			$("#hiddenModalExecutionOwner").val(rowData.EXEC_OWNER_ID);
	             	$('#liModalSingleExecutionOwner').before(
	             			'<li class="value">' +
	    					'<span class="txt" id="'+rowData.EXEC_OWNER_ID+'">'+rowData.EXEC_OWNER+' ['+ rowData.EXEC_OWNER_POSITION +']</span>' +
	    					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalExecutionOwner\',\'liModalSingleExecutionOwner\',\'hiddenModalExecutionOwner\');"><i class="fa fa-times-circle"></i></a>'
	    			);
	             	
	             	//영업대표
	             	$("#textModalSalesOwner").hide();
	    			$("#hiddenModalSalesOwner").val(rowData.SALES_OWNER_ID);
	             	$('#liModalSingleSalesOwner').before(
	             			'<li class="value">' +
	    					'<span class="txt" id="'+rowData.SALES_OWNER_ID+'">'+rowData.SALES_OWNER+' ['+ rowData.SALES_OWNER_POSITION +']</span>' +
	    					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalSalesOwner\',\'liModalSingleSalesOwner\',\'hiddenModalSalesOwner\');"><i class="fa fa-times-circle"></i></a>'
	    			);
	             	
					
					$("#textModalTotalContractAmount").attr("disabled", true);
					$("#textModalTotalContractAmount").val("시작, 종료일를 선택해 주세요.");
					$("#selectModalContractAmount").attr("disabled", true);
					$("#selectModalContractAmount").val("");
					$("#divModalContractAmountRe").css("display", "none");
					
					$("#textModalTotalInvestAmount").attr("disabled", true);
					$("#textModalTotalInvestAmount").val("시작, 종료일를 선택해 주세요.");
					$("#selectModalInvestAmount").attr("disabled", true);
					$("#selectModalInvestAmount").val("");
					$("#divModalInvestAmountRe").css("display", "none");
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					//$("#divModalTextName").val(rowData.HAN_NAME);
					//$("#divModalCreateDate").val(rowData.SYS_REGISTER_DATE);
					$("#textModalSubject").val(rowData.SUBJECT);
					$("#selectModalCategory").val(rowData.Category);
					$("#textModalDivision").val(rowData.EXEC_DIVISION);					
					$("#textModalStartDate").val(rowData.START_DATE);
					$("#textModalEndDate").val(rowData.END_DATE);
					if($("#textModalStartDate").val()!="" && $("#textModalEndDate").val()!="") {
						$("#selectModalContractAmount").attr("disabled", false);
						$("#textModalTotalContractAmount").val("주기를 선택해 주세요.");
						$("#selectModalInvestAmount").attr("disabled", false);
						$("#textModalTotalInvestAmount").val("주기를 선택해 주세요.");
					}
					
					
					//modalAmount.disable();
					params = $.param({
						datatype : 'json',
						project_id : rowData.PROJECT_ID
					});
					
					$.ajax({
						url : "/bizStrategy/selectProjectPlanInfo.do",
						async : false,
						datatype : 'json',
						type : "POST",
						data : params,
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
			            	$.ajaxLoadingShow();
						},
						success : function(data) {
							if(rowData.CONTRACT_AMOUNT_UNIT!="") {
								$("#divModalContractAmountRe").css("display", "");
								$("#selectModalContractAmount").attr("disabled", false);
								$("#selectModalContractAmount").val(rowData.CONTRACT_AMOUNT_UNIT);
								modalAmount.setting("Contract");
								$("#textModalTotalContractAmount").val(String(rowData.CONTRACT_AMOUNT_TOTAL).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
								for(var i=0; i<data.selectProjectPlanContractInfo.length; i++) {
									var planAmount = String(data.selectProjectPlanContractInfo[i].BASIS_PLAN_REVENUE_AMOUNT);
									var actualAmount = String(data.selectProjectPlanContractInfo[i].BASIS_ACTUAL_REVENUE_AMOUNT);
									$("#textModalContractPlanAmount"+i).val(planAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									$("#textModalContractActualAmount"+i).val(actualAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									if($("#textModalContractPlanAmount"+i).val()=="undefined") $("#textModalContractPlanAmount"+i).val("0");
									if($("#textModalContractActualAmount"+i).val()=="undefined") $("#textModalContractActualAmount"+i).val("0");
								}
							}
							if(rowData.INVEST_AMOUNT_UNIT!="") {
								$("#divModalInvestAmountRe").css("display", "");
								$("#selectModalInvestAmount").attr("disabled", false);
								$("#selectModalInvestAmount").val(rowData.INVEST_AMOUNT_UNIT);
								modalAmount.setting("Invest");
								$("#textModalTotalInvestAmount").val(String(rowData.INVEST_AMOUNT).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
								for(var i=0; i<data.selectProjectPlanInvestInfo.length; i++) {
									var planAmount = String(data.selectProjectPlanInvestInfo[i].BASIS_PLAN_INVEST_AMOUNT);
									var actualAmount = String(data.selectProjectPlanInvestInfo[i].BASIS_ACTUAL_INVEST_AMOUNT);
									$("#textModalInvestPlanAmount"+i).val(planAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									$("#textModalInvestActualAmount"+i).val(actualAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									if($("#textModalInvestPlanAmount"+i).val()=="undefined") $("#textModalInvestPlanAmount"+i).val("0");
									if($("#textModalInvestActualAmount"+i).val()=="undefined") $("#textModalInvestActualAmount"+i).val("0");
								}
							}
						},
						complete : function() {
							$.ajaxLoadingHide();
						}
					});
					
					$("#textareaModalDetailContents").val(rowData.DETAIL_CONTENTS);	//프로젝트개요
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalDetailContents"));
					
					$("#textModalSubject").val(rowData.SUBJECT);
					$("#hiddenModalPK").val(rowData.PROJECT_ID.toString());
					$("#hiddenModalProjectId").val(rowData.PROJECT_ID);
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=2"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("h4.modal-title").html(rowData.SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					$("#buttonModalDelete").show();
					
					//영업기회 초기화
					bizPpOpp.reset();
					if(oppList.length > 0){
						for(var i=0; i<oppList.length; i++){
							bizPpOpp.add(oppList[i]);
						}
					}
					
					//milestone
					milestones.reset();
					milestones.draw(milestonesList);
					//mileStones.clear();
					//mileStones.draw();
					//mileStones.reload();
					
					/* actionPlan.clear();
					actionPlan.draw();
					actionPlan.reload(); */
					grid.gridReset();
					grid.gridGetList();
					
					//모달 탭초기화.
					$("ul.tabmenu-type li a").removeClass("sel");
					$("ul.tabmenu-type > li:nth-child(1) > a").addClass("sel");
					$("div.modaltabmenu").addClass("off");
					$("div.modaltabmenu").eq(0).removeClass("off");
					
					$("#myModal1").modal();
					
					setTimeout(function(){
						compare_before = $("#formModalData").serialize();
						$.ajaxLoadingHide();
					},300);
				},
				complete : function(){
				}
			});
		}
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>