<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%@ include file="/WEB-INF/jsp/pc/poi/excelDataSampleFilePath.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-6">
        <h2>회사/부문별전략</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a href="#">사업전략</a>
            </li>
            <li class="active">
                <strong>회사/부문별전략</strong>
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
                        
                        	<c:if test="${strategy eq 'CO'}">
                        	<div class="mg-b20">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="bizList.categoryTab(1,this);">회사전략</a></li>
                                    <li class="" style="display: none;"><a data-toggle="tab" href="javascript:void(0);" onClick="bizList.categoryTab(2,this);">부문전략</a></li>
                                    <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="bizList.categoryTab(3,this);">본부전략</a></li>
                                    <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="bizList.categoryTab(4,this);">팀전략</a></li>
                                </ul>
                            </div>
                            </c:if>
							
							<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                  <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
                                  <div class="table-menu" style="z-index:1000;display:none;margin-top:65px;">
                                      <ul>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-1" 	value="cols_SUBJECT" checked="checked"> <label for="toggle-col-1">제목</label></li>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-2" 	value="cols_EXEC_POST" 			checked="checked"> <label for="toggle-col-2">본부</label></li>
								    	  <li><input type="checkbox" name="toggle-cols" id="toggle-col-3" value="cols_EXEC_OWNER" checked="checked"> <label for="toggle-col-3">책임리더</label></li>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-4" value="cols_KEY_MILESTONE" checked="checked"> <label for="toggle-col-4">마일스톤</label></li>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-5" value="cols_ISSUE_STATUS" checked="checked"> <label for="toggle-col-5">이슈상태</label></li>
                                          <!-- <li><input type="checkbox" name="toggle-cols" id="toggle-col-6" value="cols_STATUS" checked="checked"> <label for="toggle-col-6">Status</label></li> -->
                                                                                                         
                                                                                                          
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-7" value="cols_REVIEW_CYCLE" checked="checked"> <label for="toggle-col-7">검토주기</label></li>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-8" value="cols_SYS_REGISTER_DATE" checked="checked"> <label for="toggle-col-8">작성일</label></li>
                                          <li><input type="checkbox" name="toggle-cols" id="toggle-col-9" value="cols_FILE_COUNT" checked="checked"> <label for="toggle-col-9">첨부</label></li>
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
					                            <label class="control-label" for="date_modified">본부</label>
					                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="본부를 입력해주세요" class="input form-control" name="textSearchDivision" id="textSearchDivision" onkeydown="if(event.keyCode == 13){bizList.reset();bizList.get(1);}"></div>
					                        </div>
					                        
					                        <div class="col-sm-12 m-b">
									    	<label class="control-label" for="date_modified">책임리더</label>
					                  		<div class="input-group" style="width:100%;" ><input type="text" placeholder="책임리더를 입력해주세요" class="input form-control" name="textSearchOwner" id="textSearchOwner" onkeydown="if(event.keyCode == 13){bizList.reset();bizList.get(1);}"></div>
					                        </div>
					                        
					                        <!-- <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">이슈상태</label>
					                                  <div class="input-group" style="width:100%;">
					                                  	<select class="form-control" name="actionStatus" id="actionStatus">
															<option value="">==== 선택 ====</option>
															<option value="actionStatusY">완료</option>
															<option value="actionStatusN">진행중</option>
															<option value="actionStatusX">지연</option>
														</select>
					                                  </div>
					                              </div>
					                              
					                              <div class="col-sm-12 m-b">
					                                  <label class="control-label" for="date_modified">Status</label>
					                                  <div class="input-group" style="width:100%;">
					                                  <select class="form-control" name="status" id="status">
														<option value="">==== 선택 ====</option>
														<option value="statusY">완료</option>
														<option value="statusN">진행중</option>
														<option value="statusX">지연</option>
														</select>
					                                  </div>
					                              </div> -->
					                        
					                        <div class="col-sm-12 ag_r">
					                            <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
					                            <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="bizList.reset();bizList.get(1);"><i class="fa fa-search"></i> 검색</button>
					                        </div>
				                        </form>
				                    </div>
				                </div>
				            </div>	
                            	
							<div class="func-top-left fl_l">
                                 
                                 <!-- <div class="select-com fl_l mg-l10"><label>항목선택</label> 
                                     <select class="form-control m-b" name="selectSortCategory" id="selectSortCategory">
                                          <option value="">== 정렬 기준 ==</option>
	                                      <option value="MEMBER_POST">본부</option>
	                                      <option value="HAN_NAME">책임리더</option>
                                     </select>
                                 </div> -->
                                 
                             </div>

                            <div class="func-top-right fl_r pd-b20">
                            	<div class="fl_l template-doc">
                                    <button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">템플릿 다운로드</button>
                                    <ul class="template-list off">
                                      <!-- 
                                      <li><a href="javascript:void(0);" onclick="selectSampleFile(this);">사업전략(Industry_Play).xlsx</a></li>
					                   <li><a href="javascript:void(0);" onclick="selectSampleFile(this);">사업전략(Industry_Play_Summary).xlsx</a></li> 
					                   -->
                                      <li><a href="javascript:void(0);" onclick="downFile.selectSampleFile(this, 'companyBizFile');">사업전략(Industry_Play).xlsx</a></li>
					                   <li><a href="javascript:void(0);" onclick="downFile.selectSampleFile(this, 'companyBizFile');">사업전략(Industry_Play_Summary).xlsx</a></li>
                                    </ul>
                                </div>
                                <div class="fl_l">
                                    <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                                </div>
                            </div>
				       
							<table id="tech-companies" class="table table-bordered">
						  		<colgroup>
						        <col width="" name="cols_SUBJECT" />
						        <col width="" name="cols_EXEC_POST" />
						        <col width="" name="cols_EXEC_OWNER" />
						        <col width="8%" name="cols_KEY_MILESTONE" />
						        <col width="" name="cols_ISSUE_STATUS" />
						        <col width="" name="cols_REVIEW_CYCLE" />
						        <col width="" name="cols_SYS_REGISTER_DATE" />
						        <col width="" name="cols_FILE_COUNT" />
						    </colgroup>
						    <thead>
						    <tr>
						        <!-- <th>No</th> -->
						        <th name="cols_SUBJECT"><a href="#" class="sortLink" data-sort="TB.SUBJECT" data-method="">제 목 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <!-- <th name="cols_EXEC_OWNER">카테고리</th> -->
						        <th name="cols_EXEC_POST"><a href="#" class="sortLink" data-sort="TB.RL_DIVISION" data-method="">본부 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_EXEC_OWNER"><a href="#" class="sortLink" data-sort="TB.RL_NAME" data-method="">책임리더 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_KEY_MILESTONE">마일스톤</th>
						        <th name="cols_ISSUE_STATUS"><a href="#" class="sortLink" data-sort="TB.ISSUE_ACTION_STATUS_TEXT" data-method="">이슈상태 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <%-- <th name="cols_STATUS"><a href="#" class="sortLink" data-sort="TB.STATUS" data-method="">Status <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th> --%>
						        <th name="cols_REVIEW_CYCLE"><a href="#" class="sortLink" data-sort="TB.REVIEW_CYCLE" data-method="">검토주기 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
						        <th name="cols_SYS_REGISTER_DATE"><a href="#" class="sortLink" data-sort="TB.SYS_REGISTER_DATE" data-method="">작성일 <img src="<%=request.getContextPath()%>/images/pc/icon_sort.png" /></a></th>
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

