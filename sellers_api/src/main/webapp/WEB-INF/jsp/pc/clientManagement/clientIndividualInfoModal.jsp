<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">고객개인정보 관리</h4>
           </div>
           <div class="modal-body">
               <div class="row">
                   <div class="col-lg-12">
                       <div class="ibox float-e-margins">
                       
                          <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                           <div class="ibox-content border_n" id="divModalToggle">
                               <div class="form-group">
                                    <div class="col-sm-12 ag_r" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
                                </div>
                                
                               <div class="hr-line-bottom"></div>
                               
                               <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
	                    			<div class="col-sm-4"><input type="text" class="form-control" id="textModalClientName" name="textModalClientName" autocomplete="off"/></div>
	                    			<label class="col-sm-2 control-label">직급</label>
	                    			<div class="col-sm-4">
	                    				<input type="text" class="form-control" id="textModalPosition" name="textModalPosition" autocomplete="off"/>
                    				</div>
	               				</div>
	               				
	               				<div class="hr-line-dashed"></div>
	               				
	               				<div class="form-group"><label class="col-sm-2 control-label">휴대전화</label>
	                    			<div class="col-sm-4"><input type="text" class="form-control" placeholder="예) 01012345678" id="textModalCellPhone" name="textModalCellPhone" onblur="autoHypen(this);" onkeyup="commonCheck.onlyNumber(this);" autocomplete="off"/></div>
	                    			<label class="col-sm-2 control-label">직장전화</label>
	                    			<div class="col-sm-4"><input type="text" class="form-control" placeholder="예) 01012345678" id="textModalPhone" name="textModalPhone" onblur="autoHypen(this);" onkeyup="commonCheck.onlyNumber(this);" autocomplete="off"/></div>
	               				</div>

	               				<div class="hr-line-dashed"></div>
	               				
	               				<div class="form-group">
	               					<label class="col-sm-2 control-label">전자메일</label>
	                    			<div class="col-sm-4"><input type="text" class="form-control" id="textModalEmail" name="textModalEmail" autocomplete="off"/></div>
	                    			<label class="col-sm-2 control-label">재직여부</label>
                                    <div class="col-sm-4">
                                        <label class="" style="margin-right:30px"> <input type="radio" value="Y" name="radioModalUseYN" checked> <span class="va-m">재직</span></label>
                                        <label> <input type="radio" value="N" id="radioModalUseYN" name="radioModalUseYN"> <span class="va-m">퇴사</span></label>
                                    </div>
	               				</div>
	               				
	               				<div class="hr-line-dashed"></div>
		                                 	    
                           	    <!-- <div class="form-group pos-rel">
                           	    	<label class="col-sm-2 control-label">ERP연동 여부</label>
                        			<div class="col-sm-4">
                        				<span nmae="spanERPClientCodeCheck" id="spanERPClientCodeCheck" style="margin-right:20px">
                        					<i class="fa fa-close" style="color: red;"></i>
                        					<i class="fa fa-check" style="color: green;"></i>
                        				</span>
                        				<button type="button" class="btn btn-outline btn-seller-outline ag_r" id="buttonUpdateERPClientCode" onClick="duzonSearch.reset();"> 연동하기</button>
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
                                                        <button type="button" class="btn btn-gray btn-file" onClick="duzonSearch.salesManPop();">검색</button>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 company-result mg-b10 ">
                                                    <strong>[검색 결과]</strong>
                                                    <ul class="company-list">
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="ta-c">
                                                <button type="button" class="btn btn-gray btn-file">추가하기</button>
                                            </div>
                                        </div>
                                    </div>
                                    <label class="col-sm-2 control-label">ERP코드</label>
                                    <div class="col-sm-4">
                                    	<input type="text" class="form-control" id="textModalERPClientCode" name="textModalERPClientCode" readOnly/>
                                    </div>
                           	    </div> 
                           	    <div class="hr-line-bottom"></div> -->
	               				
	               				
                               
                               <div class="tab-area">

                                            <!-- tab-menu -->
                                            <ul class="tabmenu-type">
                                                <li><a class="sel" onclick="modal.gotoDetail('1');">소속회사</a></li>
                                                <li><a class=""  onclick="modal.gotoDetail('2');">개인정보</a></li>
                                                <li><a class="" onclick="modal.gotoDetail('3');">이전회사 정보</a></li>
                                            </ul>
                                            <!--// tab-menu -->

                                            <!-- tab-cont -->

                                            <!-- 소속회사 -->
                                            <div class="sub_cont scont1 modaltabmenu">
                                            	<div class="form-group pos-rel"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
				                                     <div class="col-sm-4 pos-rel">
				                                     	<ul id="ulCommonSearchCompany" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liCommonSearchCompany" name="liCommonSearchCompany">
                                                      <input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
		                                       	 					<input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                                 </li>
                                              </ul>
				                                         
				                                     </div>
				                                     <label class="col-sm-2 control-label">고객사ID</label>
				                                     <div class="col-sm-4 pos-rel">
			                                         	<input type="text" class="form-control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly/>
			                                         </div>
		                                 	    </div>
		                                 	    
		                                 	    <div class="hr-line-dashed"></div>
		                                 	    
		                                 	    <div class="form-group pos-rel"><label class="col-sm-2 control-label">소속본부</label>
                                        			<div class="col-sm-4"><input type="text" class="form-control" id="textModalDivision" name="textModalDivision" autocomplete="off"/></div>
                                   					<label class="col-sm-2 control-label">소속부서</label>
                                   					<div class="col-sm-4"><input type="text" class="form-control" id="textModalPost" name="textModalPost" autocomplete="off"/></div>
		                                 	    </div>
		                                 	    
		                                 	    <div class="hr-line-dashed"></div>
		                                 	    
		                                 	    <div class="form-group pos-rel"><label class="col-sm-2 control-label">소속팀</label>
                                        			<div class="col-sm-4"><input type="text" class="form-control" id="textModalTeam" name="textModalTeam" autocomplete="off"/></div>
		                                 	    	<label class="col-sm-2 control-label">직책</label>
                                        			<div class="col-sm-4"><input type="text" class="form-control" id="textModalPositionDuty" name="textModalPositionDuty"/></div>
                                   				</div>
                                   				
                                   				<div class="hr-line-dashed"></div>
                                   				
                                   				<div class="form-group pos-rel"><label class="col-sm-2 control-label">보고라인</label>
                                   					<div class="col-sm-10 pd-no">
                                                        <div class="col-sm-4 pd-no">
                                                            <label class="col-sm-12 control-label ag_l">소속팀</label>
                                                            <!-- <div class=""><input type="hidden" class="form-control" onclick="" id="textModalReportingLineTeam" name="textModalReportingLineTeam"/></div> -->
                                                            <div class="col-sm-12 pos-rel">
                                                           		<ul id="ulModalReportingLineTeamName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalReportingLineTeamName" name="liModalReportingLineTeamName">
								                                                      <input type="text" class="form-control" placeholder="보고라인을 검색해주세요." id="textModalReportingLineTeamName" name="textModalReportingLineTeamName" autocomplete="off"/>
										                                       	 					<input type="hidden" name="textModalReportingLineTeam" id="textModalReportingLineTeam"/>
										                                       	 					<input type="hidden" name="textModalReportingLineTeamErpCode" id="textModalReportingLineTeamErpCode"/>
										                                       	 					<input type="hidden" class="form-control" id="textModalReportingTeamResult" name="textModalReportingTeamResult"/>
								                                                 </li>
								                                              </ul>
                                                           	</div>
                                                            <!-- <div class="col-sm-12 control-label ag_l"><input type="text" class="form-control" id="textModalReportingTeamResult" name="textModalReportingTeamResult" readOnly/></div> -->
                                                        </div>
                                                        <div class="col-sm-4 pd-no">
                                                            <label class="col-sm-12 control-label ag_l">소속부서</label>
                                                            <!-- <div class=""><input type="hidden" class="form-control" onclick="" id="textModalReportingLinePost" name="textModalReportingLinePost"/></div> -->
                                                            <div class="col-sm-12 pos-rel">
                                                           		<ul id="ulModalReportingLinePostName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalReportingLinePostName" name="liModalReportingLinePostName">
								                                                      <input type="text" class="form-control" placeholder="보고라인을 검색해주세요." id="textModalReportingLinePostName" name="textModalReportingLinePostName" autocomplete="off"/>
										                                       	 					<input type="hidden" name="textModalReportingLinePost" id="textModalReportingLinePost"/>
										                                       	 					<input type="hidden" name="textModalReportingLinePostErpCode" id="textModalReportingLinePostErpCode"/>
										                                       	 					<input type="hidden" class="form-control" id="textModalReportingPostResult" name="textModalReportingPostResult"/>
								                                                 </li>
								                                              </ul>
                                                           	</div>
                                                            <!-- <div class="col-sm-12 control-label ag_l"><input type="text" class="form-control" id="textModalReportingPostResult" name="textModalReportingPostResult" readOnly/></div> -->
                                                        </div>
                                                        <div class="col-sm-4 pd-no">
                                                            <label class="col-sm-12 control-label ag_l">소속본부</label>
                                                            <!-- <div class=""><input type="hidden" class="form-control" onclick="" id="textModalReportingLineDivision" name="textModalReportingLineDivision"/></div> -->
                                                            <div class="col-sm-12 pos-rel">
                                                           		<ul id="ulModalReportingLineDivisionName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalReportingLineDivisionName" name="liModalReportingLineDivisionName">
								                                                      <input type="text" class="form-control" placeholder="보고라인을 검색해주세요." id="textModalReportingLineDivisionName" name="textModalReportingLineDivisionName" autocomplete="off"/>
									                                       	 						<input type="hidden" name="textModalReportingLineDivision" id="textModalReportingLineDivision"/>			
									                                       	 						<input type="hidden" name="textModalReportingLineDivisionErpCode" id="textModalReportingLineDivisionErpCode"/>	
									                                       	 						<input type="hidden" class="form-control" id="textModalReportingDivisionResult" name="textModalReportingDivisionResult"/>							 
								                                                 </li>                         
								                                              </ul>
                                                           	</div>
                                                            <!-- <div class="col-sm-12 control-label ag_l"><input type="text" class="form-control" id="textModalReportingDivisionResult" name="textModalReportingDivisionResult" readOnly/></div> -->
                                                        </div>
                                                    </div>
                                   				</div>
                                   				
                                   				<div class="hr-line-dashed"></div>
                                   				
                                   				<div class="form-group"><label class="col-sm-2 control-label">담당업무</label>
                                        			<div class="col-sm-10"><input type="text" class="form-control" id="textModalDuty" name="textModalDuty" autocomplete="off"/></div>
                                   				</div>
                                   				
                                   				<div class="hr-line-dashed"></div>
		                                 	    
		                                 	    <div class="form-group"><label class="col-sm-2 control-label">집주소</label>
                                       				<div class="col-sm-10"><input type="text" class="form-control" id="textModalAddress" name="textModalAddress" autocomplete="off"/></div>
                                   				</div>   
                                   
                                   				<div class="hr-line-dashed"></div> 
		                                 	    
		                                 	    <div class="form-group"><label class="col-sm-2 control-label">자사와의 관계</label>
                                       				<div class="col-sm-10"><input type="text" class="form-control" id="textModalRelationshipInfo" name="textModalRelationshipInfo" autocomplete="off"/></div>
			                                   	</div>   
			                                   	  
			                                   	<div class="hr-line-dashed"></div>  
			                                   	
			                                   	<div class="form-group"><label class="col-sm-2 control-label">관계수립</label>
                                       				<div class="col-sm-4">
                                       					<div class="select-com">
                                       					<select class="form-control" id="selectModalRelation" name="selectModalRelation" onchange="modal.changeSelect(this);" style="background-color:green; color: white; font-weight: bold;">
                                       						<option value="green" style="background-color: green; color: white; font-weight: bold;" selected="selected">YES</option>
                                       						<option value="red" style="background-color: red; color: white; font-weight: bold;">NO</option>
                                       					</select>
                                       					</div>
                                       				</div>
                                       				<label class="col-sm-2 control-label">호감도</label>
                                       				<div class="col-sm-4">
                                       				<div class="select-com">
                                       					<select class="form-control" id="selectModalLikeAbility" name="selectModalLikeAbility" onchange="modal.changeSelect(this);" style="background-color:green; color: white; font-weight: bold;">
                                       						<option value="green" style="background-color: green; color: white; font-weight: bold;" selected="selected">Positive</option>
                                       						<option value="orange" style="background-color: orange; color: white; font-weight: bold;">Neutral</option>
                                       						<option value="red" style="background-color: red; color: white; font-weight: bold;">Negative</option>
                                       						<option value="gray" style="background-color: gray; color: white; font-weight: bold;">None</option>
                                       					</select>
													</div>
													</div>
			                                   	</div> 
			                                   	                                                                          
			                                   	<div class="hr-line-dashed"></div>  
		                                 	    
	                                 	    	<div class="form-group"><label class="col-sm-2 control-label">사내친한직원</label>
		                                       	<div class="col-sm-4"><input type="text" class="form-control" id="textModalFriendshipInfo" name="textModalFriendshipInfo" autocomplete="off"/></div>
		                                       	<label class="col-sm-2 control-label">책임자</label>
		                                       	<div class="col-sm-4 pos-rel">
			                                       	<ul id="ulModalDirectorName" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalDirectorName" name="liModalDirectorName">
                                                      <input type="text" class="form-control" id="textModalDirectorName" name="textModalDirectorName" placeholder="책임자를 검색해 주세요." autocomplete="off"/>
		                                       	 					<input type="hidden" name="hiddenModalDirectorId" id="hiddenModalDirectorId"/>
                                                 </li>
                                              </ul> 
		                                       	</div>
			                                   	</div>
			                                   	
			                                   	<div class="hr-line-dashed"></div>
			                                   	
			                                   	<div class="form-group"><label class="col-sm-2 control-label">정보출처</label>
			                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalPerSonalInfoSource" name="textModalPerSonalInfoSource" autocomplete="off"/></div>
			                                       <label class="col-sm-2 control-label">이전영업사원</label>
			                                       <div class="col-sm-4 pos-rel">
			                                       	<ul id="ulModalPerSonalPrevSales" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalPerSonalPrevSales" name="liModalPerSonalPrevSales">
                                                      <input type="text" class="form-control" id="textModalPerSonalPrevSales" name="textModalPerSonalPrevSales" placeholder="이전영업사원을 검색해 주세요." autocomplete="off"/>
		                                       	 					<input type="hidden" name="hiddenModalPrevSalesMemberId" id="hiddenModalPrevSalesMemberId"/>
                                                 </li>
                                              </ul>    
			                                       	<!-- <input type="text" class="form-control" id="textModalPerSonalPrevSales" name="textModalPerSonalPrevSales" placeholder="이전영업사원을 검색해 주세요." autocomplete="off"/>
		                                       	 	<input type="hidden" name="hiddenModalPerSonalPrevSales" id="hiddenModalPerSonalPrevSales"/> -->
		                                       	 </div>
			                                   	</div>
			                                   	
			                                   	<div class="hr-line-dashed"></div>
			                                   	
			                                   	<div class="form-group"><label class="col-sm-2 control-label">명함/사진</label>
				                                   	<div class="col-sm-5 custom-photo">
				                                   		<label for="fileModalUploadNameCard"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck('fileModalUploadNameCard');" style="color: white">명함첨부</a>
				                                   		</label>
				                                   		<div id="divModalNameCardUploadArea">
					        															<div class="filebox photo">
					        							
							                               		<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
							                               		<input type="file" name="fileModalUploadNameCard" id="fileModalUploadNameCard" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadNameCard'))" />
													        							<div id="divModalUploadNameCard">
													        								<span class="blank-ment"><img style="background:url('../images/pc/namecard_default.png') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>
													        							</div>
					        							
					        								</div>
					                               		</div>
				                                   	</div>
				                                   	<div class="col-sm-5 custom-photo">
				                                   		<label for="fileModalUploadPhoto"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck('fileModalUploadPhoto');" style="color: white">사진첨부</a>
				                                   		</label>
				                                   		<div id="divModalPhotoUploadArea">
					        								<div class="filebox photo">
					        							
							                               		<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
							                               		<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
							        							<div id="divModalUploadPhoto">
							        								<span class="blank-ment"><img style="background:url('../images/pc/photo_default.png') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>
							        							</div>
					        							
					        								</div>
					                               		</div>
				                                   	</div>
				                                   	<!-- <div class="col-sm-12 m-b text-center custom-photo">
					                                   	<div id="divModalPhotoUploadArea">
					        								<div class="filebox photo">
					        							
							                               		<label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label>
							                               		<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
							        							<div id="divModalUploadPhoto">
							        								<span class="blank-ment"><img style="background:url('../images/pc/namecard_default.png') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>
							        							</div>
					        							
					        								</div>
					                               		</div>
				                               		</div> -->
				                               	</div>
			                                   	</div>
			                                   	
                               				</div>
                                            <!--// 소속회사 -->
                                            
                                             <!-- 개인정보 -->
                                            <div class="sub_cont scont2 modaltabmenu off">
                                            	<div class="form-group"><label class="col-sm-2 control-label">학력</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalEducation" name="textModalPerSonalEducation"></textarea></div>
			                                   	<label class="col-sm-2 control-label">학력관련<br/>인맥정보</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalEducationPerson" name="textModalPerSonalEducationPerson"></textarea></div>
			                                   	</div>
			                                   	<div class="hr-line-dashed"></div>
			                                   	<div class="form-group"><label class="col-sm-2 control-label">경력</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalCareer" name="textModalPerSonalCareer"></textarea></div>
			                                   	<label class="col-sm-2 control-label">경력관련<br/>인맥정보</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalCareerPerson" name="textModalPerSonalCareerPerson"></textarea></div>
			                                   	</div>
			                                   	<div class="hr-line-dashed"></div>                                                                                    
			                                   	<div class="form-group"><label class="col-sm-2 control-label">사회활동</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalActs" name="textModalPerSonalActs"></textarea></div>
			                                       <label class="col-sm-2 control-label">가족</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalFamily" name="textModalPerSonalFamily"></textarea></div>
			                                   	</div>
			                                   	<div class="hr-line-dashed"></div>                                                                                    
			                                   	<div class="form-group"><label class="col-sm-2 control-label">성향</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalInclination" name="textModalPerSonalInclination"></textarea></div>
			                                       <label class="col-sm-2 control-label">친한사람</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalFamiliars" name="textModalPerSonalFamiliars"></textarea></div>
			                                   	</div>
			                                   	<div class="hr-line-dashed"></div>                                                                                    
			                                   	<div class="form-group"><label class="col-sm-2 control-label">SNS</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalSNS" name="textModalPerSonalSNS"></textarea></div>
			                                       <label class="col-sm-2 control-label">기타</label>
			                                       <div class="col-sm-4"><textarea class="pop-textarea-input" rows="5" id="textModalPerSonalETC" name="textModalPerSonalETC"></textarea></div>
			                                   	</div>
                                            </div>
                               				<!--// 개인정보 -->
                                            
                                            <!-- 이전회사 이력 -->
                                            <div class="sub_cont scont3 modaltabmenu off">
                                            	<div class="form-group">
                                            		<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientIndividualHistoryModal.jsp"/>
                                            	</div>
                                            </div>
                                            <!--// 이전회사 이력 -->

                                            <!--// tab-cont -->

                                        </div>
                                        <!--// TabMenu -->

                                        <div class="hr-line-bottom"></div>

                                        <!-- <p class="text-center pt-t20">
                                            <button type="button" class="btn btn-w-m btn-primary btn-gray">등록</button>
                                        </p> -->
                                   	
                                    <p class="text-center">
                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
                                    </p>
                                    <input type="hidden" name="hiddenModalPK" 		 id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <!-- <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalDirectorId" id="hiddenModalDirectorId"/>
                                    <input type="hidden" name="hiddenModalPrevSalesMemberId" id="hiddenModalPrevSalesMemberId"/> -->
                                </form>
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
</div>
                                                
                                                
                                                
