<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 06 - 02
 * @explain	: 파트너사 협업 -> 파트너 스킬 및 교육
 -->	
		<div class="row wrapper border-bottom white-bg page-heading">
		    <!-- <div class="col-sm-6">
		        <h2>파트너 교육</h2>
		        <ol class="breadcrumb">
		            <li>
		                <a href="/main/index.do">Home</a>
		            </li>
		            <li>
		                <a>파트너사협업관리</a>
		            </li>
		            <li class="active">
		                <strong>파트너 교육</strong>
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
                              	     	<li class=""><a href="/partnerManagement/viewPartnerSales.do">1.파트너 현황</a></li>
                            	        <li class=""><a href="/partnerManagement/viewPartnerRecruitment.do">2.Recruitment</a></li>
                         	            <li class="active"><a href="/partnerManagement/viewPartnerEnablement.do">3.파트너 교육</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerSalesLinkage.do">4.파트너 협업</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerFullfillment.do">5.파트너사 비지니스 현황</a></li>
                      	            </ul>
                           		</div> 
                           		
		                        <div class="pos-rel">
		                            <div class="func-top-left fl_l">
		                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
		                                    <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
		                                    <div class="table-menu" style="z-index:1000;display:none;">
		                                        <ul>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" value="cols_EDU_AREA" checked="checked"> <label for="toggle-col-1">교육영역</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" value="cols_EDU_SUBJECT" checked="checked"> <label for="toggle-col-2">제목</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_EDU_TARGET" checked="checked"> <label for="toggle-col-3">교육목표</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_START_DATE" checked="checked"> <label for="toggle-col-4">시작일</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_END_DATE" checked="checked"> <label for="toggle-col-5">종료일</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_EDU_BUDGET" checked="checked"> <label for="toggle-col-6">교육예산</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cols_EDU_KIND" checked="checked"> <label for="toggle-col-7">신규구분</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_SAT_VALUE" checked="checked"> <label for="toggle-col-8">만족도 평가</label></li>
		                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_FILE_COUNT" checked="checked"> <label for="toggle-col-8">파일</label></li>
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
							                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompanyName" name="textSearchCompanyName" onkeydown="if(event.keyCode == 13){enableList.reset();enableList.get();}"></div>
							                              </div>
							                              
							                               <div class="col-sm-12 ag_r">
							                                   <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
							                                   <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="enableList.reset();enableList.get();"><i class="fa fa-search"></i>검색</button>
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
								        <col width=""/>
								        <col width="" name="cols_EDU_AREA"/>
								        <col width="" name="cols_EDU_SUBJECT"/>
								        <col width="" name="cols_EDU_TARGET"/>
								        <col width="" name="cols_START_DATE"/>
								        <col width="" name="cols_END_DATE"/>
								        <col width="" name="cols_EDU_BUDGET"/>
								        <col width="" name="cols_EDU_KIND"/>
								        <col width="" name="cols_SAT_VALUE"/>
								        <col width="" name="cols_FILE_COUNT"/>
								    </colgroup>
								    <thead>
								    <tr>
								        <th>No</th>
								        <th name="cols_EDU_AREA">교육영역</th>
								        <th name="cols_EDU_SUBJECT">제목</th>
								        <th name="cols_EDU_TARGET">교육목표</th>
								        <th name="cols_START_DATE">시작일</th>
								        <th name="cols_END_DATE">종료일</th>
								        <th name="cols_EDU_BUDGET">교육예산</th>
								        <th name="cols_EDU_KIND">신규구분</th>
								        <th name="cols_SAT_VALUE">만족도 평가</th>
								        <th name="cols_FILE_COUNT">파일</th>
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
		
  		<jsp:include page="/WEB-INF/jsp/pc/partnerManagement/partnerCooperationEnablementModal.jsp"/>
		
		<form id="formSampleFile" name="formSampleFile" method="post">
		 	<input type="hidden" name="sampleFileName" value=""/>
		</form>
		
</body>


<script type="text/javascript">
$(document).ready(function(){
	
	//$("#menu_title_1").html('파트너교육');
	//$("#menu_title_2").html('파트너교육');
	
	enableList.init();
	enableList.get();
	
	//스크롤 끝 이벤트	
	$(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 30;
	        if(page.start < page.totalCount){
	        	enableList.get();
	        }
	    }
	});
	
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
	});
	
});

var params;
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
var page = {
		start : 0,			   // 0부터 ~
		rowCount : 30,    //20개씩
		totalCount : null  //총 리스트 갯수
}

