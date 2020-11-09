<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-lg">
	    <div class="modal-content">
	        <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	            <h4 class="modal-title">롯데카드차세대</h4>
	        </div>
	        <div class="modal-body">
	            <div class="row">
	                <div class="col-lg-12">
	                    <div class="ibox ">
	                        <div class="ibox-content border_n" id="divModalToggle">
                                <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                                	<div class="form-group">
                                		<div class="col-sm-12 ag_r">
                                			<span class="label orange_count_bg" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView"><a onclick="coachingTalk.view('SVPJ');"><i class="fa fa-comments-o" style="color: white;"></i> <span style="color: white;" id="spanCtCount"></span></a></span>
                                    		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
                          		    	</div>
                          		    	<div id="divModalCoachingTalk" style="display: none;">
	                               			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
	                               		</div>
	                               		
                          		    </div>
                          		    
                          		    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 프로젝트명</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"></div>
                                    </div>
                                    
                                    <!-- <div class="hr-line-dashed"></div> -->
                                    <div class="form-group" style="display: none;">
								   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
	                                     <div class="col-sm-4 pos-rel">
	                                         <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
	                                     </div>
	                                     <label class="col-sm-2 control-label">고객사ID</label>
	                                     <div class="col-sm-4 pos-rel">
                                         	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
                                         </div>
	                                </div>
	                               
	                               <!-- <div class="hr-line-dashed"></div> -->
                                    <div class="form-group" style="display: none;"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalClientName" name="textModalClientName" placeholder="고객명를 검색해 주세요." autocomplete="off"/>
                                        <!-- <input type="hidden" id="hiddenModalClientId" name="hiddenModalClientId" readOnly/> --></div>
                                    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객총괄PM</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalClientPMName" name="textModalClientPMName" placeholder="고객총괄PM을 검색해 주세요." autocomplete="off"/>
                                   		</div>
                                   	</div>
                                    
                                    <!-- <div class="hr-line-dashed"></div> -->
                                    <div class="form-group" style="display: none;"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객수행PM</label>
                                    	<div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalClientEXPMName" name="textModalClientEXPMName" placeholder="고객수행PM을 검색해 주세요." autocomplete="off"/>
                                		<!-- <label class="col-sm-2 control-label" style="padding-top: 0px;">고객 주요<br/>이해당사자</label>
                                    	<div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalClientRelationName" name="textModalClientRelationName"/> -->
                                    	<!-- <input type="text" id="hiddenModalClientRelationId" name="hiddenModalClientRelationId"/> -->
                                    	</div>
                                    </div>
                                    
                                    
                                 <div class="hr-line-dashed"></div>
                                    <div class="form-group pos-rel">
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClient" name="liModalSingleClient">
                                                      <input type="text" class="form-control" id="textModalSingleClient" name="textModalSingleClient" placeholder="고객명을 검색해 주세요." autocomplete="off">
                                                  <div class="autocomplete-suggestions "></div></li>
                                              </ul>                                                            
                                          </div>
                                          <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객총괄PM</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleClientPM" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClientPM" name="liModalSingleClientPM">
                                                      <input type="text" class="form-control" id="textModalSingleClientPM" name="textModalSingleClientPM" placeholder="고객명을 검색해 주세요." autocomplete="off">
                                                  <div class="autocomplete-suggestions "></div></li>
                                              </ul>                                                            
                                          </div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group pos-rel">
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객수행PM</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleClientEXPM" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClientEXPM" name="liModalSingleClientEXPM">
                                                      <input type="text" class="form-control" id="textModalSingleClientEXPM" name="textModalSingleClientEXPM" placeholder="고객명을 검색해 주세요." autocomplete="off">
                                                  <div class="autocomplete-suggestions "></div></li>
                                              </ul>                                                            
                                          </div>
                                          <label class="col-sm-2 control-label" style="padding-top: 0px;">고객 주요<br/>이해당사자</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalClientRelationName" name="textModalClientRelationName"/>
                                        <!-- <input type="text" id="hiddenModalClientRelationId" name="hiddenModalClientRelationId"/> --></div>
                                    </div>
                                    
                                    <div class="hr-line-bottom"></div>
                                    
                                    
                                    <!-- TabMenu -->
                                    <div class="tab-area">
                                        <!-- tab-menu -->
                                        <ul class="tabmenu-type">
                                            <li><a href="#" class="sel">기본정보</a></li>
                                            <li><a href="#" class="">계약금액 및 예상매출</a></li>
                                            <li><a href="#" class="">감리사 및 파트너사</a></li>          
                                            <li><a href="#" class="">마일스톤</a></li>
                                            <li><a href="#" class="">프로젝트 이슈</a></li>
                                            <li><a href="#" class="">첨부파일</a></li>
                                        </ul>
                                        <!--// tab-menu -->

                                        <!-- tab-cont -->

                                        <!-- 기본정보 -->
                                        <div class="sub_cont scont1 modaltabmenu">
		                                    <div class="form-group"><label class="col-sm-2 control-label" for="date_modified">시작일</label>
	                                        <div class="col-sm-4">
	                                          <div class="data_1">
	                                              <div class="input-group date">
	                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                                                  <input type="text" class="form-control" onchange="modalAmount.disable();" id="textModalStartDate" name="textModalStartDate" value="">
	                                              </div>
	                                          </div>
	                                         </div>
		                                    <label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 종료일</label>
		                                      <div class="col-sm-4">
		                                          <div class="data_1">
		                                              <div class="input-group date">
		                                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" onchange="modalAmount.disable();" id="textModalEndDate" name="textModalEndDate">
		                                              </div>
		                                          </div>
		                                      </div>
		                                  </div>
		                                  
		                                  <div class="hr-line-dashed"></div>
		                                  <div class="form-group"><label class="col-sm-2 control-label">진행률(%)</label>
		                                      <div class="col-sm-10">
		                                          <div class="progress" id="divModalProgress" style="margin:0px;"><input type="hidden" class="form-control" name="hiddenModalProgress" id="hiddenModalProgress" value="0"/>
		  												<div class="progress-bar progress-bar-striped progress-bar-info active" id="divModalProgressBar" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%; color:black;">
										    		</div>
										  		</div>
		                                      </div>
		                                  </div>
		                                  
                                           <div class="hr-line-dashed"></div>
		                                    <div class="form-group pos-rel">
		                                    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 자사총괄PM</label>
		                                        <div class="col-md-9 col-lg-4">
	                                              <ul id="ulModalOurPMName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
	                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalOurPMName" name="liModalOurPMName">
	                                                      <input type="text" class="form-control" id="textModalOurPMName" name="textModalOurPMName" placeholder="자사총괄PM을 검색해 주세요." autocomplete="off" autoFlag="y">
	                                                  </li>
	                                              </ul>                                                            
	                                            </div>
		                                    	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 자사수행PM</label>
		                                        <div class="col-md-9 col-lg-4">
	                                              <ul id="ulModalOurEXPMName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
	                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalOurEXPMName" name="liModalOurEXPMName">
	                                                      <input type="text" class="form-control" id="textModalOurEXPMName" name="textModalOurEXPMName" placeholder="자사수행PM을 검색해 주세요." autocomplete="off" autoFlag="y">
	                                                  </li>
	                                              </ul>                                                            
	                                            </div>
		                                    </div>
		                                    
		                                    <div class="hr-line-dashed"></div>
		                                    <div class="form-group pos-rel">
		                                    	<label class="col-sm-2 control-label">영업대표</label>
		                                        <div class="col-md-9 col-lg-4">
	                                              <ul id="ulModalSalesOwnerName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
	                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSalesOwnerName" name="liModalSalesOwnerName">
	                                                      <input type="text" class="form-control" id="textModalSalesOwnerName" name="textModalSalesOwnerName" placeholder="영업대표를 검색해 주세요." autocomplete="off" autoFlag="y">
	                                                  </li>
	                                              </ul>                                                            
	                                            </div>
		                                    </div>
		                                    
		                                    <div class="hr-line-dashed"></div>
										   <div class="form-group">
		                                   		<label class="col-sm-2 control-label">팀 구성원</label>
			                                     <div class="col-md-9 col-lg-10">
		                                              <ul id="ulMultipleTeamMember" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
		                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liMultipleTeamMember" name="liMultipleTeamMember">
		                                                      <input type="text" class="form-control" id="textMultipleTeamMember" name="textMultipleTeamMember" placeholder="직원명을 검색해 주세요." autocomplete="off"/>
		                                                  </li>
		                                              </ul>                                                            
		                                          </div>
		                                   </div>
		                                    
		                                    <div class="hr-line-dashed"></div>
		                                    <div class="form-group"><label class="col-sm-2 control-label">상세내용</label>
		                                        <div class="col-sm-10"><textarea class="pop-textarea-input" rows="4" id="textareaModalContents" name="textareaModalContents"
		                                         onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
		                                    </div>
                                        </div>
                                        <!--// 기본정보 -->

                                        <!-- 계약금액 및 예상매출 -->
                                        <div class="sub_cont scont2 modaltabmenu off">
											<jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/serviceProjectMGMTModalAmount.jsp"></jsp:include>
                                        </div>
                                        <!--// 계약금액 및 예상매출 -->

                                        <!-- 감리사, 파트너사 -->
                                        <div class="sub_cont scont3 modaltabmenu off">
		                                    <div class="form-group"><label class="col-sm-2 control-label">파트너사명</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalPartnerCompany" name="textModalPartnerCompany"/></div>
		                                    <label class="col-sm-2 control-label">파트너 영업대표</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalPartnerSalesOwner" name="textModalPartnerSalesOwner"/></div>
		                                    </div>
		                                    
		                                    <div class="hr-line-dashed"></div>
		                                    <div class="form-group"><label class="col-sm-2 control-label">감리회사명</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalAuditCompany" name="textModalAuditCompany"/></div>
		                                    <label class="col-sm-2 control-label">감리사명</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id=textModalAuditIndividualNames name="textModalAuditIndividualNames"/></div>
		                                    </div>
		                                    <div class="hr-line-dashed"></div>
		                                    <div class="form-group"><label class="col-sm-2 control-label">감리사연락처</label>
		                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalAuditIndividualContacts" name="textModalAuditIndividualContacts"/></div>
		                                    </div>
                                        </div>
                                        <!--// 감리사, 파트너사 -->

                                        <!-- 마일스톤 -->
                                        <div class="sub_cont scont4 modaltabmenu off">
                                        	<jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/serviceProjectMGMTModalMilestones.jsp"/>
                                        </div>
                                        <!--// 마일스톤 -->

                                        <!-- 프로젝트 이슈 -->
                                        <div class="sub_cont scont5 modaltabmenu off">
											<!-- <jsp:include page="/WEB-INF/jsp/pc/clientSatisfaction/serviceProjectMGMTModalIssue.jsp"/> -->
											<jsp:include page="/WEB-INF/jsp/pc/common/grid.jsp" flush="false">
								            	<jsp:param name="gridAddBtnName" value="프로젝트 이슈"/>
								            	<jsp:param name="gridHtmlPath" value="/ajaxHtml/projectIssue.html"/>
								            	<jsp:param name="gridDelUrl" value="/clientSatisfaction/deleteProjectIssue.do"/>
								            	<jsp:param name="gridSelectUrl" value="/clientSatisfaction/gridProjectIssue.do"/>
								            	<jsp:param name="listObj" value="projectMGMTList"/>
								            </jsp:include>
                                        </div>
                                        <!--//프로젝트 이슈 -->
                                        
                                        <!-- 첨부파일 -->
                                        <div class="sub_cont scont6 modaltabmenu off">
                                        	<jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                        </div>
                                        <!--// 파일첨부 -->

                                        <!--// tab-cont -->
                                        
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

                                    </div>
                                    <!--// TabMenu -->
                                    
                                    <div class="hr-line-dashed"></div>
                                     <p class="text-center pd-t20">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(1);" id="buttonModalSubmit">저장하기</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(2);" id="buttonModalSubmitShare">저장하기 및 공유하기</button>
                                    </p>
                                    <input type="hidden" name="hiddenModalTotalContractAmount" id="hiddenModalTotalContractAmount" />
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalClientId" id="hiddenModalClientId"/>
                                    <input type="hidden" id="hiddenModalClientPMId" name="hiddenModalClientPMId"/>
                                    <input type="hidden" id="hiddenModalClientEXPMId" name="hiddenModalClientEXPMId"/>
                                    <input type="hidden" 	name="hiddenModalMemberList"	id="hiddenModalMemberList"/>
                                    
                                    <input type="hidden" 	name="hiddenModalTeamMemberIdList"	id="hiddenModalTeamMemberIdList"/>
                                    <input type="hidden" 	name="hiddenModalTeamMemberNameList"	id="hiddenModalTeamMemberNameList"/>
                                    <input type="hidden" 	name="hiddenModalNewMemberIdList"	id="hiddenModalNewMemberIdList"/>
                                    
                                    <input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}"/>
		                        	<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}"/>
		                        	
	                                <input type="hidden" id="hiddenModalOurPMId" name="hiddenModalOurPMId" readOnly/>
	                                <input type="hidden" id="hiddenModalOurEXPMId" name="hiddenModalOurEXPMId" readOnly/>
	                                <input type="hidden" id="hiddenModalSalesOwnerId" name="hiddenModalSalesOwnerId" readOnly/>
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
// 진행률
var percent = 0;

