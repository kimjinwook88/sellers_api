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
			<div id="tab2-3" class="tab-pane active">
				<div class="pull-right pos_t10m">
	               <!--  검색 -->
					<form id="formSearchCommon">
					<div class="search-common">
						<div class="input-default  fl_l" style="margin: 0;">
							<span class="input-group-btn"> 
								<a href="javascript:$('div.search-detail').toggle();void(0);"class="btn btn-search-option" style="width: 120px;"><i class="fa fa-search"></i> 고객이슈 검색</a>
							</span>
				
							<div class="search-detail" style="top:35px;left:-160px;display:none;">
				
                              <%-- <div class="col-sm-12 m-b">
                                  <label class="control-label" for="date_modified">해결상태</label>
                                  <div class="input-group" style="width:100%;">
                                  	<select class="form-control" name="searchActionStatus" id="searchActionStatus">
										<option value="" <c:if test="${searchActionStatus == null or searchActionStatus == '' }">selected</c:if>>==== 선택 ====</option>
										<option value="actionStatusY" <c:if test="${searchActionStatus eq 'actionStatusY'}">selected</c:if>>완료</option>
										<option value="actionStatusN" <c:if test="${searchActionStatus eq 'actionStatusN'}">selected</c:if>>진행중</option>
										<option value="actionStatusX" <c:if test="${searchActionStatus eq 'actionStatusX'}">selected</c:if>>지연</option>
									</select>
                                  </div>
                              </div> --%>
                              
                              <div class="col-sm-12 m-b">
                                  <label class="control-label" for="date_modified">상태</label>
                                  <div class="input-group" style="width:100%;">
                                  <select class="form-control" name="detailSearchStatus" id="detailSearchStatus">
									<option value="" <c:if test="${detailSearchStatus == null or detailSearchStatus == '' }">selected</c:if>>==== 선택 ====</option>
									<option value="statusY" <c:if test="${detailSearchStatus eq 'statusY'}">selected</c:if>>완료</option>
									<option value="statusN" <c:if test="${detailSearchStatus eq 'statusN'}">selected</c:if>>진행중</option>
									<option value="statusX" <c:if test="${detailSearchStatus eq 'statusX'}">selected</c:if>>지연</option>
									</select>
                                  </div>
                              </div>
		                                
								<div class="col-sm-12 ag_r">
									<button type="button" class="btn btn-w-m btn-primary btn-seller" onclick="companyDetail.getCompanyIssue(1,1);"><i class="fa fa-search"></i> 검색</button>
								</div>
							</div>
						</div>
					</div>
					</form>
					<!--  검색 -->
	           	</div>
	           	
				<h2>고객이슈</h2>

                   <table id="tech-companies" class="basic4_list mg-b30">
                       <thead>
                       <tr>
                           <!-- <th>No</th> -->
                           <th width="*">이슈 제목</th>
                           <th width="12%">해결책임자</th>
                           <th width="12%">발생일</th>
                           <th width="12%">해결목표일</th>
                           <th width="12%">해결일</th>
                           <th width="12%">해결확인자</th>
                           <th width="10%">해결계획<br />상태</th>
                           <th width="8%">이슈상태</th>
                       </tr>
                       </thead>
                       <tbody id="row">
                       <c:choose>
						  <c:when test="${fn:length(clientIssue) > 0}">
					   		<c:forEach items="${clientIssue}" var="clientIssue">
		                       <tr class="tr_list" onclick="goDetail.clientIssue('${clientIssue.ISSUE_ID}')">
		                           <%-- <td>${clientIssue.ROWNUM}</td> --%>
		                           <td class="ag_l">${clientIssue.ISSUE_SUBJECT}</td>
		                           <td>${clientIssue.SOLVE_OWNER_NAME}</td>
		                           <td>${clientIssue.ISSUE_DATE}</td>
		                           <td>${clientIssue.DUE_DATE}</td>
		                           <c:choose>
									<c:when test="${clientIssue.ISSUE_CLOSE_DATE != null and clientIssue.ISSUE_CLOSE_DATE != ''}">
										<td>${clientIssue.ISSUE_CLOSE_DATE}</td>
									</c:when>
									<c:otherwise>
										<td>-</td>
									</c:otherwise>
								  </c:choose>
								  <td>${clientIssue.CONFIRM_NAME}</td>
								  
								 <td class="fua_status">
				               	   <div class="milestones">
					           			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
					               			<jsp:param name="DUE_DATE_1" value="${clientIssue.DUE_DATE_1}" />
					               			<jsp:param name="DUE_DATE_2" value="${clientIssue.DUE_DATE_2}" />
					               			<jsp:param name="DUE_DATE_3" value="${clientIssue.DUE_DATE_3}" />
					               			<jsp:param name="DUE_DATE_4" value="${clientIssue.DUE_DATE_4}" />
					               			<jsp:param name="DUE_DATE_5" value="${clientIssue.DUE_DATE_5}" />
					               			<jsp:param name="CLOSE_DATE_1" value="${clientIssue.CLOSE_DATE_1}" />
					               			<jsp:param name="CLOSE_DATE_2" value="${clientIssue.CLOSE_DATE_2}" />
					               			<jsp:param name="CLOSE_DATE_3" value="${clientIssue.CLOSE_DATE_3}" />
					               			<jsp:param name="CLOSE_DATE_4" value="${clientIssue.CLOSE_DATE_4}" />
					               			<jsp:param name="CLOSE_DATE_5" value="${clientIssue.CLOSE_DATE_5}" />
					               			<jsp:param name="CONTENTS_1" value="${clientIssue.CONTENTS_1}" />
					               			<jsp:param name="CONTENTS_2" value="${clientIssue.CONTENTS_2}" />
					               			<jsp:param name="CONTENTS_3" value="${clientIssue.CONTENTS_3}" />
					               			<jsp:param name="CONTENTS_4" value="${clientIssue.CONTENTS_4}" />
					               			<jsp:param name="CONTENTS_5" value="${clientIssue.CONTENTS_5}" />
					               		</jsp:include>
					              	</div>
				               </td>
					              
		                           <td style="background-color: ${clientIssue.ISSUE_STATUS_TEXT}"></td>
		                       </tr>
	                      	</c:forEach>
						   </c:when>
						   <c:otherwise>
							<tr>
								<td colspan="8" style="text-align:center;">No Data</td>
							</tr>
							</c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>
                </div>
                 
                <div class="btn-group pull-right pd-t10">
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyIssue(${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
				    <c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
					    <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="companyDetail.getCompanyIssue(${paginNo},${listPaging.toEndPage});">${paginNo}</button>
				    </c:forEach>
				    <button type="button" class="btn btn-white" onClick="companyDetail.getCompanyIssue(${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
				</div>
				
				<div style="height:300px;"></div>