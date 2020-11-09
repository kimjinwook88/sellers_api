<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-4">
        <h2>서비스 프로젝트</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>서비스 프로젝트</strong>
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
                        <div class="func-area">
                            <div class="func-top-left fl_l">
                                <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                     <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                 <div class="table-menu" style="z-index:1000;display:none;">
                                        <ul>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" 	value="cols_COMPANY" 			checked="checked"> <label for="toggle-col-1">고객사</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" 	value="cols_PROJECT_NAME" 	checked="checked"> <label for="toggle-col-2">프로젝트명</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" 	value="cols_SALES_OWNER" 	checked="checked"> <label for="toggle-col-3">고객</label></li>
                                            <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" 	value="cols_TOTAL" 					checked="checked"> <label for="toggle-col-4">총건수</label></li> -->
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" 	value="cols_OUR_COMPANY" 						checked="checked"> <label for="toggle-col-5">자사</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" 	value="cols_MILESTONES" 		checked="checked"> <label for="toggle-col-8">수행단계</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" 	value="cols_PROGRESS" 			checked="checked"> <label for="toggle-col-9">진행률</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-10" 	value="cols_ISSUE_STATUS" 		checked="checked"> <label for="toggle-col-10">이슈</label></li>
                                            <li><input type="checkbox" name="toggle-cols" id="toggle-col-11" 	value="cols_FILE_COUNT" 		checked="checked"> <label for="toggle-col-11">첨부</label></li>
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
							                        <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompany" name="textSearchCompany" onkeydown="if(event.keyCode == 13){projectMGMTList.reset();projectMGMTList.get(1);}"></div>
							                    </div>
							                    
							                    <div class="col-sm-12 ag_r">
							                        <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
							                        <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="projectMGMTList.reset();projectMGMTList.get(1);"><i class="fa fa-search"></i> 검색</button>
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
                                            <option value="SALES_REPRESENTIVE_NAME">영업대표</option>
                                            <option value="KEY_MILESTONE">수행단계</option>
                                            <option value="PROGRESS">진행률</option>
                                            <option value="ISSUE_STATUS">해결안된이슈</option>
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
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div>
                                </div>
                            </div>
                            <!-- <p class="cboth ag_r" >금액단위 : 천원</p> -->
                            
                            
                            <table id="tech-companies" class="table table-bordered">
						  	<colgroup>
						        <col width=""	name="cols_PROJECT_NAME" 	/>
						        <col width="7%"	name="cols_SALES_OWNER" 	/>
						        <col width="7%"	name="cols_SALES_OWNER" 	/>
						        <col width="7%"	name="cols_OUR_COMPANY"  />
						        <col width="7%"	name="cols_OUR_COMPANY"  />
						        <col width="10%" name="cols_MILESTONES" 	/>
						        <col width="12%" name="cols_PROGRESS" 	/>
						        <col width="10%" name="cols_ISSUE_STATUS" 	/>
						        <col width="5%"  name="cols_FILE_COUNT" 	/>
						    </colgroup>
						    <thead>
								<tr>
								    <!-- <th rowspan="2">No</th> -->
								    <!-- <th name="cols_COMPANY">고객사</th> -->
						           <th rowspan="2" name="cols_PROJECT_NAME"><a href="#" class="sortLink" data-sort="TMP_TABLE.PROJECT_SUBJECT" data-method="">프로젝트명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						           <th colspan="2" name="cols_SALES_OWNER">고객</th>
						           <!-- <th colspan="2" name="">영업조직</th> -->
						           <th colspan="2" name="cols_OUR_COMPANY">자사</th>
						           <th rowspan="2" name="cols_MILESTONES">수행단계</th>
						           <th rowspan="2" name="cols_PROGRESS"><a href="#" class="sortLink" data-sort="TMP_TABLE.PROGRESS" data-method="">진행률 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						           <th rowspan="2" name="cols_ISSUE_STATUS">이슈</th>
						           <th rowspan="2" name="cols_FILE_COUNT"><a href="#" class="sortLink" data-sort="TMP_TABLE.FILE_COUNT" data-method="">파일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						       </tr>
								<tr>
						           <!-- <th name="cols_COMPANY">고객사</th> -->
								    <th width="5%" name="cols_SALES_OWNER"><a href="#" class="sortLink" data-sort="TMP_TABLE.CLIENT_PM_NAME" data-method="">총괄PM <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
								    <!-- <th name="">수행PM</th> -->
								    <th width="5%" name="cols_SALES_OWNER"><a href="#" class="sortLink" data-sort="TMP_TABLE.CUSTOMER_NAME" data-method="">고객명 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
								    <!-- <th name="">본부명</th> -->
								    <th width="5%" name="cols_OUR_COMPANY"><a href="#" class="sortLink" data-sort="TMP_TABLE.OUR_PM_NAME"">총괄PM <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
								    <!-- <th name="">본부명</th> -->
								    <th width="5%" name="cols_OUR_COMPANY"><a href="#" class="sortLink" data-sort="TMP_TABLE.SALES_REPRESENTIVE_NAME" data-method="">영업대표 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
								    <!-- <th name="">수행PM</th> -->
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

<jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/serviceProjectMGMTModal.jsp"/>

<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

</body>

<script type="text/javascript">
$(document).ready(function(){
	projectMGMTList.init();
	
	//스크롤 끝 이벤트	
	/* $(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	page.start += 30;
	        if(page.start < page.totalCount){
	        	projectMGMTList.get();
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
				lastEditRowQ = 0;
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
		milestonesEvent.off();
	});
	
});

var params;
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
/* var page = {
		start : 0,			   // 0부터 ~
		rowCount : 30,    //20개씩
		totalCount : null  //총 리스트 갯수
} */

var returnProjectMGMTId = "${param.returnProjectMGMTId}";

var coaching_talk = "${param.coaching_talk}";

var projectMGMTList = {
		sortCategory : null,
		
		init : function(){
			initPaing(6); //페이징 초기화
			
			$("#selectSortCategory").change(function(){
				projectMGMTList.reset();
				projectMGMTList.get(1);
			});
			
			if(!isEmpty(returnProjectMGMTId)){
				projectMGMTList.goDetail(returnProjectMGMTId);
			}
			
			projectMGMTList.get(1);
			
			//sort 기능
			$('#tech-companies').on('click','a.sortLink',function(event){
				event.preventDefault();
				
				$('a.sortLink').not($(this)).attr("data-method","");
				$('a.sortLink').not($(this)).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
				
				if($(this).attr("data-method") == ""){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_up.png');
					$(this).attr("data-method","ASC");
				
					projectMGMTList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");
					
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					
					projectMGMTList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					projectMGMTList.sortCategory = "";
				}
				
				projectMGMTList.reset();
				projectMGMTList.get();
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
			projectMGMTList.goDetail($("#hiddenModalPK").val());
			projectMGMTList.get(1);
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				params = {
									pageStart : page.start,
									pageEnd : page.end,
									latelyUpdateTable : "PROJECT_MGMT",
									sortCategory : $("#selectSortCategory").val(),
									searchCompanyName : $("#textSearchCompany").val(),
									searchPKArray : searchPKArray,
									resultInSearch : function(){
										if($("#result-in-search").is(":checked")){
											return "Y";
										}else{
											return "N";
										}
									},
									sortCategory : projectMGMTList.sortCategory
								};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트, 결과내 검색
				$.ajax({
					url : "/clientSatisfaction/selectProjectMGMTListCount.do",
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
						data.fncName = 'projectMGMTList.get';
						pageCreateNavi(data);
					},
					complete : function(){
					}
				});
				//리스트
				$.ajax({
					url : "/clientSatisfaction/selectProjectMGMTList.do",
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
				url : "/clientSatisfaction/selectProjectMGMTDetail.do",
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
					
					modalFlag = "upd"; //업데이트
					
					//EVENT ON
					modalEvent.on();
					milestonesEvent.on();
					
					//tab 초기화
					$("ul.tabmenu-type li a:first").trigger('click.modalTab');
					
					$("ul.flexdatalist-multiple li.value").remove();
					$("#formModalData #hiddenModalMemberList").val("");

					$('#formModalData').validate().resetForm();
										
					$("#hiddenModalPK").val(rowData.PROJECT_ID);
					$("#textModalSubject").val(rowData.PROJECT_SUBJECT);							//프로젝트명
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					//$("#textModalTextName").val(rowData.HAN_NAME);								//작성자
					//$("#textModalCreateDate").val(rowData.SYS_REGISTER_DATE);						//작성일
					$("#textModalStartDate").val(rowData.START_DATE);								//시작일
					$("#textModalEndDate").val(rowData.END_DATE);									//종료일
					$("#textareaModalContents").val(rowData.DETAIL_CONTENTS);						//상세내용
					$("#textModalClientName").val(rowData.CUSTOMER_NAME);							//고객명
					$("#hiddenModalClientId").val(rowData.CUSTOMER_ID);
					//$("#hiddenModalClientId")val();
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalContents"));
					
					$("#textModalClientPMName").val(rowData.CLIENT_PM_NAME);									//고객PM
					$("#hiddenModalClientPMId").val(rowData.CLIENT_PM_ID);
					$("#textModalClientEXPMName").val(rowData.CLIENT_EXEC_PM_NAME);							//고객EXPM
					$("#hiddenModalClientEXPMId").val(rowData.CLIENT_EXEC_PM_ID);
					$("#textModalClientRelationName").val(rowData.CLIENT_RELATION_NAMES);								//고객주요당사자
					$("#hiddenModalOurPMId").val(rowData.OUR_PM_ID);
					$("#textModalPartnerCompany").val(rowData.PARTNER_NAMES);						//파트너사명
					$("#textModalPartnerSalesOwner").val(rowData.PARTNER_SALES_REPS);				//파트너영업대표
					$("#textModalAuditCompany").val(rowData.AUDIT_COMPANY_NAME);					//감리회사명
					$("#textModalAuditIndividualNames").val(rowData.AUDIT_INDIVIDUAL_NAMES);		//자사EXPM
					$("#textModalAuditIndividualContacts").val(rowData.AUDIT_INDIVIDUAL_CONTACTS);	//자사EXPM
					$("#textModalTotalContractAmount").val(rowData.CONTRACT_AMOUNT_TOTAL);			//전체 계약 금액
					
					/* $("#selectModalClientCompany").val(rowData.COMPANY_NAME); */				//고객사
					/* $("#textCommonSearchCompany").val(rowData.COMPANY_NAME); 					//고객사
					$("#textCommonSearchCompanyId").val(rowData.COMPANY_ID); 					//고객사
					$("#hiddenModalCompanyId").val(rowData.COMPANY_NAME); 					//고객사
					 */
					
					//자사총괄PM
					$("#textModalOurPMName").hide();
					$("#hiddenModalOurPMId").val(rowData.OUR_PM_ID);
		         	$('#liModalOurPMName').before(
		         			'<li class="value">' +
							'<span class="txt" id="'+rowData.OUR_PM_ID+'">'+rowData.OUR_PM_NAME+' ['+ rowData.OUR_PM_POSITION_STATUS +']</span>' +
							'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOurPMName\',\'liModalOurPMName\',\'hiddenModalOurPMId\');"><i class="fa fa-times-circle"></i></a>'
					);
		         	
		         	//자사수행PM
					$("#textModalOurEXPMName").hide();
					$("#hiddenModalOurEXPMId").val(rowData.OUR_EXEC_PM_ID);
		         	$('#liModalOurEXPMName').before(
		         			'<li class="value">' +
							'<span class="txt" id="'+rowData.OUR_EXEC_PM_ID+'">'+rowData.OUR_EXEC_PM_NAME+' ['+ rowData.OUR_EXEC_PM_POSITION_STATUS +']</span>' +
							'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOurEXPMName\',\'liModalOurEXPMName\',\'hiddenModalOurEXPMId\');"><i class="fa fa-times-circle"></i></a>'
					);
		         	
		         	//영업대표
		         	if(rowData.SALES_REPRESENTIVE_ID){
						$("#textModalSalesOwnerName").hide();
						$("#hiddenModalSalesOwnerId").val(rowData.SALES_REPRESENTIVE_ID);
			         	$('#liModalSalesOwnerName').before(
			         			'<li class="value">' +
								'<span class="txt" id="'+rowData.SALES_REPRESENTIVE_ID+'">'+rowData.SALES_REPRESENTIVE_NAME+' ['+ rowData.SALES_REPRESENTIVE_POSITION_STATUS +']</span>' +
								'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalSalesOwnerName\',\'liModalSalesOwnerName\',\'hiddenModalSalesOwnerId\');"><i class="fa fa-times-circle"></i></a>'
						);
		         	}else{
		         		$("#textModalSalesOwnerName").show();
		         	}
		         	
					$("#formModalData #textModalSingleClient").hide();
					$("#formModalData #liModalSingleClient").before(
						'<li class="value">'+
						'<span class="txt" id="'+ rowData.CUSTOMER_ID +'">'+ rowData.CUSTOMER_NAME +' '+ rowData.CUSTOMER_POSITION +' ['+ rowData.COMPANY_NAME +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClient(\'textModalSingleClient\',\'textCommonSearchCompany\',\'hiddenModalCompanyId\',\'textModalClientName\',\'hiddenModalClientId\',\'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
					);
					$("#formModalData #textModalSingleClientPM").hide();
					$("#formModalData #liModalSingleClientPM").before(
						'<li class="value">'+
						'<span class="txt" id="'+ rowData.CLIENT_PM_ID +'">'+ rowData.CLIENT_PM_NAME +' '+ rowData.CLIENT_PM_POSITION +' ['+ rowData.COMPANY_NAME +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClient(\'textModalSingleClientPM\',\'\',\'\',\'textModalClientPMName\',\'hiddenModalClientPMId\',\'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
					);
					$("#formModalData #textModalSingleClientEXPM").hide();
					$("#formModalData #liModalSingleClientEXPM").before(
						'<li class="value">'+
						'<span class="txt" id="'+ rowData.CLIENT_EXEC_PM_ID +'">'+ rowData.CLIENT_EXEC_PM_NAME +' '+ rowData.CLIENT_EXEC_PM_POSITION +' ['+ rowData.COMPANY_NAME +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClient(\'textModalSingleClientEXPM\',\'\',\'\',\'textModalClientEXPMName\',\'hiddenModalClientEXPMId\',\'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
					);
					
					commonSearch.multipleTeamMemberArray = [];
					$("#hiddenModalTeamMemberIdList").val('');
					$("#hiddenModalTeamMemberNameList").val('');
					//팀구성
					if(!isEmpty(rowData.TEAM_MEMBER_ID)){
						var memberIdArr = rowData.TEAM_MEMBER_ID.split(",");
						var memberNameArr = rowData.TEAM_MEMBER_NAME.split(",");
						var tmList = '';
						$("#hiddenModalTeamMemberIdList").val(memberIdArr);
						for(var i=0; i<memberNameArr.length; i++){
							commonSearch.addMultipleTeamMember($('#formModalData #hiddenModalTeamMemberIdList'), $('#formModalData #liMultipleTeamMember'), memberIdArr[i], memberNameArr[i]);
							if(i>0) tmList = tmList + ', ';
							tmList = tmList + memberNameArr[i];
						}
						$("#hiddenModalTeamMemberNameList").val(tmList);
					}
					
					
					$("#selectModalAccount").val(rowData.SUBJECT);								//영업기회
					$("#hiddenModalPK").val(rowData.PROJECT_ID);
					$("#hiddenModalProgress").val(rowData.PROGRESS);								//진행율(%)
					$("#divModalProgressBar").html($("#hiddenModalProgress").val()+"%");
					$("#divModalProgressBar").css("width", $("#hiddenModalProgress").val()+"%");
					
					//$("#buttonModalDelete").show();
					
					//코칭톡 버튼 show, 창 hide
					$("#divModalCoachingTalk").hide();
					$("#buttonModalCoachingTalkView").show();
					$("#spanCtCount").html('('+rowData.COACHING_TALK_COUNT+')');
					
					//코톡알림 바로가기시 코톡창 바로 보이게 설정 후 코톡창 바로보기 여부 N처리.
					if(coaching_talk == 'Y'){
						$("#buttonModalCoachingTalkView").click();
						coaching_talk = 'N';
					}
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=9"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("#hiddenModalCompanyId").val(rowData.CLIENT_COMPANY_ID);					//고객사ID
					
					$("h4.modal-title").html(rowData.PROJECT_SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					//modalAmount.disable();
					$.ajax({
						url : "/clientSatisfaction/selectProjectMGMTInfo.do?",
						async : false,
						datatype : 'json',
			 			method: 'POST',
						data : {
							project_id:rowData.PROJECT_ID, 
						},
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
			            	$.ajaxLoadingShow();
						},
						success : function(data) {
							/* console.log(rowData.CONTRACT_AMOUNT_UNIT);
							console.log(rowData.CONTRACT_AMOUNT_TOTAL);
							console.log(data.selectProjectMGMTContractInfo); */
							if(rowData.CONTRACT_AMOUNT_UNIT!="") {
								$("#divModalContractAmountRe").css("display", "");
								$("#selectModalContractAmount").attr("disabled", false);
								$("#selectModalContractAmount").val(rowData.CONTRACT_AMOUNT_UNIT);
								modalAmount.setting();
								$("#textModalTotalContractAmount").val(String(rowData.CONTRACT_AMOUNT_TOTAL).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
								for(var i=0; i<data.selectProjectMGMTContractInfo.length; i++) {
									var planAmount = String(data.selectProjectMGMTContractInfo[i].BASIS_PLAN_REVENUE_AMOUNT);
									var actualAmount = String(data.selectProjectMGMTContractInfo[i].BASIS_ACTUAL_REVENUE_AMOUNT);
									$("#textModalContractPlanAmount"+i).val(planAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									$("#textModalContractActualAmount"+i).val(actualAmount.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
									if($("#textModalContractPlanAmount"+i).val()=="undefined") $("#textModalContractPlanAmount"+i).val("0");
									if($("#textModalContractActualAmount"+i).val()=="undefined") $("#textModalContractActualAmount"+i).val("0");
								}
							}
						},
						complete : function() {
							$.ajaxLoadingHide();
						}
					});
					
					mileOpper.select();
					//projectIssue.reset();
					//projectIssue.drawQualification();
					
					grid.gridReset();
					//$("label#gridTable-error").remove();
					grid.gridGetList();
					
					/* 상세보기창이 열린다 */
					$("#myModal1").modal();
					
					//값 비교를 위한.
					setTimeout(function(){
						compare_before = $("#formModalData").serialize();
						$.ajaxLoadingHide();
					}, 600);
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
