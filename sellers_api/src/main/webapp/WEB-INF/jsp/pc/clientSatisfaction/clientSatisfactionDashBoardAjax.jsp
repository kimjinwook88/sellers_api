<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- <div class="fl_l">
	<h2>고객만족도 Summary</h2>
</div>
<div class="fl_r pd-t20">단위 : 만원</div> -->
<!-- I. Opportunity Summary  table -->
<table class="dashboard_type2 mg-b50">
	<colgroup>
		<col width="23%" />
		<col width="7%" />
		<col width="15%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
	</colgroup>
	<thead>
		<tr>
			<th rowspan="2">조사제목</th>
			<th colspan="2">조사</th>
			<th colspan="2">고객 평가</th>
			<th colspan="4" class="end">관련 이슈</th>
		</tr>
		<tr>
			<th>일</th>
			<th>주관부서</th>
			<th>평균</th>
			<th>건수</th>
			<!-- <th>5</th>
			<th>4</th>
			<th>3</th>
			<th>2</th>
			<th>1</th> -->
			<th>건수</th>
			<th>진행</th>
			<th>지연</th>
			<th class="end">완료</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${fn:length(list) > 0}">
			<c:forEach items="${list}" var="ClientSatisfactionDashBoardList">
				<tr class="tr_list">
					<td class="ag_l" onclick="dashboard.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_SUBJECT}</td>
					<td onclick="dashboard.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_SURVEY_DATE}</td>
					<td onclick="dashboard.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_SURVEY_DIVISION_NAME}</td>
					<td onclick="dashboard.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_AVG_VALUE}</td>
					<td onclick="dashboard.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_TOTAL_COUNT}</td>
					<%-- <td onclick="clientSatisfactionDashBoardList.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_GREAT_COUNT}</td>
					<td onclick="clientSatisfactionDashBoardList.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_NICE_COUNT}</td>
					<td onclick="clientSatisfactionDashBoardList.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_GOOD_COUNT}</td>
					<td onclick="clientSatisfactionDashBoardList.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_BAD_COUNT}</td>
					<td onclick="clientSatisfactionDashBoardList.goDetail(${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.CSAT_HATE_COUNT}</td> --%>
					<c:choose>
						<c:when test="${ClientSatisfactionDashBoardList.TOTAL_ISSUE_COUNT eq 0}">
							<td>${ClientSatisfactionDashBoardList.TOTAL_ISSUE_COUNT}</td>
						</c:when>
						<c:otherwise>
							<td onclick="dashboard.goIssue('total', ${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.TOTAL_ISSUE_COUNT}</td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ClientSatisfactionDashBoardList.ISSUE_STATUS_ING eq 0}">
							<td>${ClientSatisfactionDashBoardList.ISSUE_STATUS_ING}</td>
						</c:when>
						<c:otherwise>
							<td onclick="dashboard.goIssue('ing', ${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.ISSUE_STATUS_ING}</td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ClientSatisfactionDashBoardList.ISSUE_STATUS_LATE eq 0}">
							<td>${ClientSatisfactionDashBoardList.ISSUE_STATUS_LATE}</td>
						</c:when>
						<c:otherwise>
							<td onclick="dashboard.goIssue('late', ${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.ISSUE_STATUS_LATE}</td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ClientSatisfactionDashBoardList.ISSUE_STATUS_COMPLETE eq 0}">
							<td class="end">${ClientSatisfactionDashBoardList.ISSUE_STATUS_COMPLETE}</td>
						</c:when>
						<c:otherwise>
							<td class="end" onclick="dashboard.goIssue('complete', ${ClientSatisfactionDashBoardList.CSAT_ID});">${ClientSatisfactionDashBoardList.ISSUE_STATUS_COMPLETE}</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td class="end" colspan="9" style="text-align:center;">No Data</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>
<!--// I. Opportunity Summary  table -->




<script type="text/javascript">

</script>