<script type="text/javascript">
var comparePerSonalProfile = "";
var comparePerSonalActs = "";
var comparePerSonalFamily = "";
var comparePerSonalInclination = "";
var comparePerSonalFamiliars = "";
var comparePerSonalSNS = "";
var comparePerSonalETC = "";

$(document).ready(function() { 
	modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();

			//자동완성 검색
			/* commonSearch.company($("#formModalData #textCommonSearchCompany"), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId')); */
			/* commonSearch.customer($("#formModalData #textModalReportingLineDivisionName"), $('#formModalData #textModalReportingDivisionResult'), $("#formModalData #textModalReportingDivisionPosition"), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.customer($("#formModalData #textModalReportingLinePostName"), $('#formModalData #textModalReportingPostResult'), $("#formModalData #textModalReportingPostPosition"), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.customer($("#formModalData #textModalReportingLineTeamName"), $('#formModalData #textModalReportingTeamResult'), $("#formModalData #textModalReportingTeamPosition"), $("#formModalData #textCommonSearchCompanyId")); */
			/* commonSearch.member($("#formModalData #textModalDirectorName"), $("#hiddenModalDirectorId")); */
			/* commonSearch.member($("#formModalData #textModalPerSonalPrevSales"), $("#hiddenModalPrevSalesMemberId")); */
			
			//자동완성 검색
			commonSearch.singleClientMaster($("#formModalData #textModalReportingLineDivisionName"), $('#formModalData #liModalReportingLineDivisionName'), $('#formModalData #textModalReportingDivisionResult'), $('#formModalData #textModalReportingLineDivisionErpCode')); //보고라인
			commonSearch.singleClientMaster($("#formModalData #textModalReportingLinePostName"), $('#formModalData #liModalReportingLinePostName'), $('#formModalData #textModalReportingPostResult'), $('#formModalData #textModalReportingLinePostErpCode')); //보고라인
			commonSearch.singleClientMaster($("#formModalData #textModalReportingLineTeamName"), $('#formModalData #liModalReportingLineTeamName'), $('#formModalData #textModalReportingTeamResult'), $('#formModalData #textModalReportingLineTeamErpCode')); //보고라인
			commonSearch.singleCompany($("#formModalData #textCommonSearchCompany"), $('#formModalData #liCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId')); //고객사
			commonSearch.singleMember($("#formModalData #textModalDirectorName"), $('#formModalData #liModalDirectorName'), $('#formModalData #hiddenModalDirectorId')); //책임자
			commonSearch.singleMember($("#formModalData #textModalPerSonalPrevSales"), $('#formModalData #liModalPerSonalPrevSales'), $('#formModalData #hiddenModalPrevSalesMemberId')); //이전영업사원
			
			//거래처영업대표 검색
			$("#formModalData #textDuzonSearchSalesMan").keydown(function(e) { 
			    if (e.keyCode == 13){
			    	duzonSearch.salesManPop();
			    }    
			});
		},
		gotoDetail : function(num) {
			var idx = $("ul.tabmenu-type li a").index($("#divModalToggle > div.tab-area > ul > li:nth-child("+num+") > a"));
			$("ul.tabmenu-type li a").removeClass("sel");
			$("#divModalToggle > div.tab-area > ul > li:nth-child("+num+") > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=5&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
					$.ajaxLoading();
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					$("#divModalFile > p").remove();
					$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientSatisfaction.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					//setTimeout(function(){$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();},300); //ajax Loading
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();	
			
			//모달 초기화
			
			// 자동완성 입력란 초기화
			$('#formModalData #textModalReportingLineDivisionName').show();
			$('#formModalData #textModalReportingLinePostName').show();
			$('#formModalData #textModalReportingLineTeamName').show();
			$('#formModalData #textCommonSearchCompany').show();
			$('#formModalData #textModalDirectorName').show();
			$('#formModalData #textModalPerSonalPrevSales').show();
			
			$('.value').next().remove();
			$('.value').remove();
			
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#hiddenModalCompanyId").val("");
			$("#hiddenModalPrevSales").val("");
			$("#formModalData select").val("");
			$("#formModalData #selectModalLikeAbility").val("green");
			$("#formModalData #selectModalRelation").val("green");
			$("#formModalData input[name='radioModalUseYN']").eq(0).prop("checked",true);
			$("#formModalData textarea").val("");
			$("#formModalData #hiddenModalCompanyId").val("");
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#buttonModalDelete").hide();
			$("#divModalFile").hide();
			$("#divModalUploadNameCard").html('<span class="blank-ment"><img style="background:url(\'../images/pc/namecard_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			$('#divModalUploadNameCard span').hide();
			$('#divModalUploadNameCard .blank-ment').show();
			$("#divModalUploadPhoto").html('<span class="blank-ment"><img style="background:url(\'../images/pc/photo_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			$('#divModalUploadPhoto span').hide();
			$('#divModalUploadPhoto .blank-ment').show();
			
			//erp코드연동 관련 초기화
			$("#formModalData #spanERPClientCodeCheck > i.fa.fa-check").hide();
			$("#formModalData #spanERPClientCodeCheck > i.fa.fa-close").show();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("고객개인 신규 등록");
			$("#buttonModalSubmit").html("등록하기");
			$("small.font-bold").css('display','none');
			
			$("#formModalData #hiddenModalPK").val("");
			
    	$("#textModalPerSonalEducation").val("<학력>\r\n\t- 초등학교 : \r\n\t- 중학교 : \r\n\t- 고등학교 : \r\n\t- 대학교 : ");
    	$("#textModalPerSonalEducationPerson").val("- ");
    	$("#textModalPerSonalCareer").val("<경력>\r\n\t- ");
    	$("#textModalPerSonalCareerPerson").val("- ");
			$("#textModalPerSonalProfile").val("<학력>\r\n\t- 초등학교 : \r\n\t- 중학교 : \r\n\t- 고등학교 : \r\n\t- 대학교 : \r\n\r\n<경력>\r\n\t- ");
			$("#textModalPerSonalActs").val("<취미>\r\n\t- \r\n\r\n<인맥>\r\n\t- \r\n\r\n<종교>\r\n\t- ");
			$("#textModalPerSonalFamily").val("<가족관계>\r\n\t- \r\n\r\n<기념일>\r\n\t- ");
			$("#textModalPerSonalInclination").val("<좋아하는 것>\r\n\t- \r\n\r\n<싫어하는 것>\r\n\t- ");
			$("#textModalPerSonalFamiliars").val("<소속,이름>\r\n\t- ");
			$("#textModalPerSonalSNS").val("<활동중인 SNS>\r\n\t- LinkedIn ID : \r\n\t- FaceBook ID : \r\n\t- Twitter ID : ");
			$("#textModalPerSonalETC").val("<금지사항>\r\n\t- \r\n\r\n<습관>\r\n\t- \r\n\r\n<주량>\r\n\t- \r\n\r\n<흡연여부>\r\n\t- ");
			
			comparePerSonalProfile = $("#textModalPerSonalProfile").val();
			comparePerSonalActs = $("#textModalPerSonalActs").val();
			comparePerSonalFamily = $("#textModalPerSonalFamily").val();
			comparePerSonalInclination = $("#textModalPerSonalInclination").val();
			comparePerSonalFamiliars = $("#textModalPerSonalFamiliars").val();
			comparePerSonalSNS = $("#textModalPerSonalSNS").val();
			comparePerSonalETC = $("#textModalPerSonalETC").val();
			
			//모달안에서 프로젝트 관련 마일스톤 없음
// 			salesDetail.reset();
// 			salesDetail.drawQualification();

			individualHistory.reset();
			individualHistory.drawQualification();
			$("#formModalData > div.tab-area > ul > li:nth-child(4)").hide();
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
			
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: "",
					rules : {
						textModalClientName : {
							required : true,
							maxlength : 20
						},
						hiddenModalCompanyId : {
							required : true
						},
						textModalCellPhone : {
							phone : true
						} ,
						textModalPhone : {
							phone : true
						},
						textModalEmail : {
							email : true
						}
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalClientName : {
							required : "고객개인명을 입력하세요.",
							maxlength: $.validator.format('{0}자 내로 입력하세요.')
						},
						hiddenModalCompanyId : {
							required : "고객사를 입력하세요." // 이와 같이 규칙이름과 메시지를 작성
						},
						textModalEmail : {
							email : "이메일 형식이 올바르지 않습니다."
						}
					},
					invalidHandler : function(error, element) {
						$('div.modaltabmenu').each(function(idx,obj){
							$("ul.tabmenu-type li a").eq(idx).trigger('click.modalTab');
							return false;
						});
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "hiddenModalCompanyId") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }
					    else {
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		submit : function(){
				var browser = getIEVersionCheck();
				var url;
				if(comparePerSonalProfile == $("#textModalPerSonalProfile").val())$("#textModalPerSonalProfile").val("");
				if(comparePerSonalActs == $("#textModalPerSonalActs").val())$("#textModalPerSonalActs").val("");
				if(comparePerSonalFamily == $("#textModalPerSonalFamily").val())$("#textModalPerSonalFamily").val("");
				if(comparePerSonalInclination == $("#textModalPerSonalInclination").val())$("#textModalPerSonalInclination").val("");
				if(comparePerSonalFamiliars == $("#textModalPerSonalFamiliars").val())$("#textModalPerSonalFamiliars").val("");
				if(comparePerSonalSNS == $("#textModalPerSonalSNS").val())$("#textModalPerSonalSNS").val("");
				if(comparePerSonalETC == $("#textModalPerSonalETC").val())$("#textModalPerSonalETC").val("");
				
				(modalFlag == "ins") ? url = "/clientManagement/insertClientIndividualInfo.do" : url = "/clientManagement/updateClientIndividualInfo.do";
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : false,
		    		dataType: "json",
		    		data : {
		    			datatype : 'json',
		    			browser : browser
		    		},
		            beforeSubmit: function (data,form,option) {
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
		                	compareFlag = false;
		                	if(modalFlag == "ins"){
		                		$("#hiddenClientId").val(data.filePK);
		                	}
// 		                	salesDetail.insertQualification();
		                	individualHistory.insertQualification();
		                	alert("저장하였습니다.");
		                	compare_before = $("#formModalData").serialize();
		                	if(modalFlag == "upd") {
		                		clientSerchList.get(1, 20);
		                		//clientList.goDetail($("#hiddenModalPK").val(), $("#hiddenModalCompanyId").val(), $("#hiddenCustomerName").val());
		                		customerDetail.getCustomerInfo();
		                		
		                		$("#divModalNameCardUploadArea .fileModalUploadNameCard").remove();
		                		$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
								$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
								$("#divModalFile > span").remove();
		                	}else {
		                		$('#myModal1').modal("hide");
		                		searchDetailClick.goDetail(data.filePK, $("#hiddenModalCompanyId").val(), $("#textModalClientName").val(), true);
		                	}
		                	
		                	$('#myModal1').modal("hide");
		                }else if(data.error == 'sequence'){
		                	alert("시퀀스에러.\n관리자에게 문의하세요.");
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		                
		                /* if(modalFlag=="upd"){
							$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
							$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
							$("#divModalFile > span").remove();
						}else{
							$('#myModal1').modal("hide");
						} */
		            },
		            complete: function() {
		            	$.ajaxLoadingHide();
					} 
		        });
		},
		
		removeFileElement : function(count,obj){
			$("input#inputUploadFile"+count).remove();
			$(obj).parent("p").remove();
			
			if($("#divModalUploadNameCard .fileModalUploadNameCard").length == 0){
				$("#divModalUploadNameCard span").show();
			}
			
			if($("#divModalUploadPhoto .fileModalUploadPhoto").length == 0){
				$("#divModalUploadPhoto span").show();
			}
		},
		
		deleteModal : function(){
			var params = $.param({
				datatype : 'json'
			});
			
			$.ajax({
				url : "/clientManagement/deleteClientIndividualInfo.do",
				async : false,
				datatype : 'json',
	 			method: 'POST',
				data : params + '&hiddenModalPK=' + $("#hiddenModalPK").val(),
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt > 0) alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$("#formDetail").attr({action:"/clientManagement/viewClientIndividualInfoDetail.do", method:"post"}).submit();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		changeSelect : function(selectbox) {
			if($(selectbox).val() != null && $(selectbox).val() != ''){
				$(selectbox).css('background-color', $(selectbox).val());
			}else{
				$(selectbox).css('background-color', 'gray');				
			}
		},
		
		browserCheck : function(val) {
			var bv = getBrowserCheck();
			if(bv == "11.0"){
				$("#"+val).click();
			}
		}
		
}
//getThumbnailPrivew(this,$('#divModalUploadPhoto'))
function getThumbnailPrivew(html, $target) {
	var bv = getBrowserCheck();
	if(bv == "9.0" && (html.value != 'undefined' && html.value != '')){
		imgPath = html.value.replace(/\\/gi, "\/");
		$target.css('display', '');
		$('#'+$target.attr('id')+' span').hide();
		$target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url(\''+ imgPath + '\') no-repeat center center; background-size:cover;" />');
	}else if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $target.css('display', '');
            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
            $('#'+$target.attr('id')+' span').hide();
            $target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url('+ e.target.result + ') no-repeat center center; background-size:cover;" />');
        }
        reader.readAsDataURL(html.files[0]);
    }
}
</script>
<style>
.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
    width:50;
    max-width:100%;
}
 
.filebox input[type="file"] {  /* 파일 필드 숨기기 */
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

</style>