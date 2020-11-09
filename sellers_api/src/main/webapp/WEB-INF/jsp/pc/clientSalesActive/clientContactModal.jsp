<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
                                  			<span class="label orange_count_bg" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView"><a onclick="coachingTalk.view('CONTACT');"><i class="fa fa-comments-o" style="color: white;"></i> <span style="color: white;" id="spanCtCount"></span></a></span>
                                    		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
	                                    </div>
                                	
	                                	<div id="divModalCoachingTalk" style="display: none;">
	                               			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
	                               		</div>
                                
                          		    </div>
                          		    <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 컨택목적</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject" autocomplete="off"/></div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 컨택방법</label>
                                       <div class="col-sm-4">
                                           <div class="select-com"><!-- <label>항목선택</label> -->
                                           		<select class="form-control" name="selectModalCategory" id="selectModalCategory">
                                           			<spring:eval expression="@config['code.contactMethod']" />
                                        		</select> 
                                            </div>
                                       </div>
                                  </div>
                                  <div class="hr-line-dashed"></div>
                                  <div class="form-group"><label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 컨택일시</label>
                                  	<div class="col-sm-4">
                                          <div class="data_1">
                                              <div class="input-group date">
                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                  <input type="text" class="form-control" id="textModalEventDate" name="textModalEventDate">
                                              </div>
                                          </div>
                                      </div>
                                    <div class="col-sm-6 ag_r">
                                   	 	<div class="input-group">
	                                   	 	<select class="form-control" 
                              	 				name="selectModalStartDateTime"
												id="selectModalStartDateTime" onclick=""
												onchange="modal.changeEndDate();">
	                                   	 		<option value="">선택</option>
														<option value="08:00">오전 08:00</option>
														<option value="08:30">오전 08:30</option>
														<option value="09:00">오전 09:00</option>
														<option value="09:30">오전 09:30</option>
														<option value="10:00">오전 10:00</option>
														<option value="10:30">오전 10:30</option>
														<option value="11:00">오전 11:00</option>
														<option value="11:30">오전 11:30</option>
														<option value="12:00">오후 12:00</option>
														<option value="12:30">오후 12:30</option>
														<option value="13:00">오후 01:00</option>
														<option value="13:30">오후 01:30</option>
														<option value="14:00">오후 02:00</option>
														<option value="14:30">오후 02:30</option>
														<option value="15:00">오후 03:00</option>
														<option value="15:30">오후 03:30</option>
														<option value="16:00">오후 04:00</option>
														<option value="16:30">오후 04:30</option>
														<option value="17:00">오후 05:00</option>
														<option value="17:30">오후 05:30</option>
														<option value="18:00">오후 06:00</option>
														<option value="18:30">오후 06:30</option>
														<option value="19:00">오후 07:00</option>
														<option value="19:30">오후 07:30</option>
														<option value="20:00">오후 08:00</option>
														<option value="20:30">오후 08:30</option>
														<option value="21:00">오후 09:00</option>
														<option value="21:30">오후 09:30</option>
														<option value="22:00">오후 10:00</option>
														<option value="22:30">오후 10:30</option>
														<option value="23:00">오후 11:00</option>
														<option value="23:30">오후 11:30</option>
	                                   	 	</select>
	                                      	<span class="input-group-addon">~</span>
	                                      	<select class="form-control" 
	                                      		name="selectModalEndDateTime"
												id="selectModalEndDateTime">
	                                      		<option value="">선택</option>
														<option value="08:00">오전 08:00</option>
														<option value="08:30">오전 08:30</option>
														<option value="09:00">오전 09:00</option>
														<option value="09:30">오전 09:30</option>
														<option value="10:00">오전 10:00</option>
														<option value="10:30">오전 10:30</option>
														<option value="11:00">오전 11:00</option>
														<option value="11:30">오전 11:30</option>
														<option value="12:00">오후 12:00</option>
														<option value="12:30">오후 12:30</option>
														<option value="13:00">오후 01:00</option>
														<option value="13:30">오후 01:30</option>
														<option value="14:00">오후 02:00</option>
														<option value="14:30">오후 02:30</option>
														<option value="15:00">오후 03:00</option>
														<option value="15:30">오후 03:30</option>
														<option value="16:00">오후 04:00</option>
														<option value="16:30">오후 04:30</option>
														<option value="17:00">오후 05:00</option>
														<option value="17:30">오후 05:30</option>
														<option value="18:00">오후 06:00</option>
														<option value="18:30">오후 06:30</option>
														<option value="19:00">오후 07:00</option>
														<option value="19:30">오후 07:30</option>
														<option value="20:00">오후 08:00</option>
														<option value="20:30">오후 08:30</option>
														<option value="21:00">오후 09:00</option>
														<option value="21:30">오후 09:30</option>
														<option value="22:00">오후 10:00</option>
														<option value="22:30">오후 10:30</option>
														<option value="23:00">오후 11:00</option>
														<option value="23:30">오후 11:30</option>
	                                      	</select>
                                      	</div>
                                    </div>
                                  </div>
                                  
								   <div class="hr-line-dashed"></div>
								   <div class="form-group">
                                   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i>고객명</label>
	                                     <div class="col-sm-10"><!-- <div class="col-md-9 col-lg-10"> -->
                                              <ul id="ulMultipleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liMultipleClient" name="liMultipleClient">
                                                      <input type="text" class="form-control" id="textMultipleClient" name="textMultipleClient" placeholder="고객명을 검색해 주세요." autocomplete="off"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                   </div>
                                   <!-- 복수입력으로 변경 주석처리// -->
								   <!-- <div class="form-group">
								   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
	                                     <div class="col-sm-4 pos-rel">
	                                         <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
	                                     </div>
	                                     <label class="col-sm-2 control-label">고객사ID</label>
	                                     <div class="col-sm-4 pos-rel">
                                         	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                         </div>
	                               </div>
                                                                                                                                                                        
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
	                                     <div class="col-sm-4 pos-rel">
                                         	<input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명을 검색해 주세요." autocomplete="off"/>
                                         </div>
                                   	   <label class="col-sm-2 control-label">고객직급</label>
                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalClientRank" name="textModalClientRank"/></div>
                                   </div> -->
                                   
                                   <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">상세내용</label>
                                       <div class="col-sm-10"><textarea class="pop-textarea-input" rows="5" id="textareaModalEventContents" name="textareaModalEventContents"
                                        onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                   </div>
                                   
                                   <!-- <div class="hr-line-dashed" name="divRelation"></div>
                                   <div class="form-group" name="divRelation">
                                   		<label class="col-sm-2 control-label">연관<br />잠재영업기회</label>
	                                     <div class="col-sm-4 pd-t7" id="relationHiddenOpp">
                                         </div>
                                   	   <label class="col-sm-2 control-label">연관<br />이슈</label>
                                        <div class="col-sm-4 pd-t7" id="relationClientIssue">
                                       </div>
                                   </div> -->
                                   
                                   <!-- <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">Follow-Up Action</label>
                                       <div class="col-sm-10">
                                       		<table id="contactFollowUpAction"></table>
                                       		<p class="text-center pd-t10">
												<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modal.addRow();">+ Follow-Up Action 추가</a>
								            </p>
                                       	</div>
                                   </div> -->
                                   
                                   <div class="hr-line-dashed"></div>                                                                                    
                                   <div class="form-group"><label class="col-sm-2 control-label">Follow-Up Action</label>
                                       <div class="col-sm-10">
								            <jsp:include page="/WEB-INF/jsp/pc/common/followUpAction.jsp" flush="false">
								            	<jsp:param name="fuaCategory" value="1"/>
								            </jsp:include>
                                       	</div>
                                   </div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label">메일공유</label>
	                                     <div class="col-md-9 col-lg-10">
                                              <ul id="ulMultipleMailShareMember" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liMultipleMailShareMember" name="liMultipleMailShareMember">
                                                      <input type="text" class="form-control" id="textMultipleMailShareMember" name="textMultipleMailShareMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off"/>
                                                  </li>
                                              </ul>                                                            
                                          </div>
                                   </div>
                                            
						            <!-- <div class="form-group pos-rel">
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
                                   <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                    
                                    
                                   <div class="hr-line-dashed" name="checkOppIssue"></div>
																		<div class="form-group" name="checkOppIssue">
																			<div class="col-lg-12" style="text-align: center;">
																				<div class="col-lg-12 mg-b20">
																					<div class="col-lg-12 form-group">
																						<div class="col-sm-12 line_h100">
																							<a href="javascript:void(0);"
																								class="dis_inb r30 a_check va_m mg-r10"
																								onClick="modal.hiddenCheck();">잠재영업기회</a> <input
																								type="checkbox" name="checkSalesOpp" class="va_m"
																								style="display: none;" /> <a href="javascript:void(0);"
																								class="dis_inb r30 a_check va_m mg-r10"
																								onClick="modal.issueCheck();">이슈</a> <input
																								type="checkbox" name="checkIssue" class="va_m"
																								style="display: none;" /><br /> <br /> <label
																								class="mg-r20">연관된 정보가 있으면 선택해 주세요.<br />저장 후 해당
																								페이지로 자동 전환됩니다.
																							</label>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>


									<div class="hr-line-dashed"></div>
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(1);" id="buttonModalSubmit">저장하기</button>
                                        <!-- <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(2);" id="buttonModalSubmitShare">저장하기 및 공유하기</button> -->
                                    </p>
                                    <input type="hidden"	name="hiddenModalPK" 				id="hiddenModalPK" 				value=""/>
		                            <input type="hidden" 	name="hiddenModalCreatorId" 		id="hiddenModalCreatorId"	value="${userInfo.MEMBER_ID_NUM}"/>
		                            <input type="hidden" 	name="hiddenModalFollowManagerId"	id="hiddenModalFollowManagerId"/>
		                            <input type="hidden" 	name="hiddenModalCustomerId"	id="hiddenModalCustomerId"/>
		                            <input type="hidden" 	name="hiddenModalMemberList"	id="hiddenModalMemberList"/>
		                            <input type="hidden" 	name="hiddenModalCcList"	id="hiddenModalCcList"/>
		                            
		                            <input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}"/>
		                        	<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}"/>
		                        	
		                        	<!-- 생산성,일정 관련 데이터 -->
		                            <input type="hidden" 	name="hiddenModalCalendarEventId"	id="hiddenModalCalendarEventId"/>
		                            <input type="hidden" 	name="hiddenModalBeforeAnalEventTime"	id="hiddenModalBeforeAnalEventTime" value="생산성분석 값 상세보기시 계산 0.5=30분"/>
		                            <input type="hidden" 	name="hiddenModalAfterAnalEventTime"	id="hiddenModalAfterAnalEventTime" value="생산성분석 값 저장하기기시 계산 0.5=30분"/>
		                            <input type="hidden" 	name="hiddenModalBeforeEventDate"	id="hiddenModalBeforeEventDate" value="수정전 날짜"/>
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
//var contactPK;
//var lastEdit;

