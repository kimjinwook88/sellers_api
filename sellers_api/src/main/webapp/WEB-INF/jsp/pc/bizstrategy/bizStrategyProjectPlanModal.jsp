<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">2016년 상반기 IBM VAD 팀전략</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="ibox">
                                
			                        <div class="ibox-content border_n" id="divModalToggle">
			                            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
			                                <div class="form-group">
			                                    <div class="col-sm-12 ag_r mg-b10" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
			                                </div>
			                                
			                                <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
                                                <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                            </div>
                                            
                                            <div class="hr-line-dashed"></div>
			                                <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 카테고리</label>
			                                    <div class="col-sm-4">
			                                        <div class="select-com"><!-- <label>항목선택</label> --> 
			                                            <select class="form-control m-b" name="selectModalCategory" id="selectModalCategory">
			                                            <option value="">=== 프로젝트 항목 ===</option>
			                                            <option value="1">신규솔루션</option>
			                                            <option value="2">선투자프로젝트</option>
			                                            <option value="3">전략프로젝트</option>
			                                        </select></div>
			                                    </div>
			                                    <label class="col-sm-2 control-label">사업부서</label>
			                                    <div class="col-sm-4"><input type="text" disabled="" placeholder="" class="form-control" id="textModalDivision"></div>
			                                </div>
                                            
                                            <div class="hr-line-dashed" name="hiddenCompany"></div>
                                            <div class="form-group pos-rel">
                                            	<label class="col-sm-2 control-label" name="hiddenCompany"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
			                                     <div class="col-md-9 col-lg-4" name="hiddenCompany">
		                                              <ul id="ulModalSingleCompany" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
		                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleCompany" name="liModalSingleCompany">
		                                                      <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off" autoFlag="y">
		                                                      <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
		                                                 </li>
		                                              </ul>                                                            
		                                          </div>
                                       
                                            	<!-- <label class="col-sm-2 control-label">고객사ID</label>
                                                <div class="col-sm-4">
                                                	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                                </div> -->
                                            </div>
                                            
                                            <div class="hr-line-bottom"></div>
                                            <!-- <div class="hr-line-dashed"></div>
                                            <div class="form-group pos-rel">
                                                <label class="col-sm-2 control-label">전체 계약금액</label>
                                                <div class="col-sm-4">                                                
                                                    <input type="text" placeholder="10,000"  OnKeyUp="comma(this)" class="form-control" />
                                                </div>
                                                <label class="col-sm-2 control-label">전체 투자금액</label>
                                                <div class="col-sm-4">                                                
                                                    <input type="text" placeholder="10,000"  OnKeyUp="comma(this)" class="form-control" />
                                                </div>
                                            </div> -->
                                            
                                            
                                            <!-- TabMenu -->
                                            <div class="tab-area">

                                                <!-- tab-menu -->
                                                <ul class="tabmenu-type">
                                                    <li><a href="#" class="sel">기본정보</a></li>
                                                    <li><a href="#" class="">매출현황</a></li>
                                                    <li><a href="#" class="">영업기회</a></li>
                                                    <li><a href="#" class="">마일스톤</a></li>
                                                    <li><a href="#" class="">이슈</a></li>
                                                    <li><a href="#" class="">첨부파일</a></li>
                                                </ul>
                                                <!--// tab-menu -->

                                                <!-- 기본정보 -->
                                                <div class="sub_cont scont1 modaltabmenu">
                                                    <div class="form-group">
	                                                    <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 책임리더</label>
	                                    				<div class="col-md-9 col-lg-4">
				                                            <ul id="ulModalSingleExecutionOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
				                                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleExecutionOwner" name="liModalSingleExecutionOwner">
				                                                    <input type="text" class="form-control" id="textModalExecutionOwner" name="textModalExecutionOwner" placeholder="책임리더을 검색해 주세요." autocomplete="off" autoFlag="y">
				                                                </li>
				                                            </ul>                                                            
				                                        </div>
                                        
                                						<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업대표</label>
                                    					<div class="col-md-9 col-lg-4">
				                                            <ul id="ulModalSingleSalesOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
				                                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleSalesOwner" name="liModalSingleSalesOwner">
				                                                    <input type="text" class="form-control" id="textModalSalesOwner" name="textModalSalesOwner" placeholder="영업대표을 검색해 주세요." autocomplete="off" autoFlag="y">
				                                                </li>
				                                            </ul>                                                            
				                                        </div>
                                                    </div> 

                                                    <div class="hr-line-dashed"></div>
                                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 시작일</label>
				                                    <div class="col-sm-4">
					                                        <div class="data_1">
					                                            <div class="input-group date">
					                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					                                                <!-- <input type="hidden" class="form-control" onchange='modalAmount.disabled(this);' id="hiddenSubModalStartDate" name="hiddenSubModalStartDate" value=""> -->
					                                                <input type="text" class="form-control" id="textModalStartDate" name="textModalStartDate" value="" onchange="modalAmount.disable();">
					                                            </div>
					                                        </div>
					                                    </div>
					                                    <label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 종료일</label>
					                                    <div class="col-sm-4">
					                                    		<div class="data_1">
					                                        		<div class="input-group date">
					                                            		<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalEndDate" name="textModalEndDate" onchange="modalAmount.disable();">
					                                        		</div>
					                                      	</div>
					                                    </div>
					                                </div>
					                                
                                                    <div class="hr-line-dashed"></div>
                                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 프로젝트 개요</label>
					                         		      <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalDetailContents" name="textareaModalDetailContents" 
					                         		      onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
					                         		      </div>
					                                </div>
                                                </div>
                                                <!--// 기본정보 -->

                                                <!-- 매출현황 -->
                                                <div class="sub_cont scont2 modaltabmenu off">
                                                	<jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyProjectPlanModalAmount.jsp"></jsp:include>
                                                </div>
                                                <!--// 매출현황 -->
												
                                                <!-- 영업기회 -->
                                                <div class="sub_cont scont3 modaltabmenu off">
                                                	<jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyProjectPlanOpportunity.jsp"></jsp:include>
                                                </div>
                                                <!--// 영업기회 -->
                                                
                                                <!-- key 마일스톤 -->
                                                <div class="sub_cont scont4 modaltabmenu off">
                                                    <!-- <div class="form-group">
				                                       <div class="col-sm-12">
				                                       		<table id="milestonesProjectPlan"></table>
				                                       		
				                                       		<p class="text-center pd-t20">
															    <button type="button" class="btn btn-w-m btn-gray" onClick="mileStones.insert();">Key Milsestones 저장</button>
															</p>
															
				                                       	</div>
				                                   </div> -->
                                               		<jsp:include page="/WEB-INF/jsp/pc/common/milestones_temp.jsp"/>
                                                </div>
                                                <!--// key 마일스톤 -->

                                                <!-- 이슈 -->
                                                <div class="sub_cont scont5 modaltabmenu off">
                                                    <!-- <div class="form-group">
				                                       <div class="col-sm-12">
				                                       		<table id="projectPlanActionPlan"></table>
												            <p class="text-center pd-t10">
												               <a href="javascript:void(0);" class="btn-row-add" name="buttonActionPlanAddRow" onclick="actionPlan.addRowActionPlan();">+ 이슈 추가</a>
												           </p>
				                                       	</div>
					                                </div> -->
					                                <jsp:include page="/WEB-INF/jsp/pc/common/grid.jsp" flush="false">
										            	<jsp:param name="gridAddBtnName" value="이슈"/>
										            	<jsp:param name="gridHtmlPath" value="/ajaxHtml/projectIssue.html"/>
										            	<jsp:param name="gridDelUrl" value="/bizStrategy/deleteProjectPlanActionPlan.do"/>
										            	<jsp:param name="gridSelectUrl" value="/bizStrategy/selectProjectPlanIssue.do"/>
										            	<jsp:param name="listObj" value="projectList"/>
										            </jsp:include>
                                                </div>
                                                <!--// 이슈 -->
                                                
                                                <!-- 파일첨부 -->
                                                <div class="sub_cont scont6 modaltabmenu off">
                                                    <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                                </div>
                                                <!--// 파일첨부 -->

                                            </div>
                                            <!--// TabMenu -->
                                            	 
                                            	<div class="hr-line-dashed"></div>
			                                    <p class="text-center">
			                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" onClick="modal.deleteModal();" id="buttonModalDelete">삭제하기</button> -->
			                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
			                                    </p>
											  	<input type="hidden" name="hiddenModalTotalContractAmount" id="hiddenModalTotalContractAmount" />
											  	<input type="hidden" name="hiddenModalTotalInvestAmount" id="hiddenModalTotalInvestAmount" />
											  	<input type="hidden" name="hiddenModalPK" 		 id="hiddenModalPK" 		value=""/>
			                                    <input type="hidden" name="hiddenModalProjectId" id="hiddenModalProjectId" value=""/>
			                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
			                                    
			                                    <input type="hidden" name="hiddenModalSalesOwner" id="hiddenModalSalesOwner"/>
			                                    <input type="hidden" name="hiddenModalExecutionOwner" id="hiddenModalExecutionOwner"/>
												<!-- 작성일 : divModalCreateDate -->
			                                </form>
			                            </div>
		                    </div>
		                </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
	            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	modal.init();
	//mileStones.init();
	//actionPlan.init();
});

