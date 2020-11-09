<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<script type="text/javascript">
//이슈 마우스 오버
var st = ""; 
$('tbody#row').on('mouseenter','td.ms_status, td.fua_status',function(){
	var subVal = $(this).find('div.step').html();
	var popMs = $(this).find('div.pop_milestones_detail');
	$(popMs).css({
		"top": "15px", 
		"left": "-230px"
	});
	st = setTimeout(function(){
		/* $.post("/clientSalesActive/selectOpportunityMilestonesList.do", { pkNo: pkNo} ).done(function( data ) {
		    console.log(data);
		}); */
		if((subVal).trim() != "-"){
			popMs.show();
		}
	},250);
}).on('mouseleave','td.ms_status, td.fua_status',function(){
	clearTimeout(st);
	$('div.pop_milestones_detail').hide();
});
</script>

				<div id="tab2-5" class="tab-pane active">
					<div class="pull-right pos_t10m">
						<!--  검색 -->
						<form id="formSearchCommon">
						<div class="search-common">
							<div class="input-default  fl_l" style="margin: 0;">
								<span class="input-group-btn"> 
									<a href="javascript:$('div.search-detail').toggle();void(0);"class="btn btn-search-option" style="width: 120px;"><i class="fa fa-search"></i> 컨택이력 검색</a>
								</span>
									<div class="search-detail" style="top:35px;left:-160px;display:none;">
									
									  <div class="col-sm-12 m-b">
		                                  <label class="control-label" for="date_modified">컨택목적</label>
		                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="컨택목적을 입력해주세요" class="input form-control" name="searchContactSubject" value="${searchContactSubject}" onkeydown="if(event.keyCode == 13){companyDetail.getCompanyContact(1,1);}"></div>
		                              </div>
		                              
									  <div class="col-sm-12 m-b">
		                                  <label class="control-label" for="date_modified">보고자</label>
		                                  <div class="input-group" style="width:100%;" ><input type="text" placeholder="보고자를 입력해주세요" class="input form-control" name="searchReportName" value="${searchReportName}" onkeydown="if(event.keyCode == 13){companyDetail.getCompanyContact(1,1);}"></div>
		                              </div>
		                              
		                              <div class="col-sm-12 m-b">                                    
			                            <label class="control-label" for="date_modified">컨택일자</label>
			                            <div class="data_1">
			                                <div class="input-group date">
			                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchContactStartDate" value="${searchContactStartDate}">
			                                </div>
			                            </div>
			                            <div style="padding:0px 5px; text-align:center; font-size:18px;">~</div>                                 
			                            <div class="data_1">
			                                <div class="input-group date">
			                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="searchContactEndDate" value="${searchContactEndDate}">
			                                </div>
			                            </div>
			                        </div>
			                        
			                        <%-- <div class="col-sm-12 m-b">
				                        <div class="form-group">
				                        	<label>액션상태</label>
				                         	<select class="form-control" name="searchActionStatus">
					                             <option value="" <c:if test="${searchActionStatus == null or searchActionStatus == ''}">selected</c:if>>=== 선택 ===</option>
					                             <option value="G" <c:if test="${searchActionStatus eq 'G'}">selected</c:if>>완료</option>
					                       		 <option value="Y" <c:if test="${searchActionStatus eq 'Y'}">selected</c:if>>진행중</option>
					                       		 <option value="R" <c:if test="${searchActionStatus eq 'R'}">selected</c:if>>지연</option>
				                         </select>
				                        </div>
					               </div> --%>
			                                
									<div class="col-sm-12 ag_r">
										<button type="button" class="btn btn-w-m btn-primary btn-seller" onclick="companyDetail.getCompanyContact(1,1);"><i class="fa fa-search"></i> 검색</button>
									</div>
								</div>
							</div>
						</div>
						</form>
						<!--  검색 -->
	           		</div>
	           		
                   <h2>컨택이력</h2>
                   
                   <table id="tech-companies" class="basic4_list mg-b30">
                       <thead>
                       <tr>
                           <!-- <th rowspan="2">No</th> -->
                           <th width="10%">컨택방법</th>
                           <th width="10%">고객명</th>
                           <th width="*">컨택목적</th>
                           <th width="10%">보고자</th>
                           <th width="12%">컨택일</th>
                           <th width="10%">액션<br />상태</th>
                           <!-- <th rowspan="2">작성자</th> -->
                           <!-- <th>Follow-Up-Action</th> -->
                       </tr>
                       </thead>
                       <tbody id="row">
				              <c:choose>
							  <c:when test="${fn:length(clientContactList) > 0}">
							   	<c:forEach items="${clientContactList}" var="clientContactList">
			                          <tr class="tr_list" onclick="goDetail.clientContact('${clientContactList.EVENT_ID}', '${clientContactList.CUSTOMER_NAME}')">
			                              <%-- <td>${clientContactList.ROWNUM}</td> --%>
			                              <td>${clientContactList.EVENT_CATEGORY}</td>
			                              <c:set var="COMPANY_NAME" value="${fn:split(clientContactList.COMPANY_NAME,',')}" />
			                              <c:set var="CUSTOMER_NAME" value="${fn:split(clientContactList.CUSTOMER_NAME,',')}" />
			                              <td>
			                              ${CUSTOMER_NAME[0]} [${COMPANY_NAME[0]}]
						              		<c:if test="${fn:length(CUSTOMER_NAME) > 1}">
						              			외 ${fn:length(CUSTOMER_NAME)-1}명
						              		</c:if>
						              	  </td>
			                              <td class="ag_l">${clientContactList.EVENT_SUBJECT}</td>
			                              <td>${clientContactList.HAN_NAME}</td>
			                              <td>${clientContactList.EVENT_DATE}</td>
			                               <td class="fua_status">
										  	<div class="milestones">
							           			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
							               			<jsp:param name="DUE_DATE_1" value="${clientContactList.SOLVE_DUE_DATE_1}" />
							               			<jsp:param name="DUE_DATE_2" value="${clientContactList.SOLVE_DUE_DATE_2}" />
							               			<jsp:param name="DUE_DATE_3" value="${clientContactList.SOLVE_DUE_DATE_3}" />
							               			<jsp:param name="DUE_DATE_4" value="${clientContactList.SOLVE_DUE_DATE_4}" />
							               			<jsp:param name="DUE_DATE_5" value="${clientContactList.SOLVE_DUE_DATE_5}" />
							               			<jsp:param name="CLOSE_DATE_1" value="${clientContactList.SOLVE_CLOSE_DATE_1}" />
							               			<jsp:param name="CLOSE_DATE_2" value="${clientContactList.SOLVE_CLOSE_DATE_2}" />
							               			<jsp:param name="CLOSE_DATE_3" value="${clientContactList.SOLVE_CLOSE_DATE_3}" />
							               			<jsp:param name="CLOSE_DATE_4" value="${clientContactList.SOLVE_CLOSE_DATE_4}" />
							               			<jsp:param name="CLOSE_DATE_5" value="${clientContactList.SOLVE_CLOSE_DATE_5}" />
							               			<jsp:param name="CONTENTS_1" value="${clientContactList.SOLVE_CONTENTS_1}" />
							               			<jsp:param name="CONTENTS_2" value="${clientContactList.SOLVE_CONTENTS_2}" />
							               			<jsp:param name="CONTENTS_3" value="${clientContactList.SOLVE_CONTENTS_3}" />
							               			<jsp:param name="CONTENTS_4" value="${clientContactList.SOLVE_CONTENTS_4}" />
							               			<jsp:param name="CONTENTS_5" value="${clientContactList.SOLVE_CONTENTS_5}" />
							               		</jsp:include>
							              	</div>
										  </td>
			                          </tr>
				                  </c:forEach>
							   </c:when>
							   <c:otherwise>
								<tr>
									<td colspan="6" style="text-align:center;">No Data</td>
								</tr>
								</c:otherwise>
							   </c:choose>
                          </tbody>
                   </table>
               </div>
               
               <div class="btn-group pull-right pd-t10">
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyContact(${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
				    <c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
					    <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="companyDetail.getCompanyContact(${paginNo},${listPaging.toEndPage});">${paginNo}</button>
				    </c:forEach>
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyContact(${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
				</div>
				
				<div style="height:300px;"></div>
				