$(document).ready(function() { 
		modal.init();
});		

var modal = {
		contactPK : null,
		lastEdit : null, //그리드용
		
		
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.multipleMultipleClient($("#formModalData #textMultipleClient"), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #liMultipleClient'));
			commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #liMultipleMailShareMember'));
			
			//직원 검색
			/* $('#textCommonSearchMember').on('keydown',function(key){
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					commonSearch.multipleMemberPop();
			     }
			}); */
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=3&datatype=json",
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
					list.reset();
					list.get();
					list.goDetail($("#hiddenModalPK").val());
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			list.modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("보고자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#hiddenModalCreatorId").val("${userInfo.MEMBER_ID_NUM}");
			//$("#textModalTextName").attr("placeholder","${userInfo.HAN_NAME}");
			//$("#textModalCreateDate").attr("placeholder",commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//코칭톡 버튼 제거, 창 hide
			$("#buttonModalCoachingTalkView").hide();
			$("#divModalCoachingTalk").hide();
			
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalCustomerId").val("");
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData #hiddenModalMemberList").val("");
			$("#formModalData #hiddenModalCcList").val("");
			$("#formModalData #hiddenModalCalendarEventId").val("");
			$("#formModalData #hiddenModalBeforeEventDate").val("");
			$("#formModalData #hiddenModalBeforeAnalEventTime").val("");
			$("#formModalData #hiddenModalAfterAnalEventTime").val("");
			commonSearch.multipleMultipleClientArray = [];
			commonSearch.multipleMailShareMemberArray = [];
			$("ul.flexdatalist-multiple li.value").remove();
			
			$("[name='divRelation']").hide();
			$("[name='checkOppIssue']").show();
			
			$("#spanModalReturnIssue").html("");
			
			$("#textModalEventDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//컨택시간
			var date = new Date();
			var hour = date.getHours()>9 ? ''+date.getHours() : '0'+date.getHours();
			var min = date.getMinutes()>9 ? ''+date.getMinutes() : '0'+date.getMinutes();
			if(parseInt(min)==0) {
				$("#selectModalStartDateTime").val(hour+":00");
				hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
				$("#selectModalEndDateTime").val(hour+":00");
			}else if(parseInt(min)>0 && parseInt(min)<=30) {
				$("#selectModalStartDateTime").val(hour+":30");
				hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
				$("#selectModalEndDateTime").val(hour+":30");
			}else if(parseInt(min)>30) {
				hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
				$("#selectModalStartDateTime").val(hour+":00");
				hour = (date.getHours()+2)>9 ? ''+(date.getHours()+2) : '0'+(date.getHours()+2);
				$("#selectModalEndDateTime").val(hour+":00");
			}
			
			//Follow-Up-Action
			fuaReset();
			fuaAdd();
			
			//파일
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("고객컨택 신규 등록");
			$("small.font-bold").css('display','none');
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			setTimeout(function(){
				list.compare_before = $("#formModalData").serialize()
			}, 400);
		},
		
		validate : function(){
			$("#formModalData").validate({ // joinForm에 validate를 적용
				ignore: "",
				rules : {
					textModalSubject : {
						required : true,
						maxlength : 100
					},
					/* textModalEventOwner : {
						required : true,
						maxlength : 10
					}, */
					textModalEventDate : {
						required : true
					},
					selectModalCategory : {
						required : true
					},
					// required는 필수, rangelength는 글자 개수(1~10개 사이)
					/* 
					textCommonSearchCompany : {
						required : true
					},
					 */
					hiddenModalCustomerId : {
						required : true
					},
					/* textareaFollowUpAction : {
						required : true,
						maxlength : 2000
					}, */
					selectModalStartDateTime : {
						required : true
					},
					selectModalEndDateTime : {
						required : true
					}
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
					textModalSubject : {
						required : "컨택목적을 입력하세요.",
						maxlength: $.validator.format('{0}자 내로 입력하세요.')
					},
					/* textModalEventOwner : {
						required : "담당자를 입력해 주세요.",
						maxlength:"10글자 이하여야 합니다"
					}, */
					textModalEventDate : {
						required : "컨택일를 선택해 주세요."
					},
					selectModalCategory : {
						required : "컨택방법을 선택하세요.", // 이와 같이 규칙이름과 메시지를 작성
					//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
					//digits:"숫자만 입력해 주세요."
					},
					hiddenModalCustomerId : {
						required : "고객명을 검색해 주세요."
					},
					/* textareaFollowUpAction : {
						required : "follow-up-action을 입력해 주세요.",
						maxlength : "2000글자 이하여야 합니다"
					}, */
					selectModalStartDateTime : {
						required : "컨택시작 시간을 선택해 주세요."
					},
					selectModalEndDateTime : {
						required : "컨택종료시간을 선택해 주세요."
					}
				},
				errorPlacement : function(error, element) {
				   if($(element).prop("id") == "hiddenModalCustomerId") {
				        $("#ulMultipleClient").after(error);
				        location.href = "#ulMultipleClient";
				    }else{
				        error.insertAfter(element); // default error placement.
				    }
				}
			})
		}, 
		
		submit : function(shareFlag){
			var url = (list.modalFlag == "ins") ? url = "/clientSalesActive/insertClientContact.do" : url = "/clientSalesActive/updateClientContact.do";
			var oppFlag = $("input[name='checkSalesOpp']").prop("checked");
     	var issueFlag = $("input[name='checkIssue']").prop("checked");
        	
			if(!isEmpty($("#hiddenModalCustomerId").val())){
				var ccList = '';
				$('ul#ulMultipleClient li').each(function(idx, val){
					if(idx>0 && idx<$('ul#ulMultipleClient li').length-1) ccList = ccList + ', ';
					if(idx<$('ul#ulMultipleClient li').length-1 && !isEmpty($('ul#ulMultipleClient li').eq(idx)["0"].innerText)) ccList += $('ul#ulMultipleClient li').eq(idx)["0"].innerText;
				});
				$("#hiddenModalCcList").val(ccList);
			}
			
			if($('#hiddenModalMemberList').val().length > 0){
				shareFlag = 2;
			}
			
			modal.timeDifference("#hiddenModalAfterAnalEventTime");
			
			 $('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			contactFollowUpAction : JSON.stringify(fuaSubmitList()),
	    			shareFlag : function(){
	    				if(shareFlag == 1){
	    					return false;
	    				}else{
	    					return true;
	    				}
	    			},
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	    		beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
          beforeSubmit: function (data,form,option) {
	           	if(!fuaValid) return false;
	           	
	           	if(!list.compareFlag){
	            	if(!confirm("저장하시겠습니까?")){
									return false;
								}
       				}
	           	
	           	/* if(list.modalFlag=="ins" && !oppFlag && !issueFlag){ // 셋다 노 체크
	           		if(!confirm("추가 입력사항이 선택되지 않았습니다.\n그래도 저장하시겠습니까?")){
	           			return false;
	           		}
	           	}else{
	           		if(!list.compareFlag){
		            	if(!confirm("저장하시겠습니까?")){
										return false;
									}
           			}
            	} */
            	$.ajaxLoadingShow();
	         },
	            success: function(data){
	            	 if(data.cnt > 0){
	                	alert("저장하였습니다.");
	                	modal.contactPK = data.returnPK;
	                	
	                	list.compareFlag = false;
	            		list.compare_before = $("#formModalData").serialize();
	                	list.reset();
	                	
	                	if(list.modalFlag == "ins"){ //신규등록
							if(!oppFlag && !issueFlag){ // 둘다 노 체크
								//list.reset();
								//list.get();
			            	}else if(oppFlag && issueFlag){ //둘다 체크
			            		alert("잠재영업기회 입력으로 이동합니다.");
			            		modal.returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/viewHiddenOpportunityList.do');
			            	}else if(oppFlag && !issueFlag){ //잠재영업기회만 체크
			            		alert("잠재영업기회 입력으로 이동합니다.");
			            		modal.returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/viewHiddenOpportunityList.do');
			            	}else if(!oppFlag && issueFlag){ //이슈만 체크 체크
			            		alert("이슈 입력으로 이동합니다.");
			            		modal.returnFollowUpAction(oppFlag, issueFlag, '/clientSatisfaction/viewClientIssueList.do');
			            	}
							list.searchReset(); //등록/수정 시 검색 초기화
		            	}else if(list.modalFlag == "upd"){ //업데이트
		            		/* list.compareFlag = false;
		            		list.compare_before = $("#formModalData").serialize();
		            		list.reset();
							list.get(); */
		            	}
	                	list.get(1);
		            	//메일 공유자 리셋
		            	commonSearch.multipleMemberArray = [];
		            	$('#myModal1').modal("hide");
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            complete : function(){
	            	setTimeout(function(){
	            		$.ajaxLoadingHide();
	            	},400);
				} 
	        });
		},
		
		returnFollowUpAction : function(oppFlag, issueFlag, url){
			$("#formFollow #contactPK").val(modal.contactPK);
			$("#formFollow #issueFlag").val(issueFlag);
			$("#formFollow #oppFlag").val(oppFlag);
			
			//$("#formFollow #returnCompanyId").val($("#formModalData #hiddenModalCompanyId").val());
			//$("#formFollow #returnCompanyName").val($("#formModalData #textCommonSearchCompany").val());
			//$("#formFollow #returnCustomerName").val($("#formModalData #textModalCustomerName").val());
			//$("#formFollow #returnCustomerId").val($("#formModalData #hiddenModalCustomerId").val());
			//$("#formFollow #returnCustomerRank").val($("#formModalData #textModalClientRank").val());
			
			$("#formFollow").attr("action",url);
			$("#formFollow").submit();
		},
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSalesActive/deleteClientContact.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					alert("삭제하였습니다."); 
					$('#myModal1').modal("hide");
					$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientSalesActive/gridClientContact.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		drawContactActionPlan : function(){
			$("#contactFollowUpAction").jqGrid('clearGridData');
			$("#contactFollowUpAction").jqGrid({
	 			 url : "/clientSalesActive/gridActionPlanContact.do?pkNo="+$("#hiddenModalPK").val(),
				datatype : 'json', 
				colModel : [ 
				{
					label : '내용',
					name : 'CONTENTS',
					align : "left",
					width : 260,
					edittype:'textarea',
					editable: true
				}, {
					label : 'SOLVE_OWNER_ID',
					name : 'SOLVE_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				},{
					label : '책임자',
					name : 'SOLVE_OWNER',
					align : "center",
					width : 90,
					editable: true,
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
				},{
					label : '완료목표일',
					name : 'SOLVE_DUE_DATE',
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
					name : 'SOLVE_CLOSE_DATE',
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
								$("#contactFollowUpAction").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								break;
							case "Y":
								$("#contactFollowUpAction").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								break;
							case "R":
								$("#contactFollowUpAction").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
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
					width : 45,
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
						if(list[i].STATUS == 'G'){
							$("#contactFollowUpAction").setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
						}else if(list[i].STATUS == 'Y'){
							$("#contactFollowUpAction").setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
						}else if(list[i].STATUS == 'R'){
							$("#contactFollowUpAction").setCell(i+1,"STATUS","",{"background-color": "#f20056"});
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
		},
		
		hiddenCheck : function(){
    		var checkFlag = $("input[name='checkSalesOpp']").prop("checked");
    		if(checkFlag){
    			$("input[name='checkSalesOpp']").prop("checked",false);
    			//alert("잠재영업기회 입력이 불가능합니다.");
    		}else{
    			$("input[name='checkSalesOpp']").prop("checked",true);
    			//alert("잠재영업기회 입력이 가능합니다.");
    		}
    	},
    	
		issueCheck: function(){
    		var checkFlag = $("input[name='checkIssue']").prop("checked");
    		if(checkFlag){
    			$("input[name='checkIssue']").prop("checked",false);
    			//alert("NCR 입력이 불가능합니다.");
    		}else{
    			$("input[name='checkIssue']").prop("checked",true);
    			//alert("NCR 입력이 가능합니다.");
    		}
    	},
    	
    	punchingCheck: function(){
    		var checkFlag = $("input[name='checkPunching']").prop("checked");
    		if(checkFlag){
    			$("input[name='checkPunching']").prop("checked",false);
    			//alert("펀칭 입력이 불가능합니다.");
    		}else{
    			$("input[name='checkPunching']").prop("checked",true);
    			//alert("펀칭 입력이 가능합니다.");
    		}
    	},
    	
		addRow : function(){
			var gridLength = $("#contactFollowUpAction").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#contactFollowUpAction").jqGrid('saveRow', i);
			}
 			$("#contactFollowUpAction").jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$("#contactFollowUpAction").jqGrid('saveRow', gridLength+1);
		},
		
		delRow : function(rowId, actionId){
			if(!isEmpty(actionId) && actionId != "undefined"){
				$.ajax({
					url : "/clientSalesActive/deleteContactActionItem.do",
					datatype : 'json',
					async : false,
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
							$("#contactFollowUpAction").jqGrid('delRowData', rowId);
							alert("삭제되었습니다.");
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
						}
					},
					complete: function(){
						$.ajaxLoadingHide();
					},
					error: function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			}else{
				$("#contactFollowUpAction").jqGrid('delRowData', rowId);
			}
			
		},
		
		changeStatus : function(){
			$("#contactFollowUpAction").jqGrid('saveRow', modal.lastEdit);
			var dueDate= ($("#contactFollowUpAction").jqGrid('getCell',modal.lastEdit,'SOLVE_DUE_DATE').replaceAll("-","")).trim();
			var closeDate= ($("#contactFollowUpAction").jqGrid('getCell',modal.lastEdit,'SOLVE_CLOSE_DATE').replaceAll("-","")).trim();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			
			if((dueDate >= nowDate) && closeDate == ""){
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'STATUS', 'Y');
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'Y');
			}else if(dueDate < nowDate && closeDate == ""){
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'STATUS', 'R');
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'R');
			}else if(closeDate != "" && closeDate != null){
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'STATUS', 'G');
				$("#contactFollowUpAction").jqGrid('setCell', modal.lastEdit, 'HIDDEN_STATUS', 'G');
			}
			
			modal.lastEdit = 0;
		},
		
		actionPlanReload : function(){
			$("#contactFollowUpAction").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSalesActive/gridActionPlanContact.do?pkNo="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
		},
		
		goSalesAct : function(pk,code) {
			var openNewWindow = window.open("about:blank");
			switch (code) {
			case "고객이슈":
				menuCookieSet("고객이슈"); //메뉴 활성화
				openNewWindow.location.href = "/clientSatisfaction/viewClientIssueList.do?issue_id="+pk;
				break;
			case "잠재영업기회":
				menuCookieSet("잠재영업기회"); //메뉴 활성화
				openNewWindow.location.href = "/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+pk;
				break;
			}
		},
		
		//시작시간 변경시 자동으로 종료시간 1시간 후로 세팅
		changeEndDate : function() {
			var startDateTime = $("#selectModalStartDateTime").val();
			
			var split = startDateTime.split(":");
			var endHour = "";
			(parseInt(split[0],"10")+1) > 9 ? endHour = parseInt(split[0],"10")+1 : endHour = "0"+(parseInt(split[0],"10")+1);
			$("#selectModalEndDateTime").val(endHour+":"+split[1]);
		},
		
		//생산성 시간데이터 계산
		timeDifference : function(obj) {
			var date1 = moment($("#textModalEventDate").val()+' '+$("#selectModalEndDateTime").val(), 'YYYY-MM-DD HH:mm').format('x');
			var date2 = moment($("#textModalEventDate").val()+' '+$("#selectModalStartDateTime").val(), 'YYYY-MM-DD HH:mm').format('x');
			var difference = date1 - date2;
			var minutesDifference = (difference/1000/60/60).toFixed(1);
			$(obj).val(minutesDifference);
		}
		
}
</script>