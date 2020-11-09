<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
	<!-- <div class="col-sm-4">
		<h2>제안서정보</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li><a>성과관리</a></li>
			<li class="active"><strong>제안서정보</strong></li>
		</ol>
	</div> -->
	<div class="col-sm-6">
		<div class="time-update">
			<span class="text-muted small pull-right">최근 업데이트: <i
				class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
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
									<a href="#" class="table-menu-btn" id="table-menu-btn"><i
										class="fa fa-th-list"></i> 항목보기 설정</a>
									<div class="table-menu" style="z-index: 1000; display: none;">
										<ul>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-1" value="cols_CATEGORY_BIZ"
												checked="checked"> <label for="toggle-col-1">
													제안영역</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-2" value="cols_COMPANY_NAME"
												checked="checked"> <label for="toggle-col-2">
													고객사</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-3" value="cols_CUSTOMER_NAME"
												checked="checked"> <label for="toggle-col-3">고객명</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-4" value="cols_CATEGORY_PRODUCT"
												checked="checked"> <label for="toggle-col-4">제안제품</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-5" value="cols_PROPOSAL_SUBJECT"
												checked="checked"> <label for="toggle-col-5">제안제목</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-6" value="cols_PROPOSAL_LEADER"
												checked="checked"> <label for="toggle-col-6">제안책임자</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-7" value="cols_PROPOSAL_COST_AMOUNT"
												checked="checked"> <label for="toggle-col-7">제안COST</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-8" value="cols_PROPOSAL_AMOUNT"
												checked="checked"> <label for="toggle-col-8">제안금액</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-9" value="cols_PROPOSAL_END_DATE"
												checked="checked"> <label for="toggle-col-9">제안제출일</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-10" value="cols_PROPOSAL_RESULT"
												checked="checked"> <label for="toggle-col-10">제안결과</label></li>
											<li><input type="checkbox" name="toggle-cols"
												id="toggle-col-11" value="cols_FILE_COUNT" checked="checked">
												<label for="toggle-col-11">첨부</label></li>
										</ul>
									</div>
								</div>
								<div class="search-common">
									<div class="input-default  fl_l" style="margin: 0;">
										<span class="input-group-btn"> <a href="javascript:void(0);"
											class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
											<a href="javascript:void(0);" class="btn btn-reset-option">검색초기화</a>
										</span>
						
										<div class="search-detail" style="display: none;">
											<form id="formSearchDetail">
												<div class="col-sm-12 m-b">
													<div class="form-group">
														<label>제안영역</label> <select class="form-control"
															id="selectSearchProposalCategory"
															name="selectSearchProposalCategory">
															<option value="">=== 선택 ===</option>
															<option value="cloud">cloud</option>
															<option value="H/W">H/W</option>
															<option value="S/W">S/W</option>
														</select>
													</div>
												</div>
							
												<div class="col-sm-12 m-b">
													<label class="control-label" for="date_modified">고객사</label>
													<div class="input-group" style="width: 100%;">
														<input type="text" placeholder="고객사를 입력해 주세요."
															class="input form-control" id="selectSearchCompany" name="selectSearchCompany"
															onkeydown="if(event.keyCode == 13){suggestList.reset();suggestList.get(1);}">
													</div>
												</div>
							
												<div class="col-sm-12 m-b">
													<label class="control-label" for="date_modified">제안책임자</label>
													<div class="input-group" style="width: 100%;">
														<input type="text" placeholder="제안책임자를 입력해 주세요."
															class="input form-control" id="selectSearchOwner" name="selectSearchOwner"
															onkeydown="if(event.keyCode == 13){suggestList.reset();suggestList.get(1);}">
													</div>
												</div>
							
												<div class="col-sm-12 ag_r">
													<label for="result-in-search" class="mg-r10"> <input
														type="checkbox" id="result-in-search" class="input v-m">
														결과내 검색
													</label>
													<button type="button" class="btn btn-w-m btn-primary btn-seller"
														onClick="suggestList.reset();suggestList.get(1);">
														<i class="fa fa-search"></i> 검색
													</button>
												</div>
											</form>
										</div>
						
									</div>
								</div>

								<!-- <div class="table-sel-view fl_l">
                                    <div class="selgrid selgrid1 mg-r5">
                                        <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
                                            <option value="">== 정렬 기준 ==</option>
                                            <option value="CATEGORY_BIZ"">제안영역</option>
                                            <option value="COMPANY_NAME">고객사</option>
                                            <option value="cols_CUSTOMER_NAME">고객명</option>
                                            <option value="CATEGORY_PRODUCT">솔루션</option>
                                            <option value="PROPOSAL_LEADER">제안책임자</option>
                                            <option value="PROPOSAL_COST_AMOUNT">제안COST</option>
                                            <option value="PROPOSAL_AMOUNT">제안금액</option>
                                            <option value="PROPOSAL_END_DATE">제안제출일</option>
                                            <option value="PROPOSAL_RESULT">제안결과</option>
                                        </select>
                                    </div>
                                </div> -->

							</div>

							<div class="fl_r pd-b20">
								<!-- <div class="fl_l template-doc">
                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
                                    <ul class="template-list off">
                                      <li><a href="#" onclick="selectSampleFile(this);">프로젝트관리(Summary_and_Initiative계획서).xlsx</a></li>
                                    </ul>
                                </div> -->
								<div class="fl_l">
									<button type="button" class="btn btn-w-m btn-seller"
										onclick="modal.reset();">신규등록</button>
								</div>
							</div>
							<!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->


							<table id="tech-companies" class="table table-bordered">
								<colgroup>
									<%-- <col width="" name="" /> --%>
									<col width="" name="cols_CATEGORY_BIZ" />
									<col width="" name="cols_COMPANY_NAME" />
									<col width="" name="cols_CUSTOMER_NAME" />
									<col width="" name="cols_CATEGORY_PRODUCT" />
									<col width="" name="cols_PROPOSAL_SUBJECT" />
									<col width="" name="cols_PROPOSAL_LEADER" />
									<col width="" name="cols_PROPOSAL_COST_AMOUNT" />
									<col width="" name="cols_PROPOSAL_AMOUNT" />
									<col width="" name="cols_PROGRESS_STATUS" />
									<col width="" name="cols_PROPOSAL_RESULT" />
									<col width="" name="cols_FILE_COUNT" />
								</colgroup>
								<thead>
									<tr>
										<!-- <th>No</th> -->
										<th name="cols_CATEGORY_BIZ"><a href="#" class="sortLink" data-sort="TMP.CATEGORY_BIZ" data-method="">제안영역 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_COMPANY_NAME"><a href="#" class="sortLink" data-sort="TMP.COMPANY_NAME" data-method="">고객사 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_CUSTOMER_NAME"><a href="#" class="sortLink" data-sort="TMP.CUSTOMER_NAME" data-method="">고객명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_CATEGORY_PRODUCT"><a href="#" class="sortLink" data-sort="TMP.CATEGORY_PRODUCT" data-method="">제안 제품 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_SUBJECT"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_SUBJECT" data-method="">제안 제목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_LEADER"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_LEADER_NAME" data-method="">제안책임자 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_COST_AMOUNT"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_COST_AMOUNT" data-method="">제안COST(천원) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_AMOUNT"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_AMOUNT" data-method="">제안금액(천원) <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_END_DATE"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_END_DATE" data-method="">제안제출일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_PROPOSAL_RESULT"><a href="#" class="sortLink" data-sort="TMP.PROPOSAL_RESULT" data-method="">제안결과 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
										<th name="cols_FILE_COUNT"><a href="#" class="sortLink" data-sort="TMP.FILE_COUNT" data-method="">첨부 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
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