var modalEvent = {
	on : function(){
		//tab menu
		if(category == "1"){
			$("ul.tabmenu-type li:eq(2)").show();
			$("[name='hiddenCompany']").hide();
		}else{
			$("ul.tabmenu-type li:eq(2)").hide();
			$("[name='hiddenCompany']").show();
		}
		$("ul.tabmenu-type").on('click.modalTab', 'li a', modalEvent.clickModalTab);
		
		//카테고리
		$("#selectModalCategory").on('change.category', modalEvent.changeCategory);
	},
	
	off : function(){
		//tab menu
		$("ul.tabmenu-type").off('click.modalTab', 'li a', modalEvent.clickModalTab);
		//카테고리
		$("#selectModalCategory").off('change.category', modalEvent.changeCategory);
	},
	
	clickModalTab : function(e){
		e.preventDefault();
		var idx = $("ul.tabmenu-type li a").index($(this));
		$("ul.tabmenu-type li a").removeClass("sel");
		$(this).addClass("sel");
		$("div.modaltabmenu").addClass("off");
		$("div.modaltabmenu").eq(idx).removeClass("off");
	},
	
	changeCategory : function(e){
		category = $(this).val(); 
		if($(this).val() == "1"){
			$("ul.tabmenu-type li:eq(2)").show();
			$("[name='hiddenCompany']").hide();
		}else{
			$("ul.tabmenu-type li a:eq(0)").trigger('click.modalTab');
			$("ul.tabmenu-type li:eq(2)").hide();
			$("[name='hiddenCompany']").show();
			bizPpOpp.reset();
		}
		//$("ul.tabmenu-type").off('click.modalTab', 'li a', modalEvent.clickModalTab);
		//$("ul.tabmenu-type").on('click.modalTab', 'li a', modalEvent.clickModalTab);
	}
}
	
