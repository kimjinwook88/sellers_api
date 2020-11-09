<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content border_n">
                            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                            	<div class="form-group">
                                    <div class="col-sm-12 ag_r">
                                    	<span class="label orange_count_bg" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView"><a onclick="coachingTalk.view('HOPP');"><i class="fa fa-comments-o" style="color: white;"></i> <span style="color: white;" id="spanCtCount"></span></a></span>
                                   		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
                                    </div>
                                	
                                	<div id="divModalCoachingTalk" style="display: none;">
                               			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
                               		</div>
                                
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group">
	                              	  <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
	                                  <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
	                             </div>
                                
                                <!-- <div class="hr-line-dashed"></div> -->
                                 <div class="form-group" style="display: none;">
							   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
                                     <div class="col-sm-4 pos-rel">
                                         <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사 검색" autocomplete="off"/>
                                     </div>
                                     <label class="col-sm-2 control-label">고객사ID</label>
                                     <div class="col-sm-4 pos-rel">
                                        	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                        </div>
		                          </div>
                                   
                            	 <!-- <div class="hr-line-dashed"></div> -->
                                    <div class="form-group" style="display: none;">
                               	  	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
                                     <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명 검색" autocomplete="off"/></div>
                               	  	<label class="col-sm-2 control-label">고객직급</label>
                                     <div class="col-sm-4"><input type="text" class="form-control" id="textModalCustomerRank" name="textModalCustomerRank"/></div>
                                 </div>
                                 
                                 <div class="hr-line-dashed"></div>
                                    <div class="form-group pos-rel">
                                    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 매출처</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleCompany" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleCompany" name="liModalSingleCompany">
                                                      <input type="text" class="form-control" id="textModalSingleCompany" name="textModalSingleCompany" placeholder="매출처를 검색해 주세요." autocomplete="off" autoFlag="y">
                                                      <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                                 </li>
                                              </ul>                                                            
                                          </div>
                                          
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> End User</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClient" name="liModalSingleClient">
                                                      <input type="text" class="form-control" id="textModalSingleClient" name="textModalSingleClient" placeholder="End User를 검색해 주세요." autocomplete="off" autoFlag="y">
                                                      <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                    </div>
                                
                                <div class="hr-line-dashed"></div>                                                                                    
                                  <div class="form-group">
                                      <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업대표</label>
                                         	<div class="col-md-9 col-lg-4">
                                            <ul id="ulModalSingleIdentifier" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleIdentifier" name="liModalSingleIdentifier">
                                                    <input type="text" class="form-control" id="textModalOppOwner" name="textModalOppOwner" placeholder="영업대표를 검색해 주세요." autocomplete="off" autoFlag="y">
                                                </li>
                                            </ul>                                                            
                                        </div>
	                                          
                                     <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 예상규모</label>
                                     <div class="col-sm-4">
                                         <input type="text" class="form-control" name="textModalAmount" id="textModalAmount" onkeyup="comma(this);" maxlength="14"/>
                                     </div>
                                   </div>
                                
                                <div class="hr-line-dashed"></div>
                                 <div class="form-group">
                                   	<label class="col-sm-2 control-label" for="date_modified">영업기회<br />전환시점</label>
	                                   <div class="col-sm-4">
	                                       <div class="data_1">
	                                           <div class="input-group date">
	                                               <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalSalesChangeDate" name="textModalSalesChangeDate">
	                                           </div>
	                                       </div>
	                                   </div>
                                 </div>
	                                
	                               <div class="hr-line-dashed" name="divRelation"></div>                                                
	                               <div class="form-group" name="divRelation">
	                                   <label class="col-sm-2 control-label">결과</label>
	                                 	<div class="col-sm-4 pd-t7" id="divModalResult">
                                       </div>
                                       <label class="col-sm-2 control-label">연관<br />고객컨택내용</label>
	                                     <div class="col-sm-4 pd-t7" id="relationContact">
                                         </div>
	                               </div>
                                  
                                  <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">내용</label>
                                       	<div class="col-sm-10">
                                       		<textarea class="pop-textarea-input" rows="5" id="textareaModalDetail" name="textareaModalDetail"
                                       		 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
                                       	</div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">Action Plan</label>
                                       <div class="col-sm-10">
                                       		<jsp:include page="/WEB-INF/jsp/pc/common/actionPlan.jsp" flush="false">
								            	<jsp:param name="fuaCategory" value="1"/>
								            </jsp:include>
                                       		<!-- <table id="hiddenActionPlanGrid"></table>
                                       		<p class="text-center pd-t10">
												<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal.addRow();">+ Action Plan 추가</a>
										    </p> -->
                                       	</div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">메일공유</label>
	                                     <div class="col-md-9 col-lg-10">
                                              <ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
                                                      <input type="text" class="form-control" id="textMultipleMailShareMember" name="textMultipleMailShareMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                   </div>
                                   
                                    <!-- <div class="hr-line-dashed"></div>
						            <div class="form-group pos-rel">
						            	<label class="col-md-3 col-lg-2 control-label">메일공유</label>
	                                    <div class="col-sm-10">
	                                        <div class="company-search mg-b5">
	                                            <div class="company-current">
	                                        	</div>
	                                            <button type="button" class="btn btn-gray btn-file" onClick="$('div.custom-company-pop').show();">직원 검색</button>
	                                        </div>                                                                                            
	                                    </div>
	                                    
	                                    <div class="custom-company-pop off">
	                                        <div class="pop-header">
	                                            <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	                                            <strong class="pop-title">직원선택</strong>
	                                        </div>
	                                        <div class="col-sm-12 cont">
	                                            <div class="form-group">
	                                                <div class="col-sm-12">
	                                                    <div class="company-search-after mg-b5">검색
	                                                        <input type="text" placeholder="직원 검색" class="form-control fl_l mg-r5" id="textCommonSearchMember">
	                                                        <button type="button" class="btn btn-gray btn-file" onClick="commonSearch.multipleMemberPop();">검색</button>
	                                                    </div>
	                                                </div>
	                                                <div class="col-sm-12 company-result mg-b10 ">검색 결과 노출시 "off" 삭제
	                                                    <strong>[직원 검색 결과]</strong>
	                                                    <ul class="company-list">
	                                                    </ul>
	                                                </div>
	                                            </div>
	                                            <div class="ta-c">
	                                                <button type="button" class="btn btn-gray btn-file">추가하기</button>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div> -->
	                                
                                   <div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-primary btn-gray-outline">삭제하기</button> -->
                                        <button type="submit" class="btn btn-w-m btn-seller" onclick="modal.submit(1);" id="buttonModalSubmit">저장하기</button>
                                        <button type="submit" class="btn btn-w-m btn-seller" onclick="modal.submit(2);" id="buttonModalSubmitShare">저장하기 및 공유하기</button>
                                    </p>
                                    
                                      <input type="hidden" name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
			                          <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
			                          <!-- <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
			                          <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/> -->
			                          <input type="hidden" name="hiddenModalSalesId" id="hiddenModalSalesId"/>
			                          <input type="hidden" name="hiddenModalContactId" id="hiddenModalContactId" value="${param.contactPK}"/>
			                          <input type="hidden" name="hiddenModalAmount" id="hiddenModalAmount"/>
			                          <input type="hidden" name="hiddenModalMemberList"	id="hiddenModalMemberList"/>
			                          <input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}"/>
                        			  <input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}"/>
                        			  <input type="hidden" name="hiddenRelationOpportunityId" id="hiddenRelationOpportunityId"/>
                        			  <input type="hidden" name="hiddenModalOppOwnerName" id="hiddenModalOppOwnerName"/>
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
});		