$(document).ready(function() { 
		modal.init();
		/* $("#divModalProgress").mousemove(function(event){
			var offset = $("#divModalProgress").offset();
			var size = $("#divModalProgress").outerWidth()/100;
			var percent = (Math.round((event.pageX-offset.left)/size/10)*10);
			$("#divModalProgressBar").html(percent+"%");
			$("#divModalProgressBar").css("width", percent+"%");
			$("#divModalProgress").click(function(event){
				console.log($("#divModalProgress").position().left);
				console.log(size);
				console.log((event.pageX-offset.left)/size);
				$("#hiddenModalProgress").val(percent);
			});
		}); */
		/* $("#divModalProgress").mouseout(function(event){
			$("#divModalProgressBar").html($("#hiddenModalProgress").val()+"%");
			$("#divModalProgressBar").css("width", $("#hiddenModalProgress").val()+"%");
		}); */
});		

var modalEvent = {
		on : function(){
			//진행률 mousemove
			$("#divModalProgress").on('mousemove', modalEvent.mousemoveModalProgress);
			//진행률 클릭
			$("#divModalProgress").on('click', modalEvent.clickModalProgress);
			//진행률 mouseout
			$("#divModalProgress").on('mouseout', modalEvent.mouseoutModalProgress);
			//tab menu
			$("ul.tabmenu-type").on('click.modalTab', 'li a', modalEvent.clickModalTab);
			//유효성 검사
			$("#textModalSubject, #textCommonSearchCompany, #textModalClientName, #textModalCustomerName, #textModalClientPMName, #textModalClientEXPMName, #textModalEndDate, #textModalSingleClient, #textModalSingleClientPM, #textModalSingleClientEXPM").on("blur", modalEvent.blurValidation);
		},
		
		off : function(){
			//진행률 mousemove
			$("#divModalProgress").off('mousemove', modalEvent.mousemoveModalProgress);
			//진행률 클릭
			$("#divModalProgress").off('click', modalEvent.clickModalProgress);
			//진행률 mouseout
			$("#divModalProgress").off('mouseout', modalEvent.mouseoutModalProgress);
			//tab menu
			$("ul.tabmenu-type").off('click.modalTab', 'li a', modalEvent.clickModalTab);
			//유효성 검사
			$("#textModalSubject, #textCommonSearchCompany, #textModalClientName, #textModalCustomerName, #textModalClientPMName, #textModalClientEXPMName, #textModalEndDate, #textModalSingleClient, #textModalSingleClientPM, #textModalSingleClientEXPM").off("blur", modalEvent.blurValidation);
		},
		
		mousemoveModalProgress : function(event){
			var offset = $("#divModalProgress").offset();
			var size = $("#divModalProgress").outerWidth()/100;
			percent = (Math.round((event.pageX-offset.left)/size/10)*10);
			$("#divModalProgressBar").html(percent+"%");
			$("#divModalProgressBar").css("width", percent+"%");
		},
		
		clickModalProgress : function(event){
			$("#hiddenModalProgress").val(percent);
		},				
		
		mouseoutModalProgress : function(event){
			$("#divModalProgressBar").html($("#hiddenModalProgress").val()+"%");
			$("#divModalProgressBar").css("width", $("#hiddenModalProgress").val()+"%");
		},
		
		clickModalTab : function(e){
			e.preventDefault();
			var idx = $("ul.tabmenu-type li a").index($(this));
			$("ul.tabmenu-type li a").removeClass("sel");
			$(this).addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		},
		
		blurValidation : function(e){
			switch (e.target.id) {
			case "textCommonSearchCompany":
				$("#formModalData").find("#hiddenModalCompanyId").valid();
				break;
			case "textModalCustomerName":
				$("#formModalData").find("#hiddenModalClientId").valid();
				break;
			case "textModalClientPMName":
				$("#formModalData").find("#hiddenModalClientPMId").valid();
				break;
			case "textModalClientEXPMName":
				$("#formModalData").find("#hiddenModalClientEXPMId").valid();
				break;
			default:
				$("#formModalData").find(e.target).valid();
				break;
			}
		}
}

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			//commonSearch.company($("#formModalData #textCommonSearchCompany"), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			commonSearch.singleClientIndividual($("#formModalData #textModalSingleClient"), $("#formModalData #liModalSingleClient"), $("#formModalData #textCommonSearchCompany"), $("#formModalData #hiddenModalCompanyId"), 
					$("#formModalData #textModalClientName"), $("#formModalData #hiddenModalClientId"), '');
			commonSearch.singleClientIndividual($("#formModalData #textModalSingleClientPM"), $("#formModalData #liModalSingleClientPM"), '', '', 
					$("#formModalData #textModalClientPMName"), $("#formModalData #hiddenModalClientPMId"), '');
			commonSearch.singleClientIndividual($("#formModalData #textModalSingleClientEXPM"), $("#formModalData #liModalSingleClientEXPM"), '', '', 
					$("#formModalData #textModalClientEXPMName"), $("#formModalData #hiddenModalClientEXPMId"), '');
			//commonSearch.customer($("#formModalData #textModalClientRelationName"), $('#formModalData #hiddenModalClientRelationId'), $('#none'), $('#formModalData #hiddenModalCompanyId'));
			
			//자사총괄PM
            commonSearch.singleMember($("#formModalData #textModalOurPMName"), $('#formModalData #liModalOurPMName'), $('#formModalData #hiddenModalOurPMId'));
			//자사수행PM
			commonSearch.singleMember($("#formModalData #textModalOurEXPMName"), $('#formModalData #liModalOurEXPMName'), $('#formModalData #hiddenModalOurEXPMId'));
			//영업대표
			commonSearch.singleMember($("#formModalData #textModalSalesOwnerName"), $('#formModalData #liModalSalesOwnerName'), $('#formModalData #hiddenModalSalesOwnerId'));
			
			//commonSearch.member($("#formModalData #textModalOurEXPMName"), $('#formModalData #hiddenModalOurEXPMId'));
			//commonSearch.member($("#formModalData #textModalSalesOwnerName"), $('#formModalData #hiddenModalSalesOwnerId'));
			//commonSearch.customer($("#formModalData #textModalCustomerName"), $('#formModalData #hiddenModalCustomerId'));
			//commonSearch.member($("#formModalData #textModalSalesRepresentive"), $('#formModalData #hiddenModalSalesId'));
			
			//프로젝트 팀구성
			commonSearch.multipleTeamMember($("#formModalData #textMultipleTeamMember"), $('#formModalData #hiddenModalTeamMemberIdList'), $('#formModalData #liMultipleTeamMember'), $('#formModalData #hiddenModalNewMemberIdList'));
			
			//메일공유
			commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #liMultipleMailShareMember'));
			
			//tab menu
			/* $("ul.tabmenu-type").on({
				'click.modalTab' : function(e){
					e.preventDefault();
					var idx = $("ul.tabmenu-type li a").index($(this));
					$("ul.tabmenu-type li a").removeClass("sel");
					$(this).addClass("sel");
					$("div.modaltabmenu").addClass("off");
					$("div.modaltabmenu").eq(idx).removeClass("off");
				}
			},'li a'); */
			
			//유효성 검사
			/* $("#textModalSubject, #textCommonSearchCompany, #textModalClientName, #textModalCustomerName, #textModalClientPMName, #textModalClientEXPMName, #textModalEndDate, #textModalSingleClient, #textModalSingleClientPM, #textModalSingleClientEXPM").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData").find("#hiddenModalClientId").valid();
						break;
					case "textModalClientPMName":
						$("#formModalData").find("#hiddenModalClientPMId").valid();
						break;
					case "textModalClientEXPMName":
						$("#formModalData").find("#hiddenModalClientEXPMId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			}); */
			
			// 프로젝트 이슈 그리드
			var cols = [];
			cols.push(grid.buildCol('*', '이슈내용'));
			cols.push(grid.buildCol(160, '해결계획'));
			cols.push(grid.buildCol(110, '책임자'));
			cols.push(grid.buildCol(135, '해결목표일'));
			cols.push(grid.buildCol(135, '실제완료일'));
			cols.push(grid.buildCol(50, 'status'));
			cols.push(grid.buildCol(40, '삭제'));
			
		    var gridColObj = {
		    		contents : 'ISSUE_DETAIL',
		    		plan : 'SOLVE_PLAN',
		    		planDate : 'DUE_DATE',
		    		actualDate : 'ISSUE_CLOSE_DATE',
		    		gridId : 'ISSUE_ID',
		    		memberId : 'SOLVE_OWNER_ID',
		    		memberName : 'SOLVE_OWNER',
		    		memberPosition : 'SOLVE_OWNER_POSITION'
		    };
			
			grid.setGrid(cols, gridColObj);
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=9&datatype=json",
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
					projectMGMTList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		reset : function() { //신규등록 시 팝업창 초기화
			
			modalFlag = "ins";
		
			//EVENT ON
			modalEvent.on();
			milestonesEvent.on();
		
			$('#formModalData').validate().resetForm();	
			$("ul.flexdatalist-multiple li.value").remove();
		
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//tabl 초기화
			$("ul.tabmenu-type li a").removeClass("sel");
			$("ul.tabmenu-type li a:first").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu:first").removeClass("off");
			
			//코칭톡 버튼 제거, 창 hide
			$("#buttonModalCoachingTalkView").hide();
			$("#divModalCoachingTalk").hide();
			
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalClientId").val("");
			$("#formModalData #hiddenModalTotalContractAmount").val("");
			$("#formModalData #hiddenModalContractPlanAmount").val("");
			$("#formModalData #hiddenModalContractActualAmount").val("");
			$("#formModalData #hiddenModalMemberList").val("");
			
			commonSearch.multipleTeamMemberArray = [];
			$("#formModalData #hiddenModalTeamMemberIdList").val("");
			$("#formModalData #hiddenModalTeamMemberNameList").val("");

			$("#formModalData #hiddenModalOurPMId").val("");
			$("#formModalData #hiddenModalOurEXPMId").val("");
			$("#formModalData #hiddenModalSalesOwnerId").val("");
			
			$("#formModalData input:text").val("");
			$("#formModalData #hiddenModalProgress").val("0");
			$("#formModalData #divModalProgressBar").html("0%");
			$("#formModalData #divModalProgressBar").css("width", "0%");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			
			//$("div.company-current").html("");
			//$("ul.company-list").html("");
			//commonSearch.partnerArray = [];
			
			$("#textModalStartDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			$("#divModalContractAmount .progress-cutom").html('');

			$("#textModalTotalContractAmount").attr("disabled", true);
			$("#textModalTotalContractAmount").val("시작, 종료일를 선택해 주세요.");
			$("#selectModalContractAmount").attr("disabled", true);
			$("#selectModalContractAmount").val("");
			$("#divModalContractAmountRe").css("display", "none");
			
			$("#formModalData #textModalOurPMName").show();
			$("#formModalData #textModalOurEXPMName").show();
			$("#formModalData #textModalSalesOwnerName").show();
         	
			$("#formModalData #textModalSingleClient").show();
			$("#formModalData #textModalSingleClientPM").show();
			$("#formModalData #textModalSingleClientEXPM").show();
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("서비스프로젝트 신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			mileOpper.reset();

			//projectIssue.reset();
			//projectIssue.drawQualification();

			// 그리드 초기화
			grid.gridReset();
			grid.gridAdd();

			$("#myModal1").modal();
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			
			//값 비교를 위한.
			setTimeout(function(){
				compare_before = $("#formModalData").serialize();
			},400);
		},
		
		validate : function(){
			$("#formModalData").validate({ // joinForm에 validate를 적용
				ignore: '', 
				rules : {
					textModalSubject : {
						required : true,
						maxlength : 100
					},
					textModalStartDate : {
						required : true
					},
					textModalEndDate : {
						required : true
					},
					/* 
					textCommonSearchCompany : {
						required : true
					},
					 */
					textModalClientName : {
						required : true
					},
					/* hiddenModalCompanyId : {
						required : true
					}, */
					hiddenModalClientId : {
						required : true
					},
					textModalClientPM : {
						required : true
					},
					textModalClientEXPM : {
						required : true
					},
					hiddenModalOurPMId : {
						required : true
					},
					hiddenModalOurEXPMId : {
						required : true
					},
					hiddenModalClientPMId : {
						required : true
					},
					hiddenModalClientEXPMId : {
						required : true
					},
					/* textModalSatName : {
						required : true,
						maxlength : 10
					},
					textModalSatDate : {
						required : true,
						maxlength : 10
					}, */
					// required는 필수, rangelength는 글자 개수(1~10개 사이)
					textareaModalContents : {
						minlength : 1,
						maxlength : 2000
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
					textModalSubject : {
						required : "제목을 입력하세요.",
						maxlength:"100글자 이하여야 합니다" 
					},
					selectModalCategory : {
						required : "카테고리를 선택하세요."
					},
					textModalStartDate : {
						required : "시작일를 선택하세요."
					},
					textModalEndDate : {
						required : "종료일를 선택하세요."
					},
					/* 
					textCommonSearchCompany : {
						required : "고객사를 입력하세요."
					},
					 */
					textModalClientName : {
						required : "고객명을 입력하세요."
					},
					/* hiddenModalCompanyId : {
						required : "고객사를 선택하세요."
					}, */
					hiddenModalClientId : {
						required : "고객명을 입력하세요."
					},
					textModalClientPM : {
						required : "고객총괄PM을 입력하세요."
					},
					textModalClientEXPM : {
						required : "고객수행PM을 입력하세요."
					},
					hiddenModalOurPMId : {
						required : "자사총괄PM을 입력하세요. "
					},
					hiddenModalOurEXPMId : {
						required : "자사수행PM을 입력하세요."
					},
					hiddenModalClientPMId : {
						required : "고객총괄PM을 입력하세요."
					},
					hiddenModalClientEXPMId : {
						required : "고객수행PM을 입력하세요."
					},
					textareaModalContents : {
						maxlength : "2000글자 이하여야 합니다"
					}
				},
				errorPlacement : function(error, element) {
				    /* if($(element).prop("id") == "hiddenModalCompanyId") {
				        $("#textCommonSearchCompany").after(error);
				        location.href = "#textCommonSearchCompany";
				    }else  */if($(element).prop("id") == "hiddenModalClientId") {
				        //$("#textModalClientName").after(error);
				        //location.href = "#textModalClientName";
				    	$("#ulModalSingleClient").after(error);
				        location.href = "#textModalSingleClient";
				    }else if($(element).prop("id") == "hiddenModalClientPMId") {
				    	$("#ulModalSingleClientPM").after(error);
				        location.href = "#textModalSingleClientPM";
				    }else if($(element).prop("id") == "hiddenModalClientEXPMId") {
				    	$("#ulModalSingleClientEXPM").after(error);
				        location.href = "#textModalSingleClientEXPM";
				    }else if($(element).prop("id") == "hiddenModalOurPMId") {
				    	$("#ulModalOurPMName").after(error);
				        location.href = "#textModalOurPMName";
				    }else if($(element).prop("id") == "hiddenModalOurEXPMId") {
				    	$("#ulModalOurEXPMName").after(error);
				        location.href = "#textModalOurEXPMName";
				    }else {
				        error.insertAfter(element); // default error placement.
				    }
				}
			});
		}, 
		
		submit : function(shareFlag){
			var url;
			$("#hiddenModalTotalContractAmount").val(uncomma($("#textModalTotalContractAmount").val()));
			
			var cpaArr = [], caaArr= [];
			
			$("input[name='textModalContractPlanAmount']").each(function(){
				cpaArr.push(uncomma($(this).val()));
			});
			
			$("input[name='textModalContractActualAmount']").each(function(){
				caaArr.push(uncomma($(this).val()));
			});
			
			$("#hiddenModalContractPlanAmount").val(cpaArr);
			$("#hiddenModalContractActualAmount").val(caaArr);
			
			//projectIssue.saveRow();
			
			(modalFlag == "ins") ? url = "/clientSatisfaction/insertProjectMGMT.do" : url = "/clientSatisfaction/updateProjectMGMT.do";
			 $('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			projectIssueData : JSON.stringify(grid.gridSubmitList()),
	    			fileData : JSON.stringify(commonFile.fileArray),
	    			clientName : $("#liModalSingleClient").prev("li.value").find("span").html(), //고객명
					clientPmName : $("#liModalSingleClientPM").prev("li.value").find("span").html(), //고객총괄PM
					ourPmName : $("#liModalOurPMName").prev("li.value").find("span").html(), //자사총괄PM
					ourSalesName : $("#liModalSalesOwnerName").prev("li.value").find("span").html(), //영업대표
	    			shareFlag : function(){
	    				if(shareFlag == 1){
	    					return false;
	    				}else{
	    					return true;
	    				}
	    			},
	    		},
	            beforeSubmit: function (data,form,option) {
					if(!grid.gridValid) return false;
	            	if($('#textModalStartDate').val()>$('#textModalEndDate').val()) {
	            		alert("종료일이 시작일보다 이전입니다."); return false;
	            	}
	            	if(!confirm("저장하시겠습니까?")) return false;
	            	/* if(!compareFlag){
						if(!confirm("저장하시겠습니까?")) return false;
	            	} */
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
	                	projectMGMTList.reset();
	                	
	                	if(modalFlag=="ins") {
	                		projectMGMTList.searchReset(); //등록/수정 시 검색 초기화
	                		
	                		projectMGMTList.get(1);
							compare_before = $("#formModalData").serialize();
	                		
	                		$('#myModal1').modal("hide");
	                		/* projectMGMTList.reset();
							projectMGMTList.get(); */
	                	}else if(modalFlag=="upd"){ //모달 닫을때 변경 값 체크
	                		projectMGMTList.get(1);
							compare_before = $("#formModalData").serialize();
	                		
	                		//compareFlag = false;
		            		//projectMGMTList.completeReload(); html 에러냄 확인필요.
		            		/* projectMGMTList.reset();
							projectMGMTList.get();
		            		compare_before = $("#formModalData").serialize(); */
	                	}
	                	//$sellersGrid.trigger("reloadGrid");
	                	commonSearch.multipleMemberArray = [];
	                	commonFile.reloadFile($("#hiddenModalPK").val(), '9');
	                }else{
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            complete : function(){
					$.ajaxLoadingHide();
				}
	        });
		},
		
		removeFileElement : function(count,obj){
			$("input#inputUploadFile"+count).remove();
			$(obj).parent("p").remove();
			
			if($("#divFileUploadList p.fileModalUploadFile").length == 0){
				$("#divFileUploadList span").show();
			}
		},
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSatisfaction/deleteProjectMGMT.do",
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
					alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$("#sellersGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectMGMT.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}
</script>