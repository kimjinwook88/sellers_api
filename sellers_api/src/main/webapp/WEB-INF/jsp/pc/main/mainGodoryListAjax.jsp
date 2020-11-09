<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(rows) > 0}">
	<div class="godori full-height-scroll pd20">
		<c:forEach items="${rows}" var="rows">
			<div class="godori_row" style="cursor:pointer;" onClick="main.goGodory(${rows.ISSUE_ID})">
                <div class="left">
                	<c:choose>
                		<c:when test="${rows.ISSUE_CATEGORY_TEXT eq '고쳐주세요' }">
                		<span class="godori_cata icon_go">고</span>
                		</c:when>
                		<c:when test="${rows.ISSUE_CATEGORY_TEXT eq '도와주세요' }">
                		<span class="godori_cata icon_do">도</span>
                		</c:when>
                		<c:otherwise>
                		<span class="godori_cata icon_ri">리</span>
                		</c:otherwise>
                	</c:choose>
                	
                    
                    <strong class="subject">${rows.ISSUE_SUBJECT}</strong>
                    <span class="info">제안자:김차장 / <i class="fa fa-clock-o"></i> 2017-10-18</span>
                </div>
                <div class="status_area">
                    <c:choose>
		              	<c:when test="${rows.ISSUE_STATUS_TEXT eq '-'}">
		              		<td name="cols_STATUS_TEXT">-</td>
		              	</c:when>
		              	<c:otherwise>
		              	
		              		<c:choose>
		              			<c:when test="${rows.ISSUE_STATUS_TEXT eq '#1ab394'}">
		              				<span class="label statusColor-green">완료</span>
		              			</c:when>
		              			<c:when test="${rows.ISSUE_STATUS_TEXT eq '#ffc000'}">
		              				<span class="label statusColor-yellow">진행</span>
		              			</c:when>
		              			<c:when test="${rows.ISSUE_STATUS_TEXT eq '#f20056'}">
		              				<span class="label statusColor-red">지연</span>
		              			</c:when>
		              			<c:otherwise>
		              				<span class="label statusColor-gray">검토중</span>
		              			</c:otherwise>
		              		</c:choose>
		              	
		              		<%-- <td name="cols_STATUS_TEXT" style="background-color: ${rows.ISSUE_ACTION_STATUS_TEXT}"></td> --%>
		              	</c:otherwise>
		              </c:choose>
                </div>
            </a>
        </div>
	 	</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;padding-top:15px;" >
		    <strong>고도리가 없습니다.</strong>
		 </div>
	</c:otherwise>
</c:choose>