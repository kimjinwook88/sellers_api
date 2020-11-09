<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<jsp:useBean id="getDate" class="java.util.Date" />
<fmt:formatDate var="currentDate" value="${getDate}" pattern="yyyy-MM-dd" />

<script type="text/javascript">
	$(document).ready(function(){
		//milestones 마우스 오버
		var st = ""; 
		$('div#tab2-2').on('mouseenter','td[name="cell_MILESTONES"]',function(){
			//var pkNo = $(this).children('input[name="milestones_oppid"]').val();
			var popMs = $(this).find('div.pop_milestones_detail');
			st = setTimeout(function(){
				/* $.post("/clientSalesActive/selectOpportunityMilestonesList.do", { pkNo: pkNo} ).done(function( data ) {
				    console.log(data);
				}); */
				popMs.show();
			},250);
		}).on('mouseleave','td[name="cell_MILESTONES"]',function(){
			clearTimeout(st);
			$('div.pop_milestones_detail').hide();
		});
	});
</script>
			<div id="tab2-2" class="tab-pane active">
                   <!-- <h2>진행중인 영업활동(최근2년)</h2> -->
					
					<div class="pull-right pos_t10m">
		               <!--  검색 -->
						<form id="formSearchCommon">
						<div class="search-common">
							<div class="input-default  fl_l" style="margin: 0;">
								<span class="input-group-btn"> 
									<a href="javascript:$('div.search-detail').toggle();void(0);"class="btn btn-search-option" style="width: 120px;"><i class="fa fa-search"></i> 영업기회 검색</a>
								</span>
					
								<div class="search-detail" style="top:35px;left:-160px;display:none;">
					
									<!-- <div class="col-sm-12 m-b">
			                            <label class="control-label" for="date_modified">고객사</label>
			                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompany" onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}"></div>
			                        </div> -->
			                        
			                        <div class="col-sm-12 m-b">
			                            <label class="control-label" for="date_modified">제목</label>
			                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="영업기회제목을 입력해주세요" value="${searchTitle}" class="input form-control" name="searchTitle" onkeydown="if(event.keyCode == 13){companyDetail.getCompanyOpp(1,1);}"></div>
			                        </div>
			                        
				                    <div class="col-sm-12 m-b">
			                            <label class="control-label" for="date_modified">Opportunity Owner</label>
			                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="Owner를 입력해주세요" value="${searchOwner}" class="input form-control" name="searchOwner" onkeydown="if(event.keyCode == 13){companyDetail.getCompanyOpp(1,1);}"></div>
			                        </div>
			                        
				                    <div class="col-sm-12 m-b">
			                            <label class="control-label" for="date_modified">예상계약금액 (입력 금액 이상 검색)</label>
			                            <div class="input-group" style="width:100%;" ><input type="text" placeholder="예상계약금액을 입력해주세요." value="${searchContractAmount}" class="input form-control" name="searchContractAmount" onkeydown="if(event.keyCode == 13){companyDetail.getCompanyOpp(1,1);}"></div>
			                        </div>
			                        
			                        <div class="col-sm-12 m-b">
				                        <div class="form-group">
				                        	<label>Forecast</label>
				                         	<select class="form-control" name="searchForecast">
					                             <option value="" <c:if test="${searchForecast == null or searchForecast == ''}">selected</c:if>>=== 선택 ===</option>
					                             <option value="In" <c:if test="${searchForecast eq 'In'}">selected</c:if>>In</option>
					                       		 <option value="Out" <c:if test="${searchForecast eq 'Out'}">selected</c:if>>Out</option>
				                         </select>
				                        </div>
					               </div>
					               
			                        <%-- <div class="col-sm-12 m-b">
				                         <div class="form-group">
				                         	 <label>Sales Cycle</label>
					                         <select class="form-control" name="searchSalesCycle">
												<option value="" <c:if test="${searchSalesCycle == null or searchSalesCycle == ''}">selected</c:if>>=== 선택 ===</option>
												<option value="1" <c:if test="${searchSalesCycle eq '1'}">selected</c:if>>기회발견</option>
												<option value="2" <c:if test="${searchSalesCycle eq '2'}">selected</c:if>>벤더등록</option>
												<option value="3" <c:if test="${searchSalesCycle eq '3'}">selected</c:if>>영업활동</option>
												<option value="4" <c:if test="${searchSalesCycle eq '4'}">selected</c:if>>제안</option>
												<option value="5" <c:if test="${searchSalesCycle eq '5'}">selected</c:if>>의사결정</option>
												<option value="6" <c:if test="${searchSalesCycle eq '6'}">selected</c:if>>Close</option>
					                         </select>
				                         </div>
				                    </div> --%>
			                        
			                        <div class="col-sm-12 m-b">                                    
			                            <label class="control-label" for="date_modified">계약일</label>
			                            <div class="data_1">
			                            
			                                <div class="input-group date">
			                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchContractStartDate" value="${searchContractStartDate}">
			                                </div>
			                            </div>
			                            <div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
			                            <div class="data_1">
			                                <div class="input-group date">
			                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchContractEndDate" value="${searchContractEndDate}">
			                                </div>
			                            </div>
			                        </div>
			                                
									<div class="col-sm-12 ag_r">
										<button type="button" class="btn btn-w-m btn-primary btn-seller" onclick="companyDetail.getCompanyOpp(1,1);"><i class="fa fa-search"></i> 검색</button>
									</div>
								</div>
							</div>
						</div>
						</form>
						<!--  검색 -->
		           </div>
		           
                   <h2>영업기회</h2>

					<div class="cboth legend-tx"> 
						<!-- <span class="mark-ti r2">EO</span> Exec Owner
						<span class="mark-ti r2 mg-l10">OO</span> Opportunity Owner -->
                        <!-- <span class="mark-ti r2 mg-l10">B</span> 일정/예산
                        <span class="mark-ti r2 mg-l10">C</span> 경쟁상황
                        <span class="mark-ti r2 mg-l10">S</span> 솔루션
                        <span class="mark-ti r2 mg-l10">T</span> 계약조건 -->
                        <span class="mark-ti r2 mg-l10">FC</span>Forecast
                        <span class="mark-ti r2 mg-l10">SC</span> Sales Cycle(1-Identify, 2-Qualification, 3-Negotiation, 4-Won/Lost/Dropped, 5-Close) <!-- Sales Cycle(1-기회발견, 2-벤더등록, 3-영업활동, 4-제안, 5-의사결정, 6-Close)  -->
                    </div>
					
                   <table id="tech-companies" class="basic4_list mg-b30">
                       <thead>
                       <tr>
                           <!-- <th rowspan="2">No</th> -->
                           <th rowspan="2">영업기회</th>
                           <!-- <th rowspan="2">영업본부</th> -->
                           <th rowspan="2">EO<br />OO<br />영업대표</th>
                           <!-- <th rowspan="2">Identifier</th> -->
                           <th colspan="4">윈플랜</th>
                           <th rowspan="2" width="5%">마일스톤</th>
                           <th rowspan="2"><span class="mark-ti r2">FC</span></th>
                           <th rowspan="2"><span class="mark-ti r2">SC</span></th>
                           <th rowspan="2">진행여부</th>
                           <!-- <th rowspan="2">예상<br />계약금액</th> -->
                           <th rowspan="2">계약일</th>
                           <!-- <th colspan="2">매출(단위:백만원)</th> -->
                       </tr>
                       <tr>
                       		<th width="7%">일정</th>
                       		<th width="7%">경쟁</th>
                       		<th width="7%">솔루션</th>
                       		<th width="7%">계약</th>
                       		<!-- <th>REV</th>
                       		<th>GP</th> -->
                       </tr>
                       </thead>
                       <tbody>
                       <c:choose>
						  <c:when test="${fn:length(currentOpportunity) > 0}">
					   		<c:forEach items="${currentOpportunity}" var="currentOpportunity">
					   			
					   			<c:choose>
					   				<c:when test="${currentOpportunity.SALES_CYCLE eq '1' }">
					   				<c:choose>
					   					<c:when test="${currentOpportunity.KEY_DEAL_YN eq 'Y' }">
					   					<c:set var="sales_tab" value="1"></c:set>
					   					</c:when>
					   					<c:otherwise>
					   					<c:set var="sales_tab" value="2"></c:set>
					   					</c:otherwise>
					   				</c:choose>
					   				</c:when>
					   				<c:when test="${currentOpportunity.SALES_CYCLE eq '2' }">
					   				<c:choose>
					   					<c:when test="${currentOpportunity.KEY_DEAL_YN eq 'Y' }">
					   					<c:set var="sales_tab" value="1"></c:set>
					   					</c:when>
					   					<c:otherwise>
					   					<c:set var="sales_tab" value="2"></c:set>
					   					</c:otherwise>
					   				</c:choose>
					   				</c:when>
					   				<c:when test="${currentOpportunity.SALES_CYCLE eq '3' }">
					   				<c:choose>
					   					<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '1' }">
					   					<c:choose>
						   					<c:when test="${currentOpportunity.KEY_DEAL_YN eq 'Y' }">
						   					<c:set var="sales_tab" value="1"></c:set>
						   					</c:when>
						   					<c:otherwise>
						   					<c:set var="sales_tab" value="2"></c:set>
						   					</c:otherwise>
						   				</c:choose>
					   					</c:when>
					   					<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '2' }">
					   					<c:set var="sales_tab" value="4"></c:set>
					   					</c:when>
					   					<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '3' }">
					   					<c:set var="sales_tab" value="4"></c:set>
					   					</c:when>
					   					<c:otherwise>
					   					<c:set var="sales_tab" value="2"></c:set>
					   					</c:otherwise>
					   				</c:choose>
					   				</c:when>
					   				<c:when test="${currentOpportunity.SALES_CYCLE eq '4' }">
					   				<c:set var="sales_tab" value="3"></c:set>
					   				</c:when>
					   				<c:otherwise>
					   				<c:set var="sales_tab" value="2"></c:set>
					   				</c:otherwise>
					   			</c:choose>
					   		
		                      <tr class="tr_list" onclick="goDetail.opportunity('${currentOpportunity.OPPORTUNITY_ID}', '${sales_tab}')">
		                          <%-- <td>${currentOpportunity.ROWNUM}</td> --%>
		                          <td class="ag_l">${currentOpportunity.SUBJECT}
              					    <c:if test="${currentOpportunity.KEY_DEAL_YN eq 'Y'}">
					               		<span><i class="fa fa-star" style="color: orange;"></i></span>
					                </c:if>
		                          </td>
		                          <%-- <td>${currentOpportunity.DIVISION_NAME}</td> --%>
		                          <td>${currentOpportunity.EXEC_NAME}<br />${currentOpportunity.OWNER_NAME}<br />${currentOpportunity.IDENTIFIER_NAME}</td>
		                          <%-- <td>${currentOpportunity.OWNER_NAME}</td> --%>
		                          <%-- <td>${currentOpportunity.IDENTIFIER_NAME}</td> --%>
		                          <c:choose>
										<c:when test="${currentOpportunity.STATUS1 ne null && currentOpportunity.STATUS1 != '' }">
										<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${currentOpportunity.STATUS1}"></td>
										</c:when>
										<c:otherwise>
										<td name="cell_CHECKLIST">-</td>
										</c:otherwise>
									</c:choose>
		                          <c:choose>
										<c:when test="${currentOpportunity.STATUS2 ne null && currentOpportunity.STATUS2 != '' }">
										<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${currentOpportunity.STATUS2}"></td>
										</c:when>
										<c:otherwise>
										<td name="cell_CHECKLIST">-</td>
										</c:otherwise>
									</c:choose>
		                          <c:choose>
										<c:when test="${currentOpportunity.STATUS3 ne null && currentOpportunity.STATUS3 != '' }">
										<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${currentOpportunity.STATUS3}"></td>
										</c:when>
										<c:otherwise>
										<td name="cell_CHECKLIST">-</td>
										</c:otherwise>
									</c:choose>
		                          <c:choose>
										<c:when test="${currentOpportunity.STATUS4 ne null && currentOpportunity.STATUS4 != '' }">
										<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${currentOpportunity.STATUS4}"></td>
										</c:when>
										<c:otherwise>
										<td name="cell_CHECKLIST">-</td>
										</c:otherwise>
									</c:choose>
	                          	
	                          	<td class="ag_l" name="cell_MILESTONES">
					              <div class="milestones">
					                  <div class="step"> 
					                        <c:choose>
					                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_1 eq null || currentOpportunity.MS_DUE_DATE_1 == '') && (currentOpportunity.MS_CLOSE_DATE_1 eq null || currentOpportunity.MS_CLOSE_DATE_1 == '') }">
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_1 ne null && currentOpportunity.MS_CLOSE_DATE_1 != '' }">
							        				<span class="icon_status statusColor-green"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_1 >= currentDate }">
							        				<span class="icon_status statusColor-yellow"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_1 < currentDate}">
							        				<span class="icon_status statusColor-red"></span>
							        			</c:when>
							        			<c:otherwise>
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:otherwise>
							        		</c:choose>
					                        <c:choose>
					                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_2 eq null || currentOpportunity.MS_DUE_DATE_2 == '') && (currentOpportunity.MS_CLOSE_DATE_2 eq null || currentOpportunity.MS_CLOSE_DATE_2 == '') }">
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_2 ne null && currentOpportunity.MS_CLOSE_DATE_2 != '' }">
							        				<span class="icon_status statusColor-green"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_2 >= currentDate }">
							        				<span class="icon_status statusColor-yellow"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_2 < currentDate}">
							        				<span class="icon_status statusColor-red"></span>
							        			</c:when>
							        			<c:otherwise>
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:otherwise>
							        		</c:choose>
					                        <c:choose>
					                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_3 eq null || currentOpportunity.MS_DUE_DATE_3 == '') && (currentOpportunity.MS_CLOSE_DATE_3 eq null || currentOpportunity.MS_CLOSE_DATE_3 == '') }">
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_3 ne null && currentOpportunity.MS_CLOSE_DATE_3 != '' }">
							        				<span class="icon_status statusColor-green"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_3 >= currentDate }">
							        				<span class="icon_status statusColor-yellow"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_3 < currentDate}">
							        				<span class="icon_status statusColor-red"></span>
							        			</c:when>
							        			<c:otherwise>
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:otherwise>
							        		</c:choose>
					                        <c:choose>
					                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_4 eq null || currentOpportunity.MS_DUE_DATE_4 == '') && (currentOpportunity.MS_CLOSE_DATE_4 eq null || currentOpportunity.MS_CLOSE_DATE_4 == '') }">
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_4 ne null && currentOpportunity.MS_CLOSE_DATE_4 != '' }">
							        				<span class="icon_status statusColor-green"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_4 >= currentDate }">
							        				<span class="icon_status statusColor-yellow"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_4 < currentDate}">
							        				<span class="icon_status statusColor-red"></span>
							        			</c:when>
							        			<c:otherwise>
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:otherwise>
							        		</c:choose>
					                        <c:choose>
					                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_5 eq null || currentOpportunity.MS_DUE_DATE_5 == '') && (currentOpportunity.MS_CLOSE_DATE_5 eq null || currentOpportunity.MS_CLOSE_DATE_5 == '') }">
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_5 ne null && currentOpportunity.MS_CLOSE_DATE_5 != '' }">
							        				<span class="icon_status statusColor-green"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_5 >= currentDate }">
							        				<span class="icon_status statusColor-yellow"></span>
							        			</c:when>
							        			<c:when test="${currentOpportunity.MS_DUE_DATE_5 < currentDate}">
							        				<span class="icon_status statusColor-red"></span>
							        			</c:when>
							        			<c:otherwise>
							        				<span class="icon_status statusColor-gray"></span>
							        			</c:otherwise>
							        		</c:choose>
					                  </div>
					                  
					                  
					                  <!-- 풍선말 팝업: milestones 상세내용/2018-10-16 -->
					                   <div class="pop_milestones_detail r5" style="display:none;">
					                       <div class="step">
						                       <c:choose>
						                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_1 eq null || currentOpportunity.MS_DUE_DATE_1 == '') && (currentOpportunity.MS_CLOSE_DATE_1 eq null || currentOpportunity.MS_CLOSE_DATE_1 == '') }">
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_1 ne null && currentOpportunity.MS_CLOSE_DATE_1 != '' }">
								        				<span class="icon_status statusColor-green"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_1 >= currentDate }">
								        				<span class="icon_status statusColor-yellow"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_1 < currentDate}">
								        				<span class="icon_status statusColor-red"></span>
								        			</c:when>
								        			<c:otherwise>
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:otherwise>
								        		</c:choose>
					                           <span class="subject">${currentOpportunity.KEY_MILESTONE_1}</span>
					                           <!-- <span class="term">(2016-07-18)</span> -->
					                       </div>
					                       
					                       <div class="step">
						                       <c:choose>
						                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_2 eq null || currentOpportunity.MS_DUE_DATE_2 == '') && (currentOpportunity.MS_CLOSE_DATE_2 eq null || currentOpportunity.MS_CLOSE_DATE_2 == '') }">
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_2 ne null && currentOpportunity.MS_CLOSE_DATE_2 != '' }">
								        				<span class="icon_status statusColor-green"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_2 >= currentDate }">
								        				<span class="icon_status statusColor-yellow"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_2 < currentDate}">
								        				<span class="icon_status statusColor-red"></span>
								        			</c:when>
								        			<c:otherwise>
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:otherwise>
								        		</c:choose>
					                           <span class="subject">${currentOpportunity.KEY_MILESTONE_2}</span>
					                           <!-- <span class="term">(2016-07-18)</span> -->
					                       </div>
					                       
					                       <div class="step">
						                       <c:choose>
						                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_3 eq null || currentOpportunity.MS_DUE_DATE_3 == '') && (currentOpportunity.MS_CLOSE_DATE_3 eq null || currentOpportunity.MS_CLOSE_DATE_3 == '') }">
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_3 ne null && currentOpportunity.MS_CLOSE_DATE_3 != '' }">
								        				<span class="icon_status statusColor-green"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_3 >= currentDate }">
								        				<span class="icon_status statusColor-yellow"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_3 < currentDate}">
								        				<span class="icon_status statusColor-red"></span>
								        			</c:when>
								        			<c:otherwise>
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:otherwise>
								        		</c:choose>
					                           <span class="subject">${currentOpportunity.KEY_MILESTONE_3}</span>
					                           <!-- <span class="term">(2016-07-18)</span> -->
					                       </div>
					                       
					                       <div class="step">
						                       <c:choose>
						                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_4 eq null || currentOpportunity.MS_DUE_DATE_4 == '') && (currentOpportunity.MS_CLOSE_DATE_4 eq null || currentOpportunity.MS_CLOSE_DATE_4 == '') }">
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_4 ne null && currentOpportunity.MS_CLOSE_DATE_4 != '' }">
								        				<span class="icon_status statusColor-green"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_4 >= currentDate }">
								        				<span class="icon_status statusColor-yellow"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_4 < currentDate}">
								        				<span class="icon_status statusColor-red"></span>
								        			</c:when>
								        			<c:otherwise>
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:otherwise>
								        		</c:choose>
					                           <span class="subject">${currentOpportunity.KEY_MILESTONE_4}</span>
					                           <!-- <span class="term">(2016-07-18)</span> -->
					                       </div>
					                       
					                       <div class="step">
						                       <c:choose>
						                        	<c:when test="${ (currentOpportunity.MS_DUE_DATE_5 eq null || currentOpportunity.MS_DUE_DATE_5 == '') && (currentOpportunity.MS_CLOSE_DATE_5 eq null || currentOpportunity.MS_CLOSE_DATE_5 == '') }">
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_CLOSE_DATE_5 ne null && currentOpportunity.MS_CLOSE_DATE_5 != '' }">
								        				<span class="icon_status statusColor-green"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_5 >= currentDate }">
								        				<span class="icon_status statusColor-yellow"></span>
								        			</c:when>
								        			<c:when test="${currentOpportunity.MS_DUE_DATE_5 < currentDate}">
								        				<span class="icon_status statusColor-red"></span>
								        			</c:when>
								        			<c:otherwise>
								        				<span class="icon_status statusColor-gray"></span>
								        			</c:otherwise>
								        		</c:choose>
					                           <span class="subject">${currentOpportunity.KEY_MILESTONE_5}</span>
					                           <!-- <span class="term">(2016-07-18)</span> -->
					                       </div>
					                   </div>
					                   <!--// 풍선말 팝업: milestones 상세내용 -->
					              </div>
					          </td>
					          
	                          	<td>
	                          		<c:choose>
	                          		<c:when test="${currentOpportunity.FORECAST_YN eq 'In'}">
	                          			<span class="forecast forecast_in">In</span>
	                          		</c:when>
	                          		<c:when test="${currentOpportunity.FORECAST_YN eq 'Out'}">
	                          			<span class="forecast forecast_out">Out</span>
	                          		</c:when>
	                          	</c:choose>
	                          	</td>
	                          	<td>
	                          	${currentOpportunity.SALES_CYCLE}
	                          	<c:if test="${currentOpportunity.SALES_CYCLE eq '4'}">
	                          	<br />
	                          		<c:choose>
	                          			<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '1'}">
	                          			(Won)
	                          			</c:when>
	                          			<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '2'}">
	                          			(Lost)
	                          			</c:when>
	                          			<c:when test="${currentOpportunity.CLOSE_CATEGORY eq '3'}">
	                          			(Dropped)
	                          			</c:when>
	                          		</c:choose>
	                          	</c:if>
	                          	</td>
	                          	<%-- <c:choose>
	                          		<c:when test="${currentOpportunity.SALES_CYCLE ne '3'}">
	                          			<td>${currentOpportunity.SALES_CYCLE}</td>
	                          		</c:when>
	                          		<c:when test="${currentOpportunity.SALES_CYCLE eq '3'}">
	                          			<td>${currentOpportunity.CLOSE_CATEGORY}</td>
	                          		</c:when>
	                          	</c:choose> --%>
	                          	<%-- <td><fmt:formatNumber value="${currentOpportunity.CONTRACT_AMOUNT}" groupingUsed="true"/></td> --%>
	                          	<td>
	                          		<c:choose>
	                          		<c:when test="${currentOpportunity.SALES_CYCLE eq '1' || currentOpportunity.SALES_CYCLE eq '2' || currentOpportunity.SALES_CYCLE eq '3'}">
	                          			진행중
	                          		</c:when>
	                          		<c:otherwise>
	                          			완료
	                          		</c:otherwise>
	                          	</c:choose>
	                          	</td>
	                          	<td>${currentOpportunity.CONTRACT_DATE}</td>
	                          	<%-- <td>${currentOpportunity.TOTAL_REV}</td>
	                          	<td>${currentOpportunity.TOTAL_GP}</td> --%>
		                      </tr>
	                      	</c:forEach>
						   </c:when>
						   <c:otherwise>
							<tr>
								<td colspan="12" style="text-align:center;">No Data</td>
							</tr>
							</c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>
               </div>
               
               <div class="btn-group pull-right pd-t10">
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyOpp(${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
				    <c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
					    <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="companyDetail.getCompanyOpp(${paginNo},${listPaging.toEndPage});">${paginNo}</button>
				    </c:forEach>
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyOpp(${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
				</div>
				
				<div style="height:300px;"></div>
	               