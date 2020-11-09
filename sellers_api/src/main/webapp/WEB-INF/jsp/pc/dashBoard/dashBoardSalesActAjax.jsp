<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(list) > 0}">
<ul class="list-group">
		<c:forEach items="${list}" var="list">
			<li class="list-group-item" style="cursor:pointer;" onClick="main.goSalesAct(${list.PK},'${list.CODE}')">
		        <p>
		        	<c:choose>
				     	<c:when test="${list.CODE == '고객이슈'}">
				         <span class="label statusColor-green">고객이슈</span> 
						</c:when>
				     	<c:when test="${list.CODE == '영업기회'}">
				         <span class="label statusColor-yellow">영업기회</span>
						</c:when>
				     	<c:when test="${list.CODE == '잠재영업기회'}">
				         <span class="label statusColor-gray">잠재영업기회</span>
						</c:when>
					</c:choose>
		            <strong>${list.SUBJECT}
		            <c:if test="${list.COACHING_TALK_COUNT > 0}">
              			<span style="color: orange;">(${list.COACHING_TALK_COUNT})</span> 
			  		</c:if>
		            </strong>
		        </p>
		        <small class="block text-muted"><span>영업대표 : ${list.SALESMAN_NAME} </span> / <span>고객 : ${list.CUSTOMER_NAME} </span> / <i class="fa fa-clock-o"></i> ${list.SYS_UPDATE_DATE}</small>
		    </li>
		</c:forEach>
</ul>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;padding-top:15px;">
		     <strong>진행중인 영업활동이 없습니다.</strong>
		 </div>
	</c:otherwise>
</c:choose>
