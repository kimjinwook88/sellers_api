<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
h4.modal-title {display: inline-block;}
</style>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title"></h4>
                <a onclick="modal.changeKeyDeal(this);"> <i class="fa fa-star fa-2x" style="color: orange;"></i></a>
            </div>
            <div class="modal-body">
                <div class="row">	
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content border_n">
                                <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                    	<div class="col-sm-6 ag_l">
                                    		<button type="button" class="btn btn-w-m btn-seller" id="buttonTempSelect" style="background-color:#8C8C8C;border-color:#8C8C8C;display:none;" onclick="modal.tempSelect();">임시저장 불러오기</button>
	                                    </div>
	                                    
                                    	<div class="col-sm-6 ag_r">
                                    		<span class="label orange_count_bg" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView"><a onclick="coachingTalk.view('OPP');"><i class="fa fa-comments-o" style="color: white;"></i> <span style="color: white;" id="spanCtCount"></span></a></span>
                                    		<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
	                                    </div>
                                        
                                        <div id="divModalCoachingTalk" style="display: none;">
                                			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
                                		</div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 사업명</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
                                    
                                    <!-- <div class="hr-line-dashed"></div> -->
                                   <!--  <div class="form-group pos-rel" style="display: none;"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/></div>
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div>
                                    </div> -->
                                    
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
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 예상계약금액</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalContractAmount" name="textModalContractAmount" onkeyup="comma(this);" maxlength="15"/></div>
                                        <label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 계약일</label>
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalContractDate" name="textModalContractDate" value="">
                                                </div>
                                            </div>
                                        </div>                                   	
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
	                                     <label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 계약기간</label>
		                                   <div class="col-sm-4">
	                                         <div class="col-sm-5 data_1" style="padding-left:0;padding-right:0;">
	                                             <div class="input-group date">
	                                                 <input type="text" class="form-control add-on" id="textModalContractStDate" name="textModalContractStDate" value="">
	                                             </div>
	                                         </div>
			                                     <label class="col-sm-2 control-label" for="date_modified" style="text-align:center;">~</label>
	                                         <div class="col-sm-5 data_1" style="padding-left:0;padding-right:0;">
		                                           <div class="input-group date">
		                                               <input type="text" class="form-control add-on" id="textModalContractEdDate" name="textModalContractEdDate" value="">
		                                           </div>
	                                         </div>
		                                    </div>
		                                    <label class="col-sm-2 control-label"> 영업기회코드 (ERP)</label>
                                        	<div class="col-sm-4"><input type="text" class="form-control" id="textModalErpOppCode" name="textModalErpOppCode" disabled="disabled"/></div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                    	<label class="col-sm-6">
                                    		<label class="col-sm-4 control-label">Forecast</label>
	                                        <div class="col-sm-4" style="width: 26%;">
	                                            <label class="" style="margin-right:3px"> 
	                                            	<input type="checkbox" value="In" name="checkModalForecastYN"> <span class="va-m">In</span>
	                                            </label>
	                                            <label> 
	                                            	<input type="checkbox" value="Out" id="checkModalForecastYN" name="checkModalForecastYN"> <span class="va-m">Out</span>
	                                            </label>
	                                        </div>
	                                        <label class="col-sm-2 control-label" name="erpTag" style="width: 21%;">ERP 전환</label>
	                                        <div class="col-sm-1" name="erpTag">
	                                        	<!-- <a href="javascript:void(0);" class="btn btn-outline btn-seller-outline" onclick="modal.submit(true);">전환하기</a> -->
	                                        	<button type="submit " class="btn btn-outline btn-seller-outline fc-button" onclick="modal.submit(true);">전환하기</button>
	                                        </div>
                                    	</label>
                                        <label class="col-sm-2 control-label"> 프로젝트코드 (ERP)</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalErpProjectCode" name="textModalErpProjectCode" disabled="disabled"/></div>                                                                                
                                    </div>
                                    
                                    <!-- <div class="hr-line-dashed" name="rebateDiv" style="display:none;"></div>
                                    <div class="form-group" name="rebateDiv" style="display:none;">
                                    	<label class="col-sm-2 control-label" name="rebateDiv">REBATE 성과전환</label>
                                        <div class="col-sm-4" name="rebateDiv">
                                        	<a href="javascript:void(0);" class="btn btn-outline btn-seller-outline" onclick="modal.submit(true);">전환하기</a>
                                        	<button type="button" class="btn btn-outline btn-seller-outline" onclick="modal.rebateComplete();" name="rebateDiv">전환하기</button>
                                        </div>
									</div> -->
									
                                    <div class="hr-line-bottom"></div>

                                    <!-- TabMenu -->
                                    <div class="tab-area">

                                    <!-- tab-menu -->
                                    <ul class="tabmenu-type">
                                        <li><a href="#" class="sel">기본정보</a></li>
                                        <li><a href="#" class="">영업단계</a></li>
                                        <li><a href="#" class="">승리계획</a></li>
                                        <li><a href="#" class="">마일스톤</a></li>
                                        <li><a href="#" class="">매출/매입 품목</a></li>
                                        <li><a href="#" class="">매출/수금 계획</a></li>
                                        <!-- <li><a href="#" class="" >체크리스트</a></li> -->
                                        <li><a href="#" class="">첨부파일</a></li>
                                    </ul>
                                    <!--// tab-menu -->
                                    
                                    <!-- tab-cont -->

                                    <!-- 기본정보 -->
                                    <div class="sub_cont scont1 modaltabmenu" tab-seq=1>
                                        <div class="form-group pos-rel">
                                         <label class="col-sm-2 control-label">Exec Owner</label>
                                             <div class="col-md-9 col-lg-4">
                                            <ul id="ulModalSingleExecOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleExecOwner" name="liModalSingleExecOwner">
                                                    <input type="text" class="form-control" id="textModalExecOwner" name="textModalExecOwner" placeholder="Exec Owner를 검색해 주세요." autocomplete="off" autoFlag="y">
                                                </li>
                                            </ul>                                                            
                                        </div>
                                       
                                            <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> Opportunity Owner</label>
                                            <div class="col-md-9 col-lg-4">
                                           <ul id="ulModalSingleOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                               <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleOwner" name="liModalSingleOwner">
                                                   <input type="text" class="form-control" id="textModalOpportunityOwner" name="textModalOpportunityOwner" placeholder="Owner를 검색해 주세요." autocomplete="off" autoFlag="y">
                                               </li>
                                           </ul>                                                            
                                       </div>
                                       
                                        </div>
                                        
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group pos-rel">
                                        	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업대표</label>
                                        	<div class="col-md-9 col-lg-4">
                                           <ul id="ulModalSingleIdentifier" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                               <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleIdentifier" name="liModalSingleIdentifier">
                                                   <input type="text" class="form-control" id="textModalOpportunityIdentifier" name="textModalOpportunityIdentifier" placeholder="영업대표를 검색해 주세요." autocomplete="off" autoFlag="y">
                                               </li>
                                           </ul>                                                            
                                       </div>
                                            <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업구분</label>
                                            <div class="col-sm-4">
                                          <div class="select-com">
                                         		<select class="form-control" name="selectModalCategoryCd" id="selectModalCategoryCd">
                                         			<c:choose>
												<c:when test="${fn:length(searchDetailGroup.code_tpso) > 0}">
													<c:forEach items="${searchDetailGroup.code_tpso}" var="searchDetailGroup">
					                                    <option value="${searchDetailGroup.CODE_ID}">${searchDetailGroup.CODE_NAME}</option>
		                                    		</c:forEach>
		                                    	</c:when>
	                                    	</c:choose>
                                      		</select> 
                                          </div>
                                   			</div>
                                        </div>
                                        
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group pos-rel">
                                        	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 영업유형</label>
                                            <div class="col-sm-4">
                                          <div class="select-com">
                                         		<select class="form-control" name="selectModalTypeCd" id="selectModalTypeCd">
                                         			<option value="0001">Direct</option>
                                         			<option value="0002">InDirect</option>
                                      		</select> 
                                          </div>
                                   			</div>
                                            <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 프로젝트형태</label>
                                            <div class="col-sm-4">
                                          <div class="select-com">
                                         		<select class="form-control" name="selectModalProjectForm" id="selectModalProjectForm">
                                         			<c:choose>
												<c:when test="${fn:length(searchDetailGroup.code_project) > 0}">
													<c:forEach items="${searchDetailGroup.code_project}" var="searchDetailGroup">
					                                    <option value="${searchDetailGroup.CODE_ID}">${searchDetailGroup.CODE_NAME}</option>
		                                    		</c:forEach>
		                                    	</c:when>
	                                    	</c:choose>
                                      		</select> 
                                          </div>
                                   			</div>
                                        </div>
                                        
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group pos-rel">
                                        	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객구분</label>
                                            <div class="col-sm-4">
                                          <div class="select-com">
                                         		<select class="form-control" name="selectModalClientCategoryCd" id="selectModalClientCategoryCd">
                                         			<option value="1">매출처</option>
                                         			<option value="2">End User</option>
                                         			<option value="3">매입처</option>
                                      		</select> 
                                          </div>
                                   			</div>
                                            <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i>고객담당자</label>
                                            <div class="col-md-9 col-lg-4">
                                           <ul id="ulModalSingleClientMaster" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                               <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClientMaster" name="liModalSingleClientMaster">
                                                   <input type="text" class="form-control" id="textModalSingleClientMaster" name="textModalSingleClientMaster" placeholder="고객담당자를 검색해 주세요." autocomplete="off" autoFlag="y">
                                               </li>
                                           </ul>
								  <div id="divSingleClientMasterErr" style="display:none;">
									  <label id="singleClientMaster-error" class="error-custom" for="singleClientMaster">ERP 코드가 있는 담당자만<br />ERP로 전환 가능합니다.<br />'연동하기' 버튼을 클릭하여 연동해주세요.</label>
									  <button type="button" class="btn btn-gray btn-file" style="line-height:0.7" onClick="$('div.custom-company-pop').show();">연동하기</button>
								  </div>
                                       </div>
                                       <div class="custom-company-pop off">
                                       <div class="pop-header" style="height: 70px;line-height: 35px;">
                                           <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                           <strong class="pop-title">거래처 대표 검색</strong>
                                           <span style="font-size: 14px; color: red;"><br>*ERP거래처대표로 등록된 고객만 검색됩니다.</span>
                                       </div>
                                       <div class="col-sm-12 cont">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <div class="company-search-after mg-b5">검색
                                                       <input type="text" placeholder="거래처 대표 검색" class="form-control fl_l mg-r5" id="textDuzonSearchSalesMan">
                                                       <button type="button" class="btn btn-gray btn-file" onClick="modal.selectClientSalesmanInfo();">검색</button>
                                                   </div>
                                               </div>
                                               <div class="col-sm-12 company-result mg-b10 ">검색 결과 노출시 "off" 삭제
                                                   <strong>[검색 결과]</strong>
                                                   <ul class="company-list">
                                                   </ul>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                                        </div>
                                        
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group pos-rel">
                                        	<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i>구매방법</label>
                                            <div class="col-sm-4">
                                          <div class="select-com">
                                         		<select class="form-control" name="selectModalBuyCd" id="selectModalBuyCd">
                                         			<option value="1">기술가격평가</option>
                                         			<option value="2">계약갱신</option>
                                         			<option value="3">수의계약</option>
                                         			<option value="4">가격입찰</option>
                                      		</select> 
                                          </div>
                                   			</div>
                                        </div>
                                        
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group"><label class="col-sm-2 control-label">사업내용</label>
                                            <div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textareaModalDetailConents" name="textareaModalDetailConents"
                                             onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                        </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group"><label class="col-sm-2 control-label">차별화 가치</label>
                                            <div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textareaModalDiscriminateValue" name="textareaModalDiscriminateValue"
                                             onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                        </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group"><label class="col-sm-2 control-label">ROUTE</label>
                                            <div class="col-sm-10"><input type="text" class="form-control" id="textModalRoute" name="textModalRoute"/></div>
                                        </div>
                                        
                                        
                                        <div class="hr-line-dashed"></div>
                                 <div class="form-group">
                                 		<label class="col-sm-2 control-label">파트너사</label>
                                    <div class="col-md-9 col-lg-10">
                                            <ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                <li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultiplePartner" name="ulMultiplePartner">
                                                    <input type="text" class="form-control" id="textMultiplePartner" name="textMultiplePartner" placeholder="파트너사를 검색해 주세요." autocomplete="off"/>
                                                </li>
                                            </ul>                                                            
                                        </div>
                                 </div>
                               
                                        <!-- <div class="hr-line-dashed"></div>
                                        <div class="form-group pos-rel"><label class="col-sm-2 control-label">파트너사</label>
                                            <div class="col-sm-10">
									<div class="company-search-after mg-b5">고객사 검색
                                           <div class="company-current">
                                       	</div>
                                           <button type="button" class="btn btn-gray btn-file" onClick="$('div.custom-company-pop').show();">검색</button>
                                           검색버튼 클릭시 아래의 "custom-company" 팝업 노출
                                       </div>
                                            </div>
                                            
                                            파트너사 추가 팝업
                                   <div class="custom-company-pop off">
                                       <div class="pop-header">
                                           <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                           <strong class="pop-title">파트너사 선택</strong>
                                       </div>
                                       <div class="col-sm-12 cont">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <div class="company-search-after mg-b5">검색
                                                       <input type="text" placeholder="파트너사 검색" class="form-control fl_l mg-r5" id="textCommonSearchPartner">
                                                       <button type="button" class="btn btn-gray btn-file" onClick="commonSearch.partnerInfo();">검색</button>
                                                   </div>
                                               </div>
                                               <div class="col-sm-12 company-result mg-b10 ">검색 결과 노출시 "off" 삭제
                                                   <strong>[파트너사 검색 결과]</strong>
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
                                        <div class="form-group"><label class="col-sm-2 control-label">파트너사 역할</label>
                                            <div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textModalPartnerRole" name="textModalPartnerRole"
                                             onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
                                        </div>
                                    </div>
                                    <!--// 기본정보 -->
		                             
                                        <!-- 영업단계 -->
                                        <div class="sub_cont scont2 modaltabmenu off" tab-seq=2>
                                            <div class="salescycle-step">
                                                <ul>
                                                    <li class="active"><a href="#"><span>Identify/Validation</span></a></li>
                                                    <li><a href="#"><span>Qualification</span></a></li>
                                                    <li><a href="#"><span>Negotiation</span></a></li>
                                                    <li><a href="#"><span>Close</span></a></li>
                                                </ul>
                                            </div>
                                            
                                            <label style="color:red;padding-left:3px;">【 아래의 각 항목을 체크해 주세요. 】</label>
                                            
                                            <div id="divSalesCycleCheck" style="padding-left:20px;">
                                            	<!-- Identify/Validation -->
                                            	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객 예산과 일정은 계획되어 있습니까 ?</label></li>
                                            	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객의 구매의사를 확인하였습니까 ?</label></li>
                                            	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객의 요구 사항에 적합한 우리의 솔루션이 있습니까 ?</label></li>
                                            	
                                            	<!-- Qualification -->
                                            	<li data-category="2"><label><input type="checkbox" value="N" name="checkSalesCycle"> 수익과 위험요소 분석을 충분히 하였습니까 ?</label></li>
                                            	<li data-category="2"><label><input type="checkbox" value="N" name="checkSalesCycle"> 사업 수행을 위한 인력과 지원 서비스는 가능합니까 ?</label></li>
                                            	<li data-category="2"><label><input type="checkbox" value="N" name="checkSalesCycle"> 제안서 작성과 제출을 했습니까 ?</label></li>
                                            	
                                            	<!-- Negotiation -->
                                            	<li data-category="3"><label><input type="checkbox" value="N" name="checkSalesCycle"> 우선협상대상자에 대한 고객 동의를 받았습니까 ?</label></li>
                                            	<li data-category="3"><label><input type="checkbox" value="N" name="checkSalesCycle"> 계약 범위와 조건에 대해 협의를 완료하였습니까 ?</label></li>
                                            	
                                            	<!-- Closed -->
                                            	<li data-category="4"><label><input type="checkbox" value="N" name="checkSalesCycle"> 계약을 성공적으로 체결했습니까 ?</label></li>
                                            </div>
                                            
                                            <!-- close -->
                                            <div id="divSalesCycleClose" style="display:none;">
									            <div class="form-group"><label class="col-sm-2 control-label">Close</label>
									                <div class="col-sm-10">
									                    <div class="select-com"><!-- <label>항목선택</label> --> 
									                        <select class="form-control" name="selectSalesCloseCategory" id="selectSalesCloseCategory">
									                        <option value="1">Win</option>
									                        <option value="2">Loss</option>
									                        <option value="3">No-Bid</option>
									                    </select></div>
									                </div>
									            </div>
									            <div class="hr-line-dashed"></div>
									            <div class="form-group"><label class="col-sm-2 control-label">사업내용</label>
									                <div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textareaSalesCloseDetail" name="textareaSalesCloseDetail"
									                 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea></div>
									            </div>
								            </div>
                                        </div>
                                        <!--// 영업단계 -->
                                        
                                        <!-- Win Plan -->
                                        <div class="sub_cont scont3 modaltabmenu off" tab-seq=3>
                                            <jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/opportunityModalWinPlan.jsp"/>
                                        </div>
                                        <!--// Win Plan -->
                                        
                                        <!-- 마일스톤 -->
                                        <div class="sub_cont scont4 modaltabmenu off" tab-seq=4>	
											<jsp:include page="/WEB-INF/jsp/pc/common/milestones_temp.jsp"/>
                                        </div>
                                        <!--// 마일스톤 -->
                                        

										<!-- 매출/매입 품목 -->
                                        <div class="sub_cont scont5 modaltabmenu off" tab-seq=5>
                                        	<jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/opportunityModalProduct.jsp"/>
                                        </div>
                                        <!--// 매출/매입 품목 -->
                                        
                                        <!-- 매출/수금 계획 -->
                                        <div class="sub_cont scont6 modaltabmenu off" tab-seq=6>
                                        	<jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/opportunityModalSalesPlan.jsp"/>
                                        </div>
                                        <!--// 매출/수금 계획 -->
                                        
										 <!-- Check List -->
                                        <%-- <div class="sub_cont scont4 modaltabmenu off">
                                            <jsp:include page="/WEB-INF/jsp/pc/clientSalesActive/opportunityModalCheckList.jsp"/>
                                        </div> --%>
                                        <!--// Check List -->

										<!-- file -->
                                        <div class="sub_cont scont7 modaltabmenu off" tab-seq=7>
                                            <jsp:include page="/WEB-INF/jsp/pc/common/attachFile.jsp"/>
                                        </div>
                                        <!--// file -->
                                        
                                        
                                        <!--// tab-cont -->

                                    </div>
                                    <!--// TabMenu -->                                            
                                    
                                    <p class="text-center pd-t20">
                                        <!-- <button type="button" class="btn btn-outline btn-primary btn-gray-outline">삭제하기</button> -->                                        
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit(false);" id="buttonModalSubmit">저장하기</button>
                                        <button type="button " class="btn btn-w-m btn-seller" onclick="modal.tempSubmit();" id="buttonTempSubmit" style="background-color:#8C8C8C;border-color:#8C8C8C;">임시저장</button>
                                    </p>
                                    
                                	<input type="hidden" name="hiddenModalPK" id="hiddenModalPK"/>
 	                                <input type="hidden" name="hiddenModalOpportunityhiddenId" id="hiddenModalOpportunityhiddenId"/>
	                                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
	                                <input type="hidden" name="hiddenModalSalesCycle" id="hiddenModalSalesCycle" value="1" />
	                                <input type="hidden" name="hiddenModalSalesCycleSave" id="hiddenModalSalesCycleSave" value="" />
	                                
	                                <!-- <input type="hidden" name="hiddenModalSalesPartner" id="hiddenModalSalesPartner"/> -->
	                                <input type="hidden" name="hiddenModalContractAmount" id="hiddenModalContractAmount"/>
	                                <input type="hidden" name="hiddenModalGPAmount" id="hiddenModalGPAmount"/>
	                               
	                                <input type="hidden" name="hiddenModalSalesREVArr" id="hiddenModalSalesREVArr"/>
	                                <input type="hidden" name="hiddenModalSalesGPArr" id="hiddenModalSalesGPArr"/>
	                                <input type="hidden" name="hiddenModalSalesDateArr" id="hiddenModalSalesDateArr"/>
	                               
	                                <input type="hidden" name="hiddenModalPartnerId" id="hiddenModalPartnerId"/>
	                               
	                                <input type="hidden" name="hiddenModalExecId" id="hiddenModalExecId"/>
	                                <input type="hidden" name="hiddenModalOwnerId" id="hiddenModalOwnerId"/>
	                                <input type="hidden" name="hiddenModalIdentifierId" id="hiddenModalIdentifierId"/>
	                                <input type="hidden" name="hiddenModalClientMaster" id="hiddenModalClientMaster"/>
	                                <input type="hidden" name="hiddenModalClientMasterErpCode" id="hiddenModalClientMasterErpCode"/>
	                                
	                                <input type="hidden" name="hiddenModalKeyDealYN" id="hiddenModalKeyDealYN"/>
	                                <input type="hidden" name="hiddenModalTempFlag" id="hiddenModalTempFlag" value="N"/>
	                                <input type="hidden" name="hiddenModalTempPK" id="hiddenModalTempPK"/>
	                                
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