var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			//자동완성 검색
                                        
			commonSearch.singleCompany($("#formModalData #textCommonSearchCompany"), $('#formModalData #liModalSingleCompany'), $('#formModalData #hiddenModalCompanyId')); //고객사
			
			commonSearch.singleMember($("#formModalData #textModalExecutionOwner"), $('#formModalData #liModalSingleExecutionOwner'), $('#formModalData #hiddenModalExecutionOwner')); //실행임원
			
			commonSearch.singleMember($("#formModalData #textModalSalesOwner"), $('#formModalData #liModalSingleSalesOwner'), $('#formModalData #hiddenModalSalesOwner')); //영업대표
			
			//유효성 검사
			$("#textModalSubject, #selectModalCategory, #textCommonSearchCompany, #textModalExecutionOwner, #textModalSalesOwner, #textareaModalDetailContents, #textModalEndDate").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalExecutionOwner":
						$("#formModalData").find("#hiddenModalExecutionOwner").valid();
						break;
					case "textModalSalesOwner":
						$("#formModalData").find("#hiddenModalSalesOwner").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			});
			
			// 그리드 셋팅
			var cols = [];
			cols.push(grid.buildCol('*', '이슈내용'));
			cols.push(grid.buildCol(160, '해결계획'));
			cols.push(grid.buildCol(110, '책임자'));
			cols.push(grid.buildCol(135, '해결목표일'));
			cols.push(grid.buildCol(135, '실제완료일'));
			cols.push(grid.buildCol(50, 'status'));
			cols.push(grid.buildCol(40, '삭제'));
			
			var gridColObj = {
		    		contents : 'ISSUE_NAME',
		    		plan : 'ACTION_PLAN_NAME',
		    		planDate : 'DUE_DATE',
		    		actualDate : 'CLOSE_DATE',
		    		gridId : 'ACTION_ID',
		    		memberId : 'ACTION_OWNER_ID',
		    		memberName : 'ACTION_OWNER',
		    		memberPosition : 'ACTION_OWNER_POSITION'
		    };
			
			grid.setGrid(cols, gridColObj);
		},
		
		deleteFile : function(fileId,projectId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=2&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;
					}
				},
				success : function(data) {
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					//projectList.completeReload();
					commonFile.reloadFile($("#hiddenModalPK").val(), 2);
				},
				complete: function() {
					$.ajaxLoadingHide();
				}
			});
		},
		
		reset : function() { //신규등록 시 팝업창 초기화
			
			//EVENT ON
			modalEvent.on();
			bizPpOppEvent.on();
			milestonesEvent.on();
			
			modalFlag = "ins";
			$('#formModalData').validate().resetForm();	
		
			//대소문자 구분할 것
			var date = new Date();
			$("#divModalCreateDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#selectModalCategory").val("");
			$("#formModalData input:text").val("");
			$("#textModalStartDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#textModalEndDate").val("");
			$("#formModalData select").val("");
			$('input[id^="textModalContractMonthAmount"][class="pay"]').val("0");
			$('input[id^="textModalContractQuarterAmount"][class="pay"]').val("0");
			$('input[id^="textModalContractQuarterAmount"][class="pay"]').attr("readonly",false);
			$('input[id^="textModalInvestMonthAmount"][class="pay"]').val("0");
			$('input[id^="textModalInvestQuarterAmount"][class="pay"]').val("0");
			$('input[id^="textModalInvestQuarterAmount"][class="pay"]').attr("readonly",false);
			$("#modalContract").hide();
			$("#modalInvest").hide();
			$("#textModalSubject").val("");
			$("#textareaModalDetailContents").val("");
			$("#textareaModalDetailContents").height(1).height(33);
			
			$("#hiddenModalProjectId").val("");
			$("#hiddenModalCompanyId").val("");
			$("#hiddenModalSalesOwner").val("");
			$("#hiddenModalExecutionOwner").val("");
			$("#hiddenModalTotalContractAmount").val("");
			$("#hiddenModalTotalInvestAmount").val("");
			$("#hiddenModalContractPlanAmount").val("");
			$("#hiddenModalContractActualAmount").val("");
			$("#hiddenModalInvestPlanAmount").val("");
			$("#hiddenModalInvestActualAmount").val("");
			
			$("ul.flexdatalist-multiple li.value").remove();
			$("#formModalData #textCommonSearchCompany").show();
			$("#formModalData #textModalExecutionOwner").show();
			$("#formModalData #textModalSalesOwner").show();
			
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#divModalContractAmount .progress-cutom").html('');
			$("#divModalInvestAmount .progress-cutom").html('');
			$("#hiddenModalPK").val("");

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
			
			commonFile.reset();
			$("#buttonModalDelete").hide();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			//$("#divModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			//$("#textModalExecutionOwner").val("${userInfo.HAN_NAME}");
			$("#divModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#textModalDivision").attr("placeholder","${userInfo.MEMBER_TEAM}");
			$("h4.modal-title").html("전략 프로젝트 신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			//전략프로젝트 카테고리 자동 선택
			$("#selectModalCategory").val(category).attr("selected", "selected");
			
			bizPpOpp.reset();
			
			// 마일스톤 초기화
			milestones.reset();
			//mileStones.clear();
			//mileStones.draw();
			//mileStones.reload();
			
			/* actionPlan.clear();
			actionPlan.draw();
			actionPlan.reload(); */
			//actionPlan.reset();
			// 그리드 초기화
			grid.gridReset();
			grid.gridAdd();
			
			//모달 탭초기화.
			$("ul.tabmenu-type li a").removeClass("sel");
			$("ul.tabmenu-type > li:nth-child(1) > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(0).removeClass("off");
			
			$("a[name='aMoveSingleCompany']").remove();
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: "", 
					rules : {
						selectModalCategory : {
							required : true
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						hiddenModalCompanyId : {
							required : function(){
								if($("#selectModalCategory").val() == "1"){
									return false;
								}else{
									return true;	
								}
							}
						},
						hiddenModalExecutionOwner : {
							required : true,
							minlength : 1
						},
						hiddenModalSalesOwner : {
							required : true,
							minlength : 1
						},
						textModalStartDate : {
							required : true,
							minlength : 1
						},
						textModalEndDate : {
							required : true,
							maxlength : 10
						},
						textModalSubject : {
							required : true,
							minlength : 1
						},
						textareaModalDetailContents : {
							required : true,
							minlength : 1
						},
					//pwdConfirm:{required:true, equalTo:"#pwd"}, 
					// equalTo : id가 pwd인 값과 같아야함
					//name:"required", // 검증값이 하나일 경우 이와 같이도 가능
					//personalNo1:{required:true, minlength:6, digits:true},
					// minlength : 최소 입력 개수, digits: 정수만 입력 가능
					//personalNo2:{required:true, minlength:7, digits:true},
					//email:{required:true, email:true},
					// email 형식 검증
					//blog:{required:true, url:true}
					// url 형식 검증
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						selectModalCategory : {
							required : "프로젝트 항목을 선택하세요.", // 이와 같이 규칙이름과 메시지를 작성
						//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
						//digits:"숫자만 입력해 주세요."
						},
						hiddenModalCompanyId : {
							required : "고객사를 입력하세요."
						},
						hiddenModalExecutionOwner : {
							required : "책임리더를 입력하세요."
						},
						hiddenModalSalesOwner : {
							required : "영업대표를 입력하세요."
						},
						textModalStartDate : {
							required : "기간선택을 해주세요.\n(시작일)",
						},
						textModalEndDate : {
							required : "기간선택을 해주세요.\n(종료일)",
						},
						textModalSubject : {
							required : "사업전략 제목을 입력하세요.",
						//rangelength:"1글자 이상, 30글자 이하여야 합니다"
						},
						textareaModalDetailContents : {
							required : "상세내용을 입력하세요.",
						//rangelength:"1글자 이상, 30글자 이하여야 합니다"
						}
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "hiddenModalCompanyId") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else if($(element).prop("id") == "hiddenModalExecutionOwner") {
					        $("#textModalExecutionOwner").after(error);
					        location.href = "#textModalExecutionOwner";
					    }else if($(element).prop("id") == "hiddenModalSalesOwner") {
					        $("#textModalSalesOwner").after(error);
					        location.href = "#textModalSalesOwner";
					    }
					    else {
					        error.insertAfter(element); // default error placement.
					    }
					    
					    setTimeout(function(){
					    	$("ul.tabmenu-type li a:eq(0)").trigger('click.modalTab');
					    },200)
					    
					}
				});
		}, 
		
		submit : function(){
			//금액
			$("#hiddenModalTotalContractAmount").val(uncomma($("#textModalTotalContractAmount").val()));
			$("#hiddenModalTotalInvestAmount").val(uncomma($("#textModalTotalInvestAmount").val()));
			
			var cpaArr = [], caaArr= [],ipaArr= [],iaaArr = [];
			
			$("input[name='textModalContractPlanAmount']").each(function(){
				cpaArr.push(uncomma($(this).val()));
			});
			
			$("input[name='textModalContractActualAmount']").each(function(){
				caaArr.push(uncomma($(this).val()));
			});
			
			$("input[name='textModalInvestPlanAmount']").each(function(){
				ipaArr.push(uncomma($(this).val()));
			});
			
			$("input[name='textModalInvestActualAmount']").each(function(){
				iaaArr.push(uncomma($(this).val()));
			});
			
			$("#hiddenModalContractPlanAmount").val(cpaArr);
			$("#hiddenModalContractActualAmount").val(caaArr);
			$("#hiddenModalInvestPlanAmount").val(ipaArr);
			$("#hiddenModalInvestActualAmount").val(iaaArr);
			
			//영업기회
			bizPpOpp.setList();
			
			//Milestones
			milestones.msAddListMaster();
			
			//for(var i=1; i <=5; i++){
			//	$milestonesProjectPlan.jqGrid('saveRow', i);
			//}
			
			//Action Plan
			/* var gridLength = $projectPlanActionPlan.jqGrid('getGridParam', 'records');
			$projectPlanActionPlan.jqGrid('saveRow', actionPlan.lastEditRow);
			for(var i=1; i<=gridLength; i++){
				$projectPlanActionPlan.jqGrid('saveRow', i);
			} */
			
			var url;
			(modalFlag == "ins") ? url = "/bizStrategy/insertProjectPlan.do" : url = "/bizStrategy/updateProjectPlan.do";
			 $('#formModalData').ajaxForm({
	    		url : url,
	    		async : false,
	    		dataType: "json",
	    		data : {
	    			datatype : 'json',
	    			actionPlanData : JSON.stringify(grid.gridSubmitList()),
	    			//mileStonesData : JSON.stringify($milestonesProjectPlan.getRowData()),
	    			milestone : JSON.stringify(milestones.msList),
	    			oppData : JSON.stringify(bizPpOpp.list),
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
	            	// 이슈 유효성 체크
	                if(!grid.gridValid) return false;
	            	if($('#textModalStartDate').val()>$('#textModalEndDate').val()) {
	            		alert("종료일이 시작일보다 이전입니다."); return false;
	            	}
	            	if(!compareFlag){
						if(!confirm("저장하시겠습니까?")) return false;
	            	}
	            	$.ajaxLoadingShow();
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	                //성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	alert("저장하였습니다.");
	                	
	                	compareFlag = false;
	                	//$sellersGrid.trigger("reloadGrid");
	                	//projectList.reset();
						//projectList.getDivision();
						//projectList.get();
						compare_before = $("#formModalData").serialize();
						
	                	//모달 닫을때 변경 값 체크
	            		if(modalFlag=="upd"){
	            			//compare_before = $("#formModalData").serialize();
	                		//compareFlag = false;
	                		projectList.completeReload();
						}else{
							//projectList.reset();
							//projectList.getDivision();
							//projectList.get();
							projectList.searchReset();  //등록/수정 시 검색 초기화
						}
	                	
	            		var cat = $('#formModalData select[name="selectModalCategory"]').val();
						if(cat == "1"){
							projectList.categoryTab(1,$('ul.nav.nav-tabs li a:contains("신규솔루션")')["0"]);
						}else if(cat == "2"){
							projectList.categoryTab(2,$('ul.nav.nav-tabs li a:contains("선투자프로젝트")')["0"]);
						}else if(cat == "3"){
							projectList.categoryTab(3,$('ul.nav.nav-tabs li a:contains("전략프로젝트")')["0"]);
						}else{
							projectList.categoryTab(1,$('ul.nav.nav-tabs li a:contains("신규솔루션")')["0"]);
						}
	                	
	            		$('#myModal1').modal("hide");
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	           
	            },
	            complete: function() {
	            	$.ajaxLoadingHide();
				}
	        });
		},
		
		deleteModal : function(){
			var params = $.param({
				datatype : 'json',
				hiddenModalProjectId : $("#hiddenModalProjectId").val()
			});
			$.ajax({
				async : false,
				url : "/bizStrategy/deleteProjectPlan.do",
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				datatype : 'json',
				data : params,
				success : function(data){
					/* alert(data.cnt);
					if(data.cnt > 0) */ alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/bizStrategy/gridProjectPlanList.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		display : function(box, type){
			if(box.value=="q") {
				$("#modal"+type).show();
				$("#modalMonth"+type).hide();
				$("#modalQuarter"+type).show();
				$("#modalMonthActual"+type).hide();
				$("#modalQuarterActual"+type).show();
			}else if(box.value=="m") {
				$("#modal"+type).show();
				$("#modalMonth"+type).show();
				$("#modalQuarter"+type).hide();
				$("#modalMonthActual"+type).show();
				$("#modalQuarterActual"+type).hide();
			}else {
				$("#modal"+type).hide();
			}
		}
}

// jq 그리드 => html 로 변경
/* var mileStones = {
		init : function(){
			$milestonesProjectPlan = $("#milestonesProjectPlan");
		},
		lastEditRow : null, 
		initData : [
			{ROWNUM : '1', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
			{ROWNUM : '2', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
			{ROWNUM : '3', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
			{ROWNUM : '4', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
			{ROWNUM : '5', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null}
		], 
		draw : function() {
			var params = $.param({
				datatype : 'json',
				project_id : $("#hiddenModalPK").val()
			});
			$milestonesProjectPlan.jqGrid({
	 			url : "/bizStrategy/selectMileStonesProjectPlanList.do",
	 			mtype: 'POST',
	 			postData : params,
				datatype : 'json',
				 jsonReader : { 
				    root: "rows",
				},  
				colModel : [ {
					label : 'No',
					name : 'ROWNUM',
					align : "center",
					width : 50
				}, {
					label : 'Key Milestones',
					name : 'KEY_MILESTONE',
					align : "center",
					editable: true,
					width : 430
				}, {
					label : '책임 담당자',
					name : 'ACT_NAME',
					align : "center",
					editable: true,
					width : 90,
					classes : "grid pos-rel",
					editoptions: {
						  dataEvents: [
         					{ 
         						type: 'change', 
         						fn: function() {
         							milestone.changeStatus();
         						} 
         					}
							],
							dataInit: function (element,rwdat) {
								commonSearch.memberGrid($(element), $(element).parent('td').siblings(".hidden_act_id"));
                        }
					}
				}, {
					label : 'ACT_ID',
					name : 'ACT_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '목표일',
					name : 'ACT_DUE_DATE',
					index : 'ACT_DUE_DATE',
					align : "center",
					editable: true,
					sorttype:"date",
					width : 90,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							mileStones.changeStatus();
		             						} 
		             					}
						],
                        // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                        // use it to place a third party control to customize the toolbar
                        dataInit: function (element) {
                           $(element).datepicker({
                        	   todayBtn: "linked",
                               keyboardNavigation: false,
                               forceParse: false,
                               calendarWeeks: true,
                               autoclose: true
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        }
                  	}
				}, {
					label : '완료일',
					name : 'ACT_CLOSE_DATE',
					index : 'ACT_CLOSE_DATE',
					align : "center",
					editable: true,
					sorttype:"date",
					width : 90,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							mileStones.changeStatus();
		             						} 
		             					}
						],
                        // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                        // use it to place a third party control to customize the toolbar
                        dataInit: function (element) {
                           $(element).datepicker({
                        	   todayBtn: "linked",
                               keyboardNavigation: false,
                               forceParse: false,
                               calendarWeeks: true,
                               autoclose: true
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        }
                  	}
				}, {
					label : 'Status',
					align : "center",
					name : 'STATUS',
					index : "STATUS",
					width : 50 ,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$milestonesProjectPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$milestonesProjectPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$milestonesProjectPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								break;
							default:
								return "";
								break;
							}	
						}else{
							return "";
						}
					}
				}, {
					label : 'MILESTONE_ID',
					name : 'MILESTONE_ID',
					hidden : true
				},{
					label : 'HIDDEN_STATUS',
					name : 'HIDDEN_STATUS',
					hidden : true
				}
				//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
				],
				height : "100%",
				shrinkToFit: true,
				onSelectRow : function(id) { //row 선택시 처리. ids는 선택한 row
					//if(id && mileStones.lastEditRow != id){
						$(this).jqGrid('saveRow',mileStones.lastEditRow,true);
						$(this).jqGrid('editRow',id,true);
						mileStones.lastEditRow = id;
					//}
				},
				onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
					//  if(action == 'next'){
					//	currPage = getGridParam("page");
					//}
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					var list = data.rows;
					if(list.length == 0){
						for(var i=0;i<=mileStones.initData.length;i++){
			                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
			                $(this).jqGrid('addRowData',i+1,mileStones.initData[i]);
			        	} 							
					}else{
						for(var i=0; i<list.length; i++ ){
							if(list[i].STATUS == 'G'){
								$milestonesProjectPlan.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
							}else if(list[i].STATUS == 'Y'){
								$milestonesProjectPlan.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
							}else if(list[i].STATUS == 'R'){
								$milestonesProjectPlan.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
							}
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
		},
		
		clear : function(){
			$milestonesProjectPlan.jqGrid('clearGridData');
		},
		
		reload : function(){
			var params = $.param({
				datatype : 'json',
				project_id : $("#hiddenModalPK").val().toString()
			});
			$milestonesProjectPlan.jqGrid(
					'setGridParam', 
					{
						url : "/bizStrategy/selectMileStonesProjectPlanList.do",
						mtype: 'POST',
						datatype : 'json',
						postData : params,
		 			}
				).trigger('reloadGrid');
		},
		
		insert : function(){
			mileStones.saveRow();
			$.ajax({
					url : "/bizStrategy/insertMileStonesProjectPlanList.do",
					async : false,
					datatype : 'json',
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(!confirm('Key Milsestones을 저장하시겠습니까?')) return false;
						$.ajaxLoading();
					},
					data : {
						datatype : 'json',
						mileStonesData : JSON.stringify($milestonesProjectPlan.getRowData()),
						project_id : $("#hiddenModalProjectId").val(),
						category : $("#selectModalCategory").val(),
						creator_id : $("#hiddenModalCreatorId").val()
					},
					success : function(data){
						projectList.completeReload();
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
			}).done(function(data){
				if(data.cnt > 0){
					alert("저장하였습니다.");	
				}else{
					alert("Key Milsestones 입력을 실패했습니다.\n관리자에게 문의하세요.");
				}
			});
			
		},
		
		saveRow : function(){
			for(var i=1; i <=5; i++){
				$milestonesProjectPlan.jqGrid('saveRow', i);
			}
			$milestonesProjectPlan.jqGrid('saveRow', mileStones.lastEditRow);
		},
		
		changeStatus : function(){
			$milestonesProjectPlan.jqGrid('saveRow', mileStones.lastEditRow);
			var dueDate= ($milestonesProjectPlan.jqGrid('getCell',mileStones.lastEditRow,'ACT_DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($milestonesProjectPlan.jqGrid('getCell',mileStones.lastEditRow,'ACT_CLOSE_DATE').replaceAll("-","")).trim();
			
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'STATUS', 'Y');
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'STATUS', 'R');
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'STATUS', 'G');
				$milestonesProjectPlan.jqGrid('setCell', mileStones.lastEditRow, 'HIDDEN_STATUS', 'G');
			}
			
			mileStones.lastEditRow = 0;
		},
}  */


/* var actionPlan = {
		init : function(){
			$projectPlanActionPlan = $("#projectPlanActionPlan");
		},
		
		actionPlanFlag : true,
		lastEditRow : null,
		actionPlanLength : null,
		
		reset : function(){
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalProjectId").val()
			});
			$projectPlanActionPlan.jqGrid(
					'setGridParam', 
					{ 
						datatype: 'json' , 
						url : "/bizStrategy/selectProjectPlanIssue.do",
						mtype: 'POST',
						postData : params
					}
				).trigger('reloadGrid');
		},
		
		insert : function(){
			var params;
			var gridLength = $projectPlanActionPlan.jqGrid('getGridParam', 'records');
			$projectPlanActionPlan.jqGrid('saveRow', actionPlan.lastEditRow);
			for(var i=1; i<=gridLength; i++){
				$projectPlanActionPlan.jqGrid('saveRow', i);
			}
			$.ajax({
				url : "/bizStrategy/insertProjectPlanIssue.do",
				async : false,
				datatype : 'json',
				data : {
					datatype : 'json',
					actionPlanData : JSON.stringify($projectPlanActionPlan.getRowData()),
					hiddenModalPK : $("#hiddenModalProjectId").val(),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("Action Plan을 저장하시겠습니까?")){
						actionPlan.lastEditRow = 0;
						return false;	
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("저장하였습니다.");
						actionPlan.lastEditRow = 0;
						params = $.param({
							datatype : 'json',
							hiddenModalPK : $("#hiddenModalProjectId").val()
						});
						$projectPlanActionPlan.jqGrid(
								'setGridParam', 
								{ 
									datatype: 'json' , 
									url : "/bizStrategy/selectProjectPlanIssue.do",
									mtype: 'POST',
									postData : params
								}
							).trigger('reloadGrid');
//						projectList.completeReload();
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		deleteActionPlan : function(actionplan_id){
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalProjectId").val(),
				actionplan_id : actionplan_id
			});
			if(!actionplan_id){
				actionPlan.delRowActionPlan();
				return;
			}
			
			$.ajax({
				url : "/bizStrategy/deleteProjectPlanActionPlan.do",
				datatype : 'json',
				method : 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("삭제하시겠습니까?")){
						actionPlan.lastEditRow = 0;
						return false;
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						alert("삭제되었습니다.");
						actionPlan.lastEditRow = 0;
						params = $.param({
							datatype : 'json',
							hiddenModalPK : $("#hiddenModalProjectId").val()
						});
						
						$projectPlanActionPlan.jqGrid(
								'setGridParam', 
								{ 
									datatype: 'json' , 
									url : "/bizStrategy/selectProjectPlanIssue.do",
									mtype: 'POST',
									postData : params
								}
							).trigger('reloadGrid');
						projectList.completeReload();
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		draw : function() {
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalProjectId").val()
			});
			$projectPlanActionPlan.jqGrid({
	 			url : "/bizStrategy/selectProjectPlanIssue.do",
	 			mtype: 'POST',
	 			postData : params,
				datatype : 'json',
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '이슈영역',
					name : 'ISSUE_NAME',
					align : "center",
					width : 100,
					editable: true
				}, {
					label : '이슈항목',
					name : 'ISSUE_ITEM',
					align : "center",
					width : 140,
					editable: true
				}, {
					label : '실행계획 상세내용',
					name : 'ACTION_PLAN_NAME',
					align : "center",
					width : 200,
					editable: true
				}, {
					label : '해결책임자',
					name : 'ACTION_OWNER',
					align : "center",
					width : 90,
					classes : "grid pos-rel",
					editable: true,
					editoptions: {
						  dataEvents: [
         					{ 
         						type: 'change', 
         						fn: function() {
         							mileStones.changeStatus();
         						} 
         					}
							],
							dataInit: function (element,rwdat) {
								commonSearch.memberGrid($(element), $(element).parent('td').siblings(".hidden_act_owner_id"));
                        }
					}
				}, {
					label : 'ACTION_OWNER_ID',
					name : 'ACTION_OWNER_ID',
					classes : 'hidden_act_owner_id',
					hidden : true
				}, {
					label : '목표일',
					name : 'DUE_DATE',
					align : "center",
					width : 90,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							actionPlan.changeStatusActionPlan();
		             						} 
		             					}
									],
                        // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                        // use it to place a third party control to customize the toolbar
                        dataInit: function (element) {
                           $(element).datepicker({
                        	   todayBtn: "linked",
                               keyboardNavigation: false,
                               forceParse: false,
                               calendarWeeks: true,
                               autoclose: true,
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        	//.datepicker("setDate", new Date());
                        }
                  	}
				}, {
					label : '완료일',
					name : 'CLOSE_DATE',
					align : "center",
					width : 90,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							actionPlan.changeStatusActionPlan();
		             						} 
		             					}
									],
                        // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                        // use it to place a third party control to customize the toolbar
                        dataInit: function (element) {
                           $(element).datepicker({
                        	   todayBtn: "linked",
                               keyboardNavigation: false,
                               forceParse: false,
                               calendarWeeks: true,
                               autoclose: true
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        }
                  	}
				}, {
					label : 'Status',
					name : 'STATUS',
					align : "center",
					width : 50,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$projectPlanActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$projectPlanActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$projectPlanActionPlan.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								break;
							default:
								return "";
								break;
							}	
						}else{
							return "";
						}
					}
				}, {
					label : '',
					name : '삭제',
					align : "center",
					width : 40,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='actionPlan.deleteActionPlan("+colpos.ACTION_ID+");'><i class='fa fa-trash-o fa-lg'></i></a>"; 
					}
				}, {
					label : 'ACTION_ID',
					name : 'ACTION_ID',
					hidden : true
				}, {
					label : 'PROJECT_ID',
					name : 'PROJECT_ID',
					hidden : true
				}, {
					label : 'CREATOR_ID',
					name : 'CREATOR_ID',
					hidden : true
				}, {
					label : 'SYS_REGISTER_DATE',
					name : 'SYS_REGISTER_DATE',
					hidden : true
				}
				],
				loadui: 'disable',
				loadonce : false,
				viewrecords : true,
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					var rowData = $(this).jqGrid("getRowData",id);
					//if(id && actionPlan.lastEditRow != id){
						$(this).jqGrid('saveRow',actionPlan.lastEditRow,true);
						$(this).jqGrid('editRow',id,true);
						actionPlan.lastEditRow = id;
					//}
				},
				
				onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
					//  if(action == 'next'){
					//	currPage = getGridParam("page");
					//}
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					actionPlan.actionPlanLength = $projectPlanActionPlan.jqGrid('getGridParam', 'records');
					var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						if(list[i].STATUS == 'G'){
							$projectPlanActionPlan.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$projectPlanActionPlan.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$projectPlanActionPlan.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
			
			if(actionPlan.actionPlanFlag){
				$projectPlanActionPlan.jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'ISSUE_ITEM', numberOfColumns: 5, titleText: '이슈해결계획 (How to Fix)'},
					  ]
				});
				actionPlan.actionPlanFlag = false;
			}
		},
		
		addRowActionPlan : function(){
			var gridLength = $projectPlanActionPlan.jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$projectPlanActionPlan.jqGrid('saveRow', i);
			}
 			$projectPlanActionPlan.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$projectPlanActionPlan.jqGrid('saveRow', gridLength+1);
		},
		
		delRowActionPlan : function(){
			$projectPlanActionPlan.jqGrid('delRowData', $projectPlanActionPlan.getDataIDs().length);
		},
		
		changeStatusActionPlan : function(){
			$projectPlanActionPlan.jqGrid('saveRow', actionPlan.lastEditRow);
			var dueDate= ($projectPlanActionPlan.jqGrid('getCell',actionPlan.lastEditRow,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($projectPlanActionPlan.jqGrid('getCell',actionPlan.lastEditRow,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'STATUS', 'Y');
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'STATUS', 'R');
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'STATUS', 'G');
				$projectPlanActionPlan.jqGrid('setCell', actionPlan.lastEditRow, 'HIDDEN_STATUS', 'G');
			}
			
			actionPlan.lastEditRow = 0;
		},
		
		clear : function(){
			$projectPlanActionPlan.jqGrid('clearGridData');
		},
		
		reload : function(){
			var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalProjectId").val()
			});
			
			$projectPlanActionPlan.jqGrid(
					'setGridParam', 
					{ 
						url : "/bizStrategy/selectProjectPlanIssue.do",
		 				mtype: 'POST',
		 				postData : params,
		 				datatype : 'json'
					}
				).trigger('reloadGrid');
		}
		
} */
</script>