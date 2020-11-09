<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="title_head">
	<h2 class="title">고객이슈</h2>
	<a href="/clientSatisfaction/clientIssueInsertForm.do" class="btn_more_landing">+</a>
</div>
<div class="issueList_box">
	<ul class="issueList">
		<c:choose>
			<c:when test="${fn:length(row) > 0 }">
				<c:forEach items="${row}" var="row">
					<c:choose>
						<c:when test="${row.STATUS_COLOR == '#1ab394'}">
							<li class="issue_green" style="display: none;">
						</c:when>
						<c:when test="${row.STATUS_COLOR == '#ffc000'}">
							<li class="issue_yellow">
						</c:when>
						<c:when test="${row.STATUS_COLOR == '#f20056'}">
							<li class="issue_red">
						</c:when>
						<c:otherwise>
						<li>
						</c:otherwise>
					</c:choose>
						<a href="/clientSatisfaction/selectClientIssueDetail.do?pkNo=${row.PK}">
							<span class="icon_status"></span>
							<span class="subject"> [${row.SUBJECT}] ${row.ISSUE_ID}</span>
							<span class="info">${row.COMPANY_NAME}</span>
							<span class="man">${row.CREATE_NAME}</span>
							<%-- ${row.COMPANY_NAME}</a> / ${row.HAN_NAME} / <span style="background:${row.STATUS_COLOR}; ">●</span>// --%>
						</a>
					</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<span>등록된 데이터가 없습니다.</span>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