var modalEvent = {
	on : function(){
		// Forecast 중복 선택 불가
		$('input:checkbox[name=checkModalForecastYN]').on('click', modalEvent.clickForecast);
		//tab menu
		$("ul.tabmenu-type").on('click.modalTab', 'li a', modalEvent.clickModalTab);
		//영업단계
		$("div.salescycle-step").on('click', 'ul li a', modalEvent.clickSalesCycle);
		//영업단계 체크항목
		$("div#divSalesCycleCheck").on('click', 'li label', modalEvent.clickSalesCycleCheck);
		//임시저장 submit 막기
		//$("#buttonTempSubmit, #buttonTempSelect").on("click", modalEvent.clickTempSubmit); 
	},
	
	off : function(){
		// Forecast 중복 선택 불가
		$('input:checkbox[name=checkModalForecastYN]').off('click', modalEvent.clickForecast);
		//tab menu
		$("ul.tabmenu-type").off('click.modalTab', 'li a', modalEvent.clickModalTab);
		//영업단계
		$("div.salescycle-step").off('click', 'ul li a', modalEvent.clickSalesCycle);
		//영업단계 체크항목
		$("div#divSalesCycleCheck").off('click', 'li label', modalEvent.clickSalesCycleCheck);
		//임시저장 submit 막기
		//$("#buttonTempSubmit, #buttonTempSelect").off("click", modalEvent.clickTempSubmit);
	},
	
	clickSalesCycle: function(e){
		e.preventDefault();
		var idx = $("div.salescycle-step ul li a").index($(this));
		$("div.salescycle-step ul li").removeClass("active");
		
		$("div#divSalesCycleCheck li").hide();
		$("div#divSalesCycleCheck li[data-category="+(idx+1)+"]").show();
		
		if(idx >= 3){ //close
			$("#divSalesCycleClose").show();	
		}else{
			$("#divSalesCycleClose").hide();
		}
		
		for(var i=0; i<=idx; i++){ //on 
			$("#hiddenModalSalesCycle").val(i+1);
			$("div.salescycle-step ul li").eq(i).addClass("active");	
		}
	},
	
	clickModalTab : function(e){
		e.preventDefault();
		var idx = $("ul.tabmenu-type li a").index($(this));
		$("ul.tabmenu-type li a").removeClass("sel");
		$(this).addClass("sel");
		$("div.modaltabmenu").addClass("off");
		$("div.modaltabmenu").eq(idx).removeClass("off");
	},
	
	clickSalesCycleCheck : function(e){
		if($(this).find("input[type='checkbox']").prop('checked')){
			$(this).find("input[type='checkbox']").val("Y");
		}else{
			$(this).find("input[type='checkbox']").val("N");
		}
	},
	
	clickForecast : function(){
		var self = $(this);
		
		if(self.prop('checked')){
			$('input:checkbox[name=checkModalForecastYN]').prop('checked', false);
			self.prop('checked', true);
		}
	},
	
	clickTempSubmit : function(e){ 
		return false;
	}
}

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.singleMember($("#formModalData #textModalExecOwner"), $('#formModalData #liModalSingleExecOwner'), $('#formModalData #hiddenModalExecId')); //실행임원
			commonSearch.singleMember($("#formModalData #textModalOpportunityOwner"), $('#formModalData #liModalSingleOwner'), $('#formModalData #hiddenModalOwnerId')); //OO
			commonSearch.singleMember($("#formModalData #textModalOpportunityIdentifier"), $('#formModalData #liModalSingleIdentifier'), $('#formModalData #hiddenModalIdentifierId')); //OI
			commonSearch.singleClientMaster($("#formModalData #textModalSingleClientMaster"), $('#formModalData #liModalSingleClientMaster'), $('#formModalData #hiddenModalClientMaster'), $('#formModalData #hiddenModalClientMasterErpCode')); //고객 담당자
			commonSearch.singleCompany($("#formModalData #textModalSingleCompany"), $('#formModalData #liModalSingleCompany'), $('#formModalData #hiddenModalCompanyId')); //고객사
			commonSearch.singleCompany($("#formModalData #textModalSingleClient"), $('#formModalData #liModalSingleClient'), $('#formModalData #hiddenModalCustomerId')); //고객명
			commonSearch.multiplePartner($("#formModalData #textMultiplePartner"), $('#formModalData #hiddenModalPartnerId'), $('#formModalData #ulMultiplePartner')); //파트너
			
			//commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			//commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
			
			/* $("#textCommonSearchPartner").keydown(function (key) {
		   		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		   			commonSearch.partnerInfo();
			     }
			 }); */
			
			//거래처영업대표 검색
			$("#formModalData #textDuzonSearchSalesMan").keydown(function(e) { 
			    if (e.keyCode == 13){
			    	//duzonSearch.salesManPopOpp();
			    	modal.selectClientSalesmanInfo();
			    }    
			});
			 
			$('#textModalContractAmount').keyup(function(){
				//$('tr[name="revTr"]').eq(0).find('input[name="amount_r"]').eq(0).val($(this).val());
				//oppSalesPlan.quarterSum();
				//oppSalesPlan.divisionSum();
			});
			
			/* 
			$("ul.tabmenu-type li a").click(function(e){
				e.preventDefault();
				var idx = $("ul.tabmenu-type li a").index($(this));
				$("ul.tabmenu-type li a").removeClass("sel");
				$(this).addClass("sel");
				$("div.modaltabmenu").addClass("off");
				$("div.modaltabmenu").eq(idx).removeClass("off");
			}); */
			
			//매출계획 계약일에 따른 분기 계산
			/* $('#textModalContractDate').change(function(){
				//if(isEmpty($("#textModalErpProjectCode").val())) oppSalesPlan.quarter();
			}); */
			
			//유효성 검사
			/* $("#textModalSubject, #textCommonSearchCompany, #textModalCustomerName, #textModalContractAmount, #textModalGPAmount,  #textModalContractDate, #textModalOpportunityOwner, #textModalOpportunityIdentifier").on("blur",function(e){
				switch (e.target.id) {
					case "textModalOpportunityOwner":
						$("#formModalData").find("#hiddenModalOwnerId").valid();
						break;
					case "textModalOpportunityIdentifier":
						$("#formModalData").find("#hiddenModalIdentifierId").valid();
						break;
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData").find("#hiddenModalCustomerId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			}); */
		},
		
		updateClientMasterErpCd : function(clientErpCd){
			$.post("/clientSalesActive/updateClientMasterErpCd.do", { customer_id: $("#hiddenModalClientMaster").val(), clientErpCd: clientErpCd }).done(function( data ) {
			    alert("연동되었습니다.");
			    $("#hiddenModalClientMasterErpCode").val(clientErpCd);
			    $("#divSingleClientMasterErr").hide();
			});
			
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=6&datatype=json",
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
					oppList.completeReload();
					commonFile.reloadFile($("#hiddenModalPK").val(), '6');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		scCheckList : function(){
			var list = new Array();
			$('div#divSalesCycleCheck input[name="checkSalesCycle"]').each(function(idx, val){
				var map = new Object();
				map.check_seq = (idx+1);
				map.check_yn = $(this).val();
				list.push(map);
			});		
			return list;
		},
		
		selectClientSalesmanInfo : function(){
			//고객담당자 ERP에서 가져옴..ㅋㅋㅋ
			$.ajaxLoadingShow();
			$.post("/duzon/selectClientSalesmanInfo2.do",function(){});
			setTimeout(function(){
				duzonSearch.salesManPopOpp();
				$.ajaxLoadingHide();	
			},3500);
		},
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			compare_flag = false;
			
			var HAN_NAME = "${userInfo.HAN_NAME}";
			var MEMBER_ID_NUM = "${userInfo.MEMBER_ID_NUM}";
			var POSITION_STATUS = "${userInfo.POSITION_STATUS}";
			
			//EVENT ON
			modalEvent.on();
			winPlanEvent.on();
			milestonesEvent.on();
			oppProductEvent.on();
			oppSalesPlanEvent.on();
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("h4.modal-title").html("영업기회 신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$('#buttonModalSubmit').show();
			
			$("small.font-bold").css('display','none');
			$("div.autocomplete-suggestions").hide();
			
			//rebate 전환하기 버튼 sales_cycle이 종료되지 않읂것만
			//$('div[name="rebateDiv"]').hide();
			
			//validate 초기화 및 text,selectbox,radio.. 등 초기화
			$("#formModalData").validate().resetForm();
			$("#formModalData textarea").height(1).height(33);
			
			//메일공유 초기화
			commonSearch.multiplePartnerArray = [];
			$("ul.flexdatalist-multiple li.value").remove();
			
			$("#formModalData input[autoFlag='y']").show(); //자동완성 항목들 show
			$('[name="erpTag"]').show(); //ERP 전환하기 보이기
			
			//히든값 초기화
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalCustomerId").val("");
			$("#formModalData #hiddenModalContractAmount").val("");
			$("#formModalData #hiddenModalExecId").val("");
			$("#formModalData #hiddenModalOwnerId").val("");
			$("#formModalData #hiddenModalIdentifierId").val("");
			$("#formModalData #hiddenModalSalesCycle").val("1");
			$("#formModalData #hiddenModalSalesCycleSave").val("");
			$("#formModalData #hiddenModalPartnerId").val("");
			$("#formModalData #hiddenModalClientMaster").val("");
			$("#formModalData #hiddenModalClientMasterErpCode").val("");
			
			$("a[name='aMoveSingleCompany']").remove();
			$("#aMoveSingleClientMaster").remove();
			$("#divSingleClientMasterErr").hide();
			
			//키딜버튼 숨김
			$("div.modal-header").children().last().hide();
			
			oppProduct.init(true); 	//매출, 매입 품목
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//tabl 초기화
			$("ul.tabmenu-type li a").removeClass("sel");
			$("ul.tabmenu-type li a:first").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu:first").removeClass("off");
			
			//Owner
			$("#textModalOpportunityOwner").hide();
			$("#hiddenModalOwnerId").val(MEMBER_ID_NUM);
         	$('#liModalSingleOwner').before(
         			'<li class="value">' +
					'<span class="txt" id="'+MEMBER_ID_NUM+'">'+HAN_NAME+' ['+ POSITION_STATUS +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityOwner\',\'liModalSingleOwner\',\'hiddenModalOwnerId\');"><i class="fa fa-times-circle"></i></a>'
			);
         	
			// 잠재영업기회에서 넘어온경우
			if(!isEmpty(returnOpportunityhiddenId)){
				//매출처
             	$("a[name='aMoveSingleCompany']").remove();
             	$("#textModalSingleCompany").hide();
             	$("#hiddenModalCompanyId").val(returnCompanyId);
             	$('#liModalSingleCompany').before(
             			'<li class="value">' +
						'<span class="txt" id="'+returnCompanyId+'">'+returnCompanyName+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
						'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+returnCompanyId+'&searchDetail='+encodeURI(returnCompanyName)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
            	//End User
            	$("#textModalSingleClient").hide();
             	$("#hiddenModalCustomerId").val(returnCustomerId);
             	$('#liModalSingleClient').before(
             			'<li class="value">' +
						'<span class="txt" id="'+returnCustomerId+'">'+returnCustomerName+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
						'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+returnCustomerId+'&searchDetail='+encodeURI(returnCustomerName)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
             	//영업대표
				$("#textModalOpportunityIdentifier").hide();
				$("#hiddenModalIdentifierId").val(returnSalesManId);
             	$('#liModalSingleIdentifier').before(
             			'<li class="value">' +
						'<span class="txt" id="'+returnSalesManId+'">'+returnSalesManName+' ['+ returnSalesManPosition +']</span>' +
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityIdentifier\',\'liModalSingleIdentifier\',\'hiddenModalIdentifierId\');"><i class="fa fa-times-circle"></i></a>'
				);
				$("#formModalData #textModalSubject").val(returnSubject);
				$("#formModalData #textModalContractAmount").val(returnOpportunityamount);
				$("#formModalData #hiddenModalOpportunityhiddenId").val(returnOpportunityhiddenId);
				returnOpportunityhiddenId = "";
			}else{
				//영업대표
				$("#textModalOpportunityIdentifier").hide();
				$("#hiddenModalIdentifierId").val(MEMBER_ID_NUM);
	           	$('#liModalSingleIdentifier').before(
	           		'<li class="value">' +
					'<span class="txt" id="'+MEMBER_ID_NUM+'">'+HAN_NAME+' ['+ POSITION_STATUS +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityIdentifier\',\'liModalSingleIdentifier\',\'hiddenModalIdentifierId\');"><i class="fa fa-times-circle"></i></a>'
				);
			}
			
             	
			oppSalesPlan.reset();
			oppSalesPlan.add();
			
			oppSalesSplit.reset();
			oppSalesSplit.add();
			
			milestones.reset();
			
			//영업단계
			$("#divSalesCycleClose").hide();
			$("div.salescycle-step ul li").removeClass("active");
			$("div.salescycle-step ul li:first").addClass("active");
			
			$('div#divSalesCycleCheck input[name="checkSalesCycle"]').prop("disabled",false);
			$('#selectSalesCloseCategory, #textareaSalesCloseDetail').prop("disabled",false);
			
			$("div#divSalesCycleCheck li").hide();
			$("div#divSalesCycleCheck li[data-category='1']").show();
			
			$("div.salescycle-step ul li a").on('click', modalEvent.clickSalesCycle);
			
			//체크리스트
			/* oppCheckList.clear();
			oppCheckList.draw();
			setTimeout(function(){
				oppCheckList.reload();
			}, 400); */
			//ockReset();
			//ockMainAdd();
			
			//윈플랜
			/* oppWinPlan.clear();
			oppWinPlan.draw();
			setTimeout(function(){
				oppWinPlan.reload();
			}, 400); */
			winReset();
			winMainAdd();
			
			//코칭톡 버튼 제거, 창 hide
			$("#buttonModalCoachingTalkView").hide();
			$("#divModalCoachingTalk").hide();
			$("#hiddenModalTempPK").val("");
			
			//임시저장 체크
			$("#buttonTempSelect").hide();
			$('#buttonTempSubmit').show();
			$.get("/clientSalesActive/selectTempCountOpp.do", {member_id_num: MEMBER_ID_NUM}).done(function(data){
    			if(data.opportunity_id != 0){
    				$("#buttonTempSelect").show();
    				$('#buttonTempSubmit').hide();
    				$('#hiddenModalTempPK').val(data.opportunity_id);
    			}
  			});
			
			$("#myModal1").modal();
			
			
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: "",
					rules : {
						textModalSubject : {
							required : true,
							maxlength : 50
						},
						selectModalCategoryCd : {
							required : true
						},
						selectModalTypeCd : {
							required : true
						},
						selectModalProjectForm : {
							required : true
						},
						selectModalClientCategoryCd : {
							required : true
						},
						selectModalBuyCd : {
							required : true
						},
						hiddenModalCompanyId : {
							required : true
						},
						hiddenModalCustomerId : {
							required : true
						},
						textModalContractAmount : {
					 		required : true
						},
						textModalContractDate : {
					 		required : true
						},
						textModalContractStDate : {
							required : true
						},
						textModalContractEdDate : {
							required : true
						},
						 hiddenModalOwnerId : {
							required : true
						},
						hiddenModalIdentifierId : {
							required : true
						},
						hiddenModalClientMaster : {
							required : true
						}
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalSubject : {
							required : "사업명을 입력하세요.",
							maxlength: $.validator.format('{0}자 내로 입력하세요.') 
						},
						selectModalCategoryCd : {
							required : "영업구분을 선택해 주세요."
						},
						selectModalTypeCd : {
							required : "영업유형을 선택해 주세요."
						},
						selectModalProjectForm : {
							required : "프로젝트형태를 선택해 주세요."
						},
						selectModalClientCategoryCd : {
							required : "고객구분을 선택해 주세요."
						},
						selectModalBuyCd : {
							required : "구매방법을 선택해 주세요."
						},
						hiddenModalCompanyId : {
							required : "매출처를 입력하세요."
						},
						hiddenModalCustomerId : {
							required : "End User를 입력하세요."
						},
						textModalContractAmount : {
							required : "예상계약금액을 입력하세요."
						},
						textModalContractDate : {
							required : "계약일를 선택하세요."
						},
						textModalContractStDate : {
							required : "계약 시작일을 선택하세요."
						},
						textModalContractEdDate : {
							required : "계약 종료일을 선택하세요."
						},
						 hiddenModalOwnerId : {
							 required : "Owner을 입력하세요."
						},
						hiddenModalIdentifierId : {
							required : "영업대표를 입력하세요."
						},
						hiddenModalClientMaster : {
							required : "고객담당자를 입력하세요."
						}
					},
					errorPlacement : function(error, element) {
						if($(element).prop("id") == "hiddenModalCompanyId") {
					    	$("#ulModalSingleCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else if($(element).prop("id") == "hiddenModalCustomerId") {
					        $("#ulModalSingleClient").after(error);
					        location.href = "#textModalSingleClient";
					    }else if($(element).prop("id") == "hiddenModalOwnerId") {
					    	$("#ulModalSingleOwner").after(error);
					        $("ul.tabmenu-type li a").eq(0).trigger('click.modalTab');
					        location.href = "#textModalOpportunityOwner";
					    }else if($(element).prop("id") == "hiddenModalIdentifierId") {
					    	$("#ulModalSingleIdentifier").after(error);
					    	$("ul.tabmenu-type li a").eq(0).trigger('click.modalTab');
					        location.href = "#textModalOpportunityIdentifier";
					    }else if($(element).prop("id") == "hiddenModalClientMaster") {
					        $("#ulModalSingleClientMaster").after(error);
					        $("ul.tabmenu-type li a").eq(0).trigger('click.modalTab');
					        location.href = "#textModalSingleClientMaster";
					    }else{
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		checkClientMaster : function(callback){
			var flag = true;
			$.post("/clientSalesActive/selectClientMasterErpCd.do", { customer_id: $("#hiddenModalClientMaster").val()}).done(function( data ) {
				callback(data.ERP_CLIENT_CODE);
 			});
		},
		
		submit : function(erpSubmitFlag){
				$("#formModalData").validate().settings.ignore = "";
				$("#formModalData").find("label.error").remove();
				
				var url = "";
				(modalFlag == "ins") ? url = "/clientSalesActive/insertOpportunity.do" : url = "/clientSalesActive/updateOpportunity.do";
				
				$("#hiddenModalTempFlag").val("N");
				//예상계약금액, 예상GP금액
				$("#hiddenModalContractAmount").val(uncomma($("#textModalContractAmount").val()));
				//$("#hiddenModalGPAmount").val(uncomma($("#textModalGPAmount").val()));
				
				//영업단계 체크
				var scCheckList = modal.scCheckList();
				
				//매입/매출품목
				var productFlag = oppProduct.setList(false);
				
				//고객담당자 체크
				modal.checkClientMaster(function(client_code){
					$("#hiddenModalClientMasterErpCode").val(client_code);
				});
				
				//매출계획
				oppSalesPlan.calSalesPlan();
				
				//스플릿
				oppSalesSplit.getList();
				
				//마일스톤
				//oppMilestone.saveRow();
				milestones.msAddListMaster();
				
				//체크리스트 new
				//var ockFlag = ockAddListMaster();
				//var ockFlag2 = ockAddListSub();
				
				//윈플랜 new
				var winFlag_1 = winAddListMaster(false);
				var winFlag_2 = winAddListSub(false);
				
				$('#formModalData').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			mileStoneData : JSON.stringify(milestones.msList),
		    			//checkMasterList : JSON.stringify(ockListMaster),
		    			//checkSubList : JSON.stringify(ockListSub),
		    			scCheckList : JSON.stringify(scCheckList),
		    			winMasterList : JSON.stringify(winListMaster),
		    			winSubList : JSON.stringify(winListSub),
		    			productSalesData : JSON.stringify(oppProduct.salesList),
		    			productPsData : JSON.stringify(oppProduct.psList),
		    			salesPlanData : JSON.stringify(oppSalesPlan.salesPlanList),
		    			salesSplitData : JSON.stringify(oppSalesSplit.salesSplitList),
		    			fileData : JSON.stringify(commonFile.fileArray)
		    		},
		            beforeSubmit: function (data,form,option) {
		            	//고객담당자 체크
		            	if(erpSubmitFlag & isEmpty($("#hiddenModalClientMasterErpCode").val())){
		            		$("#divSingleClientMasterErr").show();
		            		document.getElementById("divSingleClientMasterErr").scrollIntoView(); 
		            		$("ul.tabmenu-type li a").eq(0).trigger('click.modalTab');
		            		compare_before = $("#formModalData").serialize();
		            		return false;
		            	}
		            	
		            	//매출/매입
		            	if(!productFlag || !winFlag_1 || !winFlag_2) return false;
						
	            		if(!compare_flag){ //창 닫을떄
	            			if(!erpSubmitFlag){
	            				if(!confirm("저장하시겠습니까?")) return false;
	            			}else{
	            				if(!confirm("전환하시겠습니까?")) return false;
	            			}
						}	
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		            	if(!erpSubmitFlag){
            			 alert("저장하였습니다.");
            			 if(modalFlag == "ins") {
            				 oppList.searchReset(); //등록/수정 시 검색 초기화
            				 oppList.tabClick(2, 1);
            			 }
            			 oppList.completeReload(data.pkNo);
 		                 setTimeout(function(){
 		                 	compare_before = $("#formModalData").serialize();
 		                 	$.ajaxLoadingHide();
 		                 },450);
		            	}else{ //ERP Submit
		            		modal.submitErp(data.pkNo);
		            	}
		            },
		            complete : function(){
					}
		        });	
		},
		
		deleteModal : function(pkNo){
			$.ajax({
				url : "/clientSalesActive/deleteOpportunity.do",
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
					oppList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		submitErp : function(pkNo){
			$.ajax({
				url : "/duzon/updateOppToErp.do",
				datatype : 'json',
				beforeSend : function(xhr){
				},
				data :{
					pkNo: pkNo
				},
				success : function(data){
					alert("ERP 영업기회에 등록하였습니다.");
					oppList.completeReload(pkNo);
				},
				complete : function(){
					setTimeout(function(){
	                 	compare_before = $("#formModalData").serialize();
	                 	$.ajaxLoadingHide();
	                 },600);
				}
			});
		},
		
		//키딜(like 즐겨찾기)설정 - 신규등록일 경우는 사용 불가능
		changeKeyDeal : function(obj) {
			var keyDeal = $(obj).children().eq(0).attr('class');
			
			if(keyDeal == 'fa fa-star fa-2x') {	//키딜 해제
				$(obj).children().eq(0).attr('class', 'fa fa-star-o fa-2x');
				$("#hiddenModalKeyDealYN").val('N');
			}else { //키딜 설정
				$(obj).children().eq(0).attr('class', 'fa fa-star fa-2x');
				$("#hiddenModalKeyDealYN").val('Y');
			}
			//키딜만 저장
			$.ajax({
				url : "/clientSalesActive/updateOppKeyDeal.do",
				datatype : 'json',
				beforeSend : function(xhr){
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val(),
					hiddenModalKeyDealYN: $("#hiddenModalKeyDealYN").val()
				},
				success : function(data){
					//alert("KeyDeal로 설정하였습니다.");
					oppList.completeReload(data.pkNo);
				},
				complete : function(){
					setTimeout(function(){
	                 	compare_before = $("#formModalData").serialize();
	                 	$.ajaxLoadingHide();
	                 },500);
				}
			});
		},
		
		rebateComplete : function(){
			//salesCycle 5로 업데이트
			$.ajax({
				url : "/clientSalesActive/updateOppSalesCycle.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("전환하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					alert("전환하였습니다.");
					oppList.tabClick(3, 2);
					oppList.completeReload(data.pkNo);
				},
				complete : function(){
					setTimeout(function(){
	                 	compare_before = $("#formModalData").serialize();
	                 	$.ajaxLoadingHide();
	                 },500);
				}
			});
		},
		
		
		//임시저장
		tempSubmit : function(){

			$("#formModalData").validate().settings.ignore = "*";
				
			var url = "";
			var checkPk = $("#hiddenModalPK").val();
			(checkPk == "") ? url = "/clientSalesActive/insertOpportunity.do" : url = "/clientSalesActive/updateOpportunity.do";
			
			$("#hiddenModalTempFlag").val("Y");
			//예상계약금액, 예상GP금액
			$("#hiddenModalContractAmount").val(uncomma($("#textModalContractAmount").val()));
			//$("#hiddenModalGPAmount").val(uncomma($("#textModalGPAmount").val()));
			
			//영업단계 체크
			var scCheckList = modal.scCheckList();
			
			//매입/매출품목
			var productFlag = oppProduct.setList(true);
			
			//고객담당자 체크
			modal.checkClientMaster(function(client_code){
				$("#hiddenModalClientMasterErpCode").val(client_code);
			});
			
			//매출계획
			oppSalesPlan.calSalesPlan();
			
			//스플릿
			oppSalesSplit.getList();
			
			//마일스톤
			//oppMilestone.saveRow();
			milestones.msAddListMaster();
			
			//체크리스트 new
			//var ockFlag = ockAddListMaster();
			//var ockFlag2 = ockAddListSub();
			
			//윈플랜 new
			var winFlag_1 = winAddListMaster(true);
			var winFlag_2 = winAddListSub(true);
			
			$('#formModalData').ajaxForm({
	    		url : url,
	    		async : true,
	    		dataType: "json",
	    		data : {
	    			mileStoneData : JSON.stringify(milestones.msList),
	    			//checkMasterList : JSON.stringify(ockListMaster),
	    			//checkSubList : JSON.stringify(ockListSub),
	    			scCheckList : JSON.stringify(scCheckList),
	    			winMasterList : JSON.stringify(winListMaster),
	    			winSubList : JSON.stringify(winListSub),
	    			productSalesData : JSON.stringify(oppProduct.salesList),
	    			productPsData : JSON.stringify(oppProduct.psList),
	    			salesPlanData : JSON.stringify(oppSalesPlan.salesPlanList),
	    			salesSplitData : JSON.stringify(oppSalesSplit.salesSplitList),
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
					if(!confirm("임시저장하시겠습니까?")) return false;
	            	$.ajaxLoadingShow();
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            success: function(data){
	            	alert("임시저장하였습니다.");
	       			 if(modalFlag == "ins") {
	       				 //oppList.searchReset(); //등록/수정 시 검색 초기화
	       				 //oppList.tabClick(2, 1);
	       			 }
       			 	oppList.completeReload(data.pkNo);
	                setTimeout(function(){
	                 compare_before = $("#formModalData").serialize();
	                 $.ajaxLoadingHide();
	                },450);
	            },
	            complete : function(){
				}
	        });
			
		},
		
		//임시저장 불러오기
		tempSelect : function(){
			oppList.goDetail($('#hiddenModalTempPK').val());
		}
		
}
</script>
