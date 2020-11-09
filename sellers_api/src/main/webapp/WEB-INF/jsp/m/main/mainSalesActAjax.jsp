<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="box_head">
	<h3 class="ta_c">영업기회<span class="fs14 fc_gray_light">(총 ${fn:length(list)}개)</span></h3>
</div>

<ul class="my_act_list" id="my_act_list">
<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list">
			<li>
       	<c:choose>
		     	<c:when test="${list.CODE == '고객이슈'}">
			     	<a href="/clientSatisfaction/selectClientIssueDetail.do?pkNo=${list.PK}">
							<span class="statusColor statusColor_green">고객이슈</span> 
							<span class="subject">${list.SUBJECT}</span>
							<span class="info">영업대표 : ${list.CREATE_NAME} / 고객 : ${list.CREATE_NAME} / ${list.SYS_UPDATE_DATE}</span>
						</a>
					</c:when>
			     	<c:when test="${list.CODE == '영업기회'}">
				     	<a href="/clientSalesActive/selectOpportunityDetail.do?pkNo=${list.PK}">
							<span class="statusColor statusColor_yellow">영업기회</span>
							<span class="subject">${list.SUBJECT}</span>
							<span class="info">영업대표 : ${list.CREATE_NAME} / 고객 : ${list.CREATE_NAME} / ${list.SYS_UPDATE_DATE}</span>
						</a>
					</c:when>
			     	<c:when test="${list.CODE == '잠재영업기회'}">
				     	<a href="/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo=${list.PK}">
							<span class="statusColor statusColor_gray">잠재영업기회</span>
							<span class="subject">${list.SUBJECT}</span>
							<span class="info">영업대표 : ${list.CREATE_NAME} / 고객 : ${list.CREATE_NAME} / ${list.SYS_UPDATE_DATE}</span>
						</a>
					</c:when>
				</c:choose>
				
			</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>
			<strong>영업기회가 없습니다.</strong>
		</li>
	</c:otherwise>
</c:choose>
</ul>
