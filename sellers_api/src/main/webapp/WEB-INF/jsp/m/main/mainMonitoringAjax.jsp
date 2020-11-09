<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="coming_row">
	<h3>DUE-DATE TRACKING</h3>
	<div class="coming_box">
		<ul class="coming_list">
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list}" var="list">
						<c:if test="${list.NOTICE_CATEGORY eq 'TRACKING'}">
							<li>
								<a href="${list.NOTICE_REDIRECT_URL}">
								<%-- <a href="/clientSalesActive/selectContactDetail.do?pkNo=${list.EVENT_ID}"> --%>
									<%-- <span class="company_name">${list.COMPANY_NAME}</span> --%>
									<span class="date">[<fmt:formatDate value="${list.NOTICE_SEND_DATE}" pattern="yyyy.MM.dd"/>]</span>
									<span class="subject">${list.NOTICE_DETAIL}</span>
									
									<!-- 현황체크 -->
									<%-- <c:if test="${list.ACTION_PLAN_STATUS == '#1ab394'}">
										<span class="status statusColor_green"></span>
									</c:if>
									<c:if test="${list.ACTION_PLAN_STATUS == '#ffc000'}">
										<span class="status statusColor_yellow"></span>
									</c:if>
									<c:if test="${list.ACTION_PLAN_STATUS == '#f20056'}">
										<span class="status statusColor_red"></span>
									</c:if>
									<c:if test="${list.ACTION_PLAN_STATUS == '-'}">
										<span class="status statusColor_gray"></span>
									</c:if> --%>
								</a>
							</li>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					TRACKING 목록이 없습니다.
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>

<%-- <div class="coming_row">	
	<h3>영업기회</h3>
	<div class="coming_box">
		<ul class="coming_list">
			<c:choose>
				<c:when test="${fn:length(list2) > 0}">
					<c:forEach items="${list2}" var="list">
						<li>
							<a href="/clientSalesActive/selectOpportunityDetail.do?pkNo=${list.OPPORTUNITY_ID}">
								<span class="company_name">${list.COMPANY_NAME}</span>
								<span class="date">[${list.CONTRACT_DATE}]</span>
								<span class="subject">${list.SUBJECT}</span>
								
								<!-- 현황체크 -->
								<c:if test="${list.ACTION_PLAN_STATUS == '#1ab394'}">
									<span class="status statusColor_green"></span>
								</c:if>
								<c:if test="${list.ACTION_PLAN_STATUS == '#ffc000'}">
									<span class="status statusColor_yellow"></span>
								</c:if>
								<c:if test="${list.ACTION_PLAN_STATUS == '#f20056'}">
									<span class="status statusColor_red"></span>
								</c:if>
								<c:if test="${list.ACTION_PLAN_STATUS == '-'}">
									<span class="status statusColor_gray"></span>
								</c:if>
							</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					최근에 등록된 컨택이 없습니다.
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>

<div class="coming_row">
	<h3>고객이슈</h3>
	<div class="coming_box">
		<ul class="coming_list">
			<c:choose>
				<c:when test="${fn:length(list3) > 0}">
					<c:forEach items="${list3}" var="list">
						<li>
							<a href="/clientSatisfaction/selectClientIssueDetail.do?pkNo=${list.ISSUE_ID}">
								<span class="company_name_issue">${list.COMPANY_NAME}</span>
								<span class="date">[${list.ISSUE_DATE}]</span>
								<span class="subject">${list.ISSUE_SUBJECT}</span>
								
								<!-- 현황체크 -->
								<c:if test="${list.ISSUE_STATUS_TEXT == '#1ab394'}">
									<span class="status statusColor_green"></span>
								</c:if>
								<c:if test="${list.ISSUE_STATUS_TEXT == '#ffc000'}">
									<span class="status statusColor_yellow"></span>
								</c:if>
								<c:if test="${list.ISSUE_STATUS_TEXT == '#f20056'}">
									<span class="status statusColor_red"></span>
								</c:if>
								<c:if test="${list.ACTION_PLAN_STATUS == '-'}">
									<span class="status statusColor_gray"></span>
								</c:if>
							</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					최근에 등록된 컨택이 없습니다.
				</c:otherwise>
			</c:choose>
		</ul>
	</div>	
</div> --%>
