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
	                                    <div class="col-sm-12 ag_r" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
	                                </div>
	                                
	                                <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
	                                    
	                                <div class="hr-line-dashed"></div>
	                                <div class="form-group"><label class="col-sm-2 control-label">카테고리</label>
	                                    <div class="col-sm-4">
	                                        <div class="select-com"><!-- <label>항목선택</label> --> 
										    	 <select class="form-control" name="selectModalCategory" id="selectModalCategory">
		                                            <option value="고객전략" selected="selected">고객전략</option>
	                                        	</select>
	                                        </div>
	                                    </div>
	                               </div>
	                               
	                               <div class="hr-line-dashed"></div>
	                                    <div class="form-group">
											<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 책임리더</label>
									    	<div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalLeader" name="textModalLeader" placeholder="책임리더를 검색해 주세요." autocomplete="off"/></div>										    
									    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 검토주기</br>(반복일정)</label>
		                                    <div class="col-sm-4">
		                                        <div class="select-com"><!-- <label>항목선택</label> --> 
		                                                <select class="form-control" name="selectModalReviewCycle" id="selectModalReviewCycle">
		                                                <option value="">반복주기를 선택하세요</option>
		                                                <!-- 매주1회 새로 추가 2017-07-24 욱이 -->
		                                                <option value="3">매주 1회</option>
		                                                <option value="0">매월 1회</option>
		                                                <option value="1">분기 1회</option>
		                                                <option value="2">반기 1회</option>
		                                            </select>
		                                        </div>
		                                    </div>
	                                    </div>
	                               
	                                    <div class="hr-line-dashed"></div>
	                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 주요내용</label>
	                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalKeyContents" name="textareaModalKeyContents" 
	                                        onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
	                                        </div>
	                                    </div>
	                                        
                                     	  <!-- TabMenu -->
                                          <div class="tab-area">

                                                <!-- tab-menu -->
                                                <ul class="tabmenu-type">
                                                    <li><a href="#" class="sel">Key Milestones</a></li>
                                                    <li><a href="#" class="">이슈</a></li>
                                                    <li><a href="#" class="">첨부파일</a></li>
                                                </ul>
                                                <!--// tab-menu -->

                                                <!-- Key Milestones -->
                                                <div class="sub_cont scont1 modaltabmenu">
                                                	<%-- <jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyClientCompanyMilestonesModal.jsp" flush="false">
														<jsp:param name="url" value="/bizStrategy/selectBizStrategyMileStones.do" />
													</jsp:include> --%>
													<jsp:include page="/WEB-INF/jsp/pc/common/milestones_temp.jsp"/>
                                                </div>
                                                <!--// 기본정보 -->

                                                <!-- 이슈 -->
                                                <div class="sub_cont scont2 modaltabmenu off">
                                                	<%-- <jsp:include page="/WEB-INF/jsp/pc/bizstrategy/bizStrategyClientCompanyIssueModal.jsp"/> --%>
                                                	<jsp:include page="/WEB-INF/jsp/pc/common/grid.jsp" flush="false">
										            	<jsp:param name="gridAddBtnName" value="이슈"/>
										            	<jsp:param name="gridHtmlPath" value="/ajaxHtml/projectIssue.html"/>
										            	<jsp:param name="gridDelUrl" value="/bizStrategy/deleteBizStrategyIssue.do"/>
										            	<jsp:param name="gridSelectUrl" value="/bizStrategy/selectBizStrategyIssue.do"/>
										            	<jsp:param name="listObj" value="bizList"/>
										            </jsp:include>
                                                </div>
                                                <!--// 이슈 -->

                                                <!-- 파일첨부 -->
                                                <div class="sub_cont scont5 modaltabmenu off">
                                                    <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                                </div>
                                                <!--// 파일첨부 -->

                                            </div>
                                            <!--// TabMenu -->
                                             
	                                    <div class="hr-line-dashed"></div>
	                                    <p class="text-center">
	                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
	                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
	                                    </p>
	                                    
	                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
	                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
	                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
	                                    <input type="hidden" name="hiddenModalLeader" id="hiddenModalLeader"/>
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
var url = (($(location).attr("href")).replaceAll("#","")).trim();
$(document).ready(function() { 
	modal.init();
	
	//  초기화
	//milestone.init();
	//actionPlan.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			commonSearch.member($("#formModalData #textModalLeader"), $('#formModalData #hiddenModalLeader')); //책임리더
			
			//tab menu
			$("ul.tabmenu-type li a").click(function(e){
				e.preventDefault();
				var idx = $("ul.tabmenu-type li a").index($(this));
				$("ul.tabmenu-type li a").removeClass("sel");
				$(this).addClass("sel");
				$("div.modaltabmenu").addClass("off");
				$("div.modaltabmenu").eq(idx).removeClass("off");
			});
			
			//유효성 검사
			/* $("#textModalSubject, #textModalLeader, #selectModalReviewCycle, #textareaModalKeyContents").on("blur",function(e){
				switch (e.target.id) {
					case "textModalLeader":
						$("#formModalData").find("#hiddenModalLeader").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			}); */
			
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

		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=1&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("파일을 삭제하시겠습니까?")){
						return false;	
					}
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					//bizList.completeReload();
					commonFile.reloadFile($("#hiddenModalPK").val(), 1);
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		reset : function() { //신규등록 시 팝업창 초기화
			modalFlag = "ins";
			$('#formModalData').validate().resetForm();	
		
			// EVENT ON
			milestonesEvent.on();
			
			//대소문자 구분할 것
			var date = new Date();
			$("#divModalCreateDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#selectModalCategory").val("");
			$("#selectModalReviewCycle").val("");
			$("#textModalSubject").val("");
			$("#textareaModalKeyContents").val("");
			$("#textareaModalKeyContents").height(1).height(33);
			$("#textModalLeader").val("");
			$("#hiddenModalPK").val("");
			$("#hiddenModalLeader").val("");
			
			$("#buttonModalDelete").hide();
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("h4.modal-title").html("고객별전략 신규 등록");
			$("#selectModalCategory").val("고객전략");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			// 마일스톤 초기화
			milestones.reset();
			$("ul.flexdatalist-multiple li.value").remove();
			//milestone.clear();
			//milestone.reload();
			//milestone.draw();
			
			/* actionPlan.clear();
			actionPlan.draw();
			actionPlan.reload(); */
			// 그리드 초기화
			grid.gridReset();
			grid.gridAdd();
			
			//모달 탭초기화.
			$("ul.tabmenu-type li a").removeClass("sel");
			$("ul.tabmenu-type > li:nth-child(1) > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(0).removeClass("off");
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
			$("#formModalData").validate({ // joinForm에 validate를 적용
				ignore: '', 
				rules : {
					selectModalCategory : {
						required : true
					},
					// required는 필수, rangelength는 글자 개수(1~10개 사이)
					selectModalReviewCycle : {
						required : true
					},
					textModalSubject : {
						required : true,
						maxlength : 50
					},
					textareaModalKeyContents : {
						required : true
					},
					hiddenModalLeader : {
						required : true
					}
				},
				messages : { // rules에 해당하는 메시지를 지정하는 속성
					selectModalCategory : {
						required : "전략 항목을 선택하세요." // 이와 같이 규칙이름과 메시지를 작성
					//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
					//digits:"숫자만 입력해 주세요."
					},
					selectModalReviewCycle : {
						required : "반복일정을 선택하세요."
					//rangelength:"1글자 이상, 30글자 이하여야 합니다"
					},
					textModalSubject : {
						required : "사업전략 제목을 입력하세요.",
						maxlength: $.validator.format('{0}자 내로 입력하세요.')
					//rangelength:"1글자 이상, 30글자 이하여야 합니다"
					},
					hiddenModalLeader : {
						required : "책임리더를 입력하세요."
					},
					textareaModalKeyContents : {
						required : "상세내용을 입력하세요."
					//rangelength:"1글자 이상, 30글자 이하여야 합니다"
					}
				},
				errorPlacement : function(error, element) {
					if($(element).prop("id") == "hiddenModalLeader") {
				        $("#textModalLeader").after(error);
				        location.href = "#textModalLeader";
				    }else{
				        error.insertAfter(element); // default error placement.
				    }
				}
			});
		}, 
		
		submit : function(){
			var url = (modalFlag == "ins") ? url = "/bizStrategy/insertBizStrategy.do" : url = "/bizStrategy/updateBizStrategy.do";
			milestones.msAddListMaster();
			//milestone.saveRow(); //Milestones
			//actionPlan.saveRow(); //이슈
			$('#formModalData').ajaxForm({ 
	    		url : url,
	    		dataType: "json",
	    		data : {
	    			datatype : 'json',
	    			actionPlanData : JSON.stringify(grid.gridSubmitList()),
	    			//milestone : JSON.stringify($milestone.getRowData()),
	    			milestone : JSON.stringify(milestones.msList),
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
	                // 이슈 유효성 체크
	                if(!grid.gridValid) return false;
	            	if(!confirm("저장하시겠습니까?")) return false;
	            	$.ajaxLoading(); //ajax loading
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	                //성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	alert("저장하였습니다.");
	                	
						compareFlag = false;
						compare_before = $("#formModalData").serialize();
	                	//모달 닫을때 변경 값 체크
	            		if(modalFlag=="upd"){
	            			//compare_before = $("#formModalData").serialize();
	                		//bizList.completeReload();
						}else{
							//bizList.reset();
							//bizList.get();
							bizList.searchReset(); //등록/수정 시 검색 초기화
						}
	            		bizList.reset();
						bizList.get(1);
	                	
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
		
		/**
		 * @author 	: 준이
		 * @Date		: 2017. 03. 17.
		 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 사업전략 삭제 -> 없어진 기능.
		 */
		/* deleteModal : function(){
			$.ajax({
				url : "/bizStrategy/deleteBizStrategy.do",
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					if(data.cnt > 0) alert("삭제하였습니다."); $('#myModal1').modal("hide");
					bizList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		} */
		
}
</script>