var modal = {
		lastEdit : 0,		
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			//commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			//commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
			//commonSearch.singleClientIndividual($("#formModalData #textModalSingleClient"), $("#formModalData #liModalSingleClient"), $("#formModalData #textCommonSearchCompany"), $("#formModalData #hiddenModalCompanyId"), 
				//	$("#formModalData #textModalCustomerName"), $("#formModalData #hiddenModalCustomerId"), $("#formModalData #textModalCustomerRank"));
			//commonSearch.member($('#formModalData #textModalOppOwner'), $('#formModalData #hiddenModalSalesId'));
			commonSearch.singleMember($("#formModalData #textModalOppOwner"), $('#formModalData #liModalSingleIdentifier'), $('#formModalData #hiddenModalSalesId'), $('#formModalData #hiddenModalOppOwnerName')); //OI
			commonSearch.singleCompany($("#formModalData #textModalSingleCompany"), $('#formModalData #liModalSingleCompany'), $('#formModalData #hiddenModalCompanyId')); //고객사
			commonSearch.singleCompany($("#formModalData #textModalSingleClient"), $('#formModalData #liModalSingleClient'), $('#formModalData #hiddenModalCustomerId')); //고객명
			commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
			
			//직원 검색
			/* $('#textCommonSearchMember').on('keydown',function(key){
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					commonSearch.multipleMemberPop();
			     }
			}); */
			
			//유효성 검사
			$("#textCommonSearchCompany, #textModalCustomerName, #textModalOppOwner, #textModalSubject").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData").find("#hiddenModalCustomerId").valid();
						break;
					case "textModalOppOwner":
						$("#formModalData").find("#hiddenModalSalesId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			});
			
			$hiddenActionPlanGrid  = $("#hiddenActionPlanGrid");
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=8&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
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
					suggestList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			list.modalFlag = "ins"; //신규등록
			
			//모달 초기화
			$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			$("#textModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//코칭톡 버튼 제거, 창 hide
			$("#buttonModalCoachingTalkView").hide();
			$("#divModalCoachingTalk").hide();
			
			//validate 초기화 및 text,selectbox,radio.. 등 초기화
			$("#formModalData").validate().resetForm();
			$("#formModalData textarea").height(1).height(33);
			
			$("#formModalData #hiddenModalMemberList").val("");
			commonSearch.multipleMailShareMemberArray = [];
			$("ul.flexdatalist-multiple li.value").remove();
			
			$("#formModalData #textModalSingleClient").show();
			
			$("#ulModalSingleCompany > a").remove();
			$("#textModalSingleCompany").show();
			$("#ulModalSingleClient > a").remove();
			$("#textModalOppOwner").show();
			
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalSalesId").val("");
			$("#formModalData #hiddenModalOppOwnerName").val("");
			$("#formModalData #hiddenModalCustomerId").val("");
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData #hiddenRelationOpportunityId").val("");
			$("#formModalData #hiddenModalContactId").val("");
			$("input:radio[name='radioSuggestResult']").prop("checked",false);
			$("input:radio[name='radioSuggestProgress']").prop("checked",false);
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$('[name="divRelation"]').hide();
			
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			$("#buttonModalDelete").hide();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			// Action Plan
			fuaReset();
			fuaAdd();
			
			/* modal.drawHiddenActionPlan();
			modal.actionPlanReload(); */
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("잠재영업기회 신규 등록");
			$("small.font-bold").css('display','none');
			
			$("div.custom-company-pop.off").hide(); //메일공유 직원검색 팝업숨김
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			list.compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
			$("#formModalData").validate({ // joinForm에 validate를 적용
				ignore: "",
				rules : {
					textModalSubject : {
						required : true,
						maxlength : 50
					},
					/* selectModalCategory : {
						required : true
					}, */
					// required는 필수, rangelength는 글자 개수(1~10개 사이)
					hiddenModalCompanyId : {
						required : true
					},
					hiddenModalCustomerId : {
						required : true
					},
					hiddenModalSalesId : {
						required : true
					},
					textModalAmount : {
						required : true
					}
				},
				messages : { // rules에 해당하는 메시지를 지정하는 속성
					textModalSubject : {
						required : "제목을 입력하세요.",
						maxlength: $.validator.format('{0}자 내로 입력하세요.') 
					},
					/* selectModalCategory : {
						required : "잠재기회 영역을 선택하세요." 
						// 이와 같이 규칙이름과 메시지를 작성
						//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
						//digits:"숫자만 입력해 주세요."
					}, */
					hiddenModalCompanyId : {
						required : "고객사를 선택하세요."
					},
					hiddenModalCustomerId : {
						required : "고객명을 입력해 주세요."
					},
					hiddenModalSalesId : {
						required : "영업대표를 입력해 주세요."
					},
					textModalAmount : {
						required : "예상규모를 입력해 주세요."
					}
				},
				errorPlacement : function(error, element) {
					if($(element).prop("id") == "textModalSubject"){
						$("#textModalSubject").after(error);
				        location.href = "#textModalSubject";
				    }else if($(element).prop("id") == "hiddenModalCompanyId") {
				        //$("#textCommonSearchCompany").after(error);
				        //location.href = "#textCommonSearchCompany";
				    }else if($(element).prop("id") == "hiddenModalSalesId") {
				        $("#textModalOppOwner").after(error);
				        location.href = "#textModalOppOwner";
				    }else if($(element).prop("id") == "hiddenModalCustomerId") {
				        //$("#textModalCustomerName").after(error);
				        //location.href = "#textModalCustomerName";
				        $("#ulModalSingleClient").after(error);
				        location.href = "#textModalSingleClient";
				    }else {
				        error.insertAfter(element); // default error placement.
				    }
				}
			});
		}, 
		
		submit : function(shareFlag){
			var url = (list.modalFlag == "ins") ? url = "/clientSalesActive/insertHiddenOpportunity.do" : url = "/clientSalesActive/updateHiddenOpportunity.do";
			var gridLength = $hiddenActionPlanGrid.jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$hiddenActionPlanGrid.jqGrid('saveRow', i);
			}
			$("#hiddenModalAmount").val(uncomma($("#textModalAmount").val()));
			 $('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			hiddenActionPlan : JSON.stringify(fuaSubmitList()),
	    			salesClientName : $("#liModalSingleCompany").prevAll("li.value").find("span").html(),
	    			clientName : $("#liModalSingleClient").prevAll("li.value").find("span").html(),
	    			shareFlag : function(){
	    				if(shareFlag == 1){
	    					return false;
	    				}else{
	    					return true;
	    				}
	    			}
	    		},
	            beforeSubmit: function (data,form,option) {
	            	if(!fuaValid) return false;
	            	if(!list.compareFlag){
	            		if(!confirm("저장하시겠습니까?")){
							return false;
						}
            		}
	            	$.ajaxLoadingShow();
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	            	if(data.cnt > 0){
	            		alert("저장하였습니다.");
	                	
	                	list.compareFlag = false;
	            		list.compare_before = $("#formModalData").serialize();
	            		list.reset();
	            		
	                	if(list.modalFlag == "ins"){ //신규등록
	                		list.searchReset(); //등록/수정 시 검색 초기화
							if(list.issueFlag == "true"){
			            		alert("이슈 입력으로 이동합니다.");
			            		modal.returnFollowUpAction(list.contactPK, "/clientSatisfaction/viewClientIssueList.do");
			            	}
		            	}else if(list.modalFlag == "upd"){ //업데이트
		            		
		            	}
	                	list.get(1);
	                	$('#myModal1').modal("hide");
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
		            	
	            	//메일 공유자 리셋
	            	commonSearch.multipleMemberArray = [];
	            },
	            complete : function(){
					$.ajaxLoadingHide();
				}
	        });
		},
		
		returnFollowUpAction : function(contactPK, url){
			$("#formFollow #contactPK").val(contactPK);
			
			$("#formFollow #returnCompanyId").val($("#formModalData #hiddenModalCompanyId").val());
			$("#formFollow #returnCompanyName").val($("#formModalData #textCommonSearchCompany").val());
			$("#formFollow #returnCustomerName").val($("#formModalData #textModalCustomerName").val());
			$("#formFollow #returnCustomerId").val($("#formModalData #hiddenModalCustomerId").val());
			$("#formFollow #returnCustomerRank").val($("#formModalData #textModalCustomerRank").val());
			
			$("#formFollow").attr("action",url);
			$("#formFollow").submit();
		},
		
		drawHiddenActionPlan : function(){
			$hiddenActionPlanGrid.jqGrid({
				url : "/clientSalesActive/gridActionPlanHiddenOpportunity.do?pkNo="+$("#hiddenModalPK").val(),
				datatype : 'json',
				 jsonReader : { 
					    root: "rows",
				},  
				colModel : [ 
				{
					label : 'Action',
					name : 'DETAIL_CONENTS',
					align : "left",
					width : 260,
					edittype:'textarea',
					editable: true
				}, {
					label : 'ACTION_OWNER_ID',
					name : 'ACTION_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '담당자',
					name : 'ACTION_OWNER',
					align : "center",
					width : 100,
					classes : "grid pos-rel",
					editable: true,
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
				},{
					label : '해결목표일',
					name : 'DUE_DATE',
					align : "center",
					width : 100,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modal.changeStatus();
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
				},{
					label : '실제완료일',
					name : 'CLOSE_DATE',
					align : "center",
					width : 100,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							modal.changeStatus();
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
				},{	
					label : 'Status', 
					name : 'STATUS', 
					align : "center", 
					width : 50,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						if(rwdat == "edit"){
							switch (rowId) {
							case "G":
								$hiddenActionPlanGrid.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$hiddenActionPlanGrid.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$hiddenActionPlanGrid.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								break;
							default:
								return "";
								break;
							}	
						}else{
							return "";
						}
					}
				},{
					label : '',
					name : '삭제',
					align : "center",
					width : 50,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return '<a href="javascript:void(0);" onClick="modal.delRow(\''+cellval.rowId+'\',\''+colpos.ACTION_ID+'\');"><i class="fa fa-trash-o fa-lg"></i></a>'; 
					}
				},{
					label : 'HIDDEN_STATUS',
					name : 'HIDDEN_STATUS',
					hidden : true
				},{
					label : 'ACTION_ID',
					name : 'ACTION_ID',
					hidden : true
				}
				],
				loadui: 'disable',
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					var rowData = $(this).jqGrid("getRowData",id);
					if(id && modal.lastEdit != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', modal.lastEdit);
						modal.lastEdit = id;
					}else if(modal.lastEdit == id){
						$(this).jqGrid('editRow',id,true);
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
					var list = data.rows;
					for(var i=0; i<list.length; i++ ){
						console.log(list[i].STATUS);
						if(list[i].STATUS == 'G'){
							$hiddenActionPlanGrid.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$hiddenActionPlanGrid.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$hiddenActionPlanGrid.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
		},
		
		update : function(){
			var gridLength = $hiddenActionPlanGrid.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$hiddenActionPlanGrid.jqGrid('saveRow', i);
			}
			$hiddenActionPlanGrid.jqGrid('saveRow', modal.lastEdit);
			$.ajax({
				url : "/clientSalesActive/updateHiddenOpportunityActionPlan.do",
				async : false,
				method: 'POST',
				datatype : 'json',
				data : {
					hiddenActionPlanGridData : JSON.stringify($hiddenActionPlanGrid.getRowData()),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("저장하시겠습니까?")){
						return false;
					}
				},
				success : function(data){
					if(data.cnt > 0){
						alert("저장하였습니다.");	
					}else{
						alert("Action Plan 입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
					modal.lastEdit = 0;
					list.completeReload();
				},
				complete : function(){
					
				}
			});
		},
		
		clear : function(){
			$hiddenActionPlanGrid.jqGrid('clearGridData');
		},
		
		actionPlanReload : function(){
			//returnPK타고 들어올 경우 바로 인식 못하기 때문에 setTimeout..
			setTimeout(function(){ 
				$("#hiddenActionPlanGrid").jqGrid('setGridParam', {url :"/clientSalesActive/gridActionPlanHiddenOpportunity.do?pkNo="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
			},500);
		},
		
		addRow : function(){
			var gridLength = $hiddenActionPlanGrid.jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$hiddenActionPlanGrid.jqGrid('saveRow', i);
			}
 			$hiddenActionPlanGrid.jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$hiddenActionPlanGrid.jqGrid('saveRow', gridLength+1);
		},

		
		delRow : function(rowId, actionId){
			if(!isEmpty(actionId) && actionId != "undefined"){
				$.ajax({
					url : "/clientSalesActive/deleteActionPlanHiddenOpportunity.do",
					async : false,
					datatype : 'json',
					data : {
						action_id : actionId,
						hiddenModalPK : $("#hiddenModalPK").val()
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(!confirm("삭제하시겠습니까?")){
							return false;	
						}
						$.ajaxLoadingShow();
					},
					success : function(data){
						if(data.cnt > 0){
							$hiddenActionPlanGrid.jqGrid('delRowData', rowId);
							alert("삭제되었습니다.");
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
						}
					},
					complete: function(){
						$.ajaxLoadingHide();
					}
				});
			}else{
				$hiddenActionPlanGrid.jqGrid('delRowData', rowId);
			}
		},
		
		
		changeStatus : function(){
			$hiddenActionPlanGrid.jqGrid('saveRow', modal.lastEdit);
			var dueDate= ($hiddenActionPlanGrid.jqGrid('getCell',modal.lastEdit,'DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($hiddenActionPlanGrid.jqGrid('getCell',modal.lastEdit,'CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'STATUS', 'Y');
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'STATUS', 'R');
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'STATUS', 'G');
				$hiddenActionPlanGrid.jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'G');
			}
			
			modal.lastEdit = 0;
		},
		
		goSalesAct : function(pk,code) {
			var openNewWindow = window.open("about:blank");
			switch (code) {
			case "고객컨택":
				menuCookieSet("고객컨택"); //메뉴 활성화
				openNewWindow.location.href = "/clientSalesActive/viewClientContactList.do?event_id="+pk;
				break;
			}
		}
}
</script>