var returnEnablementPK = "${param.returnPK}";

var enableList = {
		init : function(){
			$("#selectSortCategory").change(function(){
				enableList.reset();
				enableList.get();
			});
			
			//파트너 교육
			if(returnEnablementPK){
				enableList.goDetail(returnEnablementPK);
			}
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
			enableList.goDetail($("#hiddenModalPK").val());
			enableList.get();
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(searchFlag){
				params = $.param({
									pageStart : page.start,
									rowCount : page.rowCount,
									latelyUpdateTable : "PARTNER_ENABLE_PLAN",
									sortCategory : $("#selectSortCategory").val(),
									searchCompanyName : $("#textSearchCompanyName").val(),
									searchAll : $("#textSearchDetail").val(),
									searchPKArray : searchPKArray,
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
									datatype : 'json'
								});
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/partnerManagement/selectEnablementCount.do",
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
				
				
				params2 = $.param({
					pageStart : page.start,
					rowCount : page.rowCount,
					latelyUpdateTable : "PARTNER_ENABLE_PLAN",
					sortCategory : $("#selectSortCategory").val(),
					searchCompanyName : $("#textSearchCompanyName").val(),
					searchAll : $("#textSearchDetail").val(),
					searchPKArray : searchPKArray,
					resultInSearch : function(){
						if($("#result-in-search").is(":checked")){
							return "Y";
						}else{
							return "N";
						}
					},
					datatype : 'html',
					jsp : '/partnerManagement/partnerCooperationEnablementAjax'
				});
				
				//리스트
				$.ajax({
					url : "/partnerManagement/gridEnablement.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
					data : params2,
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
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/partnerManagement/selectEnablementDetail.do",
				async : false,
	 			datatype : 'json',
				mtype: 'POST',
				data : {
					pkNo : pkNo,
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var rowData = data.detail;
					var fileList = data.fileList;
					modalFlag = "upd"; //업데이트
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					
					$("#hiddenModalPK").val(rowData.EDU_PLAN_ID);					
					$("#textModalSubject").val(rowData.EDU_SUBJECT);
					$("#textModalTextName").val(rowData.HAN_NAME);
					$("#textModalCreateDate").val(rowData.SYS_REGISTER_DATE);
					$("#textModalUpdateDate").val(rowData.SYS_UPDATE_DATE);
					
					$("#selectModalEduArea").val(rowData.EDU_AREA);
					$("input:radio[name='radioModalEduKind']:radio[value='"+rowData.EDU_KIND+"']").attr("checked",true);
					$("#textModalEduTarget").val(rowData.EDU_TARGET);
					$("#textModalEduBudget").val(rowData.EDU_BUDGET);
					$("#textModalStartDate").val(rowData.START_DATE);
					$("#textModalEndDate").val(rowData.END_DATE);
					$("#textModalTotalHours").val(rowData.TOTAL_HOURS);
					$("#textareaEduContent").text(rowData.EDU_CONTENT);	//교육내용
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaEduContent"));
					
					$("#buttonModalDelete").show();
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("h4.modal-title").html(rowData.EDU_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					$("#myModal1").modal();
					mileStones.draw();
					mileStones.reset();
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

<%--         
<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var searchSerialize;
var modalFlag = "ins/upd"; //추가 수정 변수
var listRow = 10;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;

//$("#buttonModalSubmit").trigger("click");
$(document).ready(function() {
	//그리드 생성
	jqGrid.draw();
	$sellersGrid.css("cursor","pointer");
	
	//그리드 크기를 가져올 변수
	gridWidth = $sellersGrid.jqGrid('getGridParam', 'width');
	
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}
			}
		}
		$("#divModalFile p").hide();
	});
});

/*
 *  jqGrid function()
 */
var jqGrid = {
	draw : function() {
		$sellersGrid.jqGrid({
 			url : "/partnerManagement/gridEnablement.do?",
			datatype : 'json',
			 jsonReader : { 
			    root: "rows"
			},
			colModel : [ 
			   {
				label : 'No',
				name : 'ROWNUM',
				align : "center",
				width : 50
			}, {
				label : '교육영역',
				name : 'EDU_AREA',
				align : "center",
				width : 120
			}, {
				label : '제목',
				name : 'EDU_SUBJECT',
				align : "center",
				width : 200
			}, {
				label : '교육목표',
				name : 'EDU_TARGET',
				align : "center",
				width : 180
			},{
				label : '시작일',
				name : 'START_DATE',
				align : "center",
				width : 100
			},{
				label : '종료일',
				name : 'END_DATE',
				align : "center",
				width : 100
			},{
				label : '교육예산',
				name : 'EDU_BUDGET',
				align : "center",
				width : 100,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					return add_comma(String(colpos.EDU_BUDGET));
				}
			}, {
				label : '신규구분',
				name : 'EDU_KIND',
				align : "center",
				width : 100,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(colpos.EDU_KIND == "new"){
						return "신규";
					}else if(colpos.EDU_KIND == "exi"){
						return "기존";
					}
				}
			}, {
				label : '만족도 평가',
				name : 'SAT_VALUE',
				width : 100,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					var sat_text = "" 
					switch (colpos.SAT_VALUE) {
					case 0:
						sat_text = "만족"
						break;
					case 1:
						sat_text = "보통"
						break;
					case 2:
						sat_text = "불만족"
						break;
					}
					return sat_text; 
				}
			}, {
				label : '파일',
				label : '첨부',
				align : "center",
				name : 'FILES',
				index : "FILES",
				width : 100,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					return '<span id=file'+colpos.EDU_PLAN_ID+'></span>'; 
				}
			}, {
				label : 'EDU_PLAN_ID',
				name : 'EDU_PLAN_ID',
				hidden : true
			}, {
				label : 'CREATOR_ID',
				name : 'CREATOR_ID',
				hidden : true
			},{
				label : 'SYS_REGISTER_DATE',
				name : 'SYS_REGISTER_DATE',
				hidden : true
			},{
				label : 'SYS_UPDATE_DATE',
				name : 'SYS_UPDATE_DATE',
				hidden : true
			},{
				label : 'EDU_CONTENT',
				name : 'EDU_CONTENT',
				hidden : true
			},{
				label : 'START_DATE',
				name : 'START_DATE',
				hidden : true
			},{
				label : 'END_DATE',
				name : 'END_DATE',
				hidden : true
			},{
				label : 'TOTAL_HOURS',
				name : 'TOTAL_HOURS',
				hidden : true
			},{
				label : 'HAN_NAME',
				name : 'HAN_NAME',
				hidden : true
			}
			//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
			],
			loadui: 'disable',
			loadonce : true,
			viewrecords : true,
			rowNum : 10,
			gridview: true,	
			//rowList : [ 10, 20, 30 ],
			height : "100%",
			autowidth : true,
			//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
			pager : '#pager',
			onCellSelect : function(ids, icol) {
				if(icol == 10) {
					return;
				}else {
					var rowData = $(this).jqGrid("getRowData",ids);
					modalFlag = "upd"; //업데이트
					$("#hiddenModalPK").val(rowData.EDU_PLAN_ID);					
					$("#textModalSubject").val(rowData.EDU_SUBJECT);
					$("#textModalTextName").val(rowData.HAN_NAME);
					$("#textModalCreateDate").val(rowData.SYS_REGISTER_DATE);
					$("#textModalUpdateDate").val(rowData.SYS_UPDATE_DATE);
					
					$("#selectModalEduArea").val(rowData.EDU_AREA);
					$("input:radio[name='radioModalEduKind']:radio[value='"+rowData.EDU_KIND+"']").attr("checked",true);
					$("#textModalEduTarget").val(rowData.EDU_TARGET);
					$("#textModalEduBudget").val(rowData.EDU_BUDGET);
					$("#textModalStartDate").val(rowData.START_DATE);
					$("#textModalEndDate").val(rowData.END_DATE);
					$("#textModalTotalHours").val(rowData.TOTAL_HOURS);
					$("#textareaEduContent").text(rowData.EDU_CONTENT);
					
					
					$("#buttonModalDelete").show();
					$("#divModalFile").show();
					$("#divFileUploadArea .fileModalUploadFile").remove();
					$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
					$("#divModalFile p[name='modalFile"+rowData.EDU_PLAN_ID+"']").show();
					
					$("h4.modal-title").html(rowData.ISSUE_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					$("#myModal1").modal();
					mileStones.draw();
					mileStones.reset();
					compare_before = $("#formModalData").serialize();
					//값 비교를 위한.
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
				//No Data 처리 bottom.jsp
				noDataFn(this);
				$.ajaxLoading();
				
				/* 결과 내 검색을 위한 작업 */ 
				var pkArray = [];
			    for(var key in data.rows) {
			      if(data.rows[key].EDU_PLAN_ID) {
			    	  pkArray.push(data.rows[key].EDU_PLAN_ID);
			      } 
			    }
			    $("#formSearch #hiddenSearchTypePKArray").val(pkArray);
			    
			    /* 파일 아이콘 처리 작업*/
			    var filePKArray = [];
			    var rowData = $(this).jqGrid('getRowData');
			    for(var i=0; i<rowData.length; i++){
			    	filePKArray.push(rowData[i].EDU_PLAN_ID);
			    }
			    $("#formSearch #hiddenFilePK").val(filePKArray);
			    
			    $.ajax({
			    	url: "/partnerManagement/enablementFileList.do",
			    	data : $("#formSearch").serialize(),
			    	beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
			    	},
			    	success : function(result){
			    		var fileList = result.enablementFileList;
			    		$("#divModalFile > p").remove();
			    		for(var i=0; i<fileList.length; i++){
			    			var fileType = fileList[i].FILE_TYPE.toLowerCase();
			    			if(fileType == '.jpg' || fileType == '.png' || fileType == '.gif'){
			    				$("#file"+fileList[i].EDU_PLAN_ID).append('<a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-image-o fa-lg"></i></a> ');
			    				$("#divModalFile").append('<p name="modalFile'+fileList[i].EDU_PLAN_ID+'" style="display:none;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-image-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></p>');
			    			}else if(fileType == '.xlsx' || fileType == '.xls'){
			    				$("#file"+fileList[i].EDU_PLAN_ID).append('<a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-excel-o fa-lg"></i></a> ');
			    				$("#divModalFile").append('<p name="modalFile'+fileList[i].EDU_PLAN_ID+'" style="display:none;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-excel-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></p>');
			    			}else if(fileType == '.pdf'){
			    				$("#file"+fileList[i].EDU_PLAN_ID).append('<a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-pdf-o fa-lg"></i></a> ');
			    				$("#divModalFile").append('<p name="modalFile'+fileList[i].EDU_PLAN_ID+'" style="display:none;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-pdf-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></p>');
			    			}else if(fileType == '.ppt' || fileType == '.pptx'){
			    				$("#file"+fileList[i].EDU_PLAN_ID).append('<a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-powerpoint-o fa-lg"></i></a> ');
			    				$("#divModalFile").append('<p name="modalFile'+fileList[i].EDU_PLAN_ID+'" style="display:none;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-powerpoint-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></p>');			    				
			    			}else if(fileType == '.doc' || fileType == '.docx' || fileType == '.hwp' || fileType == '.txt'){
			    				$("#file"+fileList[i].EDU_PLAN_ID).append('<a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-word-o fa-lg"></i></a> ');
			    				$("#divModalFile").append('<p name="modalFile'+fileList[i].EDU_PLAN_ID+'" style="display:none;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=7"><i class="fa fa-file-word-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></p>');											    				
			    			}
			    		}
			    		setTimeout(function(){$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();},300); //ajax Loading
			    	},
			    	complete : function(){
					$.ajaxLoadingHide();
					}
			    });
			    
			    /* 더 보기 옆 페이지 값 */
			    $("#spanTotalCount").html($sellersGrid.jqGrid('getGridParam', 'records'));
			    $("#spanCurrentCount").html($sellersGrid.jqGrid('getGridParam', 'reccount'));
			    
			    /* 최근 업데이트 */
			    if(data.rows.length > 0){
			    	$("#LATELY_UPDATE_DATE").html(data.rows[0].LATELY_UPDATE_DATE);	
			    }
			},
			loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
			}
		}).jqGrid('setGroupHeaders', {
			  useColSpanStyle: true, 
			  groupHeaders:[
				          	{startColumnName: 'STATUS1', numberOfColumns: 4, titleText: '체크리스트'},
			  ]
		});
	}
}

/*
 * 항목보기 설정
 */
$(".table-menu-wrapper input[name='toggle-cols']").click(function(){
	if($(this).is(":checked")){
		$('#sellersGrid').showCol($(this).val());
		$sellersGrid.jqGrid('setGridWidth', gridWidth, true);
	}else{
		$sellersGrid.hideCol($(this).val());
		$sellersGrid.jqGrid('setGridWidth', gridWidth, true);
	}
});

 /*
  *  더 보기
  */
$("#moreList").click(function(){
	listRow+=10;
 	if(listRow > ($sellersGrid.jqGrid('getGridParam', 'records')+10)){
  		return;
 	}
 	$.ajaxLoading();
 	$("#divModalFile p").remove();
 	$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridEnablement.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
});

/*
 *  항목보기
 */
 $("#table-menu-btn").click(function(){
	 $("div.table-menu-wrapper .table-menu").toggle();
 });
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%> --%>