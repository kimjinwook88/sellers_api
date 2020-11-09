<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="status_table mg_b20">
<caption></caption>
<colgroup>
	<col width="25%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="25%"/>
</colgroup>
<thead>
	<tr>
		<th scope="col">제목</th>
		<th scope="col">조사대상</th>
		<th scope="col">설문건수</th>
		<th scope="col">평가(응답건수)</th>
	</tr>
</thead>
<tbody>
	<c:if test="${fn:length(rows) > 0}">
		<c:set var = "sum" value = "0" />
		<c:set var = "avg" value = "0" />
		<c:set var = "avg_cnt" value = "0" />
		<c:set var = "cnt_sum" value = "0" />
		<c:forEach var="rows" items="${rows}">
			<tr>
				<c:choose>
					<c:when test="${fn:length(rows.CSAT_SUBJECT) > 8}">
						<c:set var = "subject" value = "${fn:substring(rows.CSAT_SUBJECT, 0, 8)}" />
						<th>${subject}...</th>
					</c:when>
					<c:otherwise>
						<th>${rows.CSAT_SUBJECT}</th>
					</c:otherwise>
				</c:choose>
			
				<c:choose>
					<c:when test="${rows.CSAT_TARGET != '' }">
						
						<c:choose>
							<c:when test="${fn:length(rows.CSAT_TARGET) > 8}">
								<c:set var = "target" value = "${fn:substring(rows.CSAT_TARGET, 0, 8)}" />
								<td>${target}...</td>
							</c:when>
							<c:otherwise>
								<td>${rows.CSAT_TARGET}</td>
							</c:otherwise>
						</c:choose>
						
					</c:when>
					<c:otherwise>
						<td>-</td>
					</c:otherwise>			
				</c:choose>
				
				<td>${rows.TOTAL_COUNT}</td>
				<c:set var= "sum" value="${sum + rows.TOTAL_COUNT}"/>
												
				<td>${rows.AVG_CSAT_VALUE}(${rows.GREAT_COUNT + rows.NICE_COUNT + rows.GOOD_COUNT + rows.BAD_COUNT + rows.HATE_COUNT})</td>
				<c:set var= "cnt_sum" value="${cnt_sum + rows.GREAT_COUNT + rows.NICE_COUNT + rows.GOOD_COUNT + rows.BAD_COUNT + rows.HATE_COUNT}"/>
				
				<!-- 평가가 실시된 조건으로 계산 -->
				<c:if test="${rows.AVG_CSAT_VALUE != 0}">
					<!-- 평가 점수 -->
					<c:set var= "avg" value="${avg + rows.AVG_CSAT_VALUE}"/>
					<!-- 평가 count -->
					<c:set var= "avg_cnt" value="${avg_cnt + 1}"/>
				</c:if>
				
			</tr>
		</c:forEach>
		
		<!-- 합계 -->
		<tr>
			<th>합계</th>
			<th>-</th>
			<th><c:out value="${sum}"/></th>
			<c:set var = "total_avg" value = "${avg / avg_cnt}" />
			<th><fmt:formatNumber value="${total_avg}" pattern=".0"/>(<c:out value="${cnt_sum}"/>)</th>
		</tr>
	</c:if>
</tbody>
</table>


<!-- 조사현황: 반응형 table -->
<%-- <table class="rtable rtable--flip">
	<thead>
		<tr>
			<th scope="col">제목</th>
			<c:forEach var="rows" items="${rows}">
				<th scope="col" class="word ta_l">${rows.CSAT_SUBJECT}</th>
			</c:forEach>
			<th scope="col">합계</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th scope="row">주관부서</th>
			<c:forEach var="rows" items="${rows}">
				<td>${rows.CSAT_SURVEY_TEAM}</td>
			</c:forEach>
			<td>-</td>
		</tr>
		<tr>
			<th scope="row">책임자</th>
			<c:forEach var="rows" items="${rows}">
				<td>${rows.CSAT_SURVEY_NAME}</td>
			</c:forEach>
			<td>-</td>
		</tr>
		<tr>
			<th scope="row">조사일</th>
			<c:forEach var="rows" items="${rows}">
				<td>${rows.CSAT_SURVEY_DATE}</td>
			</c:forEach>
			<td>-</td>
		</tr>
		<tr>
			<th scope="row">조사대상</th>
			<c:forEach var="rows" items="${rows}">
				<c:if test="${rows.CSAT_TARGET != '' }">
					<td>${rows.CSAT_TARGET}</td>
				</c:if>
				<c:if test="${rows.CSAT_TARGET == '' }">
					<td>-</td>
				</c:if>
			</c:forEach>
			<td>-</td>
		</tr>
		<tr>
			<th scope="row">설문건수</th>
			<c:set var = "sum" value = "0" />
			<c:forEach var="rows" items="${rows}">
				<td>${rows.TOTAL_COUNT}</td>
				<c:set var= "sum" value="${sum + rows.TOTAL_COUNT}"/>
			</c:forEach>
			<td><c:out value="${sum}"/></td>
		</tr>
		<tr>
			<th scope="row">평가(응답건수)</th>
			<c:set var = "avg" value = "0" />
			<c:set var = "avg_cnt" value = "0" />
			<c:set var = "cnt_sum" value = "0" />
			<c:forEach var="rows" items="${rows}">
				<td>${rows.AVG_CSAT_VALUE}(${rows.GREAT_COUNT + rows.NICE_COUNT + rows.GOOD_COUNT + rows.BAD_COUNT + rows.HATE_COUNT})</td>
				<c:set var= "cnt_sum" value="${cnt_sum + rows.GREAT_COUNT + rows.NICE_COUNT + rows.GOOD_COUNT + rows.BAD_COUNT + rows.HATE_COUNT}"/>
				
				<!-- 평가가 실시된 조건으로 계산 -->
				<c:if test="${rows.AVG_CSAT_VALUE != 0}">
					<!-- 평가 점수 -->
					<c:set var= "avg" value="${avg + rows.AVG_CSAT_VALUE}"/>
					<!-- 평가 count -->
					<c:set var= "avg_cnt" value="${avg_cnt + 1}"/>
				</c:if>
				
			</c:forEach>
			
			<c:set var = "total_avg" value = "${avg / avg_cnt}" />
			<td><fmt:formatNumber value="${total_avg}" pattern=".0"/>(<c:out value="${cnt_sum}"/>)</td>
		</tr>
	</tbody>
</table> --%>
<!--// 조사현황: 반응형 table -->