<jsp:include
	page="/WEB-INF/jsp/pc/salesManagement/proposalsInfoModal.jsp" />

<form id="formSampleFile" name="formSampleFile" method="post">
	<input type="hidden" name="sampleFileName" value="" />
</form>

</body>

<script type="text/javascript">
$(document).ready(function(){
	suggestList.init();
	
	//스크롤 끝 이벤트	
	/* $(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 30;
	        if(page.start < page.totalCount){
	        	suggestList.get();
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
	});
	
});

var params;
var category = "선투자프로젝트";
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
/* var page = {
		start : 0,			   // 0부터 ~
		rowCount : 30,    //10개씩
		totalCount : null  //총 리스트 갯수
} */

var proposal_id = "${param.proposal_id}";

var suggestList = {
		sortCategory : null,
		
		init : function(){
			initPaing(7); //페이징 초기화
			suggestList.get(1);
			
			$("#selectSearchDivision").change(function(){
				if(isEmpty($(this).val())){
					$("div#divSum").hide();
					suggestList.reset();
					suggestList.get(1);
				}else{
					$("div#divSum").show();
					suggestList.reset();
					suggestList.get(1);
				}
			})	;
			
			$("#selectSortCategory").change(function(){
				suggestList.reset();
				suggestList.get(1);
			});
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
					suggestList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					suggestList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					suggestList.sortCategory = "";
				}
				
				suggestList.reset();
				suggestList.get();
			});
			
			if(!isEmpty(proposal_id)){
				suggestList.goDetail(proposal_id);
			}
			
		},
		
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
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
			suggestList.goDetail($("#hiddenModalPK").val());
			suggestList.get(1);
        	page.start = tmpData;
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				params = {
									pageStart : page.start,
									pageEnd : page.end,
									//sortCategory : $("#selectSortCategory").val(),
									searchProposalResult : $("#selectSearchProposalResult").val(),
									searchProgressStatus : $("#selectSearchProgressStatus").val(),
									
									searchCompany : $('#selectSearchCompany').val(),
									searchProposalCategory : $('#selectSearchProposalCategory').val(),
									searchOwner : $('#selectSearchOwner').val(),
						               
									searchAll : $("#textSearchDetail").val(),
									searchPKArray : searchPKArray,
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
									sortCategory : suggestList.sortCategory
								};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/salesManagement/selectProposalsInfoListCount.do",
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
						data.fncName = 'suggestList.get';
						pageCreateNavi(data);
					},
					complete : function(){
					}
				});
				//리스트
				$.ajax({
					url : "/salesManagement/selectProposalsInfotList.do",
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
		
		goDetail : function(pkNo){
			//상세보기로 gogo.
			$.ajax({
				url : "/salesManagement/selectProposalsInfoDetail.do",
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
					
					$("ul.flexdatalist-multiple li.value").remove();
					
					$("#hiddenModalPK").val(rowData.PROPOSAL_ID);
					
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					$("#textModalSubject").val(rowData.PROPOSAL_SUBJECT);

					//고객
					$("#textModalCustomerName").val(rowData.CUSTOMER_NAME);
					$("#textModalCustomerRank").val(rowData.CUSTOMER_POSITION);
					$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
					
					//고객사
					$("#textCommonSearchCompany").val(rowData.COMPANY_NAME);
					$("#textCommonSearchCompanyId").val(rowData.COMPANY_ID);
					$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
					
					//제안책임자
					$("#textModalSuggestLeader").val(rowData.PROPOSAL_LEADER_NAME);
					$("#hiddenModalSuggestLeaderId").val(rowData.PROPOSAL_LEADER_ID);
					
					$("#selectModalSuggestCategoryProduct option").prop("selected",false)
					$.each((rowData.CATEGORY_PRODUCT).split(","),function(index, val){
						$("#selectModalSuggestCategoryProduct option[value='"+val+"']").prop("selected",true);
					}); 
					
					$("#selectModalSuggestCategoryBiz").val(rowData.CATEGORY_BIZ);
					$("#textareaModalDetailContents").val(rowData.DETAIL_CONTENTS);
					$("#textModalSuggestStartDate").val(rowData.PROPOSAL_START_DATE);
					$("#textModalSuggestEndDate").val(rowData.PROPOSAL_END_DATE);
					$("#textModalSuggestPtDate").val(rowData.PROPOSAL_PT_DATE);
					$("#textModalSuggestResultDate").val(rowData.PROPOSAL_RESULT_DATE);
					$("#textareaModalAmountDetail").val(rowData.PROPOSAL_AMOUNT_DETAIL);
					$("#textareaModalCostDetail").val(rowData.PROPOSAL_COST_DETAIL);
					$("#textModalSuggestAmount").val(rowData.PROPOSAL_AMOUNT);
					$("#textModalSuggestCost").val(rowData.PROPOSAL_COST_AMOUNT);
					$("input:radio[name='radioSuggestProgress']").prop("checked",false);
					$("input:radio[name='radioSuggestProgress'][value='"+rowData.PROGRESS_STATUS+"']").prop("checked",true);
					$("input:radio[name='radioSuggestResult']").prop("checked",false);
					$("input:radio[name='radioSuggestResult'][value='"+rowData.PROPOSAL_RESULT+"']").prop("checked",true);
					$("#textareaResultDetail").val(rowData.PROPOSAL_RESULT_DETAIL);
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalDetailContents"));
					textAreaAutoSize($("#textareaModalAmountDetail"));
					textAreaAutoSize($("#textareaModalCostDetail"));
					textAreaAutoSize($("#textareaResultDetail"));
					
					$("#formModalData #textModalSingleClient").hide();
					$("#formModalData #liModalSingleClient").before(
						'<li class="value">'+
						'<span class="txt" id="'+ rowData.CUSTOMER_ID +'">'+ rowData.CUSTOMER_NAME +' '+ rowData.CUSTOMER_POSITION +' ['+ rowData.COMPANY_NAME +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClient(\'textModalSingleClient\',\'textCommonSearchCompany\',\'hiddenModalCompanyId\',\'textModalCustomerName\',\'hiddenModalCustomerId\',\'textModalCustomerRank\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
					);
					
					$("#buttonModalDelete").show();
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=8"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("h4.modal-title").html(rowData.PROPOSAL_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					$("#myModal1").modal();
					
					compare_before = $("#formModalData").serialize();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

var selectSampleFile = function(file) {
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
	$("#formSampleFile").attr("action","/common/sampleDownloadFile.do");
	$("#formSampleFile").submit();
}

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>