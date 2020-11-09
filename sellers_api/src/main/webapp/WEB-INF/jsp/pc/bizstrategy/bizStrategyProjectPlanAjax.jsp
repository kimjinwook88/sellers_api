<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	  <c:choose>
		<c:when test="${fn:length(rows) > 0}">
			<c:forEach items="${rows}" var="rows">
		    <tr class="tr_list" onClick="projectList.goDetail(${rows.PROJECT_ID});">
		    	<%-- <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
               <td>${NO}</td> --%>
               <td class="ag_l" name="cols_SUBJECT">
                   <h4 class="subject">${rows.SUBJECT}</h4><br/>
                   <c:if test="${rows.COMPANY_NAME ne null && rows.COMPANY_NAME != '' }">
				   <span class="fc_gray">${rows.COMPANY_NAME} | </span>
				   </c:if>
				   <span class="fc_gray">영업대표 : ${rows.SALES_OWNER}</span>
               </td>
               <td name="cols_MEMBER_TEAM">${rows.EXEC_DIVISION}</td>
               <td name="cols_EXEC_OWNER">${rows.EXEC_OWNER} </td>
               
               <td class="ms_status" name="cols_KEY_MILESTONE">
                   <div class="milestones">
        			<jsp:include page="/WEB-INF/jsp/pc/common/milestones_status.jsp">
            			<jsp:param name="DUE_DATE_1" value="${rows.MS_DUE_DATE_1}" />
            			<jsp:param name="DUE_DATE_2" value="${rows.MS_DUE_DATE_2}" />
            			<jsp:param name="DUE_DATE_3" value="${rows.MS_DUE_DATE_3}" />
            			<jsp:param name="DUE_DATE_4" value="${rows.MS_DUE_DATE_4}" />
            			<jsp:param name="DUE_DATE_5" value="${rows.MS_DUE_DATE_5}" />
            			<jsp:param name="CLOSE_DATE_1" value="${rows.MS_CLOSE_DATE_1}" />
            			<jsp:param name="CLOSE_DATE_2" value="${rows.MS_CLOSE_DATE_2}" />
            			<jsp:param name="CLOSE_DATE_3" value="${rows.MS_CLOSE_DATE_3}" />
            			<jsp:param name="CLOSE_DATE_4" value="${rows.MS_CLOSE_DATE_4}" />
            			<jsp:param name="CLOSE_DATE_5" value="${rows.MS_CLOSE_DATE_5}" />
            			<jsp:param name="MILESTONE_1" value="${rows.KEY_MILESTONE_1}" />
            			<jsp:param name="MILESTONE_2" value="${rows.KEY_MILESTONE_2}" />
            			<jsp:param name="MILESTONE_3" value="${rows.KEY_MILESTONE_3}" />
            			<jsp:param name="MILESTONE_4" value="${rows.KEY_MILESTONE_4}" />
            			<jsp:param name="MILESTONE_5" value="${rows.KEY_MILESTONE_5}" />
            		</jsp:include>
             		</div>
               </td>
               
               <td name="cols_STATUS" class="fua_status">
            	<div class="milestones">
          			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
              			<jsp:param name="DUE_DATE_1" value="${rows.ISSUE_DUE_DATE_1}" />
              			<jsp:param name="DUE_DATE_2" value="${rows.ISSUE_DUE_DATE_2}" />
              			<jsp:param name="DUE_DATE_3" value="${rows.ISSUE_DUE_DATE_3}" />
              			<jsp:param name="DUE_DATE_4" value="${rows.ISSUE_DUE_DATE_4}" />
              			<jsp:param name="DUE_DATE_5" value="${rows.ISSUE_DUE_DATE_5}" />
              			<jsp:param name="CLOSE_DATE_1" value="${rows.ISSUE_CLOSE_DATE_1}" />
              			<jsp:param name="CLOSE_DATE_2" value="${rows.ISSUE_CLOSE_DATE_2}" />
              			<jsp:param name="CLOSE_DATE_3" value="${rows.ISSUE_CLOSE_DATE_3}" />
              			<jsp:param name="CLOSE_DATE_4" value="${rows.ISSUE_CLOSE_DATE_4}" />
              			<jsp:param name="CLOSE_DATE_5" value="${rows.ISSUE_CLOSE_DATE_5}" />
              			<jsp:param name="CONTENTS_1" value="${rows.ISSUE_NAME_1}" />
              			<jsp:param name="CONTENTS_2" value="${rows.ISSUE_NAME_2}" />
              			<jsp:param name="CONTENTS_3" value="${rows.ISSUE_NAME_3}" />
              			<jsp:param name="CONTENTS_4" value="${rows.ISSUE_NAME_4}" />
              			<jsp:param name="CONTENTS_5" value="${rows.ISSUE_NAME_5}" />
              		</jsp:include>
             	</div>
            </td>
            
                <td name="cols_PROJECT_DATE">
                    ${rows.START_DATE} <br/> ~ ${rows.END_DATE}
               </td>
               <td id="amount_basis_total" name="cols_AMOUNT_BASIS">
                   <c:choose>
		        		<c:when test="${rows.AMOUNT_BASIS_TOTAL > 0}">
						<fmt:formatNumber value="${rows.AMOUNT_BASIS_TOTAL/1000}" groupingUsed="true"/>
		        		</c:when>
		        		<c:otherwise>
		        		0
		        		</c:otherwise>
		        	</c:choose>
               </td>
               <td id="invest_paln_basis_total" name="cols_INVEST_PLAN_BASIS">
                   <c:choose>
		        		<c:when test="${rows.INVEST_PLAN_BASIS_TOTAL > 0}">
						<fmt:formatNumber value="${rows.INVEST_PLAN_BASIS_TOTAL/1000}" groupingUsed="true"/>
		        		</c:when>
		        		<c:otherwise>
		        		0
		        		</c:otherwise>
		        	</c:choose>
               </td>
               <td name="cols_FILE_COUNT">
               	<c:choose>
					<c:when test="${rows.FILE_COUNT > 0}">
						<span class="file_inner"></span>
					</c:when>
					<c:otherwise>
						<span>-</span>
					</c:otherwise>
				</c:choose>
               </td>
           </tr>
		    </c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="10" style="text-align:center;">No Data</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