</div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyOurCompanyModal.jsp"/>

</body>
 	
<script type="text/javascript">
$(document).ready(function(){
	bizList.init();
});

var bizId = "${param.bizId}";
var searchCategory = "회사전략";
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray;
var modalFlag = "ins/upd";
/* var page = {
		start : 0,			   // 0부터 ~
		rowCount : 30,    //30개씩
		totalCount : null  //총 리스트 갯수
} */
var bizList = {
		sortCategory : null,
		
		init : function(){
			initPaing(8); //페이징 초기화
			
			if(!isEmpty(bizId)){
				var category = "${param.searchCategory}";
				if(category == '3'){
					searchCategory == '본부전략'
					bizList.categoryTab(3,"ul.nav.nav-tabs > li:nth-child(3) > a");
				}else if(category == '4'){
					searchCategory == '팀전략'
					bizList.categoryTab(4,"ul.nav.nav-tabs > li:nth-child(4) > a");
				}
				bizList.goDetail(bizId);
			}
			
			//스크롤 이벤트
			/* $(window).scroll(function(){
				 if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
			    	page.start += 30;
			        if(page.start < page.totalCount){
			        	bizList.get();
			        }
			    }
			 });  */
			
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
				milestonesEvent.off();
			});
			
			 bizList.get(1);
			 
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
					if($(this).attr("data-sort") == "TB.ISSUE_ACTION_STATUS_TEXT"){ //이슈 색상 정렬 예외
						bizList.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#1ab394','#ffc000','#f20056',null)"
					}else if($(this).attr("data-sort") == "TB.STATUS"){ //status 정렬 예외
						bizList.sortCategory = statusFiled + " is null ASC," + "FIELD("+statusFiled+",'green','yellow','red',null)"
					}else{
						bizList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else if($(this).attr("data-method") == "ASC"){
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort_down.png');
					$(this).attr("data-method","DESC");
					if($(this).attr("data-sort") == "TB.ISSUE_ACTION_STATUS_TEXT"){ //이슈 색상 정렬 예외
						bizList.sortCategory = $(this).attr("data-sort") + " is null ASC," + "FIELD("+$(this).attr("data-sort")+",'#f20056','#ffc000','#1ab394',null)"
					}else if($(this).attr("data-sort") == "TB.STATUS"){ //status 정렬 예외
						bizList.sortCategory = statusFiled + " is null ASC," + "FIELD("+statusFiled+",'red','yellow','green',null)"
					}else{
						bizList.sortCategory = $(this).attr("data-sort") + " is null ASC," + $(this).attr("data-sort")+ " " +$(this).attr("data-method");	
					}
				}else{
					$(this).find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
					$(this).attr("data-method","");
					bizList.sortCategory = "";
				}
				
				bizList.reset();
				bizList.get(1);
			});
			
			
		},
		
		categoryTab : function(val,obj){
			searchPKArray = ''; //탭 선택 시 검색 초기화
			$("ul.nav.nav-tabs li").removeClass();
			$(obj).parent('li').addClass('active');
			
			$('a.sortLink').attr("data-method","");
			$('a.sortLink').find('img').attr('src','<%=request.getContextPath()%>/images/pc/icon_sort.png');
			bizList.sortCategory = "";
			
			//검색 초기화
			//$('div.search-common').find('input').val("");
			//$('div.search-common').find('select option:first').prop("selected", true);
			
			if(val==1){
				searchCategory = "회사전략";
			}else if(val==2){
				searchCategory = "부문전략";
			}else if(val==3){
				searchCategory = "본부전략";
			}else{
				searchCategory = "팀전략";
			}
			bizList.reset();
			bizList.get(1);
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
			//milestone.lastEdit = 0;
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start = 0;
        	//milestone.lastEdit = 0;
        	//bizList.goDetail($("#hiddenModalPK").val());
        	bizList.get(1);
        	page.start = tmpData;
		},
		
		//리스트 가져오기
		get : function(pn, ep){
				var listParams = $.param({
					datatype : 'html',
					jsp : '/bizstrategy/bizStrategyOurCompanyListAjax'
				});
				var countParams = $.param({
					datatype : 'json'
				});
				var params = {
					strategy : "${strategy}",
					pageStart : page.start,
					pageEnd : page.end,
					latelyUpdateTable : "BIZ_STRATEGY",
					searchCategory : searchCategory,
					searchDivision : $("#textSearchDivision").val(),
					searchOwner : $("#textSearchOwner").val(),
					searchActionStatus : $("#actionStatus option:selected").val(),
					searchStatus : $("#status option:selected").val(),
					searchPKArray : searchPKArray,
					resultInSearch : function(){
						if($("#result-in-search").is(":checked")){
							return "Y";
						}else{
							return "N";
						}
					},
					sortCategory : bizList.sortCategory
				};
				
				if(!pagingCalculation(pn,ep)) return false; //페이징 계산
				
				//카운트, 최근업데이트,결과내 검색
				$.ajax({
					url : "/bizStrategy/selectBizStrategyListCount.do",
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
						searchPKArray = data.searchPKArray;
						
						//테이블 하단 페이징 처리 및 디자인 생성
						params.pageStart = data.listPaging.pageStart;
						params.pageEnd = data.listPaging.endPage;
						data.fncName = 'bizList.get';
						pageCreateNavi(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				
				//리스트
				$.ajax({
					url : "/bizStrategy/selectBizStrategyList.do",
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
						$.ajaxLoadingHide();
					}
				});
		},
		
		goDetail : function(pkNo){
			var params = $.param({
				datatype : 'json',
				pkNo : pkNo,
				searchCategory : searchCategory
			});
			//상세보기로 gogo.
			//$.post( "/bizStrategy/gridBizStrategyList.do", { pkNo: pkNo});
			$.ajax({
				url : "/bizStrategy/selectBizStrategyDetail.do",
				async : false,
	 			datatype : 'json',
				mtype: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					var rowData = data.detail;
					var fileList = data.fileList;
					var milestonesList = data.milestonesList;
					
					//EVENT ON
					milestonesEvent.on();
					
					//초기화
					$('#formModalData').validate().resetForm();
					$("ul.flexdatalist-multiple li.value").remove();
					
					modalFlag = "upd";
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+rowData.HAN_NAME+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+rowData.SYS_REGISTER_DATE.replace(/-/gi, "/")+"</span>");
					//$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
					$("#selectModalCategory").val(rowData.CATEGORY);
					$("#selectModalReviewCycle").val(rowData.REVIEW_CYCLE);
					$("#textModalSubject").val(rowData.SUBJECT);
					$("#textareaModalKeyContents").val(rowData.KEY_CONTENTS);	//주요내용
					$("#hiddenModalPK").val(rowData.BIZ_ID);
					$("#textModalLeader").val(rowData.RL_NAME);
					$("#hiddenModalLeader").val(rowData.RL_ID);
					
					//textarea 높이 계산
					textAreaAutoSize($("#textareaModalKeyContents"));
					
					//파일
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=1"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("#buttonModalDelete").show();
					$("h4.modal-title").html(rowData.SUBJECT);
					$("small.font-bold").css('display','');
					$("#buttonModalSubmit").html("저장하기");
					
					//milestone
					milestones.reset();
					milestones.draw(milestonesList);
					//milestone.clear();
					//milestone.reload();
					
					// ActionPlan 그리드 생성
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
					
					compare_before = $("#formModalData").serialize();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>