<!-- 카드형ㅋㅋ -->
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
//리스트 총 갯수
page.totalCount = "${listCount}";

//최근 업데이트 및 결과 내 검색 처리
'<c:if test="${!empty rows}">'
	'<c:forEach items="${rows}" var="rows">'
		searchPKArray.push("${rows.BIZ_ID}");
		$("#LATELY_UPDATE_DATE").html("${rows.LATELY_UPDATE_DATE}");
	'</c:forEach>'
'</c:if>'
</script>

<c:choose>
<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows">
	<div class="col-sm-12 col-md-12 col-lg-6">
	   <div class="contact-box cardType1">
	       <a href="javascript:void(0);" onClick="projectList.goDetail(${rows.PROJECT_ID});">
	           <div class="top">
	               <h3 class="word">
	                   <strong class="subject">${rows.SUBJECT}</strong>
	               </h3>
	               <span class="statusLec statusColor-${rows.STATUS}"></span>
	           </div>
	
	           <div class="cont">
	               <div class="info_top">
	                   <span class="cata fl_l">${rows.Category}</span>
	                   <span class="fl_r">
	                       ${rows.COMPANY_NAME} | <strong class="pos">책임임원</strong> : <span class="name">${rows.EXEC_OWNER}</span> | <strong class="pos">영업대표</strong> : <span class="name">${rows.SALES_OWNER }</span>
	                   </span>
	               </div>
	
	               <div class="start_end">
	                   시작일 : <span class="date">${rows.START_DATE }</span> | 종료일 : <span class="date">${rows.END_DATE}</span>
	               </div>
	
	               <div class="sales_status">
	                   <div class="ag_r">단위 : 천원 </div>
	                   <table class="basic mg-b10">
	                       <colgroup><col width="10%" /><col width="15%"/><col width="15%"/><col width="15%"/><col width="15%"/><col width="15%"/><col width="15%"/></colgroup>
	                        <thead>
	                            <tr>
	                                <th rowspan="2">구분</th>
	                                <th colspan="4">2016</th>
	                                <th rowspan="2">2017</th>
	                                <th rowspan="2" class="total">Total</th>
	                            </tr>
	                            <tr>
	                                <th>Q1</th>
	                                <th>Q2</th>
	                                <th>Q3</th>
	                                <th>Q4</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <th>Plan</th>
	                                <td class="plan">${rows.PLAN_Q1}</td>
	                                <td class="plan">${rows.PLAN_Q2}</td>
	                                <td class="plan">${rows.PLAN_Q3}</td>
	                                <td class="plan">${rows.PLAN_Q4}</td>
	                                <td class="plan">${rows.PLAN_AFTER_YEAR}</td>
	                                <td class="plan">${rows.PLAN_BASIS_TOTAL}</td>
	                            </tr>
	                            <tr>
	                                <th>Actual</th>
	                                <td>${rows.ACTUAL_Q1}</td>
	                                <td>${rows.ACTUAL_Q2}</td>
	                                <td>${rows.ACTUAL_Q3}</td>
	                                <td>${rows.ACTUAL_Q4}</td>
	                                <td>${rows.ACTUAL_AFTER_YEAR}</td>
	                                <td class="total <c:if test='${rows.PLAN_BASIS_TOTAL > rows.ACTUAL_BASIS_TOTAL}'>red</c:if>">${rows.ACTUAL_BASIS_TOTAL}</td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	
	                <div class="milestones">
	                    <h4 class="ti_s">Key Milestones</h4>
	                    <ul class="milestones_li">
	                        <c:if test="${rows.KEY_MILESTONE_PREV ne null && rows.KEY_MILESTONE_PREV != '' }">
			                        <li class="word">
			                            <span class="icon_status statusColor-${rows.STATUS_COLOR_PREV}"></span>
			                            <span class="subject">${rows.KEY_MILESTONE_PREV}</span>
			                            <span class="term">( ${rows.ACT_DUE_DATE_PREV}
			                            <c:choose>
											<c:when test="${rows.ACT_CLOSE_DATE_PREV ne null && rows.ACT_CLOSE_DATE_PREV != '' }">
												/ <span class="complete_day">완료 : ${rows.ACT_CLOSE_DATE_PREV}</span>)</span>
											</c:when>
											<c:otherwise>
												)</span>	
											</c:otherwise>
										</c:choose>
			                        </li>
			                        </c:if>
			                        
			                        <c:if test="${rows.KEY_MILESTONE_ING ne null && rows.KEY_MILESTONE_ING != '' }">
			                        <li class="word">
			                            <span class="icon_status statusColor-${rows.STATUS_COLOR_ING}"></span>
			                            <span class="subject">${rows.KEY_MILESTONE_ING}</span>
			                            <span class="term">( ${rows.ACT_DUE_DATE_ING}
			                            <c:choose>
											<c:when test="${rows.ACT_CLOSE_DATE_ING ne null && rows.ACT_CLOSE_DATE_ING != '' }">
												/ <span class="complete_day">완료 : ${rows.ACT_CLOSE_DATE_ING}</span>)</span>
											</c:when>
											<c:otherwise>
												)</span>	
											</c:otherwise>
										</c:choose>
			                        </li>
			                        </c:if>
			                        
			                        <c:if test="${rows.KEY_MILESTONE_NEXT ne null && rows.KEY_MILESTONE_NEXT != '' }">
			                        <li class="word">
			                            <span class="icon_status statusColor-${rows.STATUS_COLOR_NEXT}"></span>
			                            <span class="subject">${rows.KEY_MILESTONE_NEXT}</span>
			                            <span class="term">( ${rows.ACT_DUE_DATE_NEXT}
			                            <c:choose>
											<c:when test="${rows.ACT_CLOSE_DATE_NEXT ne null && rows.ACT_CLOSE_DATE_NEXT != '' }">
												/ <span class="complete_day">완료 : ${rows.ACT_CLOSE_DATE_NEXT}</span>)</span>
											</c:when>
											<c:otherwise>
												)</span>	
											</c:otherwise>
										</c:choose>
			                        </li>
			                        </c:if>
	                    </ul>
	                </div>
	            </div>
	
	            <div class="bottom">
	                <span class="file_inner">첨부파일 ${rows.FILE_COUNT}</span>
	            </div>
	        </a>
	    </div>
	</div>
</c:forEach>
</c:when>
<c:otherwise>
				<!-- 데이터 없을경우 -->
				<div class="col-sm-12 col-md-12 col-lg-12 ta-c">
                    <div class="blank_ment">
                        <p>
                        현재 등록된 정보가 없습니다.<br/>
                        첫 번째 등록자가 돼보세요.
                        </p>
                        <button type="button" class="btn btn-w-m btn-seller" onclick="modal.reset();">신규등록</button>
                    </div>
                </div>
</c:otherwise>
</c:choose>
             --%>